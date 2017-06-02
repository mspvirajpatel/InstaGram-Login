
import Foundation


class Node : NSObject, NSCoding{

	var createdAt : Int! = 0
	var id : String! = ""
	var text : String! = ""
	var user : User!
	var typename : String! = ""
	var dimensions : Dimension!
	var displayUrl : String! = ""
	var edgeMediaToTaggedUser : EdgeMediaToSponsorUser!
	var isVideo : Bool! = false
	var shortcode : String! = ""
    var isSelect:Bool! = false
    
 
	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any])
    {
        if let data = dictionary["created_at"] as? Int {
            createdAt = data
        }
        
        if let data = dictionary["id"] as? String {
            id = data
        }
        
        if let data = dictionary["text"] as? String {
            text = data
        }
        
		if let userData = dictionary["user"] as? [String:Any]{
			user = User(fromDictionary: userData)
		}
        
        if let data = dictionary["__typename"] as? String {
            typename = data
        }
        
		if let dimensionsData = dictionary["dimensions"] as? [String:Any]
        {
			dimensions = Dimension(fromDictionary: dimensionsData)
		}
		
        if let data = dictionary["display_url"] as? String {
            displayUrl = data
        }
        
        if let edgeMediaToTaggedUserData = dictionary["edge_media_to_tagged_user"] as? [String:Any]{
			edgeMediaToTaggedUser = EdgeMediaToSponsorUser(fromDictionary: edgeMediaToTaggedUserData)
		}
		
        if let data = dictionary["is_video"] as? Bool {
            isVideo = data
        }
        
        if let data = dictionary["shortcode"] as? String {
            shortcode = data
        }
        
        isSelect = false
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if createdAt != nil{
			dictionary["created_at"] = createdAt
		}
		if id != nil{
			dictionary["id"] = id
		}
		if text != nil{
			dictionary["text"] = text
		}
		if user != nil{
			dictionary["user"] = user.toDictionary()
		}
		if typename != nil{
			dictionary["__typename"] = typename
		}
		if dimensions != nil{
			dictionary["dimensions"] = dimensions.toDictionary()
		}
		if displayUrl != nil{
			dictionary["display_url"] = displayUrl
		}
		if edgeMediaToTaggedUser != nil{
			dictionary["edge_media_to_tagged_user"] = edgeMediaToTaggedUser.toDictionary()
		}
		if isVideo != nil{
			dictionary["is_video"] = isVideo
		}
		if shortcode != nil{
			dictionary["shortcode"] = shortcode
		}
        if isSelect != nil{
            dictionary["isSelect"] = isSelect
        }
        
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? Int
         id = aDecoder.decodeObject(forKey: "id") as? String
         text = aDecoder.decodeObject(forKey: "text") as? String
         user = aDecoder.decodeObject(forKey: "user") as? User
         typename = aDecoder.decodeObject(forKey: "__typename") as? String
         dimensions = aDecoder.decodeObject(forKey: "dimensions") as? Dimension
         displayUrl = aDecoder.decodeObject(forKey: "display_url") as? String
         edgeMediaToTaggedUser = aDecoder.decodeObject(forKey: "edge_media_to_tagged_user") as? EdgeMediaToSponsorUser
         isVideo = aDecoder.decodeObject(forKey: "is_video") as? Bool
         shortcode = aDecoder.decodeObject(forKey: "shortcode") as? String
         isSelect = aDecoder.decodeObject(forKey: "isSelect") as? Bool
	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "created_at")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if text != nil{
			aCoder.encode(text, forKey: "text")
		}
		if user != nil{
			aCoder.encode(user, forKey: "user")
		}
		if typename != nil{
			aCoder.encode(typename, forKey: "__typename")
		}
		if dimensions != nil{
			aCoder.encode(dimensions, forKey: "dimensions")
		}
		if displayUrl != nil{
			aCoder.encode(displayUrl, forKey: "display_url")
		}
		if edgeMediaToTaggedUser != nil{
			aCoder.encode(edgeMediaToTaggedUser, forKey: "edge_media_to_tagged_user")
		}
		if isVideo != nil{
			aCoder.encode(isVideo, forKey: "is_video")
		}
		if shortcode != nil{
			aCoder.encode(shortcode, forKey: "shortcode")
		}
        if isSelect != nil{
            aCoder.encode(isSelect, forKey: "isSelect")
        }

	}

}
