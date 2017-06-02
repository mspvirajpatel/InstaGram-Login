
import UIKit
import Alamofire

class LoginView: BaseView {
    
    // Mark: - Attributes -
    
    var lblWellcome : BaseLabel!
    var lblAppTitle : BaseLabel!
    
    var btnLogin : BaseButton!
    var imgAppIcon : UIImageView!
    
    var isReturnAPI:Bool = false
    
    var btnLoginTouchUp : ControlTouchUpInsideEvent!
    private var dicParameter : NSMutableDictionary = NSMutableDictionary()
    
    // MARK: - Lifecycle -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.loadViewControls()
        AppUtility.deleteAllCookies()
        
        self.setViewlayout()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        print("LoginView Deinit called")
        self.releaseObject()
    }
    
    // MARK: - Layout -
    
    override func releaseObject() {
        super.releaseObject()
        NotificationCenter.default.removeObserver(self)
        
        if imgAppIcon != nil && imgAppIcon.superview != nil {
            imgAppIcon.removeFromSuperview()
            imgAppIcon = nil
        }
        if btnLogin != nil && btnLogin.superview != nil {
            btnLogin.removeFromSuperview()
            btnLogin = nil
        }
        
        if lblAppTitle != nil && lblAppTitle.superview != nil {
            lblAppTitle.removeFromSuperview()
            lblAppTitle = nil
        }
        if lblWellcome != nil && lblWellcome.superview != nil {
            lblWellcome.removeFromSuperview()
            lblWellcome = nil
        }
        btnLoginTouchUp = nil
        
    }
    
    override func loadViewControls() {
        super.loadViewControls()
        
        self.backgroundColor = Color.appPrimaryBG.value
        
        lblWellcome = BaseLabel(labelType: .primaryTitle, superView: self)
        lblWellcome.textColor = .white
        lblWellcome.text = "loginWelcome".localize()
        
        lblAppTitle = BaseLabel(labelType: .secondaryTitle, superView: self)
        lblAppTitle.textColor = .white
        lblAppTitle.text = AppName
        
        btnLogin = BaseButton(ibuttonType: .secondary, iSuperView: self)
        btnLogin.setTitle("loginSignInButton".localize(), for: .normal)
        btnLogin.addTarget(self, action: #selector(onLoginClick), for: .touchUpInside)
        
        imgAppIcon = BaseImageView(type: .defaultImg, superView: self)
        imgAppIcon.contentMode = .scaleAspectFit
        imgAppIcon.image = UIImage(named: "App_icon")
        
    }
    
    override func setViewlayout() {
        super.setViewlayout()
        
        baseLayout.viewDictionary = ["lblWellcome" : lblWellcome,
                                     "lblAppTitle" : lblAppTitle,
                                     "btnLogin" : btnLogin,
                                     "imgAppIcon" : imgAppIcon]
        
        let horizontalPadding : CGFloat = ControlLayout.horizontalPadding
        let virticalPadding : CGFloat = ControlLayout.verticalPadding
        let secondaryHorizontalPadding : CGFloat = ControlLayout.secondaryHorizontalPadding
        let secondaryVerticalPadding : CGFloat = ControlLayout.secondaryVerticalPadding
        
        let bottomIconHeight : CGFloat = SystemConstants.IS_IPAD ? 100.0 : 60.0
        
        baseLayout.metrics = ["horizontalPadding" : horizontalPadding,
                              "virticalPadding" : virticalPadding,
                              "secondaryHorizontalPadding" : secondaryHorizontalPadding,
                              "secondaryVerticalPadding" : secondaryVerticalPadding]
        //Top Lables
        baseLayout.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-virticalPadding-[lblWellcome]-virticalPadding-|", options: [.alignAllLeading, .alignAllTrailing], metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        self.addConstraints(baseLayout.control_H)
        
        baseLayout.control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-50-[lblWellcome]-horizontalPadding-[lblAppTitle]", options: [.alignAllLeading, .alignAllTrailing], metrics: baseLayout.metrics, views: baseLayout.viewDictionary)
        self.addConstraints(baseLayout.control_V)
        
        
        //button
        
        btnLogin.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        btnLogin.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        btnLogin.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: SystemConstants.IS_IPAD ? 0.7 : 0.9, constant: 0).isActive = true
        
        //Bottom Icon
        
        baseLayout.size_Height = NSLayoutConstraint(item: imgAppIcon, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: bottomIconHeight)
        self.addConstraint(baseLayout.size_Height)
        
        baseLayout.size_Width = NSLayoutConstraint(item: imgAppIcon, attribute: .width, relatedBy: .equal, toItem: imgAppIcon, attribute: .height, multiplier: 1.0, constant: 0)
        self.addConstraint(baseLayout.size_Width)
        
        baseLayout.position_CenterX = NSLayoutConstraint(item: imgAppIcon, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0)
        self.addConstraint(baseLayout.position_CenterX)
        
        baseLayout.position_Bottom = NSLayoutConstraint(item: imgAppIcon, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -1 * horizontalPadding)
        self.addConstraint(baseLayout.position_Bottom)
        
        
    }
    
    // MARK: - Public Interface -
    
    // MARK: - User Interaction -
    
    func onLoginClick()
    {
        AppUtility.isNetworkAvailableWithBlock { (isAvailable) in
            if isAvailable == true{
                if self.btnLoginTouchUp != nil
                {
                    self.btnLoginTouchUp("login" as AnyObject,nil)
                }
            }
            else{
                AppUtility.showWhisperAlert(message: ErrorMessage.noInternet, duration: 1.0)
            }
        }
        
    }
    
    // MARK: - Internal Helpers -
    
    func btnLoginTapped(event: @escaping ControlTouchUpInsideEvent) {
        btnLoginTouchUp = event
    }
    
    // MARK: - Server Request -
    
}

