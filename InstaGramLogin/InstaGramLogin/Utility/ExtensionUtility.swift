
import UIKit

// MARK: - UIColor Extension -
protocol UIScrollViewScrollToBottomDelegate {
    func scrollViewWillScrollToBottom(_ scrollView: UIScrollView)
    func scrollViewDidScrollToBottom(_ scrollView: UIScrollView)
}

private var xoAssociationKey = "xoAssociationKey"
private var xoAssociationDelegateKey = "xoAssociationDelegateKey"

public extension String {
   
    public func localize(comment: String?) -> String {
        if comment != nil
        {
            return NSLocalizedString(self, comment: comment!)
        }
        else
        {
            return NSLocalizedString(self, comment: "")
        }
    }
    
    public func localize() -> String {
       
        return NSLocalizedString(self, comment: "")
        
    }
}


public extension UIAlertController {
    public func kam_show(animated: Bool = true, completionHandler: (() -> Void)? = nil) {
        guard let rootVC = UIApplication.shared.keyWindow?.rootViewController else {
            return
        }
        var forefrontVC = rootVC
        while let presentedVC = forefrontVC.presentedViewController {
            forefrontVC = presentedVC
        }
        forefrontVC.present(self, animated: animated, completion: completionHandler)
    }
}

public extension UIColor {
    
    public convenience init(rgbValue: Int, alpha: CGFloat) {
        
        self.init(red:   CGFloat( (rgbValue & 0xFF0000) >> 16 ) / 255.0,
                  green: CGFloat( (rgbValue & 0x00FF00) >> 8 ) / 255.0,
                  blue:  CGFloat( (rgbValue & 0x0000FF) >> 0 ) / 255.0,
                  alpha: alpha)
        
    }
    
    public convenience init(rgbValue: Int) {
        self.init(rgbValue: rgbValue, alpha: 1.0)
    
    }
    
    public func lighterColorForColor() -> UIColor? {
        
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        if self.getRed(&r, green: &g, blue: &b, alpha: &a) {
            
            return UIColor(red: min(r + 0.2, 1.0),
                           green: min(g + 0.2, 1.0),
                           blue: min(b + 0.2, 1.0),
                           alpha: a)
            
        }
        
        return nil
        
    }
    
    public func darkerColorForColor() -> UIColor? {
        
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        if self.getRed(&r, green: &g, blue: &b, alpha: &a) {
            
            return UIColor(red: max(r - 0.15, 0.0),
                           green: max(g - 0.15, 0.0),
                           blue: max(b - 0.15, 0.0),
                           alpha: a)
            
        }
        
        return nil
        
    }
    
}


extension UIGestureRecognizerState{
    
    func toString()->String{
        switch self{
        case .began:
            return "Began"
        case .cancelled:
            return "Cancelled"
        case .changed:
            return "Changed"
        case .ended:
            return "Ended"
        case .failed:
            return "Failed"
        case .possible:
            return "invaid value"
        }
    }
}

extension UIColor {
    
    /// highlight color for test
    class var ncBlue:UIColor{
        return UIColor(red:0.505, green:0.831, blue:0.98, alpha:1)
    }
    
}


// MARK: - UIFont Extension -

public extension UIFont {
    
    public convenience init(fontString: String) {
        
        var stringArray : Array = fontString.components(separatedBy: ";")
        self.init(name: stringArray[0], size:stringArray[1].stringToFloat())!
        
    }
}

// MARK: - UIViewController Extension -
private var didKDVCInitialized = false

private var interactiveNavigationBarHiddenAssociationKey: UInt8 = 0

extension UIViewController {
    
    @IBInspectable public var interactiveNavigationBarHidden: Bool {
        get {
            var associateValue = objc_getAssociatedObject(self, &interactiveNavigationBarHiddenAssociationKey)
            if associateValue == nil {
                associateValue = false
            }
            return associateValue as! Bool;
        }
        set {
            objc_setAssociatedObject(self, &interactiveNavigationBarHiddenAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    override open static func initialize() {
        if !didKDVCInitialized {
            replaceInteractiveMethods()
            didKDVCInitialized = true
        }
    }
    
    fileprivate static func replaceInteractiveMethods() {
        method_exchangeImplementations(
            class_getInstanceMethod(self, #selector(UIViewController.viewWillAppear(_:))),
            class_getInstanceMethod(self, #selector(UIViewController.KD_interactiveViewWillAppear(_:))))
    }
    
    func KD_interactiveViewWillAppear(_ animated: Bool) {
        KD_interactiveViewWillAppear(animated)
        navigationController?.setNavigationBarHidden(interactiveNavigationBarHidden, animated: animated)
    }
    
}


// MARK: - UIView Extension -

public extension UIView {
    var width:      CGFloat { return self.frame.size.width }
    var height:     CGFloat { return self.frame.size.height }
    var size:       CGSize  { return self.frame.size}
    
    var origin:     CGPoint { return self.frame.origin }
    var x:          CGFloat { return self.frame.origin.x }
    var y:          CGFloat { return self.frame.origin.y }
    var centerX:    CGFloat { return self.center.x }
    var centerY:    CGFloat { return self.center.y }
    
    var left:       CGFloat { return self.frame.origin.x }
    var right:      CGFloat { return self.frame.origin.x + self.frame.size.width }
    var top:        CGFloat { return self.frame.origin.y }
    var bottom:     CGFloat { return self.frame.origin.y + self.frame.size.height }
   
    
    func setSize(_ size:CGSize)
    {
        self.frame.size = size
    }
    
    func setOrigin(_ point:CGPoint)
    {
        self.frame.origin = point
    }
    
    func setX(_ x:CGFloat) //only change the origin x
    {
        self.frame.origin = CGPoint(x: x, y: self.frame.origin.y)
    }
    
    func setY(_ y:CGFloat) //only change the origin x
    {
        self.frame.origin = CGPoint(x: self.frame.origin.x, y: y)
    }
    
    func roundCorner(_ radius:CGFloat)
    {
        self.layer.cornerRadius = radius
    }
    
    func setTop(_ top:CGFloat)
    {
        self.frame.origin.y = top
    }
    
    func setLeft(_ left:CGFloat)
    {
        self.frame.origin.x = left
    }
    
    func setRight(_ right:CGFloat)
    {
        self.frame.origin.x = right - self.frame.size.width
    }
    
    func setBottom(_ bottom:CGFloat)
    {
        self.frame.origin.y = bottom - self.frame.size.height
    }
    
    public func isTextControl() -> Bool{
        return (self.isTextFieldControl() || self.isTextViewControl())
    }
    
    public func isTextFieldControl() -> Bool{
        return self.isKind(of: UITextField.self)
    }
    
    public func isTextViewControl() -> Bool{
        return self.isKind(of: UITextView.self)
    }
    
    public func getRequestDictionaryFromView() -> [String: String]{
        
        var textControl : AnyObject?
        var textFromTextControl : String?
        var requestKey : String?
        
        var requestDictionary : [String: String] = Dictionary()
        
        for view in self.subviews {
            
            if(view.isTextControl()){
                
                if(view.isTextFieldControl()){
                    
                    textControl = view as? UITextField
                    textFromTextControl = textControl!.text
                    
                }else if(view.isTextViewControl()){
                    
                    textControl = view as? UITextView
                    textFromTextControl = textControl!.text
                    
                }
                
                requestKey = view.layer.value(forKey: APIConstant.controlRequestKey) as? String
                if(requestKey != nil && textFromTextControl != nil){
                    
                    requestDictionary[requestKey!] = textFromTextControl
                    
                }
                
            }
            
        }
        
        textControl = nil
        textFromTextControl = nil
        requestKey = nil
        
        return requestDictionary
        
    }

    func getDictionaryOfVariableBindings(superView : UIView , viewDic : NSDictionary) -> NSDictionary
    {
        var dicView : NSMutableDictionary = viewDic.mutableCopy() as! NSMutableDictionary
        
        if superView.subviews.count > 0
        {
            if let viewName = superView.layer .value(forKeyPath: ControlLayout.name) as? String
            {
                dicView .setValue(superView, forKey: viewName)
            }
            
            for view in superView.subviews
            {
                if view.subviews.count > 0
                {
                    dicView = self.getDictionaryOfVariableBindings(superView: view , viewDic: dicView) .mutableCopy() as! NSMutableDictionary
                }
                else
                {
                    if let viewName = view.layer .value(forKeyPath: ControlLayout.name) as? String{
                        dicView .setValue(view, forKey: viewName)
                    }
                }
            }
        }
        else
        {
            if let viewName = superView.layer .value(forKeyPath: ControlLayout.name) as? String{
                dicView .setValue(superView, forKey: viewName)
            }
        }
        
        return dicView
    }
    
    
    func getDictionaryOfVariableBindings(viewArray : [UIView]) -> NSDictionary{
        
        let dicView : NSMutableDictionary = NSMutableDictionary()
        
        for view in viewArray{
            if let viewName = view.layer .value(forKey: ControlLayout.name) as? String{
                dicView .setValue(view, forKey: viewName)
            }
        }
        
        return dicView
    }
    
    public func setBorder(_ borderColor: UIColor, width: CGFloat, radius: CGFloat){
        
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = width
        self.layer.cornerRadius = radius
        
    }

    public func setTopBorder(_ borderColor: UIColor, width: CGFloat) {
        
        let layerName: String = "upper_layer"
        var upperBorder: CALayer?
        
        for layer: CALayer in self.layer.sublayers!{
            if layer.name == layerName {
                upperBorder = layer
                break
            }
        }
        
        if(upperBorder == nil){
            upperBorder = CALayer()
        }
        
        upperBorder!.name = layerName
        upperBorder!.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 1.0)
        
        upperBorder!.borderWidth = width
        upperBorder!.borderColor = borderColor.cgColor
        
        self.layer.addSublayer(upperBorder!)
    }
    
    public func setBottomBorder(_ borderColor: UIColor, width: CGFloat) {
        
        let layerName: String = "bottom_layer"
        var bottomBorder: CALayer?
        
        for layer: CALayer in self.layer.sublayers!{
            if layer.name == layerName {
                bottomBorder = layer
                break
            }
        }
        
        if(bottomBorder == nil){
            bottomBorder = CALayer()
        }
        
        bottomBorder!.name = layerName
        bottomBorder!.frame = CGRect(x: 0, y: self.frame.height - width, width: self.frame.width, height: width)
        
        bottomBorder!.borderWidth = width
        bottomBorder!.borderColor = borderColor.cgColor
        
        self.layer.addSublayer(bottomBorder!)
    
    }
    
    public func setLeftBorder(_ borderColor: UIColor, width: CGFloat) {
        
        let layerName: String = "left_layer"
        var leftBorder: CALayer?
        
        for layer: CALayer in self.layer.sublayers!{
            if layer.name == layerName {
                leftBorder = layer
                break
            }
        }
        
        if(leftBorder == nil){
            leftBorder = CALayer()
        }
        
        leftBorder!.name = layerName
        leftBorder!.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.height)
        
        leftBorder!.borderWidth = width
        leftBorder!.borderColor = borderColor.cgColor
        
        self.layer.addSublayer(leftBorder!)
    }
    
    public func setRightBorder(_ borderColor: UIColor, width: CGFloat) {
        
        let layerName: String = "right_layer"
        var rightBorder: CALayer?
        
        for layer: CALayer in self.layer.sublayers!{
            if layer.name == layerName {
                rightBorder = layer
                break
            }
        }
        
        if(rightBorder == nil){
            rightBorder = CALayer()
        }
        
        rightBorder!.name = layerName
        rightBorder!.frame = CGRect(x: 0, y: self.frame.width, width: width, height: self.frame.height)
        
        rightBorder!.borderWidth = width
        rightBorder!.borderColor = borderColor.cgColor
        
        self.layer.addSublayer(rightBorder!)
    }
    
    public func setCircleViewWith(_ borderColor: UIColor, width: CGFloat) {
        
        self.layer.cornerRadius = (self.frame.size.width / 2)
        self.layer.masksToBounds = (true)
        self.layer.borderWidth = (width)
        self.layer.borderColor = (borderColor.cgColor)
        
        let containerLayer: CALayer = CALayer()
        containerLayer.shadowColor = UIColor.black.cgColor
        
        containerLayer.shadowRadius = 10.0
        containerLayer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        containerLayer.shadowOpacity = 1.0
        self.superview?.layer.addSublayer(containerLayer)
    
    }
    
    public func removeIndicatorFromView() {
        
        let layerNamebox: String = "bottom_box_layer"
        let layerNamepoint: String = "bottom_point_layer"
        
        for layer in self.layer.sublayers! {
            if layer.name == layerNamebox {
                layer.removeFromSuperlayer()
                break
            }
        }
        
        for layer in self.layer.sublayers! {
            if layer.name == layerNamepoint {
                layer.removeFromSuperlayer()
                break
            }
        }
        
    }
    
    public func getViewControllerFromSubView() -> UIViewController? {
        
        var responder: UIResponder = self
        
        if responder.next != nil
        {
            responder = responder.next!
        }
        else
        {
            return nil
        }
        
        while !(responder.isKind(of: NSNull.self)) {
            if responder.isKind(of: UIViewController.self) {
                return responder as? UIViewController
            }
            responder = responder.next!
        }
        
        return nil
    }
    //  Get End X point of view
    public var endX : CGFloat {
        return frame.origin.x + frame.width
    }
    
    //  Get End Y point of view
    public var endY : CGFloat {
        return frame.origin.y + frame.height
    }
    
    //  Get Origin.x
    public var startX : CGFloat {
        return frame.origin.x
    }
    
    //  Get Origin.y
    public var startY : CGFloat {
        return frame.origin.y
    }
    
    //  Get width of View
    public var getWidth : CGFloat {
        return frame.width
    }
    
    //  Get height of view
    public var getHeight : CGFloat {
        return frame.height
    }
    
    //  Set Origin.x
    public func setStartX(_ x : CGFloat) {
        self.frame.origin.x = x
    }
    
    //  Set Origin.y
    public func setStartY( _ y : CGFloat) {
        self.frame.origin.y = y
    }

    
    //  Get center
    public func getCenter() -> CGPoint {
        return self.center
    }
    
    //  Get center.x
    public func getCenterX() -> CGFloat {
        return self.center.x
    }
    
    //  Set center.y
    public func setCenterY(_ y : CGFloat)  {
        self.center = CGPoint(x : self.getCenterX(), y : y)
    }
    
    //  Get center.y
    public func getCenterY() -> CGFloat {
        return self.center.y
    }
    
    //  Get Parent View controller
    public var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if parentResponder is UIViewController {
                return parentResponder as! UIViewController!
            }
        }
        return nil
    }
    
    //  Apply plain shadow to view
    public func applyPlainShadow() {
        let layer = self.layer
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 1.0
    }
    
    //  Apply boarder to view
    public func applyBorder() {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.gray.cgColor
    }
    
    //  Apply corner radius
    public func applyCornerRadius(_ corenrRadius : CGFloat , mask : Bool) {
        self.layer.masksToBounds = mask
        self.layer.cornerRadius = corenrRadius
    }
    
    //  Add only bottom border
    public func applyBottomBorder() {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.gray.cgColor
    }
    
    //  Add Top Border
    public func addTopBorderWithColor(_ color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: self.getWidth, height: width)
        self.layer.addSublayer(border)
    }
    
    //  Add Right Border
    public func addRightBorderWithColor(_ color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: self.getWidth - width, y: 0, width: width, height: self.getHeight)
        self.layer.addSublayer(border)
    }
    
    //  Add Bottom Border
    public func addBottomBorderWithColor(_ color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.getHeight - width, width: self.getWidth, height: width)
        self.layer.addSublayer(border)
    }
    
    //  Add Left Border
    public func addLeftBorderWithColor(_ color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: width, height: self.getHeight)
        self.layer.addSublayer(border)
    }
    
    
    // TODO: Autolayout Constraint
    public func topEqualTo(view : UIView) -> Void{
        self.superview?.addConstraint(NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0.0))
    }
    
    public func topSpaceToSuper(space : CGFloat) -> Void{
        self.superview?.addConstraint(NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: self.superview, attribute: .top, multiplier: 1.0, constant: space))
    }
    
    public func topSpaceTo(view : UIView,space : CGFloat){
        self.superview?.addConstraint(NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: space))
    }
    
    public func bottomEqualTo(view : UIView){
        self.superview?.addConstraint(NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0.0))
    }
    
    public func bottomSpaceToSuper(spcae : CGFloat) -> Void{
        self.superview?.addConstraint(NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: self.superview, attribute: .bottom, multiplier: 1.0, constant: spcae))
    }
    
    public func bottomSpaceTo(view : UIView,space : CGFloat){
       self.superview?.addConstraint(NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: space))
    }
    
    public func leftMarginTo(view : UIView){
        self.superview?.addConstraint(NSLayoutConstraint(item: self, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0.0))
    }
    
    public func leftMarginTo(view : UIView,margin : CGFloat){
        self.superview?.addConstraint(NSLayoutConstraint(item: self, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: margin))
    }
    
    public func rightMarginTo(view : UIView){
        self.superview?.addConstraint(NSLayoutConstraint(item: self, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 0.0))
    }
    
    public func rightMarginTo(view : UIView,margin : CGFloat){
        self.superview?.addConstraint(NSLayoutConstraint(item: self, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: margin))
    }
    
    public func horizontalSpace(view : UIView, space : CGFloat){
        self.superview?.addConstraint(NSLayoutConstraint(item: self, attribute: .right, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: space))
    }
    
    public func verticalSpace(view : UIView, space : CGFloat){
        self.superview?.addConstraint(NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: space))
    }
    
    public func edgeEqualTo(view : UIView){
        self.leftMarginTo(view: view)
        self.rightMarginTo(view: view)
        self.topEqualTo(view: view)
        self.bottomEqualTo(view: view)
    }
    
    public func edgeToSuperView(top : CGFloat,left : CGFloat,bottom : CGFloat,right : CGFloat){
        self.topSpaceTo(view: self.superview!, space: top)
        self.bottomSpaceTo(view: self.superview!, space: bottom)
        self.leftMarginTo(view: self.superview!, margin: left)
        self.rightMarginTo(view: self.superview!, margin: right)
    }
    
    public func equalWidthTo(view : UIView){
        self.addConstraint(NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1.0, constant: 0.0))
    }
    
    public func equalHeightTo(view : UIView){
        self.addConstraint(NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1.0, constant: 0.0))
    }
    
    public func setWidth(width : CGFloat){
        self.addConstraint(NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: width))
    }
    
    public func setHeight(height : CGFloat){
        self.addConstraint(NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: height))
    }
    
    public func centerX(view : UIView){
        self.superview!.addConstraint(NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0))
    }
    
    public func centerY(view : UIView){
        self.superview!.addConstraint(NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0.0))
    }
    
    public func verticalSpace(Views : [UIView],space : CGFloat) -> Void{
    
        var verticalString : String = ""
        
        for (index,view) in Views.enumerated(){
            if index == 0{
                verticalString = "[\(view.layer .value(forKey: ControlLayout.name) as! String)]"
            }
            else{
                verticalString = verticalString + "\(space)" + "[\(view.layer .value(forKey: ControlLayout.name) as! String)]"
            }
        }
        
        var viewDic : NSDictionary! = self.getDictionaryOfVariableBindings(viewArray: Views)
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:\(verticalString)", options: NSLayoutFormatOptions(rawValue : 0), metrics: nil, views: viewDic as! [String : Any]))
        viewDic = nil
    }
    
    public func horizontalSpace(Views : [UIView],space : CGFloat) -> Void{
        var horizontalSpace : String = ""
        
        for (index,view) in Views.enumerated(){
            if index == 0{
                horizontalSpace = "[\(view.layer .value(forKey: ControlLayout.name) as! String)]"
            }
            else{
                horizontalSpace = horizontalSpace + "\(space)" + "[\(view.layer .value(forKey: ControlLayout.name) as! String)]"
            }
        }
        
        var viewDic : NSDictionary! = self.getDictionaryOfVariableBindings(viewArray: Views)
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:\(horizontalSpace)", options: NSLayoutFormatOptions(rawValue : 0), metrics: nil, views: viewDic as! [String : Any]))
        viewDic = nil
    }
}

// MARK: - NSTimer Extension -
private class NSTimerActor {
    var block: () -> ()
    
    init(_ block: @escaping () -> ()) {
        self.block = block
    }
    
    @objc func fire() {
        block()
    }
}

extension UIViewController {
    func displayNavBarActivity() {
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
        indicator.startAnimating()
        let item = UIBarButtonItem(customView: indicator)
        
        self.navigationItem.leftBarButtonItem = item
    }
    
    func dismissNavBarActivity() {
        self.navigationItem.leftBarButtonItem = nil
    }
}


extension UIViewController {
    
    func setTabBarVisible(visible: Bool, animated: Bool) {
        //* This cannot be called before viewDidLayoutSubviews(), because the frame is not set before this time
        
        // bail if the current state matches the desired state
        if (isTabBarVisible == visible) { return }
        
        // get a frame calculation ready
        let frame = self.tabBarController?.tabBar.frame
        let height = frame?.size.height
        let offsetY = (visible ? -height! : height)
        
        // zero duration means no animation
        let duration: TimeInterval = (animated ? 0.3 : 0.0)
        
        //  animate the tabBar
        if frame != nil {
            UIView.animate(withDuration: duration) {
                self.tabBarController?.tabBar.frame = frame!.offsetBy(dx: 0, dy: offsetY!)
                return
            }
        }
    }
    
    var isTabBarVisible: Bool {
        return (self.tabBarController?.tabBar.frame.origin.y ?? 0) < self.view.frame.maxY
    }
}


extension Timer {
    class func new(after interval: TimeInterval, _ block: @escaping () -> ()) -> Timer {
        let actor = NSTimerActor(block)
        return self.init(timeInterval: interval, target: actor, selector: #selector(NSTimerActor.fire), userInfo: nil, repeats: false)
    }
    
    class func new(every interval: TimeInterval, _ block: @escaping () -> ()) -> Timer {
        let actor = NSTimerActor(block)
        return self.init(timeInterval: interval, target: actor, selector: #selector(NSTimerActor.fire), userInfo: nil, repeats: true)
    }
    
    class func after(interval: TimeInterval, _ block: @escaping () -> ()) -> Timer {
        let timer = Timer.new(after: interval, block)
        RunLoop.current.add(timer, forMode: RunLoopMode.defaultRunLoopMode)
        return timer
    }
    
    class func every(interval: TimeInterval, _ block: @escaping () -> ()) -> Timer {
        let timer = Timer.new(every: interval, block)
        RunLoop.current.add(timer, forMode: RunLoopMode.defaultRunLoopMode)
        return timer
    }
}

extension Double {
    var second:  TimeInterval { return self }
    var seconds: TimeInterval { return self }
    var minute:  TimeInterval { return self * 60 }
    var minutes: TimeInterval { return self * 60 }
    var hour:    TimeInterval { return self * 3600 }
    var hours:   TimeInterval { return self * 3600 }
}

//Use
//NSTimer.after(1.minute) {
//    println("Are you still here?")
//}
//
//// Repeating an action
//NSTimer.every(0.7.seconds) {
//    statusItem.blink()
//}
//
//// Pass a method reference instead of a closure
//NSTimer.every(30.seconds, align)
//
//// Make a timer object without scheduling
//let timer = NSTimer.new(every: 1.second) {
//    println(self.status)
//}



    
// MARK: - String Extension -

public extension String {
    
    public func stringToFloat() -> CGFloat{
        
        var floatNumber : CGFloat = 0.0
        
        let number : NSNumber! = NumberFormatter().number(from: self)
        if (number != nil){
            floatNumber = CGFloat(number)
            
        }
        
        return floatNumber
        
    }

    // https://gist.github.com/stevenschobert/540dd33e828461916c11
    func camelize() -> String {
        let source = clean(with: " ", allOf: "-", "_")
        if source.characters.contains(" ") {
            let first = source.substring(to: source.characters.index(source.startIndex, offsetBy: 1))
            let cammel = NSString(format: "%@", (source as NSString).capitalized.replacingOccurrences(of: " ", with: "", options: [], range: nil)) as String
            let rest = String(cammel.characters.dropFirst())
            return "\(first)\(rest)"
        } else {
            let first = (source as NSString).lowercased.substring(to: source.characters.index(source.startIndex, offsetBy: 1))
            let rest = String(source.characters.dropFirst())
            return "\(first)\(rest)"
        }
    }
    
    func capitalize() -> String {
        return capitalized
    }
    
    func contains(_ substring: String) -> Bool {
        return range(of: substring) != nil
    }
    
    func chompLeft(_ prefix: String) -> String {
        if let prefixRange = range(of: prefix) {
            if prefixRange.upperBound >= endIndex {
                return self[startIndex..<prefixRange.lowerBound]
            } else {
                return self[prefixRange.upperBound..<endIndex]
            }
        }
        return self
    }
    
    func chompRight(_ suffix: String) -> String {
        if let suffixRange = range(of: suffix, options: .backwards) {
            if suffixRange.upperBound >= endIndex {
                return self[startIndex..<suffixRange.lowerBound]
            } else {
                return self[suffixRange.upperBound..<endIndex]
            }
        }
        return self
    }
    
    func collapseWhitespace() -> String {
        let components = self.components(separatedBy: CharacterSet.whitespacesAndNewlines).filter { !$0.isEmpty }
        return components.joined(separator: " ")
    }
    
    func clean(with: String, allOf: String...) -> String {
        var string = self
        for target in allOf {
            string = string.replacingOccurrences(of: target, with: with)
        }
        return string
    }
    
    func count(_ substring: String) -> Int {
        return components(separatedBy: substring).count-1
    }
    
    func endsWith(_ suffix: String) -> Bool {
        return hasSuffix(suffix)
    }
    
    func ensureLeft(_ prefix: String) -> String {
        if startsWith(prefix) {
            return self
        } else {
            return "\(prefix)\(self)"
        }
    }
    
    func ensureRight(_ suffix: String) -> String {
        if endsWith(suffix) {
            return self
        } else {
            return "\(self)\(suffix)"
        }
    }
    
    func indexOf(_ substring: String) -> Int? {
        if let range = range(of: substring) {
            return characters.distance(from: startIndex, to: range.lowerBound)
        }
        return nil
    }
    
    func isAlpha() -> Bool {
        for chr in characters {
            if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z") ) {
                return false
            }
        }
        return true
    }
    
    func isAlphaNumeric() -> Bool {
        let alphaNumeric = CharacterSet.alphanumerics
        return components(separatedBy: alphaNumeric).joined(separator: "").length2 == 0
    }
    
    func isEmpty() -> Bool {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).length2 == 0
    }
    
    func join<S: Sequence>(_ elements: S) -> String {
        return elements.map{String(describing: $0)}.joined(separator: self)
    }
    
    func latinize() -> String {
        return self.folding(options: .diacriticInsensitive, locale: Locale.current)
    }
    
    func lines() -> [String] {
        return self.components(separatedBy: CharacterSet.newlines)
    }
    
    var length2: Int {
        get {
            return self.characters.count
        }
    }
    
    func pad(_ n: Int, _ string: String = " ") -> String {
        return "".join([string.times(n), self, string.times(n)])
    }
    
    func padLeft(_ n: Int, _ string: String = " ") -> String {
        return "".join([string.times(n), self])
    }
    
    func padRight(_ n: Int, _ string: String = " ") -> String {
        return "".join([self, string.times(n)])
    }
    
    func slugify(withSeparator separator: Character = "-") -> String {
        let slugCharacterSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\(separator)")
        return latinize().lowercased()
            .components(separatedBy: slugCharacterSet.inverted)
            .filter { $0 != "" }
            .joined(separator: String(separator))
    }
    
    func split(_ separator: Character) -> [String] {
        return characters.split{$0 == separator}.map(String.init)
    }
    
    func startsWith(_ prefix: String) -> Bool {
        return hasPrefix(prefix)
    }
    
   
    func times(_ n: Int) -> String {
        return (0..<n).reduce("") { $0.0 + self }
    }
    
    func toFloat() -> Float? {
        if let number = defaultNumberFormatter().number(from: self) {
            return number.floatValue
        }
        return nil
    }
    
    func toInt() -> Int? {
        if let number = defaultNumberFormatter().number(from: self) {
            return number.intValue
        }
        return nil
    }
    

    func toBool() -> Bool? {
        let trimmed = self.trimmed().lowercased()
        if trimmed == "true" || trimmed == "false" {
            return (trimmed as NSString).boolValue
        }
        return nil
    }
    
    func toDate(_ format: String = "yyyy-MM-dd") -> Date? {
        return dateFormatter(format).date(from: self)
    }
    
    func toDateTime(_ format: String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        return toDate(format)
    }
    
    func trimmedLeft() -> String {
        if let range = rangeOfCharacter(from: CharacterSet.whitespacesAndNewlines.inverted) {
            return self[range.lowerBound..<endIndex]
        }
        return self
    }
    
    func trimmedRight() -> String {
        if let range = rangeOfCharacter(from: CharacterSet.whitespacesAndNewlines.inverted, options: NSString.CompareOptions.backwards) {
            return self[startIndex..<range.upperBound]
        }
        return self
    }
    
    func trimmed() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    subscript(r: Range<Int>) -> String {
        get {
            let startIndex = self.characters.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.characters.index(self.startIndex, offsetBy: r.upperBound - r.lowerBound)
            return self[startIndex..<endIndex]
        }
    }
    
    func substring(_ startIndex: Int, length: Int) -> String {
        let start = self.characters.index(self.startIndex, offsetBy: startIndex)
        let end = self.characters.index(self.startIndex, offsetBy: startIndex + length)
        return self[start..<end]
    }
    
    subscript(i: Int) -> Character {
        get {
            let index = self.characters.index(self.startIndex, offsetBy: i)
            return self[index]
        }
    }
   
    // Returns true if the string has at least one character in common with matchCharacters.
    func containsCharactersIn(_ matchCharacters: String) -> Bool {
        let characterSet = CharacterSet(charactersIn: matchCharacters)
        return self.rangeOfCharacter(from: characterSet) != nil
    }
    
    // Returns true if the string contains only characters found in matchCharacters.
    func containsOnlyCharactersIn(_ matchCharacters: String) -> Bool {
        let disallowedCharacterSet = CharacterSet(charactersIn: matchCharacters).inverted
        return self.rangeOfCharacter(from: disallowedCharacterSet) == nil
    }
    
    // Returns true if the string has no characters in common with matchCharacters.
    func doesNotContainCharactersIn(_ matchCharacters: String) -> Bool {
        let characterSet = CharacterSet(charactersIn: matchCharacters)
        return self.rangeOfCharacter(from: characterSet) == nil
    }
    
    // Returns true if the string represents a proper numeric value.
    // This method uses the device's current locale setting to determine
    // which decimal separator it will accept.
    func isNumeric() -> Bool
    {
        let scanner = Scanner(string: self)
        
        // A newly-created scanner has no locale by default.
        // We'll set our scanner's locale to the user's locale
        // so that it recognizes the decimal separator that
        // the user expects (for example, in North America,
        // "." is the decimal separator, while in many parts
        // of Europe, "," is used).
        scanner.locale = Locale.current
        
        return scanner.scanDecimal(nil) && scanner.isAtEnd
    }
    
    public func dictionary() -> NSDictionary?{
        do{
            return try JSONSerialization .jsonObject(with: self.data(using: String.Encoding.utf8)!, options: JSONSerialization.ReadingOptions(rawValue : 0)) as? NSDictionary
        }
        catch let error as NSError{
            print(error.localizedDescription)
            return nil
        }
    }
    
}


// MARK: - NSArray Extension -
public extension NSArray
{
    public func JSONString() -> NSString{
        var jsonString : NSString = ""
        
        do
        {
            let jsonData : Data = try JSONSerialization .data(withJSONObject: self, options: JSONSerialization.WritingOptions(rawValue : 0))
            jsonString = NSString(data: jsonData ,encoding: String.Encoding.utf8.rawValue)!
        }
        catch let error as NSError
        {
            print(error.localizedDescription)
        }
        
        return jsonString
    }
    
    
    //  Make Comma separated String from array
    public var toCommaString: String! {
        return self.componentsJoined(by: ",")
    }
   
    
    //  Chack Array contain specific object
    public func containsObject<T:AnyObject>(_ item:T) -> Bool
    {
        for element in self
        {
            if item === element as? T
            {
                return true
            }
        }
        return false
    }
    
    //  Get Index of specific object
    public func indexOfObject<T : Equatable>(_ x:T) -> Int? {
        for i in 0...self.count {
            if self[i] as! T == x {
                return i
            }
        }
        return nil
    }
    
    //  Gets the object at the specified index, if it exists.
    public func get(_ index: Int) -> Element? {
        return index >= 0 && index < count ? self[index] : nil
    }
    
}

// MARK: - Character Extension -

public extension Character {
    /// Return true if character is emoji.
    public var isEmoji: Bool {
        // http://stackoverflow.com/questions/30757193/find-out-if-character-in-string-is-emoji
        guard let scalarValue = String(self).unicodeScalars.first?.value else {
            return false
        }
        switch scalarValue {
        case 0x3030, 0x00AE, 0x00A9,// Special Characters
        0x1D000...0x1F77F, // Emoticons
        0x2100...0x27BF, // Misc symbols and Dingbats
        0xFE00...0xFE0F, // Variation Selectors
        0x1F900...0x1F9FF: // Supplemental Symbols and Pictographs
            return true
        default:
            return false
        }
    }
    
    /// Return true if character is number.
    public var isNumber: Bool {
        return Int(String(self)) != nil
    }
    
    /// Return integer from character (if applicable).
    public var toInt: Int? {
        return Int(String(self))
    }
    
    /// Return string from character.
    public var toString: String {
        return String(self)
    }
}



// MARK: - UIImageView Extension -

extension UIImageView{
    func roundImage()
    {
        //height and width should be the same
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.size.width / 2;
    }
}

// MARK: - UIImage Extension -

extension UIImage{
    
    func maskWithColor(_ color: UIColor) -> UIImage? {
        
        let maskImage = self.cgImage
        let width = self.size.width
        let height = self.size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let bitmapContext = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue) //needs rawValue of bitmapInfo
        
        bitmapContext?.clip(to: bounds, mask: maskImage!)
        bitmapContext?.setFillColor(color.cgColor)
        bitmapContext?.fill(bounds)
        
        //is it nil?
        if let cImage = bitmapContext?.makeImage() {
            let coloredImage = UIImage(cgImage: cImage)
            
            return coloredImage
            
        } else {
            return nil
        }
    }
    
    func croppedImage(_ bound : CGRect) -> UIImage
    {
        let scaledBounds : CGRect = CGRect(x: bound.origin.x * self.scale, y: bound.origin.y * self.scale, width: bound.size.width * self.scale, height: bound.size.height * self.scale)
        let imageRef = self.cgImage?.cropping(to: scaledBounds)
        let croppedImage : UIImage = UIImage(cgImage: imageRef!, scale: self.scale, orientation: UIImageOrientation.up)
        return croppedImage;
    }
  
    
    public func normalizeBitmapInfo(_ bI: CGBitmapInfo) -> UInt32 {
        var alphaInfo: UInt32 = bI.rawValue & CGBitmapInfo.alphaInfoMask.rawValue
        
        if alphaInfo == CGImageAlphaInfo.last.rawValue {
            alphaInfo =  CGImageAlphaInfo.premultipliedLast.rawValue
        }
        
        if alphaInfo == CGImageAlphaInfo.first.rawValue {
            alphaInfo = CGImageAlphaInfo.premultipliedFirst.rawValue
        }
        
        var newBI: UInt32 = bI.rawValue & ~CGBitmapInfo.alphaInfoMask.rawValue;
        
        newBI |= alphaInfo;
        
        return newBI
    }
    
    enum WaterMarkCorner{
        case TopLeft
        case TopRight
        case BottomLeft
        case BottomRight
    }
    
    func waterMarkedImage(waterMarkText:String, corner:WaterMarkCorner = .BottomRight, margin:CGPoint = CGPoint(x: 20, y: 20), waterMarkTextColor:UIColor = UIColor.white, waterMarkTextFont:UIFont = UIFont.systemFont(ofSize: 20), backgroundColor:UIColor = UIColor.clear) -> UIImage{
        
        let textAttributes = [NSForegroundColorAttributeName:waterMarkTextColor, NSFontAttributeName:waterMarkTextFont]
        let textSize = NSString(string: waterMarkText).size(attributes: textAttributes)
        var textFrame = CGRect.init(x: 0, y: 0, width: textSize.width, height: textSize.width)
        
        let imageSize = self.size
        switch corner{
        case .TopLeft:
            textFrame.origin = margin
        case .TopRight:
            textFrame.origin = CGPoint(x: imageSize.width - textSize.width - margin.x, y: margin.y)
        case .BottomLeft:
            textFrame.origin = CGPoint(x: margin.x, y: imageSize.height - textSize.height - margin.y)
        case .BottomRight:
            textFrame.origin = CGPoint(x: imageSize.width - textSize.width - margin.x, y: imageSize.height - textSize.height - margin.y)
        }
        
        /// Start creating the image with water mark
        UIGraphicsBeginImageContext(imageSize)
        self.draw(in: CGRect.init(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
        
        NSString(string: waterMarkText).draw(in: textFrame, withAttributes: textAttributes)
        
        let waterMarkedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return waterMarkedImage!
    }
    
    public func editWithText(text : String) -> UIImage? {
        
        let font : UIFont! = UIFont(name: FontStyle.medium, size: 50.0)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.left
        
        let imageSize = self.size
        UIGraphicsBeginImageContext(self.size)
        let context = UIGraphicsGetCurrentContext()
        self.draw(at: .zero)
        
        let stringBox : CGSize = NSString(string: text).size(attributes: [NSFontAttributeName : font])
        
        
        //Ractangle
        let rectangle = CGRect(x: 0, y: (imageSize.height) - (stringBox.height), width: stringBox.width + 110, height: stringBox.height)
        context!.setFillColor(Color.appPrimaryBG.value.cgColor)
        context!.addRect(rectangle)
        context!.drawPath(using: .fill)
        
        //Image
        let image : UIImage = (UIImage(named: "repost")?.maskWithColor(.white))!
        let imageRact : CGRect = CGRect(x: 20, y: (imageSize.height) - (stringBox.height / 2) - (50 / 2), width: 50, height: 50)
        image.draw(in: imageRact)
        
        
        //Labale
        let lableRact = CGRect(x: 90, y: (imageSize.height) - stringBox.height, width: stringBox.width, height: stringBox.height)
        text.draw(in: lableRact.integral, withAttributes: [NSFontAttributeName : font, NSForegroundColorAttributeName : UIColor.white , NSParagraphStyleAttributeName : paragraphStyle])
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}

extension Bundle {
    static func podBundle(forClass: AnyClass) -> Bundle? {
        
        let bundleForClass = Bundle(for: forClass)
        
        if let bundleURL = bundleForClass.url(forResource: "OpalImagePickerResources", withExtension: "bundle") {
            if let bundle = Bundle(url: bundleURL) {
                return bundle
            }
            else {
                assertionFailure("Could not load the bundle")
            }
        }
        else {
            assertionFailure("Could not create a path to the bundle")
        }
        return nil
    }
}


// MARK: - NSDictionary Extension -
public extension NSDictionary
{
    public func JSONString() -> NSString{
        var jsonString : NSString = ""
        
        do
        {
            let jsonData : Data = try JSONSerialization .data(withJSONObject: self, options: JSONSerialization.WritingOptions(rawValue : 0))
            jsonString = NSString(data: jsonData ,encoding: String.Encoding.utf8.rawValue)!
        }
        catch let error as NSError
        {
            print(error.localizedDescription)
        }
        
        return jsonString
    }
    
    
    //  Convert NSDictionary to NSData
    public var toNSData : Data! {
        do {
            return try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)          // success ...
        } catch {
            // failure
            print("Fetch failed: \((error as NSError).localizedDescription)")
        }
        return Data()
    }
    
    //  Check key is exist in NSDictionary or not
    public func has(_ key: Key) -> Bool {
        return object(forKey: key) != nil
    }
    
}

// MARK: - Button Extension -

public extension UIButton {
    
    //  Apply corner radius
    public func applyCornerRadius(_ mask : Bool) {
        self.layer.masksToBounds = mask
        self.layer.cornerRadius = self.frame.size.width/2
    }
    
    //  Set background color for state
    public func setBackgroundColor(_ color: UIColor, forState: UIControlState) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()?.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.setBackgroundImage(colorImage, for: forState)
    }
    
    //  Set title text for all state
    public func textForAllState(_ titleText : String) {
        self.setTitle(titleText, for: UIControlState())
        self.setTitle(titleText, for: .selected)
        self.setTitle(titleText, for: .highlighted)
        self.setTitle(titleText, for: .disabled)
    }
    
    //  Set title text for only normal state
    public func textForNormal(_ titleText : String) {
        self.setTitle(titleText, for: UIControlState())
    }
    
    //  Set title text for only selected state
    public func textForSelected(_ titleText : String) {
        self.setTitle(titleText, for: .selected)
    }
    
    //  Set title text for only highlight state
    public func textForHighlighted(_ titleText : String) {
        self.setTitle(titleText, for: .highlighted)
    }
    
    //  Set image for all state
    public func imageForAllState(_ image : UIImage) {
        self.setImage(image, for: UIControlState())
        self.setImage(image, for: .selected)
        self.setImage(image, for: .highlighted)
        self.setImage(image, for: .disabled)
    }
    
    //  Set image for only normal state
    public func imageForNormal(_ image : UIImage) {
        self.setImage(image, for: UIControlState())
    }
    
    //  Set image for only selected state
    public func imageForSelected(_ image : UIImage) {
        self.setImage(image, for: .selected)
    }
    
    //  Set image for only highlighted state
    public func imageForHighlighted(_ image : UIImage) {
        self.setImage(image, for: .highlighted)
    }
    
    //  Set title color for all state
    public func colorOfTitleLabelForAllState(_ color : UIColor) {
        self.setTitleColor(color, for: UIControlState())
        self.setTitleColor(color, for: .selected)
        self.setTitleColor(color, for: .highlighted)
        self.setTitleColor(color, for: .disabled)
    }
    
    //  Set title color for normal state
    public func colorOfTitleLabelForNormal(_ color : UIColor) {
        self.setTitleColor(color, for: UIControlState())
    }
    
    //  Set title color for selected state
    public func colorOfTitleLabelForSelected(_ color : UIColor) {
        self.setTitleColor(color, for: .selected)
    }
    
    //  Set title color for highkighted state
    public func colorForHighlighted(_ color : UIColor) {
        self.setTitleColor(color, for: .highlighted)
    }
    
    //  Set image behind the text in button
    public func setImageBehindTextWithCenterAlignment(_ imageWidth : CGFloat, buttonWidth : CGFloat, space : CGFloat) {
        let titleLabelWidth:CGFloat = 50.0
        let buttonMiddlePoint = buttonWidth/2
        let fullLenght = titleLabelWidth + space + imageWidth
        
        let imageInset = buttonMiddlePoint + fullLenght/2 - imageWidth + space
        let buttonInset = buttonMiddlePoint - fullLenght/2 - imageWidth
        
        self.imageEdgeInsets = UIEdgeInsetsMake(0, imageInset, 0, 0)
        self.titleEdgeInsets = UIEdgeInsetsMake(0, buttonInset, 0, 0)
    }
    
    //  Set image behind text in left alignment
    public func setImageBehindTextWithLeftAlignment(_ imageWidth : CGFloat, buttonWidth : CGFloat) {
        let titleLabelWidth:CGFloat = 40.0
        let fullLenght = titleLabelWidth + 5 + imageWidth
        
        let imageInset = fullLenght - imageWidth + 5
        let buttonInset = CGFloat(-10.0)
        
        self.imageEdgeInsets = UIEdgeInsetsMake(0, imageInset, 0, 0)
        self.titleEdgeInsets = UIEdgeInsetsMake(0, buttonInset, 0, 0)
    }
    
    //  Set image behind text in right alignment
    public func setImageOnRightAndTitleOnLeft(_ imageWidth : CGFloat, buttonWidth : CGFloat)  {
        let imageInset = CGFloat(buttonWidth - imageWidth - 10)
        
        let buttonInset = CGFloat(-10.0)
        
        self.imageEdgeInsets = UIEdgeInsetsMake(0, imageInset, 0, 0)
        self.titleEdgeInsets = UIEdgeInsetsMake(0, buttonInset, 0, 0)
    }
}

// MARK:  - Mirro Extension -

public extension Mirror
{
    public func proparty() -> [String]
    {
        var arrPropary : [String] = []
        
        for item in self.children
        {
            arrPropary.append(item.label!)
        }
        return arrPropary
    }
}



// MARK:   - NSDate Extension -

public extension Date
{
    public func getCurrentUTCTimeStampe() -> TimeInterval
    {
        let date = Date();
        
        let dateFormatter = DateFormatter()
        
        //To prevent displaying either date or time, set the desired style to NoStyle.
        dateFormatter.timeStyle = DateFormatter.Style.none //Set time style
        dateFormatter.dateStyle = DateFormatter.Style.long //Set date style
        
        let UTCDate = dateFormatter.string(from: date)
        
        let timeZone = TimeZone.autoupdatingCurrent
        let seconds:Double = Double(timeZone.secondsFromGMT(for: dateFormatter.date(from: UTCDate)!))
        
        return Date(timeInterval: seconds, since: dateFormatter.date(from: UTCDate)!).timeIntervalSince1970
        
    }
    
    public func getTimeStampWithDateTime()  -> TimeInterval
    {
        let date = Date();
        
        let dateFormatter = DateFormatter()
        
        //To prevent displaying either date or time, set the desired style to NoStyle.
        dateFormatter.timeStyle = DateFormatter.Style.long //Set time style
        dateFormatter.dateStyle = DateFormatter.Style.long //Set date style
        
        let UTCDate = dateFormatter.string(from: date)
        
        let timeZone = TimeZone.autoupdatingCurrent
        let seconds:Double = Double(timeZone.secondsFromGMT(for: dateFormatter.date(from: UTCDate)!))
        
        return Date(timeInterval: seconds, since: dateFormatter.date(from: UTCDate)!).timeIntervalSince1970
    }
    
    func initializeDateWithTime(_ hrs:Int,minutes:Int) -> TimeInterval{
        
        let date = Date();
        
        let dateFormatter = DateFormatter()
        
        //To prevent displaying either date or time, set the desired style to NoStyle.
        dateFormatter.timeStyle = DateFormatter.Style.none //Set time style
        dateFormatter.dateStyle = DateFormatter.Style.long //Set date style
        
        let UTCDate = dateFormatter.string(from: date)
        
        let today = dateFormatter.date(from: UTCDate)
        
        let gregorian:Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        var dateComponents = (gregorian as NSCalendar).components([.year, .month, .day], from: today!)
        
        dateComponents.hour = hrs;
        dateComponents.minute = minutes;
        let dateFormatter2 = DateFormatter()
        
        //To prevent displaying either date or time, set the desired style to NoStyle.
        dateFormatter2.timeStyle = DateFormatter.Style.long //Set time style
        dateFormatter2.dateStyle = DateFormatter.Style.long //Set date style
        
        let todayAtX = gregorian.date(from: dateComponents)
        
        let UTCDate2 = dateFormatter2.string(from: todayAtX!)
        let timeZone = TimeZone.autoupdatingCurrent
        let seconds:Double = Double(timeZone.secondsFromGMT(for: dateFormatter2.date(from: UTCDate2)!))
        
        return Date(timeInterval: seconds, since: dateFormatter2.date(from: UTCDate2)!).timeIntervalSince1970
        
    }
    
    
    public func getDateFromTimeStampe(_ formate : String , timestampe : String) -> String?
    {
        let dateFormater : DateFormatter = DateFormatter()
        dateFormater .dateFormat = formate
        
        let dateString = dateFormater .string(from: Date(timeIntervalSince1970: Double(timestampe)!))
        return dateString
    }
    
    public func setDateFromTimeStampe(_ formate : String , timestampe : Double) -> String?
    {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = formate
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        let date = Date(timeIntervalSince1970: timestampe)
        
        let timeZone = TimeZone.autoupdatingCurrent
        let UTCDate = dateFormatter.string(from: date)
        
        let seconds:Double = Double(timeZone.secondsFromGMT(for: dateFormatter.date(from: UTCDate)!))
        
        let date2 = Date(timeInterval: -seconds, since: dateFormatter.date(from: UTCDate)!).timeIntervalSince1970
        
        return dateFormatter.string(from: Date(timeIntervalSince1970: date2))
    }
    
    //  Get Week day from date
    public var weekDay:Int {
        return (Calendar.current as NSCalendar).component(.weekday, from: self)
    }
    
    //  Get Week index of month from date
    public var weekOfMonth : Int {
        return (Calendar.current as NSCalendar).component(.weekOfMonth, from: self)
    }
    
    //  Get Week day name from date
    public var weekDayName : String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: self)
    }
    
    
    //  Get Month name from date
    public var monthName : String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter.string(from: self)
    }
    
    //  Get Month index from date
    public var month: Int {
        return (Calendar.current as NSCalendar).component(.month, from: self)
    }
    
    //  Get Day index from date
    public var day: Int {
        return (Calendar.current as NSCalendar).component(.day, from: self)
    }
    
    //  Get Year index from date
    public var year: Int {
        return (Calendar.current as NSCalendar).component(.year, from: self)
    }
    
    //  Get Hour and Minute from date
    public func getHourAndMinute() -> (hour : Int, minute : Int) {
        let calendar = Calendar.current
        let comp = (calendar as NSCalendar).components([.hour, .minute], from: self)
        return (comp.hour!, comp.minute!)
    }
    
    //  Get Total count of weeks in month from date
    public func weeksInMonth() -> Int?
    {
        var calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        calendar.firstWeekday = 2 // 2 == Monday
        
        // First monday in month:
        var comps = DateComponents()
        comps.month = self.month
        comps.year = self.year
        comps.weekday = calendar.firstWeekday
        comps.weekdayOrdinal = 1
        guard let first = calendar.date(from: comps)  else {
            return nil
        }
        
        // Last monday in month:
        comps.weekdayOrdinal = -1
        guard let last = calendar.date(from: comps)  else {
            return nil
        }
        
        // Difference in weeks:
        let weeks = (calendar as NSCalendar).components(.weekOfMonth, from: first, to: last, options: [])
        return weeks.weekOfMonth! + 1
    }
    
    //  Get Total count of week days in month from date
    public func weekDaysInMonth() -> Int?
    {
        guard 1...12 ~= month else { return nil }
        
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        var components = DateComponents()
        components.weekday =  self.weekDay
        components.weekdayOrdinal = 1
        components.month = self.month
        components.year = self.year
        
        if let date = calendar.date(from: components)  {
            let firstDay = (calendar as NSCalendar).component(.day, from: date)
            let days = (calendar as NSCalendar).range(of: .day, in:.month, for:date).length
            return (days - firstDay) / 7 + 1
        }
        return nil
    }
    
    //  Get Total count of days in month from date
    public func daysInMonth() -> Int? {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        return (calendar as NSCalendar).range(of: .day, in: .month, for: self).length
    }
    
    //  Get Time in AM / PM format
    public func getTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter.string(from: self)
    }
    
    //  Get Time short (i.e 12 Mar) format
    public func getTimeInShortFormat() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM"
        return formatter.string(from: self)
    }
    
    //  Get Time short (i.e 12 Mar, 2016) format
    public func getTimeInFullFormat() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM, yyyy"
        return formatter.string(from: self)
    }
    
    //  Get Time standard (i.e 2016-03-12) format
    public func formateBirthDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
    
    //  Check date is after date
    public func afterDate(_ date : Date) -> Bool {
        return self.compare(date) == ComparisonResult.orderedAscending
    }
    
    //  Check date is before date
    public func beforDate(_ date : Date) -> Bool {
        return self.compare(date) == ComparisonResult.orderedDescending
    }
    
    //  Check date is equal date
    public func equalDate(_ date : Date) -> Bool {
        return (self == date)
    }
    
    //  Get days difference between dates
    public func daysInBetweenDate(_ date: Date) -> Int {
        var difference = self.timeIntervalSinceNow - date.timeIntervalSinceNow
        difference = fabs(difference/86400)
        return Int(difference)
    }
    
    //  Get hours difference between dates
    public func hoursInBetweenDate(_ date: Date) -> Int {
        var difference = self.timeIntervalSinceNow - date.timeIntervalSinceNow
        difference = fabs(difference/3600)
        return Int(difference)
    }
    
    //  Get minutes difference between dates
    public func minutesInBetweenDate(_ date: Date) -> Int {
        var difference = self.timeIntervalSinceNow - date.timeIntervalSinceNow
        difference = fabs(difference/60)
        return Int(difference)
    }
    
    //  Get seconds difference between dates
    public func secondsInBetweenDate(_ date: Date) -> Int {
        var difference = self.timeIntervalSinceNow - date.timeIntervalSinceNow
        difference = fabs(difference)
        return Int(difference)
    }
    
    //  Get time difference between dates
    public func getDifferenceBetweenDates() -> String {
        let interval = self.timeIntervalSinceNow
        let year : Int = Int(interval) / 31536000
        var finalString = "'"
        if year >= 1 {
            if year == 1 {
                finalString += "1 year : "
            }
            else {
                finalString += "\(year) years : "
            }
        }
        let remainAfterYear = Int( interval) % 31536000
        let month = remainAfterYear / 2592000
        if month >= 1 {
            if month == 1 {
                finalString += "1 month : "
            }
            else {
                finalString += "\(month) months : "
            }
        }
        let remainAfterMonth =  remainAfterYear % 2592000
        let day = remainAfterMonth / 86400
        if day >= 1 {
            if day == 1 {
                finalString += "1 day : "
            }
            else {
                finalString += "\(day) days : "
            }
        }
        let remainAfterDay =  remainAfterMonth % 86400
        let hour = remainAfterDay / 3600
        if hour >= 1 {
            finalString += "\(hour)h : "
        }
        let remainAfterHour = remainAfterDay % 3600
        let minute = remainAfterHour / 60
        if minute >= 1 {
            finalString += "\(minute)m : "
        }
        let remainAfterMinute = remainAfterHour % 60
        let second = remainAfterMinute / 60
        if second >= 1 {
            finalString += "\(second)s "
        }
        
        return finalString
    }
}

// MARK:  - Double Extension -

public extension Double
{
//    mutating func roundOf() -> Double
//    {
//        return Double(round(self))
//    }
//    
//    mutating func roundTo2f() -> Double
//    {
//        return Double(round(100*self)/100)
//    }
//    
//    func roundTo3f() -> Double
//    {
//        return Double(round(1000*self)/1000)
//    }
//    
//    func roundTo4f() -> Double
//    {
//        return Double(round(10000*self)/10000)
//    }
//    
    func roundToNf(_ n : Int) -> NSString
    {
        return NSString(format: "%.\(n)f" as NSString, self)
    }
}


// MARK: - Int Extension -

extension Int{
    var isEven:Bool     {return (self % 2 == 0)}
    var isOdd:Bool      {return (self % 2 != 0)}
    var isPositive:Bool {return (self >= 0)}
    var isNegative:Bool {return (self < 0)}
    var toDouble:Double {return Double(self)}
    var toFloat:Float   {return Float(self)}
    
    var digits:Int {//this only works in bound of LONG_MAX 2147483647, the maximum value of int
        if(self == 0)
        {
            return 1
        }
        else if(Int(fabs(Double(self))) <= LONG_MAX)
        {
            return Int(log10(fabs(Double(self)))) + 1
        }
        else
        {
            return -1; //out of bound
        }
    }
}






// MARK:   - NSObject Extension -

public extension NSObject
{
    public func setValueFromDictionary(_ dicResponse : NSDictionary)
    {
        let mirror = Mirror(reflecting: self)
        let allKey : [String] = mirror.proparty()
        
        for key in allKey
        {
            if let value = dicResponse.value(forKey: key)
            {
                if value is Int
                {
                    self.setValue(String(value as! Int), forKey: key)
                }
                else if value is String
                {
                    self.setValue(value, forKey: key)
                }
                else if value is NSDictionary
                {
                    self.setValue(value, forKey: key)
                }
            }
        }
    }
}

extension Data {
    var stringValue: String? {
        return String(data: self, encoding: String.Encoding.utf8)
    }
    var base64EncodedString: String? {
        return self.base64EncodedString(options: .lineLength64Characters)
    }
}

extension String {
    var utf8StringEncodedData: Data? {
        return data(using: String.Encoding.utf8)
    }
    var base64DecodedData: Data? {
        return Data(base64Encoded: self, options: .ignoreUnknownCharacters)
    }
}



//For String

private enum ThreadLocalIdentifier {
    case dateFormatter(String)
    
    case defaultNumberFormatter
    case localeNumberFormatter(Locale)
    
    var objcDictKey: String {
        switch self {
        case .dateFormatter(let format):
            return "SS\(self)\(format)"
        case .localeNumberFormatter(let l):
            return "SS\(self)\(l.identifier)"
        default:
            return "SS\(self)"
        }
    }
}

private func threadLocalInstance<T: AnyObject>(_ identifier: ThreadLocalIdentifier, initialValue: @autoclosure () -> T) -> T {
    let storage = Thread.current.threadDictionary
    let k = identifier.objcDictKey
    
    let instance: T = storage[k] as? T ?? initialValue()
    if storage[k] == nil {
        storage[k] = instance
    }
    
    return instance
}

private func dateFormatter(_ format: String) -> DateFormatter {
    return threadLocalInstance(.dateFormatter(format), initialValue: {
        let df = DateFormatter()
        df.dateFormat = format
        return df
        }())
}

private func defaultNumberFormatter() -> NumberFormatter {
    return threadLocalInstance(.defaultNumberFormatter, initialValue: NumberFormatter())
}

private func localeNumberFormatter(_ locale: Locale) -> NumberFormatter {
    return threadLocalInstance(.localeNumberFormatter(locale), initialValue: {
        let nf = NumberFormatter()
        nf.locale = locale
        return nf
        }())
}


//Others 

// each type has its own random
public extension Bool {
    /// SwiftRandom extension
    public static func random() -> Bool {
        return Int.random() % 2 == 0
    }
}

public extension Int {
    
    /// SwiftRandom extension
    public static func random(_ lower: Int = 0, _ upper: Int = 100) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
    }
}

public extension Int32 {
    /// SwiftRandom extension
    ///
    /// - note: Using `Int` as parameter type as we usually just want to write `Int32.random(13, 37)` and not `Int32.random(Int32(13), Int32(37))`
    public static func random(_ lower: Int = 0, _ upper: Int = 100) -> Int32 {
        let r = arc4random_uniform(UInt32(Int64(upper) - Int64(lower)))
        return Int32(Int64(r) + Int64(lower))
    }
}

public extension Double {
    /// SwiftRandom extension
    public static func random(_ lower: Double = 0, _ upper: Double = 100) -> Double {
        return (Double(arc4random()) / 0xFFFFFFFF) * (upper - lower) + lower
    }
}

public extension Float {
    /// SwiftRandom extension
    public static func random(_ lower: Float = 0, _ upper: Float = 100) -> Float {
        return (Float(arc4random()) / 0xFFFFFFFF) * (upper - lower) + lower
    }
}

public extension CGFloat {
    /// SwiftRandom extension
    public static func random(_ lower: CGFloat = 0, _ upper: CGFloat = 1) -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * (upper - lower) + lower
    }
}

public extension Date {
    
    /// SwiftRandom extension
    public static func random() -> Date {
        let randomTime = TimeInterval(arc4random_uniform(UInt32.max))
        return Date(timeIntervalSince1970: randomTime)
    }
    
}

public extension UIColor {
    /// SwiftRandom extension
    public static func random(_ randomAlpha: Bool = false) -> UIColor {
        let randomRed = CGFloat.random()
        let randomGreen = CGFloat.random()
        let randomBlue = CGFloat.random()
        let alpha = randomAlpha ? CGFloat.random() : 1.0
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: alpha)
    }
}

public extension Array {
    /// SwiftRandom extension
    public func randomItem() -> Element {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}

public extension ArraySlice {
    /// SwiftRandom extension
    public func randomItem() -> Element {
        let index = Int.random(startIndex, endIndex)
        return self[index]
    }
}

public extension URL {
    /// SwiftRandom extension
    public static func random() -> URL {
        let urlList = ["http://www.google.com", "http://leagueoflegends.com/", "https://github.com/", "http://stackoverflow.com/", "https://medium.com/", "http://9gag.com/gag/6715049", "http://imgur.com/gallery/s9zoqs9", "https://www.youtube.com/watch?v=uelHwf8o7_U"]
        return URL(string: urlList.randomItem())!
    }
}


public struct Randoms {
    
    //==========================================================================================================
    // MARK: - Object randoms
    //==========================================================================================================
    public static func randomBool() -> Bool {
        return Bool.random()
    }
    
    public static func randomInt(_ lower: Int = 0, _ upper: Int = 100) -> Int {
        return Int.random(lower, upper)
    }
    
    public static func randomInt32(_ lower: Int = 0, _ upper: Int = 100) -> Int32{
        return Int32.random(lower, upper)
    }
    
    public static func randomPercentageisOver(_ percentage: Int) -> Bool {
        return Int.random() > percentage
    }
    
    public static func randomDouble(_ lower: Double = 0, _ upper: Double = 100) -> Double {
        return Double.random(lower, upper)
    }
    
    public static func randomFloat(_ lower: Float = 0, _ upper: Float = 100) -> Float {
        return Float.random(lower, upper)
    }
    
    public static func randomCGFloat(_ lower: CGFloat = 0, _ upper: CGFloat = 1) -> CGFloat {
        return CGFloat.random(lower, upper)
    }
    
    
    public static func randomDate() -> Date {
        return Date.random()
    }
    
    public static func randomColor(_ randomAlpha: Bool = false) -> UIColor {
        return UIColor.random(randomAlpha)
    }
    
    public static func randomNSURL() -> URL {
        return URL.random()
    }
    
    //==========================================================================================================
    // MARK: - Fake random data generators
    //==========================================================================================================
    public static func randomFakeName() -> String {
        let firstNameList = ["Henry", "William", "Geoffrey", "Jim", "Yvonne", "Jamie", "Leticia", "Priscilla", "Sidney", "Nancy", "Edmund", "Bill", "Megan"]
        let lastNameList = ["Pearson", "Adams", "Cole", "Francis", "Andrews", "Casey", "Gross", "Lane", "Thomas", "Patrick", "Strickland", "Nicolas", "Freeman"]
        return firstNameList.randomItem() + " " + lastNameList.randomItem()
    }
    
    public static func randomFakeGender() -> String {
        return Bool.random() ? "Male" : "Female"
    }
    
    public static func randomFakeConversation() -> String {
        let convoList = ["You embarrassed me this evening.","You don't think that was just lemonade in your glass, do you?","Do you ever think we should just stop doing this?","Why didn't he come and talk to me himself?","Promise me you'll look after your mother.","If you get me his phone, I might reconsider.","I think the room is bugged.","No! I'm tired of doing what you say.","For some reason, I'm attracted to you."]
        return convoList.randomItem()
    }
    
    public static func randomFakeTitle() -> String {
        let titleList = ["CEO of Google", "CEO of Facebook", "VP of Marketing @Uber", "Business Developer at IBM", "Jungler @ Fanatic", "B2 Pilot @ USAF", "Student at Stanford", "Student at Harvard", "Mayor of Raccoon City", "CTO @ Umbrella Corporation", "Professor at Pallet Town University"]
        return titleList.randomItem()
    }
    
    public static func randomFakeTag() -> String {
        let tagList = ["meta", "forum", "troll", "meme", "question", "important", "like4like", "f4f"]
        return tagList.randomItem()
    }
    
    fileprivate static func randomEnglishHonorific() -> String {
        let englishHonorificsList = ["Mr.", "Ms.", "Dr.", "Mrs.", "Mz.", "Mx.", "Prof."]
        return englishHonorificsList.randomItem()
    }
    
    public static func randomFakeNameAndEnglishHonorific() -> String {
        let englishHonorific = randomEnglishHonorific()
        let name = randomFakeName()
        return englishHonorific + " " + name
    }
    
    public static func randomFakeCity() -> String {
        let cityPrefixes = ["North", "East", "West", "South", "New", "Lake", "Port"]
        let citySuffixes = ["town", "ton", "land", "ville", "berg", "burgh", "borough", "bury", "view", "port", "mouth", "stad", "furt", "chester", "mouth", "fort", "haven", "side", "shire"]
        return cityPrefixes.randomItem() + citySuffixes.randomItem()
    }
    
    public static func randomCurrency() -> String {
        let currencyList = ["USD", "EUR", "GBP", "JPY", "AUD", "CAD", "ZAR", "NZD", "INR", "BRP", "CNY", "EGP", "KRW", "MXN", "SAR", "SGD",]
        
        return currencyList.randomItem()
    }
    
    public enum GravatarStyle: String {
        case standard
        case mm
        case identicon
        case monsterID
        case wavatar
        case retro
        
        static let allValues = [standard, mm, identicon, monsterID, wavatar, retro]
    }

}


/**
 Description: the toppest view controller of presenting view controller
 How to use: UIApplication.topMostViewController
 Where to use: controllers are not complex
 */

extension UIApplication {
    
    var topMostViewController: UIViewController? {
        var topController = UIApplication.shared.keyWindow?.rootViewController
        while topController?.presentedViewController != nil {
            topController = topController?.presentedViewController
        }
        return topController
    }
    
    /// App has more than one window and just want to get topMostViewController of the AppDelegate window.
    var appDelegateWindowTopMostViewController: UIViewController? {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        var topController = delegate?.window?.rootViewController
        while topController?.presentedViewController != nil {
            topController = topController?.presentedViewController
        }
        return topController
    }
}


/**
 Description: the toppest view controller of presenting view controller
 How to use:  UIApplication.sharedApplication().keyWindow?.rootViewController?.topMostViewController
 Where to use: There are lots of kinds of controllers (UINavigationControllers, UITabbarControllers, UIViewController)
 */

extension UIViewController {
    var topMostViewController: UIViewController? {
        // Handling Modal views
        if let presentedViewController = self.presentedViewController {
            return presentedViewController.topMostViewController
        }
            // Handling UIViewController's added as subviews to some other views.
        else {
            for view in self.view.subviews
            {
                // Key property which most of us are unaware of / rarely use.
                if let subViewController = view.next {
                    if subViewController is UIViewController {
                        let viewController = subViewController as! UIViewController
                        return viewController.topMostViewController
                    }
                }
            }
            return self
        }
    }
}

extension UITabBarController {
    
    override var topMostViewController: UIViewController? {
        return self.selectedViewController?.topMostViewController
    }
    
    var topVisibleViewController: UIViewController? {
        var top = selectedViewController
        while top?.presentedViewController != nil {
            top = top?.presentedViewController
        }
        return top
    }
}

extension UINavigationController {
    override var topMostViewController: UIViewController? {
        return self.visibleViewController?.topMostViewController
    }
}

public extension DispatchQueue {
    
    private static var _onceTracker = [String]()
    
    /**
     Executes a block of code, associated with a unique token, only once.  The code is thread safe and will
     only execute the code once even in the presence of multithreaded calls.
     
     - parameter token: A unique reverse DNS style name such as com.vectorform.<name> or a GUID
     - parameter block: Block to execute once
     */
    public class func once(token: String, block:(Void)->Void) {
        objc_sync_enter(self); defer { objc_sync_exit(self) }
        
        if _onceTracker.contains(token) {
            return
        }
        
        _onceTracker.append(token)
        block()
    }
}

extension UIScrollView {
    
//    var scrollToBottomDelegate: UIScrollViewScrollToBottomDelegate? {
//        get {
//            return objc_getAssociatedObject(self, &xoAssociationDelegateKey) as? UIScrollViewScrollToBottomDelegate
//        }
//        set {
//            objc_setAssociatedObject(self, &xoAssociationDelegateKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
//        }
//    }
//    
//    enum Priority {
//        case top
//        case bottom
//    }
//    
//    var isOnTop: Bool {
//        return contentOffset.y == -contentInset.top
//    }
//    
//    var isAtBottom: Bool {
//        return contentOffset.y == contentSize.height - bounds.size.height
//    }
//    
//    /// default is false
//    var rightBottomTriggerBoundToScrollViewDidScrollToTop: Bool {
//        get {
//            return objc_getAssociatedObject(self, &xoAssociationKey) as? Bool ?? false
//        }
//        set {
//            objc_setAssociatedObject(self, &xoAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
//        }
//    }
//    
//    func scrollToTop(animated: Bool = true) -> CGPoint {
//        let topOffset = CGPoint(x: 0, y: -contentInset.top)
//        setContentOffset(topOffset, animated: animated)
//        bindToScrollViewDidScrollToTopIfNeeded()
//        return topOffset
//    }
//    
//    func scrollToBottom(animated: Bool = true) -> CGPoint {
//        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height)
//        setContentOffset(bottomOffset, animated: animated)
//        scrollViewScrollingToBottom()
//        return bottomOffset
//    }
//    
//    func scrollToTopOrBottomAutomatically(animated: Bool = true, priority: Priority = .top, fuzzyOffset: CGFloat = 0) -> CGPoint {
//        
//        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height)
//        
//        guard bottomOffset.y > 0 else { return .zero }
//        
//        let topOffset = CGPoint(x: 0, y: -contentInset.top)
//        
//        let offset: CGPoint
//        
//        switch priority {
//        case .top:
//            let shouldBeTop = abs(contentOffset.y - topOffset.y) > abs(fuzzyOffset)
//            offset = shouldBeTop ? topOffset : bottomOffset
//        case .bottom:
//            let shouldBeTop = abs(contentOffset.y - bottomOffset.y) <= abs(fuzzyOffset)
//            offset = shouldBeTop ? topOffset : bottomOffset
//        }
//        
//        setContentOffset(offset, animated: animated)
//        
//        if offset == topOffset {
//            bindToScrollViewDidScrollToTopIfNeeded()
//        } else {
//            scrollViewScrollingToBottom()
//        }
//        
//        return offset
//    }
//    
//    @objc public func didTriggerOff() {
//        scrollToTopOrBottomAutomatically()
//    }
    
//    func configureRightBottomCornerScrollTrigger(superView: UIView? = nil, color: UIColor? = nil, radius: CGFloat = 4) -> UIView? {
//        
//        let view: UIView
//        
//        if superView != nil {
//            view = superView!
//        } else {
//            guard let sv = self.superview else { return nil }
//            view = sv
//        }
//        
//        let v = UIView()
//        view.addSubview(v)
//        v.snp.makeConstraints {
//            $0.width.height.equalTo(44)
//            $0.right.bottom.equalTo(0)
//        }
//        
//        var color = color
//        
//        if color == nil {
//            color = color ?? view.tintColor ?? AppDelegate().window?.tintColor ?? .black
//            color = color?.withAlphaComponent(0.8)
//        }
//        
//        let center = CGPoint(x: 44, y: 44)
//        let circlePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat(M_PI * 2), clockwise: true)
//        let shapeLayer = CAShapeLayer()
//        shapeLayer.path = circlePath.cgPath
//        shapeLayer.fillColor = color!.cgColor
//        v.layer.addSublayer(shapeLayer)
//        
//        let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTriggerOff))
//        v.addGestureRecognizer(recognizer)
//        v.isUserInteractionEnabled = true
//        
//        return v
//    }
    

//    func configureLeftBottomCornerTrigger(target: Any?, action: Selector, superView: UIView? = nil, color: UIColor? = nil, radius: CGFloat = 4) -> UIButton? {
//        
//        let view: UIView
//        
//        if superView != nil {
//            view = superView!
//        } else {
//            guard let sv = self.superview else { return nil }
//            view = sv
//        }
//        
//        let b = UIButton()
//        b.backgroundColor = .clear
//        b.isUserInteractionEnabled = true
//        b.addTarget(target, action: action, for: .touchUpInside)
//        view.addSubview(b)
//        b.snp.makeConstraints() {
//            $0.width.height.equalTo(44)
//            $0.left.bottom.equalTo(0)
//        }
//        
//        var color = color
//        
//        if color == nil {
//            color = color ?? view.tintColor ?? AppDelegate().window?.tintColor ?? .black
//            color = color?.withAlphaComponent(0.8)
//        }
//        
//        let center = CGPoint(x: 0, y: 44)
//        let circlePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat(M_PI * 2), clockwise: true)
//        let shapeLayer = CAShapeLayer()
//        shapeLayer.path = circlePath.cgPath
//        shapeLayer.fillColor = color!.cgColor
//        b.layer.addSublayer(shapeLayer)
//        
//        return b
//    }
//    
//    private func bindToScrollViewDidScrollToTopIfNeeded() {
//        
//        guard rightBottomTriggerBoundToScrollViewDidScrollToTop else { return }
//        
//        // call scrollViewShouldScrollToTop as well, may be needed somewhere
//        _ = delegate?.scrollViewShouldScrollToTop?(self)
//        
//        executeAfterDelay(0.3, closure: { [weak self] in
//            guard let strongSelf = self else { return }
//            strongSelf.delegate?.scrollViewDidScrollToTop?(strongSelf)
//            })
//    }
//    
//    private func scrollViewScrollingToBottom() {
//        
//        scrollToBottomDelegate?.scrollViewWillScrollToBottom(self)
//        
//        executeAfterDelay(0.3) { [weak self] in
//            guard let strongSelf = self else { return }
//            strongSelf.scrollToBottomDelegate?.scrollViewDidScrollToBottom(strongSelf)
//        }
//    }
}



