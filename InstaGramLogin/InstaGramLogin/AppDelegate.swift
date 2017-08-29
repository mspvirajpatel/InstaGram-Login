     
import UIKit
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationController : BaseNavigationController!
    var backgroundSessionCompletionHandler : (() -> Void)?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        BuddyBuildSDK.setup()
        
        // Override point for customization after application launch.
        
        Crashlytics().debugMode = true
        Fabric.with([Crashlytics.self,Answers.self])
        
        self.loadUI()
        UIApplication.shared.statusBarStyle = .lightContent
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {
        backgroundSessionCompletionHandler = completionHandler
    }
    
    // MARK: Public Method
    open func loadUI(){
        
        window = UIWindow(frame: UIScreen.main.bounds)
        self.displayHome()
        window?.makeKeyAndVisible()
    }
    
    // MARK: Internal Helper
    private func displayHome() {
        
       
        if let _ : String = AppUtility.getUserDefaultsObjectForKey("LoginUserName") as? String{
           let homeController : ProfileViewController = ProfileViewController()
             navigationController = BaseNavigationController(rootViewController: homeController)
        }
        else
        {
             let homeController : LoginViewController = LoginViewController()
             navigationController = BaseNavigationController(rootViewController: homeController)
        }
       
        
        window?.rootViewController = navigationController
    }
}

