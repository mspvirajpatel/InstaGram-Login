
import Foundation


class Like : NSObject, NSCoding{

	var count : Int! = 0
	var nodes : [Node]! = []
	var viewerHasLiked : Bool! = false


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any])
    {
        if let data = dictionary["count"] as? Int {
            count = data
        }
        
		nodes = [Node]()
		if let nodesArray = dictionary["nodes"] as? [[String:Any]]{
			for dic in nodesArray{
				let value = Node(fromDictionary: dic)
				nodes.append(value)
			}
		}
        
        if let data = dictionary["viewer_has_liked"] as? Bool {
            viewerHasLiked = data
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
		if viewerHasLiked != nil{
			dictionary["viewer_has_liked"] = viewerHasLiked
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
         viewerHasLiked = aDecoder.decodeObject(forKey: "viewer_has_liked") as? Bool

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
		if viewerHasLiked != nil{
			aCoder.encode(viewerHasLiked, forKey: "viewer_has_liked")
		}

	}

}
