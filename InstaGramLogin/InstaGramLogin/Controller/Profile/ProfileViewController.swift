
import UIKit
import Alamofire


class ProfileViewController: BaseViewController {
    
    // Mark: - Attributes -
    var profileView : ProfileView!
    var isProfileRequestCompleted = false
    
    // MARK: - Lifecycle -
    
    override init() {
        
        var username : String = " " // Don't remove blank space from username it may affect the UI in navigation view of profile.
        
        if let name : String = AppUtility.getUserDefaultsObjectForKey("LoginUserName") as? String{
            username = name
        }
        
        profileView = ProfileView(frame:CGRect.zero)
        super.init(iView: profileView, andNavigationTitle: username)
        
        self.loadViewControls()
        self.setViewlayout()
        self.changeShowSettingsScreen()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        print("ProfileView ViewController deinit called")
        NotificationCenter.default.removeObserver(self)
        
        if profileView != nil && profileView.superview != nil {
            profileView.removeFromSuperview()
            profileView = nil
        }
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Layout -
    override func loadViewControls() {
        super.loadViewControls()
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func setViewlayout() {
        super.setViewlayout()
        super.expandViewInsideView()
    }
    
    // MARK: - Public Interface -
    
    func changeSettingsScreen(){
        let btnLogout : UIButton! = UIButton(type: .custom)
        btnLogout.setImage(UIImage(named: "logout")?.maskWithColor(.white), for: .normal)
        btnLogout.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        btnLogout.imageEdgeInsets = SystemConstants.IS_IPAD ? UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5 ) : UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        btnLogout.addTarget(self, action: #selector(self.btnLogoutTapped(sender:)), for: .touchUpInside)
        let buttonItembtnLogout : UIBarButtonItem! = UIBarButtonItem(customView: btnLogout)
        
        self.navigationItem.setLeftBarButtonItems([buttonItembtnLogout], animated: true)
        
        let btnReload : UIButton! = UIButton(type: .custom)
        btnReload.setImage(UIImage(named: "BarButton_Refresh")?.maskWithColor(.white), for: .normal)
        btnReload.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        btnReload.imageEdgeInsets = SystemConstants.IS_IPAD ? UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5 ) : UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        btnReload.addTarget(self, action: #selector(self.btnReloadTapped(sender:)), for: .touchUpInside)
        let buttonItemReload : UIBarButtonItem! = UIBarButtonItem(customView: btnReload)
     
        self.navigationItem.setRightBarButtonItems([buttonItemReload], animated: true)
    }
    
    func changeShowSettingsScreen(){
        
        let btnLogout : UIButton! = UIButton(type: .custom)
        btnLogout.setImage(UIImage(named: "logout")?.maskWithColor(.white), for: .normal)
        btnLogout.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        btnLogout.imageEdgeInsets = SystemConstants.IS_IPAD ? UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5 ) : UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        btnLogout.addTarget(self, action: #selector(self.btnLogoutTapped(sender:)), for: .touchUpInside)
        let buttonItembtnLogout : UIBarButtonItem! = UIBarButtonItem(customView: btnLogout)
        
        self.navigationItem.setLeftBarButtonItems([buttonItembtnLogout], animated: true)
        
        let btnReload : UIButton! = UIButton(type: .custom)
        btnReload.setImage(UIImage(named: "BarButton_Refresh")?.maskWithColor(.white), for: .normal)
        btnReload.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        btnReload.imageEdgeInsets = SystemConstants.IS_IPAD ? UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5 ) : UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        btnReload.addTarget(self, action: #selector(self.btnReloadTapped(sender:)), for: .touchUpInside)
        let buttonItemReload : UIBarButtonItem! = UIBarButtonItem(customView: btnReload)
       
        self.navigationItem.setRightBarButtonItems([buttonItemReload], animated: true)
    }
    
    
    // MARK: - User Interaction -
  
    
    func handleLongPressOnCell(sender : UILongPressGestureRecognizer) {
        if sender.state != .ended {
            return
        }
       
    }
    
    @objc private func btnReloadTapped(sender : UIButton) {
        
       
            if AppUtility.getUserDefaultsObjectForKey("LoginUserName") != nil {
                
                let username : String = AppUtility.getUserDefaultsObjectForKey("LoginUserName") as! String
                self.profileView.userProfileRequest(userName: username)
                
            }
        
    }
    
    @objc private func btnLogoutTapped(sender : UIButton) {
        AppUtility.executeTaskInGlobalQueueWithCompletion { [weak self] in
            if self == nil{
                return
            }
            self?.logoutUser()
        }
    }
    
    private func logoutUser() -> Void
    {
        AppUtility.executeTaskInMainQueueWithCompletion { [weak self] in
            if self == nil {
                return
            }
            
            let alertView : UIAlertController! = UIAlertController(title: "logoutConfirmation".localize(), message: "logoutDescription".localize(), preferredStyle: UIAlertControllerStyle.alert)
            
            alertView.addAction(UIAlertAction(title: "NO".localize(), style: .destructive, handler: nil))
            alertView.addAction(UIAlertAction(title: "YES".localize(), style: .default, handler: { [weak self] (action) in
                if self == nil{
                    return
                }
                self?.userProfileLogoutRequest()
            }))
            
            self?.present(alertView, animated: true, completion: nil)
        }
    }
    
    // MARK: - Internal Helpers -
    
    // MARK: - Server Request -
    public func userProfileLogoutRequest()
    {
        profileView.operationQueue.addOperation { [weak self] in
            if self == nil{
                return
            }
            let dicParameter : NSMutableDictionary = NSMutableDictionary()
            
            var headers : HTTPHeaders = HTTPHeaders.init()
            let csrftoken = AppUtility.getCsrftokenFromUserDefaults()
            let mid = AppUtility.getMidFromUserDefaults()
            let sessionid = AppUtility.getSessionidFromUserDefaults()
            let ds_user_id = AppUtility.getDs_user_idFromUserDefaults()
            
            headers[APIConstant.referer] = APIConstant.baseURL
            headers[APIConstant.xcsrftoken] = csrftoken
            headers[APIConstant.rur] = "ATN"
            
            headers[APIConstant.cookie] = "\(APIConstant.csrftoken)=\(csrftoken);                                              \(APIConstant.mid)=\(mid);                                                          \(APIConstant.ig_vw)=1535;                                                          \(APIConstant.ig_pr)=\(APIConstant.ig_prValue);                                         \(APIConstant.ds_user_id)=\(ds_user_id);                                            \(APIConstant.sessionid)=\(sessionid);                                              \(APIConstant.s_network)="
            headers[APIConstant.ig_pr] = APIConstant.ig_prValue
            headers[APIConstant.ig_vw] = APIConstant.ig_vwValue
            headers[APIConstant.s_network] = ""
            headers[APIConstant.accept] = APIConstant.accepthtml
            headers["upgrade-insecure-requests"] = "1"
            
            let userprofileApi = "\(APIConstant.logout)"
            dicParameter .setValue(csrftoken, forKey: "csrfmiddlewaretoken")
            
            BaseAPICall.shared.postReques(URL: userprofileApi, Parameter: dicParameter, Type: APITask.Logout, Headers: headers, completionHandler: {  [weak self] (result) in
                if self == nil{
                    return
                }
                
                switch result{
                case .Success(_, _):
                    AppUtility.deleteAllCookies()
                    AppUtility.clearUserDefaults()
                    AppUtility.clearUserDefaultsForKey(UserDefaultKey.loginUserData)
                    AppUtility.clearUserDefaultsForKey(APIConstant.sessionid)
                    self?.profileView.hideProgressHUD()
                    AppUtility.getAppDelegate().navigationController.viewControllers = [LoginViewController.init()]
                    
                    break
                case .Error( _):
                    
                    self?.profileView.hideProgressHUD()
                    AppUtility.deleteAllCookies()
                    AppUtility.clearUserDefaults()
                    AppUtility.clearUserDefaultsForKey(UserDefaultKey.loginUserData)
                    AppUtility.clearUserDefaultsForKey(APIConstant.sessionid)
                     AppUtility.getAppDelegate().navigationController.viewControllers = [LoginViewController.init()]
                    
                    break
                case .Internet(let isOn):
                    self?.profileView.handleNetworkCheck(isAvailable: isOn, viewController: self!.profileView, showLoaddingView: true)
                    break
                }
            })
        }
    }
    
}
