
import UIKit

class BaseNavigationController: UINavigationController,UIGestureRecognizerDelegate {

    // MARK: - Interface
    @IBInspectable open var clearBackTitle: Bool = true
    
    
    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaultParameters()
    }
    
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: - Public Interface -
    func setDefaultParameters(){
        
        var navigationBarFont: UIFont? = UIFont(name: FontStyle.regular, size: SystemConstants.IS_IPAD ? 22.0 : 18.0)
       
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: Color.navigationTitle.value,NSFontAttributeName: navigationBarFont!] as [String : Any]
        
        self.navigationBar.tintColor =  UIColor.white //Color.navigationTitle.value
        
        self.navigationBar.barTintColor = Color.navigationBG.value
        self.navigationBar.isTranslucent = false
        
        self.view.backgroundColor = UIColor.clear
        
        defer{
            navigationBarFont = nil
        }
    }
   
    
    func setPopOverParameters(){
        
    }
    
    // MARK: - User Interaction -
    override open func pushViewController(_ viewController: UIViewController, animated: Bool) {
        controlClearBackTitle()
        super.pushViewController(viewController, animated: animated)
    }
    
    override open func show(_ vc: UIViewController, sender: Any?) {
        controlClearBackTitle()
        super.show(vc, sender: sender)
    }
    
    // MARK: - Internal Helpers -
}

extension BaseNavigationController {
    
    func controlClearBackTitle() {
        if self.clearBackTitle {
            topViewController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
    }
    
}
