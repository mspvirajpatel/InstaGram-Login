
import UIKit
import Alamofire

class ProfileView: BaseView {
    
    // Mark: - Attributes -
    var viewContant : UIView!
    
    var profileListHeader : ProfileListHeader!
    
    var lblUser : BaseLabel!
    var lblDetail : BaseLabel!
    var lblLink : BaseLabel!
    var lblFolowDetail : BaseLabel!
    var imgFollow : BaseImageView!
    
    var collectionView : UICollectionView!
    
    var privacyView : UIView!
    var privacyIcon : UIImageView!
    var lblPrivacyMsg : BaseLabel!
    
    var constantProfileTopWithSuper : NSLayoutConstraint!
    var constantProfileTopWithProfile : NSLayoutConstraint!
   
    var userProfileModel : UserProfileModel!
    
    var arrToDownload : NSMutableArray = NSMutableArray()
    var timeLine: TimeLine!
    var isAPIRunning: Bool = false
    var isProfileVisible : Bool = true
    var followingbtnHidden: Bool = false
    
    var allShow : [NSLayoutConstraint]!
    var linkShow : [NSLayoutConstraint]!
    var detailsShow : [NSLayoutConstraint]!
    /// Its for show the Error on View
    var errorMessage : UILabel!
    var isSelectedCells : Bool = false
    
    // MARK: - Lifecycle -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.loadViewControls()
        self.setViewlayout()
        
        followingbtnHidden = true
       
        if let userName : String = AppUtility.getUserDefaultsObjectForKey("LoginUserName") as? String{
            
//            if let userProfile : UserProfileModel = AppUtility.getUserDefaultsCustomObjectForKey("userprofilemodel") as? UserProfileModel{
//                
//                
//                self.userProfileModel = userProfile
//                
//                if self.userProfileModel.user != nil
//                {
//                    self.profileListHeader.imgProfile.displayImageFromURLWithPlaceholder((self.userProfileModel.user.profilePicUrlHd)!, placeholder: UIImage(named: "profileplaceholder"))
//                    self.lblUser.text = self.userProfileModel.user.fullName
//                    self.lblDetail.text = self.userProfileModel.user.biography
//                    self.lblLink.text = self.userProfileModel.user.externalUrl
//                }
//                
//                self.isAPIRunning = false
//                
//                if self.userProfileModel.user != nil && self.userProfileModel.user.media != nil && self.userProfileModel.user.followedBy != nil && self.userProfileModel.user.follows != nil
//                {
//                    self.profileListHeader.segmentButton.setTitleOnSegment(["\(AppUtility.suffixNumber(no: Double(self.userProfileModel.user.media.count!)))\n\("profilePost".localize())", "\(AppUtility.suffixNumber(no: Double(self.userProfileModel.user.followedBy.count!)))\n\("profileFollowers".localize())","\(AppUtility.suffixNumber(no: Double(self.userProfileModel.user.follows.count!)))\n\("profileFollowing".localize())"])
//                }
//                
//                if self.userProfileModel.user != nil && self.userProfileModel.user.isPrivate == true
//                {
//                    self.viewContant.bringSubview(toFront: self.privacyView)
//                    self.privacyView.isHidden = false
//                    self.errorMessage.isHidden = true
//                    
//                    if (self.userProfileModel.user.followedByViewer == true)
//                    {
//                        self.privacyView.isHidden = true
//                        self.userProfileMediaRequest(userName: userName)
//                    }
//                    
//                }
//                else
//                {
//                    self.privacyView.isHidden = true
//                    self.userProfileMediaRequest(userName: userName)
//                }
//                
//                if self.userProfileModel.user != nil && self.userProfileModel.user.followedByViewer == true
//                {
//                    self.profileListHeader.isFollowingButton(isOn: true)
//                }
//                else
//                {
//                    self.profileListHeader.isFollowingButton(isOn: false)
//                }
//                
//                if self.userProfileModel.user != nil && (self.userProfileModel.user.requestedByViewer == true) {
//                    self.profileListHeader.isRequestedButton(isOn: true)
//                }
//                
//                if self.lblDetail.text !=  nil &&  self.lblLink.text !=  nil{
//                    AppUtility.executeTaskInMainQueueWithCompletion { [weak self] in
//                        if self == nil
//                        {
//                            return
//                        }
//                        
//                        UIView.animate(withDuration: 0.0, animations: {
//                            
//                            self?.layoutSubviews()
//                            self?.layoutIfNeeded()
//                        })
//                        
//                        
//                    }
//                }
//                else if self.lblLink.text !=  nil
//                {
//                    AppUtility.executeTaskInMainQueueWithCompletion { [weak self] in
//                        if self == nil
//                        {
//                            return
//                        }
//                        
//                        self?.viewContant.removeConstraints((self?.allShow)!)
//                        self?.viewContant.addConstraints((self?.linkShow)!)
//                        UIView.animate(withDuration: 0.0, animations: {
//                            
//                            self?.layoutSubviews()
//                            self?.layoutIfNeeded()
//                        })
//                        
//                    }
//                }
//                else if self.lblDetail.text !=  nil
//                {
//                    AppUtility.executeTaskInMainQueueWithCompletion { [weak self] in
//                        if self == nil
//                        {
//                            return
//                        }
//                        self?.viewContant.removeConstraints((self?.allShow)!)
//                        self?.viewContant.addConstraints((self?.detailsShow)!)
//                        UIView.animate(withDuration: 0.0, animations: {
//                            
//                            self?.layoutSubviews()
//                            self?.layoutIfNeeded()
//                        })
//                    }
//                }
//            }
//            else{
//                   self.userProfileRequest(userName: userName)
//                
//            }
            self.userProfileRequest(userName: userName)
        }
        
        //https://api.instagram.com/v1/users/self/?access_token=ACCESS-TOKEN
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    deinit {
        print("ProfileView Deinit called")
        self.releaseObject()
    }
    
    // MARK: - Layout -
    
    override func releaseObject() {
        super.releaseObject()
        NotificationCenter.default.removeObserver(self)
        
        if collectionView != nil && collectionView.superview != nil {
            collectionView.removeFromSuperview()
            collectionView = nil
        }
        
        if viewContant != nil && viewContant.superview != nil {
            viewContant.removeFromSuperview()
            viewContant = nil
        }
        
        
        userProfileModel = nil
    }
    
    override func loadViewControls()
    {
        super.loadViewControls()
        
        self.backgroundColor = Color.appSecondaryBG.value
        
        
        viewContant = UIView(frame: .zero)
        viewContant.translatesAutoresizingMaskIntoConstraints = false
        viewContant.backgroundColor = Color.appSecondaryBG.value
        self.addSubview(viewContant)
        
        var swipeUp : UISwipeGestureRecognizer! = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeUp.direction = .up
        var swipeDown : UISwipeGestureRecognizer! = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeDown.direction = .down
        
        
        profileListHeader = ProfileListHeader(frame: .zero)
        profileListHeader.translatesAutoresizingMaskIntoConstraints = false
        viewContant.addSubview(profileListHeader)
        
        profileListHeader.addGestureRecognizer(swipeUp)
        profileListHeader.addGestureRecognizer(swipeDown)
        
        profileListHeader.imgProfile.isUserInteractionEnabled = true
        
        profileListHeader.btnFollowing.setButtonTouchUpInsideEvent { [weak self] (sender, object) in
            if self == nil {
                return
            }
            
            if self!.userProfileModel != nil && self?.userProfileModel.user != nil
            {
                
                
            }
        }
        
        var tapGesture : UITapGestureRecognizer! = UITapGestureRecognizer(target: self, action: #selector(self.imgProfileTapped(sender:)))
        profileListHeader.imgProfile.addGestureRecognizer(tapGesture)
        
        profileListHeader.segmentButton.setSegmentTabbedEvent({ [weak self] (numberoftab) in
            if self == nil{
                return
            }
            
            
        })
        
        profileListHeader.isShowFollowerButton(isOn: false)
       
        
        // Privacy View Constraint
        privacyView = UIView()
        privacyView.translatesAutoresizingMaskIntoConstraints = false
        privacyView.backgroundColor = UIColor.clear
        privacyView.isHidden = true
        viewContant.addSubview(privacyView)
        
        privacyIcon  = UIImageView(image: UIImage(named : "PrivacyIcon"))
        privacyIcon.translatesAutoresizingMaskIntoConstraints = false
        privacyView.contentMode = .scaleAspectFill
        privacyView.clipsToBounds = true
        privacyView.addSubview(privacyIcon)
        
        lblPrivacyMsg = BaseLabel(labelType: BaseLabelType.large, superView: privacyView)
        lblPrivacyMsg.text = "accountprivate".localize()
        
        lblUser = BaseLabel(labelType: .medium, superView: viewContant)
        lblUser.text = ""
        
        lblDetail = BaseLabel(labelType: .medium, superView: viewContant)
        lblDetail.numberOfLines = 0
        lblDetail.text = ""
        
        lblLink = BaseLabel(labelType: .medium, superView: viewContant)
        lblLink.text = ""
        
        lblFolowDetail = BaseLabel(labelType: .medium, superView: viewContant)
        lblFolowDetail.text = ""
        lblFolowDetail.isHidden = true
        
        imgFollow = BaseImageView(type: .defaultImg, superView: viewContant)
        imgFollow.backgroundColor = .red
        imgFollow.isHidden = true
        
        if (followingbtnHidden == true)
        {
            profileListHeader.btnFollowing.isHidden = true
            lblFolowDetail.isHidden = true
            imgFollow.isHidden = true
        }
        else
        {
            profileListHeader.btnFollowing.isHidden = false
            lblFolowDetail.isHidden = false
            imgFollow.isHidden = false
        }
        
        var  layout: UICollectionViewFlowLayout! = UICollectionViewFlowLayout()
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceVertical = true
        collectionView.allowsMultipleSelection = true
        viewContant.addSubview(collectionView)
        collectionView.alpha = 0
        
        collectionView.register(PhotoCollectionViewcell.self, forCellWithReuseIdentifier : CellIdentifire.photoCollection)
        
        collectionView.register(ListHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: CellIdentifire.profileCollectionHeader)
        
       
        self.loadErrorMessage()
        
        defer {
            layout = nil
        }
        
    }
    
    
    func loadErrorMessage(){
        
        errorMessage = UILabel(frame: CGRect.zero)
        errorMessage.translatesAutoresizingMaskIntoConstraints = false
        
        errorMessage.font = UIFont(name: FontStyle.medium, size: 15.0)
        errorMessage.numberOfLines = 0
        
        errorMessage.preferredMaxLayoutWidth = 200
        errorMessage.textAlignment = .center
        
        errorMessage.backgroundColor = UIColor.clear
        errorMessage.textColor = Color.labelErrorText.withAlpha(1.0)
        
        errorMessage.tag = -1
        viewContant.addSubview(errorMessage)
        
        self.displayErrorMessage(nil)
        
    }
    
    func displayErrorMessage(_ errorMessage : String?){
        
        AppUtility.executeTaskInMainQueueWithCompletion { [weak self] in
            
            if self == nil{
                return
            }
            
            if(self!.errorMessage != nil){
                
                self!.errorMessage.isHidden = true
                self!.errorMessage.text = ""
                
                if(self!.errorMessage.tag == -1){
                    self!.sendSubview(toBack: self!.errorMessage)
                }
                
                if(errorMessage != nil){
                    
                    if(self!.errorMessage.tag == -1){
                        self!.bringSubview(toFront: self!.errorMessage)
                    }
                    
                    self!.errorMessage.isHidden = false
                    self!.errorMessage.text = errorMessage
                    
                }
                self!.errorMessage.layoutSubviews()
            }
        }
    }
    
    
    override func setViewlayout() {
        super.setViewlayout()
        
        self.baseLayout.viewDictionary = [
                                          "viewContant" : viewContant,
                                          "profileListHeader" : profileListHeader,
                                          "collectionView" : collectionView,
                                          "privacyView" : privacyView,
                                          "privacyIcon" : privacyIcon,
                                          "lblPrivacyMsg" : lblPrivacyMsg,
                                          "lblUserName" : lblUser,
                                          "lblDetail" : lblDetail,
                                          "lblLink" : lblLink,
                                          "lblFolowDetail" : lblFolowDetail,
                                          "imgFollow" : imgFollow,
                                          "errorMessage": errorMessage]
        
        
        let horizontalPadding : CGFloat = ControlLayout.horizontalPadding
        let virticalPadding : CGFloat = ControlLayout.verticalPadding
        let secondaryHorizontalPadding : CGFloat = ControlLayout.secondaryHorizontalPadding
        let secondaryVerticalPadding : CGFloat = ControlLayout.secondaryVerticalPadding
        
        let AddViewHeight : CGFloat = SystemConstants.IS_IPAD ? 0 : 0
        let profileDetailViewHeight : CGFloat = SystemConstants.IS_IPAD ? 120 : 100
        let segmentHeight : CGFloat = SystemConstants.IS_IPAD ? 70 : 70
        //let follwoImgHeight : CGFloat = SystemConstants.IS_IPAD ? 25 : 15   /temp Hidden
        let follwoImgHeight : CGFloat = SystemConstants.IS_IPAD ? 0 : 0
        
        self.baseLayout.metrics = ["horizontalPadding" : horizontalPadding,
                                   "virticalPadding" : virticalPadding,
                                   "secondaryHorizontalPadding" : secondaryHorizontalPadding,
                                   "secondaryVerticalPadding" : secondaryVerticalPadding,
                                   "AddViewHeight" : AddViewHeight,
                                   "profileDetailViewHeight" : profileDetailViewHeight,
                                   "segmentHeight" : segmentHeight
        ]
        
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|[viewContant]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        self.addConstraints(baseLayout.control_H)
        
        baseLayout.control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[viewContant]-0-|", options: [.alignAllLeading, .alignAllTrailing], metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        self.addConstraints(baseLayout.control_V)
        
        
        //TopHeaderView
        
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|[profileListHeader]-0@751-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        viewContant.addConstraints(baseLayout.control_H)
        
        allShow = NSLayoutConstraint.constraints(withVisualFormat: "V:|[profileListHeader]-secondaryVerticalPadding-[lblUserName]-virticalPadding-[lblDetail]-secondaryVerticalPadding-[lblLink][lblFolowDetail(0)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        viewContant.addConstraints(allShow)
        //
        linkShow = NSLayoutConstraint.constraints(withVisualFormat: "V:|[profileListHeader]-secondaryVerticalPadding-[lblUserName][lblDetail(0)]-secondaryVerticalPadding-[lblLink][lblFolowDetail(0)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        //        viewContant.addConstraints(linkShow)
        //
        detailsShow = NSLayoutConstraint.constraints(withVisualFormat: "V:|[profileListHeader]-secondaryVerticalPadding-[lblUserName]-virticalPadding-[lblDetail][lblLink(0)][lblFolowDetail(0)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        //        viewContant.addConstraints(detailsShow)
        
        //All Labels
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-horizontalPadding-[lblUserName]-horizontalPadding-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        self.addConstraints(baseLayout.control_H)
        
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-horizontalPadding-[lblDetail]-horizontalPadding-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        self.addConstraints(baseLayout.control_H)
        
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-horizontalPadding-[lblLink]-horizontalPadding-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        self.addConstraints(baseLayout.control_H)
        
        
        
        //Follow Label and icon
        
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-horizontalPadding-[imgFollow]-horizontalPadding-[lblFolowDetail]-horizontalPadding-|", options: [.alignAllCenterY], metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        self.addConstraints(baseLayout.control_H)
        
        baseLayout.size_Height = NSLayoutConstraint(item: imgFollow, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: follwoImgHeight)
        viewContant.addConstraint(baseLayout.size_Height)
        
        baseLayout.size_Width = NSLayoutConstraint(item: imgFollow, attribute: .width, relatedBy: .equal, toItem: imgFollow, attribute: .height, multiplier: 1.0, constant: 0)
        viewContant.addConstraint(baseLayout.size_Width)
        
        
        
        //CollectionView
        
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|[collectionView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        viewContant.addConstraints(baseLayout.control_H)
        
        
        constantProfileTopWithSuper = NSLayoutConstraint(item: collectionView, attribute: .top, relatedBy: .equal, toItem: profileListHeader, attribute: .bottom, multiplier: 1.0, constant: 0)
        //viewContant.addConstraint(constantProfileTopWithSuper)
        
        
        constantProfileTopWithProfile = NSLayoutConstraint(item: collectionView, attribute: .top, relatedBy: .equal, toItem: lblFolowDetail, attribute: .bottom, multiplier: 1.0, constant: virticalPadding)
        viewContant.addConstraint(constantProfileTopWithProfile)
        
        baseLayout.position_Bottom = NSLayoutConstraint(item: collectionView, attribute: .bottom, relatedBy: .equal, toItem: viewContant, attribute: .bottom, multiplier: 1.0, constant: 0)
        viewContant.addConstraint(baseLayout.position_Bottom)
        
        
        // MARK : Privacy View Constraint
        baseLayout.size_Width = NSLayoutConstraint(item: privacyView, attribute: .width, relatedBy: .equal, toItem: collectionView, attribute: .width, multiplier: 1.0, constant: 0.0)
        viewContant.addConstraint(baseLayout.size_Width)
        
        baseLayout.size_Height = NSLayoutConstraint(item: privacyView, attribute: .height, relatedBy: .equal, toItem: collectionView, attribute: .height, multiplier: 1.0, constant: 0.0)
        viewContant.addConstraint(baseLayout.size_Height)
        
        privacyView.centerX(view: collectionView)
        privacyView.centerY(view: collectionView)
        privacyIcon.centerX(view: privacyView)
        privacyIcon.centerY(view: privacyView)
        privacyIcon.verticalSpace(view: lblPrivacyMsg, space: -10.0)
        lblPrivacyMsg.centerX(view: privacyIcon)
        
        
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|[errorMessage]|", options:NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: baseLayout.viewDictionary)
        
        viewContant.addConstraints(baseLayout.control_H)
        
        baseLayout.position_Top = NSLayoutConstraint(item: errorMessage, attribute: .top, relatedBy: .equal, toItem: profileListHeader, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        
        baseLayout.position_Bottom = NSLayoutConstraint(item: errorMessage, attribute: .bottom, relatedBy: .equal, toItem: viewContant, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        
        viewContant.addConstraints([baseLayout.position_Top, baseLayout.position_Bottom])
        
        
        self.layoutIfNeeded()
        self.layoutSubviews()
        
        defer {
            baseLayout.releaseObject()
        }
    }
    
    // MARK: - Public Interface -
    
    
    public func reloadColletionOnDownload(){
        isSelectedCells = false
        AppUtility.executeTaskInMainQueueWithCompletion { [weak self] in
            if self == nil{
                return
            }
            
        }
    }
    
    // MARK: - User Interaction -
    
    @objc func segmentControlValueChanged(sender : UISegmentedControl) {
        
    }
    
    func imgProfileTapped(sender : UITapGestureRecognizer)
    {
        
    }
    
    
    func hideProfile() {
        if isProfileVisible {
            AppUtility.executeTaskInMainQueueWithCompletion({ [weak self] in
                if self == nil {
                    return
                }
                self?.collectionView.isScrollEnabled = false
                
                UIView.animate(withDuration: 0.7, animations: { [weak self] in
                    if self == nil {
                        return
                    }
                    self!.viewContant.removeConstraint(self!.constantProfileTopWithProfile)
                    self!.viewContant.addConstraint(self!.constantProfileTopWithSuper)
                    self!.viewContant.layoutIfNeeded()
                    
                    self!.lblUser.alpha = 0
                    self!.lblDetail.alpha = 0
                    self!.lblLink.alpha = 0
                    self!.imgFollow.alpha = 0
                    self!.lblFolowDetail.alpha = 0
                    
                    
                    
                    }, completion: { [weak self] (isComplete) in
                        if self == nil {
                            return
                        }
                        self?.collectionView.isScrollEnabled = true
                })
                self!.isProfileVisible = !(self?.isProfileVisible)!
            })
        }
    }
    
    func visibleProfile() {
        if !isProfileVisible {
            
            AppUtility.executeTaskInMainQueueWithCompletion({ [weak self] in
                if self == nil {
                    return
                }
                self?.collectionView.isScrollEnabled = false
                
                UIView.animate(withDuration: 0.7, animations: { [weak self] in
                    if self == nil {
                        return
                    }
                    self!.viewContant.removeConstraint(self!.constantProfileTopWithSuper)
                    self!.viewContant.addConstraint(self!.constantProfileTopWithProfile)
                    self!.viewContant.layoutIfNeeded()
                    
                    self!.lblUser.alpha = 1
                    self!.lblDetail.alpha = 1
                    self!.lblLink.alpha = 1
                    self!.imgFollow.alpha = 1
                    self!.lblFolowDetail.alpha = 1
                    
                    
                    }, completion: { [weak self] (isComplete) in
                        if self == nil {
                            return
                        }
                        self?.collectionView.isScrollEnabled = true
                })
                self!.isProfileVisible = !(self?.isProfileVisible)!
            })
        }
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.down:
                self.visibleProfile()
                break
                
            case UISwipeGestureRecognizerDirection.up:
                self.hideProfile()
                break
                
            default:
                break
            }
        }
    }
    
    
    // MARK: - Internal Helpers -
  
    
    // MARK: - Server Request -
    
    open func userProfileRequest(userName : String)
    {
        if operationQueue == nil{
            return
        }
        
        if isAPIRunning != true
        {
            if operationQueue != nil
            {
                operationQueue.addOperation { [weak self] in
                    if self == nil{
                        return
                    }
                    
                    let userprofileApi = "\(userName)\(APIConstant.userProfile)"
                    self?.isAPIRunning = true
                    
                    //                self?.displayErrorMessage("No Posts Found")
                    //                self?.bringSubview(toFront: (self?.errorMessage)!)
                    
                    BaseAPICall.shared.getRequest(URL: userprofileApi, Parameter: NSDictionary(), Task: APITask.UserProfile, completionHandler: { [weak self] (result) in
                        if self == nil{
                            return
                        }
                        
                        switch result{
                        case .Success(let object, _):
                            
                            self!.hideProgressHUD()
                            
                            if object is UserProfileModel
                            {
                                self?.userProfileModel = object as! UserProfileModel
                              
                                if self?.userProfileModel.user != nil
                                {
                                    self?.profileListHeader.imgProfile.displayImageFromURLWithPlaceholder((self?.userProfileModel.user.profilePicUrlHd)!, placeholder: UIImage(named: "profileplaceholder"))
                                    self?.lblUser.text = self?.userProfileModel.user.fullName
                                    self?.lblDetail.text = self?.userProfileModel.user.biography
                                    self?.lblLink.text = self?.userProfileModel.user.externalUrl
                                }
                                
                                self?.isAPIRunning = false
                            
                                if self?.userProfileModel.user != nil && self?.userProfileModel.user.media != nil && self?.userProfileModel.user.followedBy != nil && self?.userProfileModel.user.follows != nil
                                {
                                    self?.profileListHeader.segmentButton.setTitleOnSegment(["\(AppUtility.suffixNumber(no: Double(self!.userProfileModel.user.media.count!)))\n\("profilePost".localize())", "\(AppUtility.suffixNumber(no: Double(self!.userProfileModel.user.followedBy.count!)))\n\("profileFollowers".localize())","\(AppUtility.suffixNumber(no: Double(self!.userProfileModel.user.follows.count!)))\n\("profileFollowing".localize())"])
                                }
                               
                                if self?.userProfileModel.user != nil && self?.userProfileModel.user.isPrivate == true
                                {
                                    self!.viewContant.bringSubview(toFront: self!.privacyView)
                                    self?.privacyView.isHidden = false
                                    self?.errorMessage.isHidden = true
                                    
                                    if (self?.userProfileModel.user.followedByViewer == true)
                                    {
                                        self?.privacyView.isHidden = true
                                      
                                    }
                                    
                                }
                                else
                                {
                                    self?.privacyView.isHidden = true
                                
                                }
                                
                                if self?.userProfileModel.user != nil && self?.userProfileModel.user.followedByViewer == true
                                {
                                    self?.profileListHeader.isFollowingButton(isOn: true)
                                }
                                else
                                {
                                    self?.profileListHeader.isFollowingButton(isOn: false)
                                }
                                
                                if self?.userProfileModel.user != nil && (self?.userProfileModel.user.requestedByViewer == true) {
                                    self?.profileListHeader.isRequestedButton(isOn: true)
                                }
                                
                                if self?.lblDetail.text !=  nil &&  self?.lblLink.text !=  nil{
                                    AppUtility.executeTaskInMainQueueWithCompletion { [weak self] in
                                        if self == nil
                                        {
                                            return
                                        }
                                        
                                        UIView.animate(withDuration: 0.0, animations: {
                                            
                                            self?.layoutSubviews()
                                            self?.layoutIfNeeded()
                                        })
                                        
                                        
                                    }
                                }
                                else if self?.lblLink.text !=  nil
                                {
                                    AppUtility.executeTaskInMainQueueWithCompletion { [weak self] in
                                        if self == nil
                                        {
                                            return
                                        }
                                        
                                        self?.viewContant.removeConstraints((self?.allShow)!)
                                        self?.viewContant.addConstraints((self?.linkShow)!)
                                        UIView.animate(withDuration: 0.0, animations: {
                                            
                                            self?.layoutSubviews()
                                            self?.layoutIfNeeded()
                                        })
                                        
                                    }
                                }
                                else if self?.lblDetail.text !=  nil
                                {
                                    AppUtility.executeTaskInMainQueueWithCompletion { [weak self] in
                                        if self == nil
                                        {
                                            return
                                        }
                                        self?.viewContant.removeConstraints((self?.allShow)!)
                                        self?.viewContant.addConstraints((self?.detailsShow)!)
                                        UIView.animate(withDuration: 0.0, animations: {
                                            
                                            self?.layoutSubviews()
                                            self?.layoutIfNeeded()
                                        })
                                    }
                                }
                            }
                            break
                        case .Error(let error):
                            
                            self!.hideProgressHUD()
                            AppUtility.executeTaskInMainQueueWithCompletion { [weak self] in
                                if self == nil {
                                    return
                                }
                                AppUtility.showWhisperAlert(message: error!.serverMessage, duration: 1.0)
                            }
                            self?.isAPIRunning = false
                            
                            break
                        case .Internet(let isOn):
                            
                            self?.isAPIRunning = isOn
                            
                            self!.handleNetworkCheck(isAvailable: isOn, viewController: self!, showLoaddingView: true)
                            break
                        }
                        
                    })
                }
            }
        }
    }
    
}




