
import Foundation


class UserProfileModel : NSObject, NSCoding{

	var loggingPageId : String! = ""
	var user : User!

	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){

        if let data = dictionary["logging_page_id"] as? String{
            loggingPageId = data
        }
		
        if let userData = dictionary["user"] as? [String:Any]{
			user = User(fromDictionary: userData)
		}
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if loggingPageId != nil{
			dictionary["logging_page_id"] = loggingPageId
		}
		if user != nil{
			dictionary["user"] = user.toDictionary()
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         loggingPageId = aDecoder.decodeObject(forKey: "logging_page_id") as? String
         user = aDecoder.decodeObject(forKey: "user") as? User

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if loggingPageId != nil{
			aCoder.encode(loggingPageId, forKey: "logging_page_id")
		}
		if user != nil{
			aCoder.encode(user, forKey: "user")
		}

	}

}
