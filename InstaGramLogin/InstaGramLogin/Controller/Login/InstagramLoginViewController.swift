
import UIKit
import Alamofire

class InstagramLoginViewController:BaseViewController{
    
    // MARK :- Attributes -
    
    var webView : UIWebView!
    var loginView : InstagramLoginView!
    
    // MARK :- Life Cycle -
    
    override init()
    {
        let  subView : InstagramLoginView = InstagramLoginView(frame:CGRect.zero)
        super.init(iView: subView, andNavigationTitle: "Login")
        
        loginView = subView
        self.loadViewControls()
        self.setViewlayout()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        var btnDismiss : UIButton! = UIButton(type: .custom)
        btnDismiss.setImage(UIImage(named: "closed")?.maskWithColor(.white), for: .normal)
        btnDismiss.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        btnDismiss.imageEdgeInsets = SystemConstants.IS_IPAD ? UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5 ) : UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        btnDismiss.addTarget(self, action: #selector(self.btnDismissTapped(sender:)), for: .touchUpInside)
        var buttonItemDismiss : UIBarButtonItem! = UIBarButtonItem(customView: btnDismiss)
        
        self.navigationItem.setRightBarButtonItems([buttonItemDismiss], animated: true)
        defer {
            btnDismiss = nil
            buttonItemDismiss = nil
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    @objc private func btnDismissTapped(sender : UIButton) {
        self.dismiss(animated: true) {
        }
    }
    
    // MARK : - Layout -
    
    override func loadViewControls() {
        
        super.loadViewControls()
        
        loginView.loginEvent { [weak self] (success, object) in
            if self == nil{
                return
            }
            self?.dismiss(animated: true, completion: {
                let profileViewController: ProfileViewController = ProfileViewController()
                AppUtility.getAppDelegate().navigationController.viewControllers = [profileViewController]
            })
        }
    }
    
    override func setViewlayout() {
        
        super.setViewlayout()
        super.expandViewInsideView()
    }
}
