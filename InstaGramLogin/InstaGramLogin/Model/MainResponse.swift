
import UIKit

class MainResponse: NSObject
{
    // MARK: - Attributes -
    
    var contactListArray:NSMutableArray!
    
    // MARK: - Lifecycle -
    required override init() {
        super.init()
    }
    
    // MARK: - Public Interface -
    func getModelFromResponse(response : AnyObject , task : APITask) -> AnyObject
    {
        var returnModel : AnyObject = response
        
        switch task
        {
            
        case .TimeLine:
            
            var timeLine : TimeLine! = TimeLine.init(fromDictionary: response as! [String : Any])
            
            returnModel = timeLine as AnyObject
            
            timeLine = nil
            break
             
        case .UserProfile:
            
            var userProfile : UserProfileModel! = UserProfileModel.init(fromDictionary: response as! [String : Any])
            
            returnModel = userProfile as AnyObject
            
            userProfile = nil
            break
        
            
        default:
            break
        }
        
        return returnModel
    }
    
    // MARK: - Internal Helpers -
    
  
    
}
