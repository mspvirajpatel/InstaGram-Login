
import Foundation


class EdgeMediaToComment : NSObject, NSCoding{

	var count : Int! = 0
	var edges : [TimeLineEdge]! = []
	var pageInfo : PageInfo!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any])
    {
        if let data = dictionary["count"] as? Int{
            count = data
        }
        
		edges = [TimeLineEdge]()
		if let edgesArray = dictionary["edges"] as? [[String:Any]]{
			for dic in edgesArray{
				let value = TimeLineEdge(fromDictionary: dic)
				edges.append(value)
			}
		}
		if let pageInfoData = dictionary["page_info"] as? [String:Any]{
			pageInfo = PageInfo(fromDictionary: pageInfoData)
		}
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if count != nil{
			dictionary["count"] = count
		}
		if edges != nil{
			var dictionaryElements = [[String:Any]]()
			for edgesElement in edges {
				dictionaryElements.append(edgesElement.toDictionary())
			}
			dictionary["edges"] = dictionaryElements
		}
		if pageInfo != nil{
			dictionary["page_info"] = pageInfo.toDictionary()
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         count = aDecoder.decodeObject(forKey: "count") as? Int
         edges = aDecoder.decodeObject(forKey :"edges") as? [TimeLineEdge]
         pageInfo = aDecoder.decodeObject(forKey: "page_info") as? PageInfo

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if count != nil{
			aCoder.encode(count, forKey: "count")
		}
		if edges != nil{
			aCoder.encode(edges, forKey: "edges")
		}
		if pageInfo != nil{
			aCoder.encode(pageInfo, forKey: "page_info")
		}

	}

}
