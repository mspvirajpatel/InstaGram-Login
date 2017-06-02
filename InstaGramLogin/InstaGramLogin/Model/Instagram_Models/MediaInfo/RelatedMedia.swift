

import Foundation


class RelatedMedia : NSObject, NSCoding{

	var nodes : [AnyObject]! = []

	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		nodes = dictionary["nodes"] as? [AnyObject]
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if nodes != nil{
			dictionary["nodes"] = nodes
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         nodes = aDecoder.decodeObject(forKey: "nodes") as? [AnyObject]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if nodes != nil{
			aCoder.encode(nodes, forKey: "nodes")
		}

	}

}
