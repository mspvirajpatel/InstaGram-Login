

import Foundation
import SystemConfiguration
import UserNotifications
import ReachabilitySwift

struct PushNotificationType : OptionSet {
    
    let rawValue: Int
    
    
}

open class NotificationManager: NSObject, UNUserNotificationCenterDelegate {
    
    // MARK: - Attributes -
    
    var KReloadKeyboard:String = "KReloadKeyboard"
    var KSuccessGoogleLogin:String = "KSuccessGoogleLogin"
    var KunSuccessGoogleLogin:String = "KunSuccessGoogleLogin"
 
   // MARK: - Lifecycle -
    
    static let sharedInstance : NotificationManager = {
        
        let instance = NotificationManager()
        return instance
        
    }()
    
    deinit{
        NotificationCenter.default.removeObserver(self)
     
    }
    
    // MARK: - Public Interface -
    
    open func isNetworkAvailableWithBlock(_ completion: @escaping (_ wasSuccessful: Bool) -> Void) {
      
        let reachability = Reachability()!
        
        reachability.whenReachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            DispatchQueue.main.async {
                if reachability.isReachableViaWiFi {
                    print("Reachable via WiFi")
                } else {
                    print("Reachable via Cellular")
                }
                completion(true)
            }
        }
        reachability.whenUnreachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            DispatchQueue.main.async {
                print("Not reachable")
                completion(false)
            }
            
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
            completion(false)
        }
        
    }
    
    
    // MARK: - Internal Helpers -
    
    
    func handlePushNotification(_ userInfo: [AnyHashable: Any]) {
       
        
    }
 
    
    
//    In case if you need to know the permissions granted
//    
//    UNUserNotificationCenter.current().getNotificationSettings(){ (setttings) in
//    
//    switch setttings.soundSetting{
//    case .enabled:
//    
//    print("enabled sound setting")
//    
//    case .disabled:
//    
//    print("setting has been disabled")
//    
//    case .notSupported:
//    print("something vital went wrong here")
//    }
//    }
    
}
