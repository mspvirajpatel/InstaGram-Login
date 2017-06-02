

import Foundation


class Owner : NSObject, NSCoding{

	var blockedByViewer : Bool! = false
	var followedByViewer : Bool! = false
	var fullName : String! = ""
	var hasBlockedViewer : Bool! = false
	var id : String! = ""
	var isPrivate : Bool! = false
	var isUnpublished : Bool! = false
	var profilePicUrl : String! = ""
	var requestedByViewer : Bool! = false
	var username : String! = ""

	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any])
    {
        if let data = dictionary["blocked_by_viewer"] as? Bool{
            blockedByViewer = data
        }

        if let data = dictionary["followed_by_viewer"] as? Bool{
            followedByViewer = data
        }
        
        if let data = dictionary["full_name"] as? String{
            fullName = data
        }
        
        if let data = dictionary["has_blocked_viewer"] as? Bool{
            hasBlockedViewer = data
        }
        
        if let data = dictionary["id"] as? String{
            id = data
        }
        
        if let data = dictionary["is_private"] as? Bool{
            isPrivate = data
        }
        
        if let data = dictionary["is_unpublished"] as? Bool{
            isUnpublished = data
        }
		
        if let data = dictionary["profile_pic_url"] as? String{
            profilePicUrl = data
        }
        
        if let data = dictionary["requested_by_viewer"] as? Bool{
            requestedByViewer = data
        }
        
        if let data = dictionary["username"] as? String{
            username = data
        }
    }

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if blockedByViewer != nil{
			dictionary["blocked_by_viewer"] = blockedByViewer
		}
		if followedByViewer != nil{
			dictionary["followed_by_viewer"] = followedByViewer
		}
		if fullName != nil{
			dictionary["full_name"] = fullName
		}
		if hasBlockedViewer != nil{
			dictionary["has_blocked_viewer"] = hasBlockedViewer
		}
		if id != nil{
			dictionary["id"] = id
		}
		if isPrivate != nil{
			dictionary["is_private"] = isPrivate
		}
		if isUnpublished != nil{
			dictionary["is_unpublished"] = isUnpublished
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
         blockedByViewer = aDecoder.decodeObject(forKey: "blocked_by_viewer") as? Bool
         followedByViewer = aDecoder.decodeObject(forKey: "followed_by_viewer") as? Bool
         fullName = aDecoder.decodeObject(forKey: "full_name") as? String
         hasBlockedViewer = aDecoder.decodeObject(forKey: "has_blocked_viewer") as? Bool
         id = aDecoder.decodeObject(forKey: "id") as? String
         isPrivate = aDecoder.decodeObject(forKey: "is_private") as? Bool
         isUnpublished = aDecoder.decodeObject(forKey: "is_unpublished") as? Bool
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
		if blockedByViewer != nil{
			aCoder.encode(blockedByViewer, forKey: "blocked_by_viewer")
		}
		if followedByViewer != nil{
			aCoder.encode(followedByViewer, forKey: "followed_by_viewer")
		}
		if fullName != nil{
			aCoder.encode(fullName, forKey: "full_name")
		}
		if hasBlockedViewer != nil{
			aCoder.encode(hasBlockedViewer, forKey: "has_blocked_viewer")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if isPrivate != nil{
			aCoder.encode(isPrivate, forKey: "is_private")
		}
		if isUnpublished != nil{
			aCoder.encode(isUnpublished, forKey: "is_unpublished")
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
