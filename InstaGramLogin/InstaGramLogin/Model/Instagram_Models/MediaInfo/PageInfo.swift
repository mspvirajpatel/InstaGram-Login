
import Foundation


class PageInfo : NSObject, NSCoding{

	var endCursor : String? = ""
    var hasNextPage : Bool! = false
	var hasPreviousPage : Bool! = false
	var startCursor : AnyObject!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any])
    {
        if let data = dictionary["end_cursor"] as? String{
            endCursor = data
        }
        
        if let data = dictionary["has_next_page"] as? Bool{
            hasNextPage = data
        }
        
        if let data = dictionary["has_previous_page"] as? Bool{
            hasPreviousPage = data
        }
        
        if let data = dictionary["start_cursor"]{
            startCursor = data as AnyObject!
        }
    }

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if endCursor != nil{
			dictionary["end_cursor"] = endCursor
		}
		if hasNextPage != nil{
			dictionary["has_next_page"] = hasNextPage
		}
		if hasPreviousPage != nil{
			dictionary["has_previous_page"] = hasPreviousPage
		}
		if startCursor != nil{
			dictionary["start_cursor"] = startCursor
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder) {
         endCursor = aDecoder.decodeObject(forKey: "end_cursor") as? String
         hasNextPage = aDecoder.decodeObject(forKey: "has_next_page") as? Bool
         hasPreviousPage = aDecoder.decodeObject(forKey: "has_previous_page") as? Bool
         startCursor = aDecoder.decodeObject(forKey: "start_cursor") as AnyObject!
	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if endCursor != nil{
			aCoder.encode(endCursor, forKey: "end_cursor")
		}
		if hasNextPage != nil{
			aCoder.encode(hasNextPage, forKey: "has_next_page")
		}
		if hasPreviousPage != nil{
			aCoder.encode(hasPreviousPage, forKey: "has_previous_page")
		}
		if startCursor != nil{
			aCoder.encode(startCursor, forKey: "start_cursor")
		}

	}

}
