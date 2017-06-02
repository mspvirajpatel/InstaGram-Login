

import Foundation


class Image : NSObject, NSCoding{

	var lowResolution : LowResolution!
	var standardResolution : LowResolution!
	var thumbnail : LowResolution!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		if let lowResolutionData = dictionary["low_resolution"] as? [String:Any]{
			lowResolution = LowResolution(fromDictionary: lowResolutionData)
		}
		if let standardResolutionData = dictionary["standard_resolution"] as? [String:Any]{
			standardResolution = LowResolution(fromDictionary: standardResolutionData)
		}
		if let thumbnailData = dictionary["thumbnail"] as? [String:Any]{
			thumbnail = LowResolution(fromDictionary: thumbnailData)
		}
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if lowResolution != nil{
			dictionary["low_resolution"] = lowResolution.toDictionary()
		}
		if standardResolution != nil{
			dictionary["standard_resolution"] = standardResolution.toDictionary()
		}
		if thumbnail != nil{
			dictionary["thumbnail"] = thumbnail.toDictionary()
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         lowResolution = aDecoder.decodeObject(forKey: "low_resolution") as? LowResolution
         standardResolution = aDecoder.decodeObject(forKey: "standard_resolution") as? LowResolution
         thumbnail = aDecoder.decodeObject(forKey: "thumbnail") as? LowResolution

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if lowResolution != nil{
			aCoder.encode(lowResolution, forKey: "low_resolution")
		}
		if standardResolution != nil{
			aCoder.encode(standardResolution, forKey: "standard_resolution")
		}
		if thumbnail != nil{
			aCoder.encode(thumbnail, forKey: "thumbnail")
		}

	}

}
