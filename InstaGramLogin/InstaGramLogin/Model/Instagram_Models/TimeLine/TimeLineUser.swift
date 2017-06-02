 

import Foundation


class TimeLineUser : NSObject, NSCoding{

	var edgeSuggestedUser : EdgeSuggestedUser!
	var edgeWebFeedTimeline : EdgeWebFeedTimeline!
	var id : String! = ""
	var profilePicUrl : String! = ""
	var username : String! = ""


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any])
    {
		if let edgeSuggestedUserData = dictionary["edge_suggested_user"] as? [String:Any]
        {
			edgeSuggestedUser = EdgeSuggestedUser(fromDictionary: edgeSuggestedUserData)
		}
        
		if let edgeWebFeedTimelineData = dictionary["edge_web_feed_timeline"] as? [String:Any]
        {
			edgeWebFeedTimeline = EdgeWebFeedTimeline(fromDictionary: edgeWebFeedTimelineData)
		}
        
        if let data = dictionary["id"] as? String {
            id = data
        }
        
        if let data = dictionary["profile_pic_url"] as? String {
            profilePicUrl = data
        }
        
        if let data = dictionary["username"] as? String {
            username = data
        }
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if edgeSuggestedUser != nil{
			dictionary["edge_suggested_user"] = edgeSuggestedUser.toDictionary()
		}
		if edgeWebFeedTimeline != nil{
			dictionary["edge_web_feed_timeline"] = edgeWebFeedTimeline.toDictionary()
		}
		if id != nil{
			dictionary["id"] = id
		}
		if profilePicUrl != nil{
			dictionary["profile_pic_url"] = profilePicUrl
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
         edgeSuggestedUser = aDecoder.decodeObject(forKey: "edge_suggested_user") as? EdgeSuggestedUser
         edgeWebFeedTimeline = aDecoder.decodeObject(forKey: "edge_web_feed_timeline") as? EdgeWebFeedTimeline
         id = aDecoder.decodeObject(forKey: "id") as? String
         profilePicUrl = aDecoder.decodeObject(forKey: "profile_pic_url") as? String
         username = aDecoder.decodeObject(forKey: "username") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if edgeSuggestedUser != nil{
			aCoder.encode(edgeSuggestedUser, forKey: "edge_suggested_user")
		}
		if edgeWebFeedTimeline != nil{
			aCoder.encode(edgeWebFeedTimeline, forKey: "edge_web_feed_timeline")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if profilePicUrl != nil{
			aCoder.encode(profilePicUrl, forKey: "profile_pic_url")
		}
		if username != nil{
			aCoder.encode(username, forKey: "username")
		}

	}

}
