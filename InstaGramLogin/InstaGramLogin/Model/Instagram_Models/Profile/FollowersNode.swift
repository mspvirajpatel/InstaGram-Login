
import Foundation


class FollowersNode : NSObject, NSCoding{

	var followedByViewer : Bool! = false
	var fullName : String! = ""
	var id : String! = ""
	var isVerified : Bool! = false
	var profilePicUrl : String! = ""
	var requestedByViewer : Bool! = false
	var username : String! = ""


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any])
    {
        if let data = dictionary["followed_by_viewer"] as? Bool {
            followedByViewer = data
        }
        
        if let data = dictionary["full_name"] as? String {
            fullName = data
        }
        
        if let data = dictionary["id"] as? String {
            id = data
        }
        
        if let data = dictionary["is_verified"] as? Bool {
            isVerified = data
        }
        
        if let data = dictionary["profile_pic_url"] as? String {
            profilePicUrl = data
        }
		
        if let data = dictionary["requested_by_viewer"] as? Bool {
            requestedByViewer = data
        }
        
        if let data = dictionary["username"] as? String
        {
            username = data
        }
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if followedByViewer != nil{
			dictionary["followed_by_viewer"] = followedByViewer
		}
		if fullName != nil{
			dictionary["full_name"] = fullName
		}
		if id != nil{
			dictionary["id"] = id
		}
		if isVerified != nil{
			dictionary["is_verified"] = isVerified
		}
		if profilePicUrl != nil{
			dictionary["profile_pic_url"] = profilePicUrl
		}
		if requestedByViewer != nil{
			dictionary["requested_by_viewer"] = requestedByViewer
		}
		if username != nil{
			dictionary["username"] = username
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         followedByViewer = aDecoder.decodeObject(forKey: "followed_by_viewer") as? Bool
         fullName = aDecoder.decodeObject(forKey: "full_name") as? String
         id = aDecoder.decodeObject(forKey: "id") as? String
         isVerified = aDecoder.decodeObject(forKey: "is_verified") as? Bool
         profilePicUrl = aDecoder.decodeObject(forKey: "profile_pic_url") as? String
         requestedByViewer = aDecoder.decodeObject(forKey: "requested_by_viewer") as? Bool
         username = aDecoder.decodeObject(forKey: "username") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if followedByViewer != nil{
			aCoder.encode(followedByViewer, forKey: "followed_by_viewer")
		}
		if fullName != nil{
			aCoder.encode(fullName, forKey: "full_name")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if isVerified != nil{
			aCoder.encode(isVerified, forKey: "is_verified")
		}
		if profilePicUrl != nil{
			aCoder.encode(profilePicUrl, forKey: "profile_pic_url")
		}
		if requestedByViewer != nil{
			aCoder.encode(requestedByViewer, forKey: "requested_by_viewer")
		}
		if username != nil{
			aCoder.encode(username, forKey: "username")
		}

	}

}
