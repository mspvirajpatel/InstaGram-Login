
import UIKit


class AppTheme : NSObject{
    
    class func getFont(fontName : String, size : CGFloat) -> UIFont{
        return UIFont(fontString: "\(fontName);\(size)")
    }
}

struct FontStyle{
    static let bold = "AppleSDGothicNeo-Bold"
    static let regular = "AppleSDGothicNeo-Regular"
    static let light = "AppleSDGothicNeo-Regular"
    static let medium = "AppleSDGothicNeo-Medium"
    
    
}

extension Color{
    
    var value: UIColor {
        var instanceColor = UIColor.clear
        
        switch self {
            
        // TODO: SideMenu Color
        case .sideMenuBG:
            instanceColor = UIColor(rgbValue: 0x1B3B5B)  //2D3238 0x1B3B5B
            break
            
        case .sideMenuText:
            instanceColor = UIColor(rgbValue: 0xe4e7eb)
            break
            
        case .sideMenuSelectedText:
            instanceColor = UIColor(rgbValue: 0x69a0ff)
            break
            
        // TODO: Activity Loader Color
        case .activityLoader: // this will set spinner/activity loader tint color
            instanceColor = UIColor.red
            break
            
        case .activityLoaderBG:
            instanceColor = UIColor(rgbValue: 0xffffff, alpha: 0.5)
            break
            
        case .activityText:
            instanceColor = UIColor(rgbValue: 0x000000, alpha: 0.5)
            break
            
        // TODO: Bar Button Color
        case .activeBarButtonText:
            instanceColor = UIColor(rgbValue: 0x000000, alpha: 0.5)
            break
            
        case .disableBarButtonText:
            instanceColor = UIColor(rgbValue: 0xffffff, alpha: 0.5)
            break
            
        case .barButtonBorder:
            instanceColor = UIColor(rgbValue: 0x000000, alpha: 0.5)
            break
            
        case .border: // This will general border color in whole application
            instanceColor = UIColor(rgbValue: 0x333333, alpha: 1.0)
            break
            
        case .shadow: // This will mainly use for give shadow to view and cell cardview
            instanceColor = UIColor(rgbValue: 0x333333, alpha: 1.0)
            break
            
        // TODO: Application Background Colors
        case .appPrimaryBG: // this is application general dark backgroud color
            instanceColor = UIColor(rgbValue: 0x2874F0, alpha: 1.0)
            break
            
        case .appSecondaryBG: // this is application general light backgroud color
            instanceColor = UIColor(rgbValue: 0xffffff, alpha: 1.0)
            break
            
        case .appIntermidiateBG: // this is application general intermidiate backgroud color
            instanceColor = UIColor(rgbValue: 0xeeeeee, alpha: 1.0)
            break
            
        case .icon: // this is application general icon color
            instanceColor = UIColor(rgbValue: 0xa0a0a0, alpha: 1.0)
            break
            
        // TODO: UITextField / UITextView
        case .textFieldBG:
            instanceColor = UIColor(rgbValue: 0xDCDCDC, alpha: 1.0)
            break
            
        case .textFieldText:
            instanceColor = UIColor(rgbValue: 0x000000, alpha: 1.0)
            break
            
        case .textFieldBorder:
            instanceColor = UIColor(rgbValue: 0x2874F0, alpha: 1.0)
            break
            
        case .textFieldErrorBorder:
            instanceColor = UIColor(rgbValue: 0xffffff, alpha: 1.0)
            break
            
        case .textFieldPlaceholder:
            instanceColor = UIColor(rgbValue: 0x555555, alpha: 1.0)
            break
            
        // TODO: UIButton Color
        case .buttonPrimaryBG:
            instanceColor = UIColor(rgbValue: 0xBD8670, alpha: 1.0)
            break
            
        case .buttonSecondaryBG:
            instanceColor = UIColor(rgbValue: 0x4C4C4C, alpha: 1.0)
            break
            
        case .buttonPrimaryTitle:
            instanceColor = UIColor(rgbValue: 0x2874F0, alpha: 1.0)
            break
            
        case .buttonSecondaryTitle:
            instanceColor = UIColor(rgbValue: 0xffffff, alpha: 1.0)
            break
            
        case .buttonBorder:
            instanceColor = UIColor(rgbValue: 0xffffff, alpha: 1.0)
            break
            
        // TODO: UILable Color
        case .labelText:
            instanceColor = UIColor(rgbValue: 0x2874F0, alpha: 1.0)
            break
            
        case .labelPrimary:
            instanceColor = UIColor(rgbValue: 0x4C4C4C, alpha: 1.0)
            break
            
        case .labelErrorText:
            instanceColor = UIColor(rgbValue: 0xc1272d, alpha: 1.0)
            break
            
        // TODO: Segment View Color
        case .segmentBG:
            instanceColor = UIColor(rgbValue: 0x2874F0, alpha: 1.0)
            break
            
        case .segmentTitle:
            instanceColor = UIColor(rgbValue: 0xBD8670, alpha: 1.0)
            break
            
        case .segmentBorder:
            instanceColor = UIColor(rgbValue: 0x4C4C4C, alpha: 1.0)
            break
            
        case .segmentSelectedBG:
            instanceColor = UIColor(rgbValue: 0xBD8670, alpha: 1.0)
            break
            
        case .segmentSelectedTitle:
            instanceColor = UIColor(rgbValue: 0xffffff, alpha: 1.0)
            break
            
        // TODO: Navigation Color
        case .navigationBG: // This will use for set navigation Text Color
            instanceColor = UIColor(rgbValue: 0x2874F0, alpha: 1.0)
            break
            
        case .navigationTitle: // This will use for set navigation title color
            instanceColor = UIColor(rgbValue: 0xffffff, alpha: 1.0)
            break
            
        case .navigationBottomBorder:
            instanceColor = UIColor(rgbValue: 0xffffff, alpha: 1.0)
            break
            
        // TODO: AlertView Color
        case .alertMessageText:
            instanceColor = UIColor(rgbValue: 0xffffff, alpha: 1.0)
            break
            
        case .alertErrorText:
            instanceColor = UIColor(rgbValue: 0xffffff, alpha: 1.0)
            break
            
        case .alertBG:
            instanceColor = UIColor(rgbValue: 0x000000, alpha: 1.0)
            break
            
        case .alertErrorBG:
            instanceColor = UIColor(rgbValue: 0xBD8670, alpha: 1.0)
            break
            
        // TODO: UITableView Color
        case .tableSeperator:
            instanceColor = UIColor(rgbValue: 0x2874F0, alpha: 1.0)
            break
            
        case .tablePrimaryBG:
            instanceColor = UIColor(rgbValue: 0xffffff, alpha: 1.0)
            break
            
        // TODO: UITableView Cell Color
        case .cellBG:
            instanceColor = UIColor(rgbValue: 0x2874F0, alpha: 1.0)
            break
            
        case .cellSelectedBG:
            instanceColor = UIColor(rgbValue: 0x2874F0, alpha: 1.0)
            break
        
        // TODO: ImageView Color
        case .imageViewBorder:
            instanceColor = UIColor(rgbValue: 0x000000, alpha: 1.0)
            break
            
        // TODO: TabBar Color
        case .tabBarBG:
            instanceColor = UIColor(rgbValue: 0x2874F0, alpha: 1.0)
            break
            
        case .tabBarTint:
            instanceColor = UIColor.white
            break
            
        // TODO: Custom Color
        case .custom(let hexValue, let opacity):
            instanceColor = UIColor(rgbValue: hexValue, alpha: CGFloat(opacity))
            break
        }
        return instanceColor
    }
}

enum Color{
    
    // Activity loader
    case activityLoader
    case activityLoaderBG
    case activityText
    
    // Keyboard Bar Button Text Color
    case activeBarButtonText
    case disableBarButtonText
    case barButtonBorder
    
    case border
    case shadow
    
    // Application Background Colors
    case appPrimaryBG
    case appSecondaryBG
    case appIntermidiateBG
    
    // UITableView Color
    case tableSeperator
    case tablePrimaryBG
    
    // UITableView Cell Color
    case cellBG
    case cellSelectedBG
    
    // Application Text Color
    case textFieldBG
    case textFieldText
    case textFieldPlaceholder
    case textFieldBorder
    case textFieldErrorBorder
  
    // Application SideMenu
    case sideMenuBG
    case sideMenuText
    case sideMenuSelectedText
    
    // Application UILabel Color
    case labelText
    case labelPrimary
    case labelErrorText
    
    // Application Button Color
    case buttonPrimaryBG
    case buttonSecondaryBG
    case buttonPrimaryTitle
    case buttonSecondaryTitle
    case buttonBorder
    
    // Application SegmentView Color
    case segmentTitle
    case segmentBG
    case segmentSelectedTitle
    case segmentSelectedBG
    case segmentBorder
    
    // Application Navigation Color
    case navigationBG
    case navigationTitle
    case navigationBottomBorder
    
    // Application Murmor Alert Color
    case alertMessageText
    case alertErrorText
    case alertBG
    case alertErrorBG
    
    // Profile Image Border color
    case imageViewBorder
    
    
    // TabBar Color
    case tabBarTint
    case tabBarBG
    
    //icon color of whole app
    case icon
    
    // 1
    case custom(hexString: Int, alpha: CGFloat)
    // 2
    func withAlpha(_ alpha: CGFloat) -> UIColor {
        return self.value.withAlphaComponent(CGFloat(alpha))
    }
}
