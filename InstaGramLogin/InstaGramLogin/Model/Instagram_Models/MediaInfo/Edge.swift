
import Foundation


class Edge : NSObject, NSCoding{

	var node : Node!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		if let nodeData = dictionary["node"] as? [String:Any]{
			node = Node(fromDictionary: nodeData)
		}
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if node != nil{
			dictionary["node"] = node.toDictionary()
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         node = aDecoder.decodeObject(forKey: "node") as? Node

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if node != nil{
			aCoder.encode(node, forKey: "node")
		}

	}

}
