
import UIKit

class AppBaseLayout: NSObject {
   
    var position_Top, position_Bottom: NSLayoutConstraint!
    var position_Left, position_Right: NSLayoutConstraint!
    
    var margin_Left, margin_Right: NSLayoutConstraint!
    var size_Width, size_Height: NSLayoutConstraint!
    
    var position_CenterX, position_CenterY: NSLayoutConstraint!
    
    var control_H: Array<NSLayoutConstraint>!
    var control_V: Array<NSLayoutConstraint>!
    
    var viewDictionary: [String : AnyObject]!
    var metrics: [String : CGFloat]!
    
    var view: UIView!
    
    // MARK: - Lifecycle -
    
    override init(){
        super.init()
    }
    
    init(iView: UIView){
        self.view = iView
    }
    
    // MARK: - Public Interface -
    func setLeftRightConstraint(_ superView : UIView, control : UIView , space : CGFloat)
    {
        let dictionary: Dictionary = ["superView" : superView , "control" : control ]
        let metrics : Dictionary = ["space" : space]
        
        self.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-space-[control]-space-|", options:NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: dictionary)
        superView.addConstraints(self.control_H)
    }
    
    
    func expandViewInsideView(_ mainView: UIView){
        
        let dictionary: Dictionary = ["view" : self.view]
        
        self.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options:NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        self.control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options:NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        
        mainView.addConstraints(self.control_H)
        mainView.addConstraints(self.control_V)
    }
    
    func expandView(_ containerView: UIView, insideView mainView: UIView){
        
        let dictionary: Dictionary = ["containerView" : containerView]
        
        self.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|[containerView]|", options:NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        self.control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|[containerView]|", options:NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        
        mainView.addConstraints(self.control_H)
        mainView.addConstraints(self.control_V)
    }
    
    func expandView(_ containerView: UIView, insideView mainView: UIView, betweenSpace space:CGFloat ){
        
        
        let dictionary: Dictionary = ["containerView" : containerView]
        
        let metrics : Dictionary = ["space" : space]
        self.control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-space-[containerView]-space-|", options:NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: dictionary)
        self.control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-space-[containerView]-space-|", options:NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: dictionary)
        
        mainView.addConstraints(self.control_H)
        mainView.addConstraints(self.control_V)
    }
    
    func releaseObject(){
        position_Top = nil
        position_Left = nil
        position_Right = nil
        position_Bottom = nil
        position_CenterX = nil
        position_CenterY = nil
        size_Width = nil
        size_Height = nil
        control_H = nil
        control_V = nil
        margin_Left = nil
        margin_Right = nil
        
        if metrics != nil{
            metrics.removeAll()
        }
        
        if viewDictionary != nil{
            viewDictionary.removeAll()
        }
    }
    
    // MARK: - Internal Helpers -
}
