

import Foundation


class TimeLineNode : NSObject, NSCoding{
    
    var edgeFollowedBy : EdgeFollowedBy!
    var followedByViewer : Bool! = false
    var fullName : String! = ""
    var id : String! = ""
    var isPrivate : Bool! = false
    var isVerified : Bool! = false
    var isViewer : Bool! = false
    var profilePicUrl : String! = ""
    var requestedByViewer : Bool! = false
    var username : String! = ""
    var text : String! = ""
    var createdAt : Int! = 0
    var owner : Owner!
    var typename : String! = ""
    var attribution : AnyObject!
    var commentsDisabled : Bool! = false
    var dimensions : Dimension!
    var displayUrl : String! = ""
    var edgeMediaPreviewLike : EdgeMediaPreviewLike!
    var edgeMediaToCaption : EdgeSuggestedUser!
    var edgeMediaToComment : EdgeMediaToComment!
    var edgeMediaToSponsorUser : EdgeMediaToSponsorUser!
    var edgeMediaToTaggedUser : EdgeMediaToSponsorUser!
    var isVideo : Bool! = false
    var shortcode : String! = ""
    var takenAtTimestamp : Int! = 0
    var viewerHasLiked : Bool! = false
    var isSelected : Bool! = false
    var videourl : String! = ""
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any])
    {
        if let edgeFollowedByData = dictionary["edge_followed_by"] as? [String:Any]
        {
            edgeFollowedBy = EdgeFollowedBy(fromDictionary: edgeFollowedByData)
        }
        
        if let data = dictionary["followed_by_viewer"] as? Bool{
            followedByViewer = data
        }
        
        if let data = dictionary["full_name"] as? String{
            fullName = data
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
        
        if let data = dictionary["is_viewer"] as? Bool{
            isViewer = data
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
        
        if let data = dictionary["text"] as? String{
            text = data
        }
        
        if let data = dictionary["created_at"] as? Int{
            createdAt = data
        }
        
        if let ownerData = dictionary["owner"] as? [String:Any]{
            owner = Owner(fromDictionary: ownerData)
        }
        
        if let data = dictionary["__typename"] as? String{
            typename = data
        }
        
        attribution = dictionary["attribution"] as AnyObject!
        
        if let data = dictionary["comments_disabled"] as? Bool{
            commentsDisabled = data
        }
        
        if let dimensionsData = dictionary["dimensions"] as? [String:Any]{
            dimensions = Dimension(fromDictionary: dimensionsData)
        }
        
        if let data = dictionary["display_url"] as? String{
            displayUrl = data
        }
        
        if let edgeMediaPreviewLikeData = dictionary["edge_media_preview_like"] as? [String:Any]
        {
            edgeMediaPreviewLike = EdgeMediaPreviewLike(fromDictionary: edgeMediaPreviewLikeData)
        }
        
        if let edgeMediaToCaptionData = dictionary["edge_media_to_caption"] as? [String:Any]
        {
            edgeMediaToCaption = EdgeSuggestedUser(fromDictionary: edgeMediaToCaptionData)
        }
        
        if let edgeMediaToCommentData = dictionary["edge_media_to_comment"] as? [String:Any]
        {
            edgeMediaToComment = EdgeMediaToComment(fromDictionary: edgeMediaToCommentData)
        }
        
        if let edgeMediaToSponsorUserData = dictionary["edge_media_to_sponsor_user"] as? [String:Any]
        {
            edgeMediaToSponsorUser = EdgeMediaToSponsorUser(fromDictionary: edgeMediaToSponsorUserData)
        }
        
        if let edgeMediaToTaggedUserData = dictionary["edge_media_to_tagged_user"] as? [String:Any]
        {
            edgeMediaToTaggedUser = EdgeMediaToSponsorUser(fromDictionary: edgeMediaToTaggedUserData)
        }
        
        if let data = dictionary["is_video"] as? Bool{
            isVideo = data
        }
        
        
        if let data = dictionary["shortcode"] as? String{
            shortcode = data
        }
        
        if let data = dictionary["taken_at_timestamp"] as? Int{
            takenAtTimestamp = data
        }
        
        if let data = dictionary["viewer_has_liked"] as? Bool{
            viewerHasLiked = data
        }
        isSelected = false
        
        if let data = dictionary["video_url"] as? String {
            videourl = data
        }
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if edgeFollowedBy != nil{
            dictionary["edge_followed_by"] = edgeFollowedBy.toDictionary()
        }
        if followedByViewer != nil{
            dictionary["followed_by_viewer"] = followedByViewer
        }
        if fullName != nil{
            dictionary["full_name"] = fullName
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
        if isViewer != nil{
            dictionary["is_viewer"] = isViewer
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
        if text != nil{
            dictionary["text"] = text
        }
        if createdAt != nil{
            dictionary["created_at"] = createdAt
        }
        if owner != nil{
            dictionary["owner"] = owner.toDictionary()
        }
        if typename != nil{
            dictionary["__typename"] = typename
        }
        if attribution != nil{
            dictionary["attribution"] = attribution
        }
        if commentsDisabled != nil{
            dictionary["comments_disabled"] = commentsDisabled
        }
        if dimensions != nil{
            dictionary["dimensions"] = dimensions.toDictionary()
        }
        if displayUrl != nil{
            dictionary["display_url"] = displayUrl
        }
        if edgeMediaPreviewLike != nil{
            dictionary["edge_media_preview_like"] = edgeMediaPreviewLike.toDictionary()
        }
        if edgeMediaToCaption != nil{
            dictionary["edge_media_to_caption"] = edgeMediaToCaption.toDictionary()
        }
        if edgeMediaToComment != nil{
            dictionary["edge_media_to_comment"] = edgeMediaToComment.toDictionary()
        }
        if edgeMediaToSponsorUser != nil{
            dictionary["edge_media_to_sponsor_user"] = edgeMediaToSponsorUser.toDictionary()
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
        if takenAtTimestamp != nil{
            dictionary["taken_at_timestamp"] = takenAtTimestamp
        }
        if viewerHasLiked != nil{
            dictionary["viewer_has_liked"] = viewerHasLiked
        }
        if isSelected != nil{
            dictionary["isSelected"] = isSelected
        }
        if videourl != nil
        {
            dictionary["video_url"] = videourl
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        edgeFollowedBy = aDecoder.decodeObject(forKey: "edge_followed_by") as? EdgeFollowedBy
        followedByViewer = aDecoder.decodeObject(forKey: "followed_by_viewer") as? Bool
        fullName = aDecoder.decodeObject(forKey: "full_name") as? String
        id = aDecoder.decodeObject(forKey: "id") as? String
        isPrivate = aDecoder.decodeObject(forKey: "is_private") as? Bool
        isVerified = aDecoder.decodeObject(forKey: "is_verified") as? Bool
        isViewer = aDecoder.decodeObject(forKey: "is_viewer") as? Bool
        profilePicUrl = aDecoder.decodeObject(forKey: "profile_pic_url") as? String
        requestedByViewer = aDecoder.decodeObject(forKey: "requested_by_viewer") as? Bool
        username = aDecoder.decodeObject(forKey: "username") as? String
        text = aDecoder.decodeObject(forKey: "text") as? String
        createdAt = aDecoder.decodeObject(forKey: "created_at") as? Int
        owner = aDecoder.decodeObject(forKey: "owner") as? Owner
        typename = aDecoder.decodeObject(forKey: "__typename") as? String
        attribution = aDecoder.decodeObject(forKey: "attribution") as AnyObject!
        commentsDisabled = aDecoder.decodeObject(forKey: "comments_disabled") as? Bool
        dimensions = aDecoder.decodeObject(forKey: "dimensions") as? Dimension
        displayUrl = aDecoder.decodeObject(forKey: "display_url") as? String
        edgeMediaPreviewLike = aDecoder.decodeObject(forKey: "edge_media_preview_like") as? EdgeMediaPreviewLike
        edgeMediaToCaption = aDecoder.decodeObject(forKey: "edge_media_to_caption") as? EdgeSuggestedUser
        edgeMediaToComment = aDecoder.decodeObject(forKey: "edge_media_to_comment") as? EdgeMediaToComment
        edgeMediaToSponsorUser = aDecoder.decodeObject(forKey: "edge_media_to_sponsor_user") as? EdgeMediaToSponsorUser
        edgeMediaToTaggedUser = aDecoder.decodeObject(forKey: "edge_media_to_tagged_user") as? EdgeMediaToSponsorUser
        isVideo = aDecoder.decodeObject(forKey: "is_video") as? Bool
        shortcode = aDecoder.decodeObject(forKey: "shortcode") as? String
        takenAtTimestamp = aDecoder.decodeObject(forKey: "taken_at_timestamp") as? Int
        viewerHasLiked = aDecoder.decodeObject(forKey: "viewer_has_liked") as? Bool
        isSelected = aDecoder.decodeObject(forKey: "isSelected") as? Bool
        videourl  = aDecoder.decodeObject(forKey: "video_url") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if edgeFollowedBy != nil{
            aCoder.encode(edgeFollowedBy, forKey: "edge_followed_by")
        }
        if followedByViewer != nil{
            aCoder.encode(followedByViewer, forKey: "followed_by_viewer")
        }
        if fullName != nil{
            aCoder.encode(fullName, forKey: "full_name")
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
        if isViewer != nil{
            aCoder.encode(isViewer, forKey: "is_viewer")
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
        if text != nil{
            aCoder.encode(text, forKey: "text")
        }
        if createdAt != nil{
            aCoder.encode(createdAt, forKey: "created_at")
        }
        if owner != nil{
            aCoder.encode(owner, forKey: "owner")
        }
        if typename != nil{
            aCoder.encode(typename, forKey: "__typename")
        }
        if attribution != nil{
            aCoder.encode(attribution, forKey: "attribution")
        }
        if commentsDisabled != nil{
            aCoder.encode(commentsDisabled, forKey: "comments_disabled")
        }
        if dimensions != nil{
            aCoder.encode(dimensions, forKey: "dimensions")
        }
        if displayUrl != nil{
            aCoder.encode(displayUrl, forKey: "display_url")
        }
        if edgeMediaPreviewLike != nil{
            aCoder.encode(edgeMediaPreviewLike, forKey: "edge_media_preview_like")
        }
        if edgeMediaToCaption != nil{
            aCoder.encode(edgeMediaToCaption, forKey: "edge_media_to_caption")
        }
        if edgeMediaToComment != nil{
            aCoder.encode(edgeMediaToComment, forKey: "edge_media_to_comment")
        }
        if edgeMediaToSponsorUser != nil{
            aCoder.encode(edgeMediaToSponsorUser, forKey: "edge_media_to_sponsor_user")
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
        if takenAtTimestamp != nil{
            aCoder.encode(takenAtTimestamp, forKey: "taken_at_timestamp")
        }
        if viewerHasLiked != nil{
            aCoder.encode(viewerHasLiked, forKey: "viewer_has_liked")
        }
        if isSelected != nil{
            aCoder.encode(isSelected, forKey: "isSelected")
        }
        if videourl != nil
        {
            aCoder.encode(videourl, forKey: "video_url")
        }
    }
}
