
import Foundation


class User : NSObject, NSCoding{

    var biography : String! = ""
    var blockedByViewer : Bool! = false
    var connectedFbPage : Any!
    var countryBlock : Bool! = false
    var externalUrl : String! = ""
    var externalUrlLinkshimmed : String! = ""
    var followedBy : FollowedBy!
    var followedByViewer : Bool! = false
    var follows : FollowedBy!
    var followsViewer : Bool! = false
    var fullName : String! = ""
    var hasBlockedViewer : Bool! = false
    var hasRequestedViewer : Bool! = false
    var id : String! = "0"
    var isPrivate : Bool! = false
    var isVerified : Bool! = false
    var media : ProfileMedia!
    var profilePicUrl : String! = ""
    var profilePicUrlHd : String! = ""
    var requestedByViewer : Bool! = false
    var username : String! = ""
    

	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any])
    {
        if let data = dictionary["biography"] as? String{
            biography = data
        }
        
        if let data = dictionary["blocked_by_viewer"] as? Bool{
            blockedByViewer = data
        }
        
        if let data = dictionary["country_block"] as? Bool{
            countryBlock = data
        }
        
        connectedFbPage = dictionary["connected_fb_page"] as AnyObject!
        
        if let data = dictionary["external_url"] as? String{
            externalUrl = data
        }
        
        if let data = dictionary["external_url_linkshimmed"] as? String{
            externalUrlLinkshimmed = data
        }
        
        if let data = dictionary["followed_by_viewer"] as? Bool{
            followedByViewer = data
        }
        
        if let followedByData = dictionary["followed_by"] as? [String:Any]
        {
            followedBy = FollowedBy(fromDictionary: followedByData)
        }
        
        if let followsData = dictionary["follows"] as? [String:Any]
        {
            follows = FollowedBy(fromDictionary: followsData)
        }
        
        if let data = dictionary["follows_viewer"] as? Bool{
            followsViewer = data
        }
        
        if let data = dictionary["full_name"] as? String{
            fullName = data
        }
        
        if let data = dictionary["has_blocked_viewer"] as? Bool{
            hasBlockedViewer = data
        }
        
        if let data = dictionary["has_requested_viewer"] as? Bool{
            hasRequestedViewer = data
        }
        
        if let data = dictionary["id"] as? String{
            id = data
        }
        
        if let data = dictionary["is_private"] as? Bool{
            isPrivate = data
        }
        
        if let data = dictionary["is_verified"] as? Bool{
            isVerified = data
        }
        
        if let mediaData = dictionary["media"] as? [String:Any]{
            media = ProfileMedia(fromDictionary: mediaData)
        }
        
        if let data = dictionary["profile_pic_url"] as? String{
            profilePicUrl = data
        }
        
        if let data = dictionary["profile_pic_url_hd"] as? String{
            profilePicUrlHd = data
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
		if biography != nil{
			dictionary["biography"] = biography
		}
		if blockedByViewer != nil{
			dictionary["blocked_by_viewer"] = blockedByViewer
		}
		if connectedFbPage != nil{
			dictionary["connected_fb_page"] = connectedFbPage
		}
		if countryBlock != nil{
			dictionary["country_block"] = countryBlock
		}
		if externalUrl != nil{
			dictionary["external_url"] = externalUrl
		}
		if externalUrlLinkshimmed != nil{
			dictionary["external_url_linkshimmed"] = externalUrlLinkshimmed
		}
		if followedBy != nil{
			dictionary["followed_by"] = followedBy.toDictionary()
		}
		if followedByViewer != nil{
			dictionary["followed_by_viewer"] = followedByViewer
		}
		if follows != nil{
			dictionary["follows"] = follows.toDictionary()
		}
		if followsViewer != nil{
			dictionary["follows_viewer"] = followsViewer
		}
		if fullName != nil{
			dictionary["full_name"] = fullName
		}
		if hasBlockedViewer != nil{
			dictionary["has_blocked_viewer"] = hasBlockedViewer
		}
		if hasRequestedViewer != nil{
			dictionary["has_requested_viewer"] = hasRequestedViewer
		}
		if id != nil{
			dictionary["id"] = id
		}
		if isPrivate != nil{
			dictionary["is_private"] = isPrivate
		}
		if isVerified != nil{
			dictionary["is_verified"] = isVerified
		}
		if media != nil{
			dictionary["media"] = media.toDictionary()
		}
		if profilePicUrl != nil{
			dictionary["profile_pic_url"] = profilePicUrl
		}
		if profilePicUrlHd != nil{
			dictionary["profile_pic_url_hd"] = profilePicUrlHd
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
         biography = aDecoder.decodeObject(forKey: "biography") as? String
         blockedByViewer = aDecoder.decodeObject(forKey: "blocked_by_viewer") as? Bool
         connectedFbPage = aDecoder.decodeObject(forKey: "connected_fb_page") 
         countryBlock = aDecoder.decodeObject(forKey: "country_block") as? Bool
         externalUrl = aDecoder.decodeObject(forKey: "external_url") as? String
         externalUrlLinkshimmed = aDecoder.decodeObject(forKey: "external_url_linkshimmed") as? String
         followedBy = aDecoder.decodeObject(forKey: "followed_by") as? FollowedBy
         followedByViewer = aDecoder.decodeObject(forKey: "followed_by_viewer") as? Bool
         follows = aDecoder.decodeObject(forKey: "follows") as? FollowedBy
         followsViewer = aDecoder.decodeObject(forKey: "follows_viewer") as? Bool
         fullName = aDecoder.decodeObject(forKey: "full_name") as? String
         hasBlockedViewer = aDecoder.decodeObject(forKey: "has_blocked_viewer") as? Bool
         hasRequestedViewer = aDecoder.decodeObject(forKey: "has_requested_viewer") as? Bool
         id = aDecoder.decodeObject(forKey: "id") as? String
         isPrivate = aDecoder.decodeObject(forKey: "is_private") as? Bool
         isVerified = aDecoder.decodeObject(forKey: "is_verified") as? Bool
         media = aDecoder.decodeObject(forKey: "media") as? ProfileMedia
         profilePicUrl = aDecoder.decodeObject(forKey: "profile_pic_url") as? String
         profilePicUrlHd = aDecoder.decodeObject(forKey: "profile_pic_url_hd") as? String
         requestedByViewer = aDecoder.decodeObject(forKey: "requested_by_viewer") as? Bool
         username = aDecoder.decodeObject(forKey: "username") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if biography != nil{
			aCoder.encode(biography, forKey: "biography")
		}
		if blockedByViewer != nil{
			aCoder.encode(blockedByViewer, forKey: "blocked_by_viewer")
		}
		if connectedFbPage != nil{
			aCoder.encode(connectedFbPage, forKey: "connected_fb_page")
		}
		if countryBlock != nil{
			aCoder.encode(countryBlock, forKey: "country_block")
		}
		if externalUrl != nil{
			aCoder.encode(externalUrl, forKey: "external_url")
		}
		if externalUrlLinkshimmed != nil{
			aCoder.encode(externalUrlLinkshimmed, forKey: "external_url_linkshimmed")
		}
		if followedBy != nil{
			aCoder.encode(followedBy, forKey: "followed_by")
		}
		if followedByViewer != nil{
			aCoder.encode(followedByViewer, forKey: "followed_by_viewer")
		}
		if follows != nil{
			aCoder.encode(follows, forKey: "follows")
		}
		if followsViewer != nil{
			aCoder.encode(followsViewer, forKey: "follows_viewer")
		}
		if fullName != nil{
			aCoder.encode(fullName, forKey: "full_name")
		}
		if hasBlockedViewer != nil{
			aCoder.encode(hasBlockedViewer, forKey: "has_blocked_viewer")
		}
		if hasRequestedViewer != nil{
			aCoder.encode(hasRequestedViewer, forKey: "has_requested_viewer")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if isPrivate != nil{
			aCoder.encode(isPrivate, forKey: "is_private")
		}
		if isVerified != nil{
			aCoder.encode(isVerified, forKey: "is_verified")
		}
		if media != nil{
			aCoder.encode(media, forKey: "media")
		}
		if profilePicUrl != nil{
			aCoder.encode(profilePicUrl, forKey: "profile_pic_url")
		}
		if profilePicUrlHd != nil{
			aCoder.encode(profilePicUrlHd, forKey: "profile_pic_url_hd")
		}
		if requestedByViewer != nil{
			aCoder.encode(requestedByViewer, forKey: "requested_by_viewer")
		}
		if username != nil{
			aCoder.encode(username, forKey: "username")
		}

	}

}
