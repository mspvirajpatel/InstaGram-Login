
import Foundation

class CarouselMedia : NSObject, NSCoding{
    
    var images : Image!
    var type : String! = ""
    var usersInPhoto : [AnyObject]! = []
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any])
    {
        if let imagesData = dictionary["images"] as? [String:Any]{
            images = Image(fromDictionary: imagesData)
        }
        
        if let data = dictionary["type"] as? String {
            type = data
        }
        
        if let data = dictionary["users_in_photo"] as? [AnyObject] {
            usersInPhoto = data
        }
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if images != nil{
            dictionary["images"] = images.toDictionary()
        }
        if type != nil{
            dictionary["type"] = type
        }
        if usersInPhoto != nil{
            dictionary["users_in_photo"] = usersInPhoto
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        images = aDecoder.decodeObject(forKey: "images") as? Image
        type = aDecoder.decodeObject(forKey: "type") as? String
        usersInPhoto = aDecoder.decodeObject(forKey: "users_in_photo") as? [AnyObject]
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if images != nil{
            aCoder.encode(images, forKey: "images")
        }
        if type != nil{
            aCoder.encode(type, forKey: "type")
        }
        if usersInPhoto != nil{
            aCoder.encode(usersInPhoto, forKey: "users_in_photo")
        }
        
    }
    
}
