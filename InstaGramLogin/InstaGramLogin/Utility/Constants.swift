

import Foundation
import UIKit

//  MARK: - System Oriented Constants -

//AppName
let AppName = "InstaGramLogin"

struct SystemConstants {
    
    static let showLayoutArea = true
    static let hideLayoutArea = false
    static let showVersionNumber = 1
    
    static let IS_IPAD = (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad)
    static let IS_DEBUG = false
}

struct General{
    static let textFieldColorAlpha : CGFloat = 0.5
}

//  MARK: - Thired Party Constants -
struct ThiredPartyKey {
    
}

struct Instagram_data {
    //static let KApp_Id = "4fef19045d624e1aaab112b66ca07938"
    static let kDialogBaseURL = "https://instagram.com/"
    static let KInstagramLogin = "https://www.instagram.com/accounts/login/"
   
}

//  MARK: - Server Constants -
struct APIConstant {
    
    //  Main Domain
    static let baseURL = "https://www.instagram.com/"
    
    //  API - Sub Domain
    static let login = "accounts/login/ajax/"
    static let logout = "accounts/logout/"
    
    static let userProfile = "/?__a=1"
    static let timeline = "?__a=1"
    
    static let controlRequestKey : String = "ControlRequestKey"
   
    static let username : String = "username"
    static let password : String = "password"
    
    //For Header Values
    static let accepthtml  = "text/html"
    static let acceptjson  = "application/json"
    static let ig_prValue  = "1"
    static let ig_vwValue  = "1599"
    static let xrequestedwithValue  = "XMLHttpRequest"
    static let xinstagramajaxValue = "1"
    
    //For Header Keys
    static let accept  = "Accept"
    static let referer  = "referer"
    static let xcsrftoken  = "x-csrftoken"
    static let cookie  = "cookie"
    static let ig_pr  = "ig_pr"
    static let ig_vw  = "ig_vw"
    static let ds_user_id  = "ds_user_id"
    static let s_network  = "s_network"
    static let xinstagramajax  = "x-instagram-ajax"
    static let xrequestedwith  = "x-requested-with"
    
    //Cookie in
    static let sessionid  = "sessionid"
    static let rur  = "rur"
    static let csrftoken  = "csrftoken"
    static let mid  = "mid"
   
}


//  MARK: - layoutTime Constants -
struct ControlLayout {
    
    static let name : String = "controlName"
    static let borderRadius : CGFloat = 4.0
    
    static let horizontalPadding : CGFloat = SystemConstants.IS_IPAD ? 15 : 10.0
    static let verticalPadding : CGFloat = SystemConstants.IS_IPAD ? 15 : 10.0
    
    static let secondaryHorizontalPadding : CGFloat = SystemConstants.IS_IPAD ? 20 : 15.0
    static let secondaryVerticalPadding : CGFloat = SystemConstants.IS_IPAD ? 20 : 15.0
    static let secondaryPadding : CGFloat = SystemConstants.IS_IPAD ? 10 : 5.0
    
    static let txtBorderWidth : CGFloat = 1.5
    static let txtBorderRadius : CGFloat = 2.5
    static let textFieldHeight : CGFloat = 30.0
    static let textLeftPadding : CGFloat = 10.0
}


//  MARK: - Cell Identifier Constants -
struct CellIdentifire {
    
    static let leftMenu = "leftMenu"
    static let leftMenuCell = "leftMenuCell"
    
    static let detailProfile  = "detailProfile"
    static let photoCollection  = "photoCollection"
    static let commonList = "commonList"
    static let topSearch = "topSearch"
    static let place = "place"
    static let people = "people"
    static let hashTag = "hashTag"
    static let hashTagCollection = "hashTagCollection"
    static let placeCollectction = "placeCollectction"
    static let downloadInfo = "downloadInfo"
    static let imageViewer = "ImageViewerCollectionCell"
    static let profileCollectionHeader = "profileCollectionHeader"
    
    static let profilePhoto = "profilePhoto"
}

//  MARK: - Info / Error Message Constants -
struct ErrorMessage {
    
    static let noInternet = "⚠️ Internet connection is not available."
    
}

struct UserDefaultKey
{
    static let loginUserData            = "loginUserData"
    static let tempUserName             = "tempUserName"
    
    static let timeline                  = "timeline"
    
}

struct LocalNotification {
    static let logoutSuccess : String = "Logout Event"
    static let loginEvent : String = "Login Event"
    static let ProfileAPICall   = "ProfileAPICall"
    
}


// MARK: - Device Compatibility
struct currentDevice {
    static let isIphone = (UIDevice.current.model as NSString).isEqual(to: "iPhone") ? true : false
    static let isIpad = (UIDevice.current.model as NSString).isEqual(to: "iPad") ? true : false
    static let isIPod = (UIDevice.current.model as NSString).isEqual(to: "iPod touch") ? true : false
}

