
import UIKit

class LoginViewController: BaseViewController {

    // Mark: - Attributes -
    var loginView : LoginView!
    
    // MARK: - Lifecycle -
    
    override init() {
        
        loginView = LoginView(frame:CGRect.zero)
        super.init(iView: loginView, andNavigationTitle: "")
        
        self.loadViewControls()
        self.setViewlayout()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        print("Login ViewController deinit called")
        NotificationCenter.default.removeObserver(self)
        
        if loginView != nil && loginView.superview != nil {
            loginView.removeFromSuperview()
            loginView = nil
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    // MARK: - Layout -
    override func loadViewControls() {
        super.loadViewControls()
        
        loginView.btnLoginTapped { [weak self] (sender, object) in
            if self == nil {
                return
            }
            
            let instagramloginControler = InstagramLoginViewController()
            let navController : BaseNavigationController! = BaseNavigationController(rootViewController: instagramloginControler)
            self?.navigationController?.present(navController, animated:true, completion: nil)
        }
        
    }
    
    override func setViewlayout() {
        super.setViewlayout()
        super.expandViewInsideView()
        
    }
    
    
    // MARK: - Public Interface -
    
    // MARK: - User Interaction -
   
    
    // MARK: - Internal Helpers -
    
    // MARK: - Server Request -
    
}
