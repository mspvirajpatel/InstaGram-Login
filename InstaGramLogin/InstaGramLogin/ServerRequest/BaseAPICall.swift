
import UIKit
import Alamofire

// MARK: - API Task Constant -
enum APITask : String
{
    case Instagram = "Instagram"
    case Login = "Login"
    case TimeLine = "TimeLine"
    case UserProfile = "User Profile"
    
    case Logout = "Logout"
}

enum Result {
    case Success(response : AnyObject?,error : BaseError?)
    case Error(error : BaseError?)
    case Internet(isOn : Bool)
}

class BaseAPICall: NSObject
{
    class var shared: BaseAPICall
    {
        struct Static
        {
            static var instance: BaseAPICall?
        }
        
        let _onceToken = NSUUID().uuidString
        
        DispatchQueue.once(token: _onceToken) {
            Static.instance = BaseAPICall()
        }
        return Static.instance!
    }
    

    func postReques(URL url : String , Parameter param : NSDictionary , Type type : APITask,Headers header: HTTPHeaders , completionHandler : @escaping (_ result : Result) -> ()){
        AppUtility.isNetworkAvailableWithBlock { (isAvailable) in
            if isAvailable == true{
                completionHandler(Result.Internet(isOn: true))
                
                var requestURL : String! = APIConstant.baseURL + url

//                print("---------------------")
//                print("\(type.rawValue) request :- \(param .JSONString())")
//                print("Request URL :- \(requestURL)")
//                print("---------------------")
                
                Alamofire.request(requestURL, method:.post, parameters: param as? Parameters, encoding: URLEncoding(destination: .httpBody), headers: header).responseJSON(completionHandler: { (response) in
                    if let
                        headerFields = response.response?.allHeaderFields as? [String: String],
                        let URL = response.request?.url
                    {
                        let cookies = HTTPCookieStorage.shared.cookies(for: URL)
                      
                        HTTPCookieStorage.shared.setCookies(cookies!, for: URL, mainDocumentURL: nil)
                        
                        for cookie in cookies! {
                            var cookieProperties = [HTTPCookiePropertyKey : Any]()
                            cookieProperties[HTTPCookiePropertyKey.name] = cookie.name
                            cookieProperties[HTTPCookiePropertyKey.value] = cookie.value
                            cookieProperties[HTTPCookiePropertyKey.domain] = cookie.domain
                            cookieProperties[HTTPCookiePropertyKey.path] = cookie.path
                            cookieProperties[HTTPCookiePropertyKey.version] = NSNumber(value: cookie.version)
                            cookieProperties[HTTPCookiePropertyKey.expires] = NSDate().addingTimeInterval(31536000)
                            
                            let newCookie = HTTPCookie(properties: cookieProperties)
                            HTTPCookieStorage.shared.setCookie(newCookie!)
                            if  cookie.name == APIConstant.sessionid
                            {
                                let strsession : String? = AppUtility.getUserDefaultsObjectForKey(APIConstant.sessionid) as? String
                                if strsession == nil
                                {
                                    AppUtility.setUserDefaultsObject(cookie.value as AnyObject, forKey: cookie.name)
                                }
                            }
                            else{
                                AppUtility.setUserDefaultsObject(cookie.value as AnyObject, forKey: cookie.name)
                            }

                            
                            //print("name: \(cookie.name) value: \(cookie.value)")
                        }
                    }
                    
                    switch response.result
                    {
                    case .success(let responseJSON):
                        
                        guard let dicResponse = responseJSON as? NSDictionary else{
                            return
                        }
                        
                        //print("Response : \((dicResponse) .JSONString())")
                        
                        var handledResopnse : (BaseError? , AnyObject?)! = self.handleResponse(response: dicResponse, task: type)
                        if handledResopnse.1 != nil{
                            completionHandler(Result.Success(response: handledResopnse.1, error: handledResopnse.0))
                        }
                        else{
                            completionHandler(Result.Error(error: handledResopnse.0))
                        }
                        defer{
                            handledResopnse = nil
                        }
                        break
                    case .failure(let error):
                        completionHandler(Result.Error(error: self.handleFailure(error: error)))
                        break
                    }
                })
                
                requestURL = nil
                
            }
            else{
                completionHandler(Result.Internet(isOn: false))
            }
        }
    }
    
    
    func getRequest(URL url : String , Parameter param : NSDictionary , Task type : APITask, completionHandler : @escaping (_ result : Result) -> ()) -> Void
    {
        
        AppUtility.isNetworkAvailableWithBlock { (isAvailable) in
            if isAvailable == true{
                completionHandler(Result.Internet(isOn: true))
                var requestURL : String!
                
                requestURL = APIConstant.baseURL + url
                

                //var requestURL : String! = APIConstant.baseURL + url
                
//                print("---------------------")
//                print("\(type.rawValue) request :- \(param .JSONString())")
//                print("Request URL :- \(requestURL!)")
//                print("---------------------")
                let headers = [
                    "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
                    "Accept": "application/json"
                ]
                
                Alamofire.request(requestURL, method:.get, parameters: param as? Parameters, encoding: URLEncoding(destination: .httpBody), headers: headers).responseJSON(completionHandler: { (response) in
                    if let
                        headerFields = response.response?.allHeaderFields as? [String: String],
                        let URL = response.request?.url
                    {
                        let cookies = HTTPCookieStorage.shared.cookies(for: URL)
                      
                        
                        HTTPCookieStorage.shared.setCookies(cookies!, for: URL, mainDocumentURL: nil)
                        
                        for cookie in cookies! {
                            var cookieProperties = [HTTPCookiePropertyKey : Any]()
                            cookieProperties[HTTPCookiePropertyKey.name] = cookie.name
                            cookieProperties[HTTPCookiePropertyKey.value] = cookie.value
                            cookieProperties[HTTPCookiePropertyKey.domain] = cookie.domain
                            cookieProperties[HTTPCookiePropertyKey.path] = cookie.path
                            cookieProperties[HTTPCookiePropertyKey.version] = NSNumber(value: cookie.version)
                            cookieProperties[HTTPCookiePropertyKey.expires] = NSDate().addingTimeInterval(31536000)
                            
                            let newCookie = HTTPCookie(properties: cookieProperties)
                            HTTPCookieStorage.shared.setCookie(newCookie!)
                            if  cookie.name == APIConstant.sessionid
                            {
                                let strsession : String? = AppUtility.getUserDefaultsObjectForKey(APIConstant.sessionid) as? String
                                if strsession == nil
                                {
                                    AppUtility.setUserDefaultsObject(cookie.value as AnyObject, forKey: cookie.name)
                                }
                            }
                            else{
                                AppUtility.setUserDefaultsObject(cookie.value as AnyObject, forKey: cookie.name)
                            }

                            
                           // AppUtility.setUserDefaultsObject(cookie.value as AnyObject, forKey: cookie.name)
                            
                           // print("name: \(cookie.name) value: \(cookie.value)")
                        }
                    }
                    
                    switch response.result
                    {
                    case .success(let responseJSON):
                        
                        guard let dicResponse = responseJSON as? NSDictionary else{
                            return
                        }
                        
                        //print("Response : \((dicResponse) .JSONString())")
                        
                        var handledResopnse : (BaseError? , AnyObject?)! = self.handleResponse(response: dicResponse, task: type)
                        if handledResopnse.1 != nil
                        {
                            completionHandler(Result.Success(response: handledResopnse.1, error: handledResopnse.0))
                        }
                        else
                        {
                            completionHandler(Result.Error(error: handledResopnse.0))
                        }
                        
                        defer{
                            handledResopnse = nil
                        }
                        
                        break
                    case .failure(let error):
                        completionHandler(Result.Error(error: self.handleFailure(error: error)))
                        break
                    }
                })
            }
            else{
                completionHandler(Result.Internet(isOn: false))
            }
        }
    }
    
    func getInstgramRequest(URL url : String , Parameter param : NSDictionary , Task type : APITask,Headers header: HTTPHeaders , completionHandler : @escaping (_ result : Result) -> ()) -> Void
    {
        
        AppUtility.isNetworkAvailableWithBlock { (isAvailable) in
            if isAvailable == true{
                completionHandler(Result.Internet(isOn: true))
                var requestURL : String! = APIConstant.baseURL + url
                
//                print("---------------------")
//                print("\(type.rawValue) request :- \(param .JSONString())")
//                print("Request URL :- \(requestURL!)")
//                print("---------------------")
                
                
                Alamofire.request(requestURL, method:.get, parameters: param as? Parameters, encoding: URLEncoding(destination: .httpBody), headers: header).responseJSON(completionHandler: { (response) in
                    
                    if let
                        headerFields = response.response?.allHeaderFields as? [String: String],
                        let URL = response.request?.url
                    {
                        let cookies = HTTPCookieStorage.shared.cookies(for: URL)
                        
                        HTTPCookieStorage.shared.setCookies(cookies!, for: URL, mainDocumentURL: nil)
                        
                        for cookie in cookies! {
                            var cookieProperties = [HTTPCookiePropertyKey : Any]()
                            cookieProperties[HTTPCookiePropertyKey.name] = cookie.name
                            cookieProperties[HTTPCookiePropertyKey.value] = cookie.value
                            cookieProperties[HTTPCookiePropertyKey.domain] = cookie.domain
                            cookieProperties[HTTPCookiePropertyKey.path] = cookie.path
                            cookieProperties[HTTPCookiePropertyKey.version] = NSNumber(value: cookie.version)
                            cookieProperties[HTTPCookiePropertyKey.expires] = NSDate().addingTimeInterval(31536000)
                            
                            let newCookie = HTTPCookie(properties: cookieProperties)
                            HTTPCookieStorage.shared.setCookie(newCookie!)
                            if  cookie.name == APIConstant.sessionid
                            {
                                let strsession : String? = AppUtility.getUserDefaultsObjectForKey(APIConstant.sessionid) as? String
                                if strsession == nil
                                {
                                    AppUtility.setUserDefaultsObject(cookie.value as AnyObject, forKey: cookie.name)
                                }
                            }
                            else{
                                AppUtility.setUserDefaultsObject(cookie.value as AnyObject, forKey: cookie.name)
                            }

                           // print("name: \(cookie.name) value: \(cookie.value)")
                        }
                    }
                    
                    switch response.result
                    {
                    case .success(let responseJSON):
                        
                        guard let dicResponse = responseJSON as? NSDictionary else{
                            return
                        }
                        
                        //print("Response : \(type) : \((dicResponse) .JSONString())")
                        
                        var handledResopnse : (BaseError? , AnyObject?)! = self.handleResponse(response: dicResponse, task: type)
                        if handledResopnse.1 != nil
                        {
                            completionHandler(Result.Success(response: handledResopnse.1, error: handledResopnse.0))
                        }
                        else
                        {
                            completionHandler(Result.Error(error: handledResopnse.0))
                        }
                        
                        defer{
                            handledResopnse = nil
                        }
                        
                        break
                    case .failure(let error):
                        
                        completionHandler(Result.Error(error: self.handleFailure(error: error)))
                        break
                    }
                })
            }
            else{
                completionHandler(Result.Internet(isOn: false))
            }
        }
    }
    
    func localAPIspostRequest(URL url : String , Parameter param : NSDictionary , Type type : APITask,Headers header: HTTPHeaders , completionHandler : @escaping (_ result : Result) -> ()){
        AppUtility.isNetworkAvailableWithBlock { (isAvailable) in
            if isAvailable == true{
                completionHandler(Result.Internet(isOn: true))
                
                var requestURL : String! = url
                
                print("---------------------")
                print("\(type.rawValue) request :- \(param .JSONString())")
                print("Request URL :- \(requestURL)")
                print("---------------------")
                
                Alamofire.request(requestURL, method:.post, parameters: param as? Parameters, encoding: URLEncoding(destination: .httpBody), headers: header).responseJSON(completionHandler: { (response) in
                  
                    switch response.result
                    {
                    case .success(let responseJSON):
                        
                        guard let dicResponse = responseJSON as? NSDictionary else{
                            return
                        }
                        
                        print("Response : \((dicResponse) .JSONString())")
                        
                        var handledResopnse : (BaseError? , AnyObject?)! = self.handleResponse(response: dicResponse, task: type)
                        if handledResopnse.1 != nil{
                            completionHandler(Result.Success(response: handledResopnse.1, error: handledResopnse.0))
                        }
                        else{
                            completionHandler(Result.Error(error: handledResopnse.0))
                        }
                        defer{
                            handledResopnse = nil
                        }
                        break
                    case .failure(let error):
                        completionHandler(Result.Error(error: self.handleFailure(error: error)))
                        break
                    }
                })
                
                requestURL = nil
                
            }
            else{
                completionHandler(Result.Internet(isOn: false))
            }
        }
    }
    
    func uploadImage (url: String, Parameter param : NSDictionary, Images arrImage: NSArray, Type type : APITask , completionHandler : @escaping (_ result : Result) -> ()) -> Void
    {
        
        AppUtility.isNetworkAvailableWithBlock { (isAvailable) in
            
            if isAvailable == true{
                completionHandler(Result.Internet(isOn: true))
                var requestURL : String! = APIConstant.baseURL + url
                let headers = [
                    "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
                    "Accept": "application/json"
                ]
                
//                print("---------------------")
//                print("\(type.rawValue) request :- \(param .JSONString())")
//                print("Request URL :- \(requestURL)")
//                print("---------------------")
                
                
                Alamofire.upload(multipartFormData: { (data) in
                    
                    for (key, value) in param {
                        data.append((value as! String).data(using: .utf8)!, withName: key as! String)
                    }
                    
                    for imageInfo in arrImage
                    {
                        var dicInfo : NSDictionary! = imageInfo as! NSDictionary
                        data.append(dicInfo["data"] as! Data, withName: dicInfo["name"] as! String, fileName: dicInfo["fileName"] as! String, mimeType: dicInfo["type"] as! String)
                        dicInfo = nil
                    }
                    
                }, to: requestURL, method: .post , headers:nil, encodingCompletion: { (encodeResult) in
                    switch encodeResult {
                    case .success(let upload, _, _):
                        
                        upload.responseJSON(completionHandler: { (response) in
                            
                            switch response.result
                            {
                            case .success(let responseJSON):
                                guard let dicResponse = responseJSON as? NSDictionary else{
                                    return
                                }
                                
                               //print("Response : \((dicResponse) .JSONString())")
                                
                                var handledResopnse : (BaseError? , AnyObject?)! = self.handleResponse(response: dicResponse, task: type)
                                
                                if handledResopnse.1 != nil{
                                    completionHandler(Result.Success(response: handledResopnse.1, error: handledResopnse.0))
                                }
                                else{
                                    completionHandler(Result.Error(error: handledResopnse.0))
                                }
                                
                                defer{
                                    handledResopnse = nil
                                }
                                
                            case .failure(let error):
                                
                                print(error)
                                completionHandler(Result.Error(error: self.handleFailure(error: error)))
                                break
                            }
                        })
                    case .failure(let error):
                        completionHandler(Result.Error(error: self.handleFailure(error: error)))
                        break
                    }
                })
            }
            else{
                completionHandler(Result.Internet(isOn: false))
            }
        }
    }
    
    private func handleResponse(response : AnyObject,task : APITask) -> (BaseError? , AnyObject?){
        
        var baseError : BaseError! = BaseError.getError(responseObject: response, task: task)
        
        if baseError.errorCode == "1" || baseError.errorCode == "ok" || baseError.errorCode == "200" { // 1 is success code, here we need to set success code as per project and api backend. its may 1 or 200, depend on API
            var modelResponse : AnyObject! = MainResponse().getModelFromResponse(response: response , task: task)
            defer{
                modelResponse = nil
                baseError = nil
            }
            return (baseError,modelResponse)
        }
        else if baseError.errorCode == "400"
        {
            AppUtility.clearUserDefaults()
            AppUtility.deleteAllCookies()
            //AppUtility.getAppDelegate().displayLoginViewOnWindow()
            defer{
                baseError = nil
            }
            return (baseError, nil)
        }
        else{
            defer{
                baseError = nil
            }
            return (baseError, nil)
        }
    }
    
    private func handleFailure(error : Error) -> BaseError{
        
        print("Error : \(error.localizedDescription)")
        
        var baseError : BaseError! = BaseError()
        
        switch error._code{
        case NSURLErrorTimedOut:
            baseError.errorCode = String(error._code)
            baseError.alertMessage = "Server is not responding please try again after some time."
            baseError.serverMessage = "Server is not responding please try again after some time."
            break
        case NSURLErrorNetworkConnectionLost:
            baseError.errorCode = String(error._code)
            baseError.alertMessage = "Network connection lost try again."
            baseError.serverMessage = "Network connection lost try again."
            break
        default:
            baseError.errorCode = String(-1)
            baseError.alertMessage = "Something wants wrong please try again leter."
            baseError.serverMessage = "Something wants wrong please try again leter."
            break
        }
        
        defer{
            baseError = nil
        }
        return baseError
    }
    
}

//Get All Cookies 



