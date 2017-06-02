//
//  AppUtility.swift
//  ViewControllerDemo
//
//  Created by SamSol on 24/08/15.
//  Copyright (c) 2015 SamSol. All rights reserved.
//

import UIKit
import Whisper

class AppUtility: NSObject {
   
    //  MARK: - Network Connection Methods
    
    class func isNetworkAvailableWithBlock(_ completion: @escaping (_ wasSuccessful: Bool) -> Void) {

        NotificationManager.sharedInstance.isNetworkAvailableWithBlock { (wasSuccessful) in
            completion(wasSuccessful)
        }
    }

    class func clearImageData() {
       
    }
    //  MARK: - User Defaults Methods
    
    class func getUserDefaultsObjectForKey(_ key: String) -> AnyObject? {
        let object: AnyObject? = UserDefaults.standard.object(forKey: key) as AnyObject?
        return object
    }
    
    class func setUserDefaultsObject(_ object: AnyObject, forKey key: String) {
        UserDefaults.standard.set(object, forKey:key)
        UserDefaults.standard.synchronize()
    }
    
    class func clearUserDefaultsForKey(_ key: String) {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func clearUserDefaults(){
        let appDomain: String = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: appDomain)
        UserDefaults.standard.synchronize()
    }
    
    class func setUserDefaultsCustomObject(_ object: AnyObject, forKey key: String) {
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: object)
        UserDefaults.standard.set(encodedData, forKey:key)
        UserDefaults.standard.synchronize()
    }
    
    class func getUserDefaultsCustomObjectForKey(_ key: String)-> AnyObject? {
        let decoded  =  UserDefaults.standard.object(forKey: key) as? Data
        if decoded != nil {
            let decodedTeams = NSKeyedUnarchiver.unarchiveObject(with: decoded!)
            return decodedTeams! as AnyObject?
        }
        return nil
    }
    
    class func deleteAllCookies() {
        
        let cookieStore = HTTPCookieStorage.shared
        for cookie in cookieStore.cookies ?? [] {
            cookieStore.deleteCookie(cookie)
        }
        self.clearUserDefaults()
    }
    
    class func getDocumentDirectoryPath() -> String
    {
        let arrPaths : NSArray = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        return arrPaths[0] as! String
    }
    class func stringByPathComponet(fileName : String , Path : String) -> String
    {
        var tmpPath : NSString = Path as NSString
        tmpPath = tmpPath.appendingPathComponent(fileName) as NSString
        return tmpPath as String
    }
    
    //  MARK: - UIDevice Methods
    
    class func getDeviceIdentifier()->String{
        let deviceUUID: String = UIDevice.current.identifierForVendor!.uuidString
        return deviceUUID
    }
    
    //  MARK: - Misc Methods
    
    class func getAppDelegate()->AppDelegate{
        let appDelegate: UIApplicationDelegate = UIApplication.shared.delegate!
        return appDelegate as! AppDelegate
    }
    
    
    //  MARK: - Time-Date Methods
    
    class func convertDateToLocalTime(_ iDate: Date) -> Date {
        let timeZone: TimeZone = TimeZone.autoupdatingCurrent
        let seconds: Int = timeZone.secondsFromGMT(for: iDate)
        return Date(timeInterval: TimeInterval(seconds), since: iDate)
    }
    
    class func convertDateToGlobalTime(_ iDate: Date) -> Date {
        let timeZone: TimeZone = TimeZone.autoupdatingCurrent
        let seconds: Int = -timeZone.secondsFromGMT(for: iDate)
        return Date(timeInterval: TimeInterval(seconds), since: iDate)
    }
    
    class func getCurrentDateInFormat(_ format: String)->String{
        
        let usLocale: Locale = Locale(identifier: "en_US")
        
        let timeFormatter: DateFormatter = DateFormatter()
        timeFormatter.dateFormat = format
        
        timeFormatter.timeZone = TimeZone.autoupdatingCurrent
        timeFormatter.locale = usLocale
        
        let date: Date = Date()
        let stringFromDate: String = timeFormatter.string(from: date)
        
        return stringFromDate
    }
    
    class func getDate(_ date: Date, inFormat format: String) -> String {
        
        let usLocale: Locale = Locale(identifier: "en_US")
        let timeFormatter: DateFormatter = DateFormatter()
        
        timeFormatter.dateFormat = format
        timeFormatter.timeZone = TimeZone.autoupdatingCurrent
        
        timeFormatter.locale = usLocale
        
        let stringFromDate: String = timeFormatter.string(from: date)
        
        return stringFromDate
    }
    
    
    class func convertStringDateFromFormat(_ inputFormat:String, toFormat outputFormat:String, fromString dateString:String)->String{
        
        let usLocale: Locale = Locale(identifier: "en_US")
        
        var dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.locale = usLocale
        dateFormatter.dateFormat = inputFormat
        
        dateFormatter = DateFormatter()
        let date: Date = dateFormatter.date(from: dateString)!
        
        dateFormatter.locale = usLocale
        dateFormatter.dateFormat = outputFormat
        
        let resultedDateString: String = dateFormatter.string(from: date)
        
        return resultedDateString
    }
    
    class func getTimeStampForCurrentTime()->String{
        let timestampNumber: NSNumber = NSNumber(value: (Date().timeIntervalSince1970) * 1000 as Double)
        return timestampNumber.stringValue
    }
    
    class func getTimeStampFromDate(_ iDate: Date) -> String {
        let timestamp: String = String(iDate.timeIntervalSince1970)
        return timestamp
    }
    
    class func getCurrentTimeStampInGMTFormat() -> String {
        return AppUtility.getTimeStampFromDate(AppUtility.convertDateToGlobalTime(Date()))
    }
    
    //  MARK: - GCD Methods
    
    class func executeTaskAfterDelay(_ delay: CGFloat, completion completionBlock: @escaping () -> Void)
    {
        DispatchQueue.global(qos: .default).asyncAfter(deadline: DispatchTime.now() + Double(Int64(delay * CGFloat(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) { 
            completionBlock()
        }
    }
    
    class func executeTaskInMainThreadAfterDelay(_ delay: CGFloat, completion completionBlock: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(delay * CGFloat(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {() -> Void in
            completionBlock()
        })
    }
    
    class func executeTaskInGlobalQueueWithCompletion(_ completionBlock: @escaping () -> Void) {
        DispatchQueue.global(qos: .default).async(execute: {() -> Void in
            completionBlock()
        })
    }
    
    class func executeTaskInMainQueueWithCompletion(_ completionBlock: @escaping () -> Void) {
        DispatchQueue.main.async(execute: {() -> Void in
            completionBlock()
        })
    }
    
    class func executeTaskInGlobalQueueWithSyncCompletion(_ completionBlock: () -> Void) {
        DispatchQueue.global(qos: .default).sync(execute: {() -> Void in
            completionBlock()
        })
    }
    
    class func executeTaskInMainQueueWithSyncCompletion(_ completionBlock: () -> Void) {
        DispatchQueue.main.sync(execute: {() -> Void in
            completionBlock()
        })
    }
    
    //  MARK: - Data Validation Methods
    
    class func isValidEmail(_ checkString: String)->Bool{
        
        let laxString: String = "^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$"
        
        let emailRegex: String = laxString
        
        let emailTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: checkString)
    }
    
    class func isValidPhone(_ phoneNumber: String) -> Bool {
        let phoneRegex: String = "^((\\+)|(00))[0-9]{6,14}$"
        let phoneTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@",phoneRegex)
        return phoneTest.evaluate(with: phoneNumber)
    }
    
    class func isValidURL(_ candidate: String) -> Bool {
        let urlRegEx: String = "(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"
        let urlTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@",urlRegEx)
        return urlTest.evaluate(with: candidate)
    }
    
    class func isTextFieldBlank(_ textField : UITextField) -> Bool    {
        return (textField.text?.trimmingCharacters(in: CharacterSet.whitespaces).isEmpty)!
    }
    
    class func validateMobileNo(_ mobileNo : String) -> Bool    {
        return mobileNo.characters.count == 10 ? true : false
    }
    
    func validateCharCount(_ name: String,minLimit : Int,maxLimit : Int) -> Bool    {
        // check the name is between 4 and 16 characters
        if !(minLimit...maxLimit ~= name.characters.count) {
            return false
        }
        return true
    }
    
    func isRunningSimulator() -> Bool {
        return TARGET_OS_SIMULATOR != 0 // Use this line in Xcode 7 or newer
        
    }
    
     ///Change file size
    
//    myImageView.image =  ResizeImage(myImageView.image!, targetSize: CGSizeMake(600.0, 450.0))
//    
//    let imageData = UIImageJPEGRepresentation(myImageView.image!,0.50)
    
    func ResizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize.init(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize.init(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect.init(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    // MARK: - Show Whisper Alert Method
    class func showWhisperAlert(message : String , duration : TimeInterval)
    {
        let alert =  Murmur(title: message, backgroundColor: Color.alertBG.value, titleColor: Color.alertMessageText.value, font: UIFont(name: FontStyle.regular, size: 11.0)!)
        show(whistle: alert, action: .show(duration))
        hide(whistleAfter: duration)
    }
    
    class func showWhisperErrorAlert(message : String , duration : TimeInterval)
    {
        let alert =  Murmur(title: message, backgroundColor: Color.alertErrorBG.value, titleColor: Color.alertErrorText.value, font: UIFont(name: FontStyle.regular, size: 11.0)!)
        show(whistle: alert, action: .show(duration))
        hide(whistleAfter: duration)
    }
   
    class func suffixNumber(no : Double) -> String {
        
        var num : Double = no
        let sign = ((num < 0) ? "-" : "" );
        
        num = fabs(num);
        
        if (num < 1000.0){
            return "\(sign)\(Int(num))"
        }
        
        let exp:Int = Int(log10(num) / 3.0 )
        
        let units:[String] = ["K","M","G","T","P","E"];
        
        let roundedNum : Double = round(10 * num / pow(1000.0, Double(exp))) / 10
        
        return "\(sign)\(roundedNum)\(units[exp-1])";
    }
    
    // MARK: - Validation
 
    
    class func validateEmailWithString(email: String) -> Bool
    {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }
    
    class func validateMobileNo(mobileNo : String) -> Bool
    {
        return mobileNo.characters.count == 10 ? true : false
        //        let phoneRegex = "[0-9]{10}$"
        //        let phoneTest =  NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        //        return phoneTest.evaluateWithObject(phoneRegex)
    }
    class func isValidEmail(checkString: String)->Bool{
        
        let laxString: String = "^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$"
        
        let emailRegex: String = laxString
        
        let emailTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: checkString)
    }
    
    class func isValidPhone(phoneNumber: String) -> Bool {
        let phoneRegex: String = "^((\\+)|(00))[0-9]{6,14}$"
        let phoneTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@",phoneRegex)
        return phoneTest.evaluate(with: phoneNumber)
    }
    
    class func isValidURL(candidate: String) -> Bool {
        let urlRegEx: String = "(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"
        let urlTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@",urlRegEx)
        return urlTest.evaluate(with: candidate)
    }
    
    class func isSaveSessionId() -> Bool {
        
        if let csrftoken : String = self.getUserDefaultsObjectForKey(APIConstant.sessionid) as? String{
            return csrftoken != "" ? true : false
        }
        return false
    }
    
    class func getMidFromUserDefaults() -> String {
        
        if let csrftoken : String = self.getUserDefaultsObjectForKey(APIConstant.mid) as? String{
            return csrftoken
        }
        return ""
    }
    
    class func getRurFromUserDefaults() -> String {
        
        if let csrftoken:String = self.getUserDefaultsObjectForKey(APIConstant.rur) as? String{
            return csrftoken
        }
        return ""
    }

    class func getCsrftokenFromUserDefaults() -> String {
        
        if let csrftoken:String = self.getUserDefaultsObjectForKey(APIConstant.csrftoken) as? String{
            return csrftoken
        }
        return ""
    }
    
    class  func timeAgoSinceDate(date:NSDate, numericDates:Bool) -> String
    {
        let calendar = NSCalendar.current
        let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
        let now = NSDate()
        let earliest = now.earlierDate(date as Date)
        let latest = (earliest == now as Date) ? date : now
        let components = calendar.dateComponents(unitFlags, from: earliest as Date,  to: latest as Date)
      
        if components.year != nil
        {
            if (components.year! >= 2)
            {
                return "\(components.year!) years ago"
            }
            else if (components.year! >= 1)
            {
                if (numericDates)
                {
                    return "1 year ago"
                }
                else
                {
                    return "Last year"
                }
            }
        }
        
        if components.month != nil{
            if (components.month! >= 2)
            {
                return "\(components.month!) months ago"
            }
            else if (components.month! >= 1)
            {
                if (numericDates)
                {
                    return "1 month ago"
                }
                else
                {
                    return "Last month"
                }
            }
        }
        
        if components.weekOfYear != nil
        {
            if (components.weekOfYear! >= 2)
            {
                return "\(components.weekOfYear!) weeks ago"
            }
            else if (components.weekOfYear! >= 1)
            {
                if (numericDates)
                {
                    return "1 week ago"
                }
                else
                {
                    return "Last week"
                }
            }
        }
        
        if components.day != nil
        {
            if (components.day! >= 2) {
                return "\(components.day!) days ago"
            } else if (components.day! >= 1){
                if (numericDates){
                    return "1 day ago"
                } else {
                    return "Yesterday"
                }
            }
        }
        
        if components.hour != nil{
            if (components.hour! >= 2) {
                return "\(components.hour!) hours ago"
            } else if (components.hour! >= 1){
                if (numericDates){
                    return "1 hour ago"
                } else {
                    return "An hour ago"
                }
            }
        }
       
        if components.minute != nil{
            if (components.minute! >= 2) {
                return "\(components.minute!) minutes ago"
            } else if (components.minute! >= 1){
                if (numericDates){
                    return "1 minute ago"
                } else {
                    return "A minute ago"
                }
            } else if (components.second! >= 3) {
                return "\(components.second!) seconds ago"
            } else {
                return "Just now"
            }
        }
        
        return ""
    }

    
    class func getSessionidFromUserDefaults() -> String {
        
        if let sessionId : String = self.getUserDefaultsObjectForKey(APIConstant.sessionid) as? String{
            return sessionId
        }
        return ""
    }
    
    class func getDs_user_idFromUserDefaults() -> String {
        
        if let userId : String = self.getUserDefaultsObjectForKey(APIConstant.ds_user_id) as? String{
            return userId
        }
        return ""
    }
    
    class func saveLoginUserModel(modelDictString: String) -> Bool {
        
        if modelDictString == ""
        {
            return false
        }
        
        let dicLogin : [String: Any]? = self.convertToDictionary(text: modelDictString)
        
        if dicLogin != nil
        {
            self.setUserDefaultsCustomObject(LoginUser.init(fromDictionary: dicLogin!) as AnyObject, forKey: UserDefaultKey.loginUserData)
            return true
        }
        return false
    }
    
    class func getLoginUserModel() -> LoginUser?  {
        
        guard let userData : LoginUser = self.getUserDefaultsCustomObjectForKey(UserDefaultKey.loginUserData) as? LoginUser else{
            return nil
        }
        return userData
    }
    
    class func getLoginUserID() -> String  {
        if let userModel : LoginUser = AppUtility.getLoginUserModel(){
            if let userId : Int = userModel.authUserId{
                return String(userId)
            }
        }
        return "0"
    }

    class func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}
