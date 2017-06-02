
import Foundation


class LoginUser : NSObject, NSCoding{

	var authUserBackend : String! = ""
	var authUserHash : String! = ""
	var authUserId : Int! = 0
	var platform : Int! = 0
	var token : String! = ""
	var tokenVer : Int! = 0
	var lastRefreshed : Float! = 0.0

	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any])
    {
        if let data = dictionary["_auth_user_backend"] as? String {
            authUserBackend = data
        }
        
        if let data = dictionary["_auth_user_hash"] as? String {
            authUserHash = data
        }
		
        if let data = dictionary["_auth_user_id"] as? Int {
            authUserId = data
        }
		
        if let data = dictionary["_platform"] as? Int {
            platform = data
        }
		
        if let data = dictionary["_token"] as? String {
            token = data
        }
		
        if let data = dictionary["_token_ver"] as? Int {
            tokenVer = data
        }
		
        if let data = dictionary["last_refreshed"] as? Float {
            lastRefreshed = data
        }
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if authUserBackend != nil{
			dictionary["_auth_user_backend"] = authUserBackend
		}
		if authUserHash != nil{
			dictionary["_auth_user_hash"] = authUserHash
		}
		if authUserId != nil{
			dictionary["_auth_user_id"] = authUserId
		}
		if platform != nil{
			dictionary["_platform"] = platform
		}
		if token != nil{
			dictionary["_token"] = token
		}
		if tokenVer != nil{
			dictionary["_token_ver"] = tokenVer
		}
		if lastRefreshed != nil{
			dictionary["last_refreshed"] = lastRefreshed
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         authUserBackend = aDecoder.decodeObject(forKey: "_auth_user_backend") as? String
         authUserHash = aDecoder.decodeObject(forKey: "_auth_user_hash") as? String
         authUserId = aDecoder.decodeObject(forKey: "_auth_user_id") as? Int
         platform = aDecoder.decodeObject(forKey: "_platform") as? Int
         token = aDecoder.decodeObject(forKey: "_token") as? String
         tokenVer = aDecoder.decodeObject(forKey: "_token_ver") as? Int
         lastRefreshed = aDecoder.decodeObject(forKey: "last_refreshed") as? Float

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if authUserBackend != nil{
			aCoder.encode(authUserBackend, forKey: "_auth_user_backend")
		}
		if authUserHash != nil{
			aCoder.encode(authUserHash, forKey: "_auth_user_hash")
		}
		if authUserId != nil{
			aCoder.encode(authUserId, forKey: "_auth_user_id")
		}
		if platform != nil{
			aCoder.encode(platform, forKey: "_platform")
		}
		if token != nil{
			aCoder.encode(token, forKey: "_token")
		}
		if tokenVer != nil{
			aCoder.encode(tokenVer, forKey: "_token_ver")
		}
		if lastRefreshed != nil{
			aCoder.encode(lastRefreshed, forKey: "last_refreshed")
		}

	}

}
