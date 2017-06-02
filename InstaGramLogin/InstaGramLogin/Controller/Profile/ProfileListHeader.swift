
import UIKit

class ProfileListHeader: UIView {

    // Mark: - Attributes -
    var segmentButton : SegmentControlView!
    var btnFollowing : BaseButton!
    var imgProfile : BaseImageView!
     var followingbtnHidden: Bool = false
    var layout_center : [NSLayoutConstraint]!
    var layout_topconstraint : [NSLayoutConstraint]!
    
    // MARK: - Lifecycle -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.loadViewControls()
        self.setViewlayout()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        print("ProfileListHeader deinit called")
        NotificationCenter.default.removeObserver(self)
        
        if imgProfile.superview != nil && imgProfile != nil {
            imgProfile.removeFromSuperview()
            imgProfile = nil
        }
        
        if btnFollowing.superview != nil && btnFollowing != nil {
            btnFollowing.removeFromSuperview()
            btnFollowing = nil
        }
        
        if segmentButton.superview != nil && segmentButton != nil {
            segmentButton.removeFromSuperview()
            segmentButton = nil
        }
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        AppUtility.executeTaskInMainQueueWithCompletion { [weak self] in
            if self == nil {
                return
            }
            self!.imgProfile.layer.borderWidth = 1.0
            self!.imgProfile.layer.borderColor = Color.imageViewBorder.value.cgColor
            self!.imgProfile.layer.cornerRadius = self!.imgProfile.bounds.height / 2
            
        }
    }
    
    // MARK: - Layout -
    func loadViewControls() {
        self.backgroundColor = Color.appPrimaryBG.withAlpha(0.1)
        segmentButton = SegmentControlView(iSegmentType: .secondary, titleArray: ["0\n\("profilePost".localize())", "0\n\("profileFollowers".localize())", "0\n\("profileFollowing".localize())"], iSuperView: self)
        segmentButton.selectedindex = 0
        
        btnFollowing = BaseButton(ibuttonType: .transparent, iSuperView: self)
        btnFollowing.setTitle("profileFollowbtn".localize(), for: .normal)
        btnFollowing.alpha = 0
        self.isFollowingButton(isOn: false)
        
        imgProfile = BaseImageView(type: .profile, superView: self)
        imgProfile.image = UIImage(named: "usericon")
        imgProfile.layer.masksToBounds = true
        imgProfile.clipsToBounds = true
        imgProfile.isUserInteractionEnabled = true
    }
    
    func setViewlayout() {
        var layout : AppBaseLayout! = AppBaseLayout()
        
        layout.viewDictionary = ["segmentButton" : segmentButton,
                                 "btnFollowing" : btnFollowing,
                                 "imgProfile" : imgProfile]
        
        let horizontalPadding : CGFloat = ControlLayout.horizontalPadding
        let virticalPadding : CGFloat = ControlLayout.verticalPadding
        let secondaryHorizontalPadding : CGFloat = ControlLayout.secondaryHorizontalPadding
        let secondaryVerticalPadding : CGFloat = ControlLayout.secondaryVerticalPadding
        
        let segmentHeight : CGFloat = SystemConstants.IS_IPAD ? 70 : 50
        let buttonHeight : CGFloat = SystemConstants.IS_IPAD ? 45 : 35
        let profileImageWidth : CGFloat = SystemConstants.IS_IPAD ? 100 : 70
        
        layout.metrics = ["horizontalPadding" : horizontalPadding,
                          "virticalPadding" : virticalPadding,
                          "secondaryHorizontalPadding" : secondaryHorizontalPadding,
                          "secondaryVerticalPadding" : secondaryVerticalPadding,
                          "buttonHeight" : buttonHeight,
                          "profileImageWidth" : profileImageWidth]

        
        layout_topconstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[segmentButton]-0@751-[btnFollowing(buttonHeight)]-virticalPadding@751-|", options: [.alignAllLeading, .alignAllTrailing], metrics: layout.metrics, views: layout.viewDictionary)
        //self.addConstraints(layout_topconstraint)
        
        layout_center = NSLayoutConstraint.constraints(withVisualFormat: "V:|-22-[segmentButton]-22@751-|", options: [.alignAllLeading, .alignAllTrailing], metrics: layout.metrics, views: layout.viewDictionary)
        self.addConstraints(layout_center)
        
        layout.control_H = SystemConstants.IS_IPAD ? NSLayoutConstraint.constraints(withVisualFormat: "H:|-secondaryHorizontalPadding-[imgProfile(profileImageWidth)]-horizontalPadding@751-[segmentButton]-secondaryHorizontalPadding@751-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: layout.metrics, views: layout.viewDictionary) : NSLayoutConstraint.constraints(withVisualFormat: "H:|-horizontalPadding-[imgProfile(profileImageWidth)]-horizontalPadding@751-[segmentButton]-horizontalPadding@751-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: layout.metrics, views: layout.viewDictionary)
        self.addConstraints(layout.control_H)
        
        
        //imgProfile
        layout.size_Height = NSLayoutConstraint(item: imgProfile, attribute: .height, relatedBy: .equal, toItem: imgProfile, attribute: .width, multiplier: 1.0, constant: 0)
        self.addConstraint(layout.size_Height)
        
        layout.position_CenterY = NSLayoutConstraint(item: imgProfile, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0)
        self.addConstraint(layout.position_CenterY)
        
        
        //segmentButton
        layout.size_Height = NSLayoutConstraint(item: segmentButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: segmentHeight)
        self.addConstraint(layout.size_Height)
        
        layout.size_Width = NSLayoutConstraint(item: segmentButton, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: SystemConstants.IS_IPAD ? 0.6 : 0.65, constant: 1.0)
        self.addConstraint(layout.size_Width)
        
        self.layoutIfNeeded()
        self.layoutSubviews()
        
        defer {
            layout.releaseObject()
            layout = nil
        }
        
    }
    
    // MARK: - Public Interface -
    
    
    func isShowFollowerButton(isOn : Bool)
    {
        if isOn == true {
            self.removeConstraints(layout_center)
            self.addConstraints(layout_topconstraint)
            
            UIView.animate(withDuration: 0.0, animations: {
                self.btnFollowing.alpha = 1
                self.layoutSubviews()
                self.layoutIfNeeded()
            })
        }
        else{
            self.removeConstraints(layout_topconstraint)
            self.addConstraints(layout_center)
            
            
            UIView.animate(withDuration: 0.0, animations: {
                self.btnFollowing.alpha = 0
                self.layoutSubviews()
                self.layoutIfNeeded()
            })
            
        }
    }
    

    
    // MARK: - User Interaction -
    
    func isFollowingButton(isOn : Bool)
    {
        if isOn == true {
            self.btnFollowing.setTitle("profileFollowing".localize(), for: .normal)
            
            self.btnFollowing.backgroundColor = UIColor.clear
            self.btnFollowing.setTitleColor(Color.buttonPrimaryTitle.value, for: UIControlState())
            self.btnFollowing.setBorder(Color.buttonPrimaryBG.value, width: 1.5, radius: ControlLayout.borderRadius)
        }
        else{
            self.btnFollowing.setTitle("profileFollowbtn".localize(), for: .normal)
            
            self.btnFollowing.backgroundColor = Color.buttonPrimaryBG.value
            self.btnFollowing.setTitleColor(Color.buttonSecondaryTitle.value, for: UIControlState())
            
        }
    }
    
    func isRequestedButton(isOn : Bool)
    {
        if isOn == true {
            self.btnFollowing.setTitle("profileRequested".localize(), for: .normal)
            
            self.btnFollowing.backgroundColor = UIColor.clear
            self.btnFollowing.setTitleColor(Color.buttonPrimaryTitle.value, for: UIControlState())
            self.btnFollowing.setBorder(Color.buttonPrimaryBG.value, width: 1.5, radius: ControlLayout.borderRadius)
        }
        
    }
    
    
    // MARK: - Internal Helpers -
    
   
    
    // MARK: - Server Request -

}
