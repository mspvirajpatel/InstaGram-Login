

import Foundation


class TimeLine : NSObject, NSCoding{

	var graphql : Graphql!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		if let graphqlData = dictionary["graphql"] as? [String:Any]{
			graphql = Graphql(fromDictionary: graphqlData)
		}
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if graphql != nil{
			dictionary["graphql"] = graphql.toDictionary()
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         graphql = aDecoder.decodeObject(forKey: "graphql") as? Graphql

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if graphql != nil{
			aCoder.encode(graphql, forKey: "graphql")
		}

	}

}
