
import Foundation


class Comment : NSObject, NSCoding{

	var count : Int! = 0
	var nodes : [Node]! = []
	var pageInfo : PageInfo!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		count = dictionary["count"] as? Int
		nodes = [Node]()
		if let nodesArray = dictionary["nodes"] as? [[String:Any]]{
			for dic in nodesArray{
				let value = Node(fromDictionary: dic)
				nodes.append(value)
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
		if nodes != nil{
			var dictionaryElements = [[String:Any]]()
			for nodesElement in nodes {
				dictionaryElements.append(nodesElement.toDictionary())
			}
			dictionary["nodes"] = dictionaryElements
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
         nodes = aDecoder.decodeObject(forKey :"nodes") as? [Node]
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
		if nodes != nil{
			aCoder.encode(nodes, forKey: "nodes")
		}
		if pageInfo != nil{
			aCoder.encode(pageInfo, forKey: "page_info")
		}

	}

}
