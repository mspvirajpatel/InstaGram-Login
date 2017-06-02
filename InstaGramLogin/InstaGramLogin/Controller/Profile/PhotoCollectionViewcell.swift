

import UIKit

class PhotoCollectionViewcell : UICollectionViewCell {
    
    // MARK: - Attributes -
    var imgPhoto : BaseImageView!
    var imgSelected : BaseImageView!
    var parentcollection:UICollectionView!
    var imgVideoIcon : UIImageView!
    var isImageSelected : Bool = false
    weak var overlayView: UIView?
    weak var overlayImageView: UIImageView?
    
    var selectionTintColor: UIColor = UIColor.black.withAlphaComponent(0.8) {
        didSet {
            overlayView?.backgroundColor = selectionTintColor
        }
    }
    
    open var selectionImageTintColor: UIColor = .white {
        didSet {
            overlayImageView?.tintColor = selectionImageTintColor
        }
    }
    
    open var selectionImage: UIImage? {
        didSet {
            overlayImageView?.image = selectionImage?.withRenderingMode(.alwaysTemplate)
        }
    }
    
    override var isSelected: Bool {
        set {
            setSelected(newValue, animated: true)
        }
        get {
            return super.isSelected
        }
    }
    
    func setSelected(_ isSelected: Bool, animated: Bool) {
        super.isSelected = isSelected
        // updateSelected(animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        //        overlayImageView?.image = nil
        //
        //        //Cancel request if needed
        //
        //        //Remove selection
        setSelected(false, animated: false)
    }
    
    fileprivate func updateSelected(_ animated: Bool) {
        if isSelected {
            addOverlay(animated)
        }
        else {
            removeOverlay(animated)
        }
    }
    
    
//    @IBInspectable var first: CGFloat = 1.2
//    
//    @IBInspectable var parallaxRatio: CGFloat = 1.2 {
//        didSet {
//            self.parallaxRatio = max(parallaxRatio, 1.0)
//            self.parallaxRatio = min(parallaxRatio, 2.0)
//            var rect: CGRect = self.bounds
//            rect.size.height = rect.size.height * parallaxRatio
//            self.imgPhoto.frame = rect
//            self.updateParallaxOffset()
//        }
//    }

    
    // MARK: - Life Cycle -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadViewControls()
        self.setViewControlsLayout()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        
    }
    
    deinit {
        print("PhotoCollectionView Cell deinit called")
        NotificationCenter.default.removeObserver(self)
        
        if imgSelected != nil && imgSelected.superview != nil {
            imgSelected.removeFromSuperview()
             imgSelected = nil
        }
      
        if imgPhoto != nil && imgPhoto.superview != nil {
            imgPhoto.removeFromSuperview()
            imgPhoto = nil
        }
        
        if parentcollection != nil && parentcollection.superview != nil {
            parentcollection.removeFromSuperview()
            parentcollection = nil
        }
        
    }
    
    
    override func layoutSubviews(){
        super.layoutSubviews()
        //self.parallaxRatio = first;
    }
    
    
    func loadViewControls()
    {
        self.contentView.backgroundColor = Color.appPrimaryBG.withAlpha(0.2)
        self.contentView.clipsToBounds = true
        self.backgroundColor = UIColor.clear
        self.clipsToBounds = true
       
        imgPhoto = BaseImageView(type: .defaultImg, superView: self.contentView)
        
        imgSelected = BaseImageView(type: .defaultImg, superView: self.contentView)
        imgSelected.image = UIImage(named: "ic_check")
        
        self.imgSelected.alpha = 0
        
        imgVideoIcon = UIImageView(image: UIImage(named: "videoIcon"))
        imgVideoIcon.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(imgVideoIcon)
        imgVideoIcon.isHidden = true
        self.contentView.bringSubview(toFront: imgVideoIcon)
    }
    
    
    func setViewControlsLayout() {
        
        let layout : AppBaseLayout = AppBaseLayout()
        
        layout.viewDictionary = ["imgPhoto" : imgPhoto,
                                 "imgSelected" : imgSelected]
        
        let horizontalPadding : CGFloat = ControlLayout.horizontalPadding
        let verticalPadding : CGFloat = ControlLayout.verticalPadding
        let secondaryHorizontalPadding : CGFloat = ControlLayout.secondaryHorizontalPadding
        let secondaryVerticalPadding : CGFloat = ControlLayout.secondaryVerticalPadding
        
        layout.metrics = ["horizontalPadding" : horizontalPadding,
                               "verticalPadding" : verticalPadding,
                               "secondaryHorizontalPadding" : secondaryHorizontalPadding,
                               "secondaryVerticalPadding" : secondaryVerticalPadding]
        //imagPhoto
        layout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|[imgPhoto]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: layout.metrics, views: layout.viewDictionary)
        self.contentView.addConstraints(layout.control_H)
        
        layout.control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|[imgPhoto]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: layout.metrics, views: layout.viewDictionary)
        self.contentView.addConstraints(layout.control_V)
        
        
        //Selected Image
        layout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:[imgSelected]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: layout.metrics, views: layout.viewDictionary)
        self.contentView.addConstraints(layout.control_H)
        
        layout.control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[imgSelected]", options: NSLayoutFormatOptions(rawValue: 0), metrics: layout.metrics, views: layout.viewDictionary)
        self.contentView.addConstraints(layout.control_V)
        
        layout.size_Height = NSLayoutConstraint(item: imgSelected, attribute: .height, relatedBy: .equal, toItem: self.contentView, attribute: .height, multiplier: 0.22, constant: 0)
        self.contentView.addConstraint(layout.size_Height)
        
        layout.size_Width = NSLayoutConstraint(item: imgSelected, attribute: .width, relatedBy: .equal, toItem: imgSelected, attribute: .height, multiplier: 1.0, constant: 0)
        self.contentView.addConstraint(layout.size_Width)
        
        imgVideoIcon.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        imgVideoIcon.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        imgVideoIcon.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
        imgVideoIcon.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        
    }
    
    func displayCell(){
        isImageSelected == false ? self.setUnselected() : self.setSelected()
    }
    
    func displayImages(userImages : ProfileNode)  {
        userImages.isSelect == false ? self.setUnselected() : self.setSelected()
        imgPhoto.displayImageFromURL(userImages.displaySrc)
        imgVideoIcon.isHidden = !userImages.isVideo
    }
    
    
    func setSelected() {
        self.imgSelected.alpha = 0
        self.isImageSelected = true
        updateSelected(true)
    }
    func setUnselected() {
        self.imgSelected.alpha = 0
        self.isImageSelected = false
        updateSelected(false)
    }
    
    fileprivate func addOverlay(_ animated: Bool) {
        guard self.overlayView == nil && self.overlayImageView == nil else { return }
        
        let overlayView = UIView(frame: frame)
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        overlayView.backgroundColor = selectionTintColor
        contentView.addSubview(overlayView)
        self.overlayView = overlayView
        
        let overlayImageView = UIImageView(frame: frame)
        overlayImageView.translatesAutoresizingMaskIntoConstraints = false
        overlayImageView.contentMode = .center
        overlayImageView.image = selectionImage ?? UIImage(named: "ic_check")?.withRenderingMode(.alwaysTemplate)
        overlayImageView.tintColor = selectionImageTintColor
        overlayImageView.alpha = 0
        contentView.addSubview(overlayImageView)
        self.overlayImageView = overlayImageView
        
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: overlayView.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: overlayView.rightAnchor),
            contentView.topAnchor.constraint(equalTo: overlayView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: overlayView.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: overlayImageView.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: overlayImageView.rightAnchor),
            contentView.topAnchor.constraint(equalTo: overlayImageView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: overlayImageView.bottomAnchor)
            ])
        layoutIfNeeded()
        
        let duration = animated ? 0.2 : 0.0
        UIView.animate(withDuration: duration, animations: {
            overlayView.alpha = 0.7
            overlayImageView.alpha = 1
        })
    }
    
    fileprivate func removeOverlay(_ animated: Bool) {
        guard let overlayView = self.overlayView,
            let overlayImageView = self.overlayImageView else {
                self.overlayView?.removeFromSuperview()
                self.overlayImageView?.removeFromSuperview()
                return
        }
        
        let duration = animated ? 0.2 : 0.0
        UIView.animate(withDuration: duration, animations: {
            overlayView.alpha = 0
            overlayImageView.alpha = 0
        }, completion: { (_) in
            overlayView.removeFromSuperview()
            overlayImageView.removeFromSuperview()
        })
    }
    
//    override func willMove(toSuperview newSuperview: UIView?) {
//        
//        super.willMove(toSuperview: newSuperview)
//        self.safeRemoveObserver()
//        var v: UIView? = newSuperview
//        while (v != nil) {
//            if (v is UICollectionView) {
//                self.parentcollection = (v as? UICollectionView)
//                break
//            }
//            v = v?.superview
//        }
//        self.safeAddObserver()
//    }
//    
//    func safeAddObserver() {
//        if self.parentcollection != nil {
//            defer {
//            }
//            do {
//                self.parentcollection.addObserver(self, forKeyPath: "contentOffset", options: [NSKeyValueObservingOptions.new , NSKeyValueObservingOptions.old], context: nil)
//            } catch _ {
//                
//            }
//        }
//    }
//    func safeRemoveObserver() {
//        if (self.parentcollection != nil) {
//            defer {
//                self.parentcollection = nil
//            }
//            do {
//                self.parentcollection.removeObserver(self, forKeyPath: "contentOffset", context: nil)
//            } catch let exception {
//            }
//        }
//    }
//    
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        if (keyPath == "contentOffset") {
//            if !self.parentcollection.visibleCells.contains(self) || (self.parallaxRatio == 1.0) {
//                return
//            }
//            self.updateParallaxOffset()
//        }
//    }
//    
//    
//    func updateParallaxOffset() {
//        if(self.parentcollection != nil)
//        {
//            let contentOffset: CGFloat = self.parentcollection.contentOffset.y
//            let cellOffset: CGFloat = self.frame.origin.y - contentOffset
//            let percent: CGFloat = (cellOffset + self.frame.size.height) / (self.parentcollection.frame.size.height + self.frame.size.height)
//            let extraHeight: CGFloat = self.frame.size.height * (self.parallaxRatio - 1.0)
//            var rect: CGRect = self.imgPhoto.frame
//            rect.origin.y = -extraHeight * percent
//            self.imgPhoto.frame = rect
//        }
//        
//        
//    }
    
}
