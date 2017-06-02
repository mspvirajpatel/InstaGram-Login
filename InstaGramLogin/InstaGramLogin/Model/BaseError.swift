

import Foundation
import Whisper

class BaseError: NSObject {

    // MARK: - Attributes -

    var errorCode: String = ""
    var serverMessage: String = ""
    var alertMessage: String = ""

    // MARK: - Lifecycle -
    
    deinit{
        
    }
    
    // MARK: - Public Interface -
    
    class func getError(responseObject: AnyObject , task : APITask) -> BaseError{
        
        let error: BaseError = BaseError()

        if let code = responseObject["status"] as? Int
        {
            error.errorCode = String(code)
        }
        else if let code = responseObject["status"] as? String
        {
            error.errorCode = code
        }
        else if let meta = responseObject["meta"] as? NSDictionary{
            
            if let code = meta["code"]{
                if code is Int{
                    error.errorCode = String(code as! Int)
                }
                else if code is String{
                    
                    error.errorCode = code as! String
                }
            }
            if let msg = meta["error_message"] as? String{
                
                error.serverMessage = msg
            }
        }
        else
        {
            error.errorCode = ""
        }
        
        if(error.errorCode == ""){
            error.errorCode = "1";
        }
        
        if let code = responseObject["message"] as? String
        {
            error.serverMessage = String(code)
        }
        
        error.alertMessage = error.serverMessage;

//        print("---------------------");
//        print("Request Type: %@", task.rawValue);
//        print("Error Code: %@", error.errorCode);
//        print("Server Message: %@", error.serverMessage);
//        
//        print("Alert Message: %@", error.alertMessage);
//        print("---------------------");
        
        return error
    }
    
    // MARK: - Internal Helpers -
    
}
