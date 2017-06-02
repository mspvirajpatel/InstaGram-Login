
import UIKit
import Foundation
import AVFoundation

class InterfaceUtility: NSObject {
    
    class func getDeviceScreenSize()->CGSize{
        let screenBounds: CGRect = UIScreen.main.bounds
        return screenBounds.size
    }
  
    class func getAppropriateSizeFromSize(_ iSize: CGSize, withDivision divider: CGFloat, andInterSpacing interSpacing: CGFloat) -> CGSize {
        
        let iWidth: CGFloat = iSize.width
        let iHeight: CGFloat = iSize.height
        
        var oWidth: CGFloat
        var oHeight: CGFloat
        
        if iWidth >= iHeight {
            
            oWidth = (iHeight-(interSpacing*(divider+1)))/divider
            oHeight = oWidth
            
        } else {
            
            oWidth = (iWidth-(interSpacing*(divider+1)))/divider
            oHeight = oWidth
            
        }
        
        let oSize: CGSize = CGSize(width: oWidth, height: oHeight)
        return oSize
    }
    
    class func aspectScaledImageSizeForImageView(_ iv: UIImageView, image: UIImage) -> CGSize {
      
        var x: CGFloat
        var y: CGFloat
        
        var a: CGFloat
        var b: CGFloat
        
        x = iv.frame.size.width
        y = iv.frame.size.height
        
        a = image.size.width
        b = image.size.height
        
        if x == a && y == b {
            
        }
        else {
            if x > a && y > b {
                if x - a > y - b {
                    a = y / b * a
                    b = y
                }
                else {
                    b = x / a * b
                    a = x
                }
            }
            else {
                if x < a && y < b {
                    if a - x > b - y {
                        a = y / b * a
                        b = y
                    }
                    else {
                        b = x / a * b
                        a = x
                    }
                }
                else {
                    if x < a && y > b {
                        b = x / a * b
                        a = x
                    }
                    else {
                        if x > a && y < b {
                            a = y / b * a
                            b = y
                        }
                        else {
                            if x == a {
                                a = y / b * a
                                b = y
                            }
                            else {
                                if y == b {
                                    b = x / a * b
                                    a = x
                                }
                            }
                        }
                    }
                }
            }
        }
        return CGSize(width: a, height: b)
    }
    
    class func cropImage(_ image: UIImage, fromRect rect: CGRect) -> UIImage {
        let imageRef: CGImage = image.cgImage!.cropping(to: rect)!
        let croppedImage: UIImage = UIImage(cgImage: imageRef)
        return croppedImage
    }
    
    class func imageFromColor(_ color: UIColor) -> UIImage {
        let rect: CGRect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return image
    }
    
    class func createImageFromView(_ view: UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, 0.0)
        
        let context: CGContext = UIGraphicsGetCurrentContext()!
        view.layer.render(in: context)
        
        let snapshotImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return snapshotImage
    }
    
    class func setCircleViewWith(_ borderColor: UIColor, width: CGFloat, ofView view: UIView) {
        
        view.layer.cornerRadius = (view.frame.size.width / 2)
        view.layer.masksToBounds = (true)
        view.layer.borderWidth = (width)
        view.layer.borderColor = (borderColor.cgColor)
        
        let containerLayer: CALayer = CALayer()
        containerLayer.shadowColor = UIColor.black.cgColor
        
        containerLayer.shadowRadius = 10.0
        containerLayer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        containerLayer.shadowOpacity = 1.0
        view.superview?.layer.addSublayer(containerLayer)
    }
    
    class func getViewControllerForAlertController() -> AnyObject?
    {
        let controller = AppUtility .getAppDelegate() .window?.rootViewController
        return controller
    }
    
    public static var topMostVC: UIViewController? {
        var presentedVC = UIApplication.shared.keyWindow?.rootViewController
        while let pVC = presentedVC?.presentedViewController {
            presentedVC = pVC
        }
        
        if presentedVC == nil {
            print("EZSwiftExtensions Error: You don't have any views set. You may be calling them in viewDidLoad. Try viewDidAppear instead.")
        }
        return presentedVC
    }
    
    class var currentRegion: String? {
        return (Locale.current as NSLocale).object(forKey: NSLocale.Key.countryCode) as? String
    }
    
    /// EZSE: Calls action when a screen shot is taken
    public static func detectScreenShot(_ action: @escaping () -> ()) {
        let mainQueue = OperationQueue.main
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIApplicationUserDidTakeScreenshot, object: nil, queue: mainQueue) { notification in
            // executes after screenshot
            action()
        }
    }
    
    /// EZSE: Downloads JSON from url string
    public static func requestJSON(_ url: String, success: @escaping ((Any?) -> Void), error: ((NSError) -> Void)?) {
        requestURL(url,
                   success: { (data) -> Void in
                    let json: Any? = self.dataToJsonDict(data)
                    success(json)
            },
                   error: { (err) -> Void in
                    if let e = error {
                        e(err)
                    }
        })
    }
    
    /// EZSE: converts NSData to JSON dictionary
    fileprivate static func dataToJsonDict(_ data: Data?) -> Any? {
        if let d = data {
            var error: NSError?
            let json: Any?
            do {
                json = try JSONSerialization.jsonObject(
                    with: d,
                    options: JSONSerialization.ReadingOptions.allowFragments)
            } catch let error1 as NSError {
                error = error1
                json = nil
            }
            
            if let _ = error {
                return nil
            } else {
                return json
            }
        } else {
            return nil
        }
    }
    
    /// EZSE:
    fileprivate static func requestURL(_ url: String, success: @escaping (Data?) -> Void, error: ((NSError) -> Void)? = nil) {
        guard let requestURL = URL(string: url) else {
            assertionFailure("EZSwiftExtensions Error: Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(
            with: URLRequest(url: requestURL),
            completionHandler: { data, response, err in
                if let e = err {
                    error?(e as NSError)
                } else {
                    success(data)
                }
        }).resume()
    }
    
    class func animateCellTableView(tableview:UITableView)
    {
        let cells = tableview.visibleCells
        let tableHeight: CGFloat = tableview.bounds.size.height
        
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        
        var index = 0
        
        for a in cells {
            let cell: UITableViewCell = a as UITableViewCell
            UIView.animate(withDuration: 1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0);
            }, completion: nil)
            
            index += 1
        }
    }

    
    class func animateCellCollectionViewOnTap(cell: UIView)
    {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: [],
                       animations: {
                        cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                        
        },
                       completion: { finished in
                        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: .curveEaseInOut,
                                       animations: {
                                        cell.transform = CGAffineTransform(scaleX: 1, y: 1)
                        },
                                       completion: nil
                        )
                        
        })
    }
    
    
}
