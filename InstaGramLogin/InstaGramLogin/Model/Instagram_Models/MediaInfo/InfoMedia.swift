

import Foundation


class InfoMedia : NSObject, NSCoding{

	var typename : String! = ""
	var caption : String! = ""
	var captionIsEdited : Bool! = false
	var code : String! = ""
	var comments : Comment!
	var commentsDisabled : Bool! = false
	var date : Int! = 0
	var dimensions : Dimension!
	var displaySrc : String! = ""
	var edgeMediaToSponsorUser : EdgeMediaToSponsorUser!
	var edgeSidecarToChildren : EdgeSidecarToChildren!
	var id : String! = ""
	var isAd : Bool! = false
	var isVideo : Bool! = false
	var likes : Comment!
	var location : AnyObject!
	var owner : Owner!
	var relatedMedia : RelatedMedia!
	var usertags : RelatedMedia!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any])
    {
        if let data = dictionary["__typename"] as? String {
            typename = data
        }
        
        if let data = dictionary["caption"] as? String {
            caption = data
        }
        
        if let data = dictionary["caption_is_edited"] as? Bool {
            captionIsEdited = data
        }
        
        if let data = dictionary["code"] as? String {
            code = data
        }
		
        if let commentsData = dictionary["comments"] as? [String:Any]{
			comments = Comment(fromDictionary: commentsData)
		}
		
        if let data = dictionary["comments_disabled"] as? Bool {
            commentsDisabled = data
        }
        
        if let data = dictionary["date"] as? Int {
            date = data
        }
        
        if let dimensionsData = dictionary["dimensions"] as? [String:Any]{
			dimensions = Dimension(fromDictionary: dimensionsData)
		}
		
        if let data = dictionary["display_src"] as? String {
            displaySrc = data
        }
        
        if let edgeMediaToSponsorUserData = dictionary["edge_media_to_sponsor_user"] as? [String:Any]
        {
			edgeMediaToSponsorUser = EdgeMediaToSponsorUser(fromDictionary: edgeMediaToSponsorUserData)
		}
		
        if let edgeSidecarToChildrenData = dictionary["edge_sidecar_to_children"] as? [String:Any]
        {
			edgeSidecarToChildren = EdgeSidecarToChildren(fromDictionary: edgeSidecarToChildrenData)
		}
		
        if let data = dictionary["id"] as? String {
            id = data
        }
        
        if let data = dictionary["is_ad"] as? Bool {
            isAd = data
        }
        
        if let data = dictionary["is_video"] as? Bool {
            isVideo = data
        }
        
		
        if let likesData = dictionary["likes"] as? [String:Any]{
			likes = Comment(fromDictionary: likesData)
		}
		
        location = dictionary["location"] as AnyObject!
		
        if let ownerData = dictionary["owner"] as? [String:Any]{
			owner = Owner(fromDictionary: ownerData)
		}
		
        if let relatedMediaData = dictionary["related_media"] as? [String:Any]{
			relatedMedia = RelatedMedia(fromDictionary: relatedMediaData)
		}
		
        if let usertagsData = dictionary["usertags"] as? [String:Any]{
			usertags = RelatedMedia(fromDictionary: usertagsData)
		}
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if typename != nil{
			dictionary["__typename"] = typename
		}
		if caption != nil{
			dictionary["caption"] = caption
		}
		if captionIsEdited != nil{
			dictionary["caption_is_edited"] = captionIsEdited
		}
		if code != nil{
			dictionary["code"] = code
		}
		if comments != nil{
			dictionary["comments"] = comments.toDictionary()
		}
		if commentsDisabled != nil{
			dictionary["comments_disabled"] = commentsDisabled
		}
		if date != nil{
			dictionary["date"] = date
		}
		if dimensions != nil{
			dictionary["dimensions"] = dimensions.toDictionary()
		}
		if displaySrc != nil{
			dictionary["display_src"] = displaySrc
		}
		if edgeMediaToSponsorUser != nil{
			dictionary["edge_media_to_sponsor_user"] = edgeMediaToSponsorUser.toDictionary()
		}
		if edgeSidecarToChildren != nil{
			dictionary["edge_sidecar_to_children"] = edgeSidecarToChildren.toDictionary()
		}
		if id != nil{
			dictionary["id"] = id
		}
		if isAd != nil{
			dictionary["is_ad"] = isAd
		}
		if isVideo != nil{
			dictionary["is_video"] = isVideo
		}
		if likes != nil{
			dictionary["likes"] = likes.toDictionary()
		}
		if location != nil{
			dictionary["location"] = location
		}
		if owner != nil{
			dictionary["owner"] = owner.toDictionary()
		}
		if relatedMedia != nil{
			dictionary["related_media"] = relatedMedia.toDictionary()
		}
		if usertags != nil{
			dictionary["usertags"] = usertags.toDictionary()
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         typename = aDecoder.decodeObject(forKey: "__typename") as? String
         caption = aDecoder.decodeObject(forKey: "caption") as? String
         captionIsEdited = aDecoder.decodeObject(forKey: "caption_is_edited") as? Bool
         code = aDecoder.decodeObject(forKey: "code") as? String
         comments = aDecoder.decodeObject(forKey: "comments") as? Comment
         commentsDisabled = aDecoder.decodeObject(forKey: "comments_disabled") as? Bool
         date = aDecoder.decodeObject(forKey: "date") as? Int
         dimensions = aDecoder.decodeObject(forKey: "dimensions") as? Dimension
         displaySrc = aDecoder.decodeObject(forKey: "display_src") as? String
         edgeMediaToSponsorUser = aDecoder.decodeObject(forKey: "edge_media_to_sponsor_user") as? EdgeMediaToSponsorUser
         edgeSidecarToChildren = aDecoder.decodeObject(forKey: "edge_sidecar_to_children") as? EdgeSidecarToChildren
         id = aDecoder.decodeObject(forKey: "id") as? String
         isAd = aDecoder.decodeObject(forKey: "is_ad") as? Bool
         isVideo = aDecoder.decodeObject(forKey: "is_video") as? Bool
         likes = aDecoder.decodeObject(forKey: "likes") as? Comment
         location = aDecoder.decodeObject(forKey: "location") as AnyObject
         owner = aDecoder.decodeObject(forKey: "owner") as? Owner
         relatedMedia = aDecoder.decodeObject(forKey: "related_media") as? RelatedMedia
         usertags = aDecoder.decodeObject(forKey: "usertags") as? RelatedMedia

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if typename != nil{
			aCoder.encode(typename, forKey: "__typename")
		}
		if caption != nil{
			aCoder.encode(caption, forKey: "caption")
		}
		if captionIsEdited != nil{
			aCoder.encode(captionIsEdited, forKey: "caption_is_edited")
		}
		if code != nil{
			aCoder.encode(code, forKey: "code")
		}
		if comments != nil{
			aCoder.encode(comments, forKey: "comments")
		}
		if commentsDisabled != nil{
			aCoder.encode(commentsDisabled, forKey: "comments_disabled")
		}
		if date != nil{
			aCoder.encode(date, forKey: "date")
		}
		if dimensions != nil{
			aCoder.encode(dimensions, forKey: "dimensions")
		}
		if displaySrc != nil{
			aCoder.encode(displaySrc, forKey: "display_src")
		}
		if edgeMediaToSponsorUser != nil{
			aCoder.encode(edgeMediaToSponsorUser, forKey: "edge_media_to_sponsor_user")
		}
		if edgeSidecarToChildren != nil{
			aCoder.encode(edgeSidecarToChildren, forKey: "edge_sidecar_to_children")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if isAd != nil{
			aCoder.encode(isAd, forKey: "is_ad")
		}
		if isVideo != nil{
			aCoder.encode(isVideo, forKey: "is_video")
		}
		if likes != nil{
			aCoder.encode(likes, forKey: "likes")
		}
		if location != nil{
			aCoder.encode(location, forKey: "location")
		}
		if owner != nil{
			aCoder.encode(owner, forKey: "owner")
		}
		if relatedMedia != nil{
			aCoder.encode(relatedMedia, forKey: "related_media")
		}
		if usertags != nil{
			aCoder.encode(usertags, forKey: "usertags")
		}

	}

}
