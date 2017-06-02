
import Foundation


class ProfileNode : NSObject, NSCoding{
    
    var typename : String! = ""
    var caption : String! = ""
    var code : String! = ""
    var comments : FollowedBy!
    var commentsDisabled : Bool! = false
    var date : Int! = 0
    var dimensions : Dimension!
    var displaySrc : String! = ""
    var id : String! = ""
    var isVideo : Bool! = false
    var likes : FollowedBy!
    var owner : Owner!
    var thumbnailSrc : String! = ""
    var isSelect:Bool! = false
    var userHasLiked : Bool! = false
    var videoURL : String = ""
    var tagSlug : String = "" // This will use of get the video detail
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any])
    {
        
        if let data = dictionary["__typename"] as? String{
            typename = data
        }
        
        if let data = dictionary["caption"] as? String{
            caption = data
        }
        
        if let data = dictionary["code"] as? String{
            code = data
        }
        
        if let commentsData = dictionary["comments"] as? [String:Any]
        {
            comments = FollowedBy(fromDictionary: commentsData)
        }
        
        if let data = dictionary["comments_disabled"] as? Bool{
            commentsDisabled = data
        }
        
        if let data = dictionary["date"] as? Int{
            date = data
        }
        
        if let dimensionsData = dictionary["dimensions"] as? [String:Any]
        {
            dimensions = Dimension(fromDictionary: dimensionsData)
        }
        
        if let data = dictionary["display_src"] as? String{
            displaySrc = data
        }
        
        if let data = dictionary["id"] as? String{
            id = data
        }
        
        if let data = dictionary["is_video"] as? Bool{
            isVideo = data
        }
        
        if let likesData = dictionary["likes"] as? [String:Any]
        {
            likes = FollowedBy(fromDictionary: likesData)
        }
        
        if let ownerData = dictionary["owner"] as? [String:Any]
        {
            owner = Owner(fromDictionary: ownerData)
        }
        
        if let data = dictionary["thumbnail_src"] as? String{
            thumbnailSrc = data
        }
        
        isSelect = false
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
        if id != nil{
            dictionary["id"] = id
        }
        if isVideo != nil{
            dictionary["is_video"] = isVideo
        }
        if likes != nil{
            dictionary["likes"] = likes.toDictionary()
        }
        if owner != nil{
            dictionary["owner"] = owner.toDictionary()
        }
        if thumbnailSrc != nil{
            dictionary["thumbnail_src"] = thumbnailSrc
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
        typename = aDecoder.decodeObject(forKey: "__typename") as? String
        caption = aDecoder.decodeObject(forKey: "caption") as? String
        code = aDecoder.decodeObject(forKey: "code") as? String
        comments = aDecoder.decodeObject(forKey: "comments") as? FollowedBy
        commentsDisabled = aDecoder.decodeObject(forKey: "comments_disabled") as? Bool
        date = aDecoder.decodeObject(forKey: "date") as? Int
        dimensions = aDecoder.decodeObject(forKey: "dimensions") as? Dimension
        displaySrc = aDecoder.decodeObject(forKey: "display_src") as? String
        id = aDecoder.decodeObject(forKey: "id") as? String
        isVideo = aDecoder.decodeObject(forKey: "is_video") as? Bool
        likes = aDecoder.decodeObject(forKey: "likes") as? FollowedBy
        owner = aDecoder.decodeObject(forKey: "owner") as? Owner
        thumbnailSrc = aDecoder.decodeObject(forKey: "thumbnail_src") as? String
        
        isSelect = aDecoder.decodeObject(forKey: "isSelect") as? Bool
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
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if isVideo != nil{
            aCoder.encode(isVideo, forKey: "is_video")
        }
        if likes != nil{
            aCoder.encode(likes, forKey: "likes")
        }
        if owner != nil{
            aCoder.encode(owner, forKey: "owner")
        }
        if thumbnailSrc != nil{
            aCoder.encode(thumbnailSrc, forKey: "thumbnail_src")
        }
        if isSelect != nil{
            aCoder.encode(isSelect, forKey: "isSelect")
        }
        
    }
    
}
