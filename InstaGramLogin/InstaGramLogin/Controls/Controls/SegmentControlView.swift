
import UIKit

typealias SegmentTabbedEvent = (_ index : Int) -> ()

enum SegmentControlViewType : Int
{
    case unknown = -1
    case primary = 1
    case secondary
    
}

class SegmentControlView: UIView {
    
    // MARK: - Attributes -
    var segmentViewHeight : CGFloat! = 50.0
    var tabbedEventBlock : SegmentTabbedEvent?
    var selectedindex:Int = 0

    private var segmentControlViewType : SegmentControlViewType = .unknown

    
    // MARK: - Lifecycle -
    init(iSegmentType : SegmentControlViewType, titleArray : [String], iSuperView : UIView){
        super.init(frame: CGRect.zero)
        
        self.segmentControlViewType = iSegmentType
        self.translatesAutoresizingMaskIntoConstraints = false
        iSuperView.addSubview(self)
        
        self.loadViewWithTitleArray(titleArray)
        self.setViewlayout()
    }
    
    init(iSegmentType : SegmentControlViewType,titleArray : [String], iSuperView : UIView, height : CGFloat)
    {
        self.segmentControlViewType = iSegmentType

        super.init(frame: CGRect.zero)
        segmentViewHeight = height
        self.translatesAutoresizingMaskIntoConstraints = false
        iSuperView.addSubview(self)
        
        self.loadViewWithTitleArray(titleArray)
        self.setViewlayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    override func layoutSubviews(){
        super.layoutSubviews()
        
        switch segmentControlViewType {
        case .primary:
            self.setBottomBorder(Color.segmentBorder.value, width: 0.6)
            break
            
        case .secondary:
            self.setBottomBorder(.clear, width: 0.6)
            break
            
        default:
            break
        }
    }
    
    /**
     Its will free the memory of basebutton's current hold object's. Mack every object nill her which is declare in class as Swift not automattically release the object.
     */
    deinit{
        NotificationCenter.default.removeObserver(self)
        
        segmentViewHeight = nil
        tabbedEventBlock = nil
    }
    
    // MARK: - Layout -
    
    func loadViewWithTitleArray(_ titleArray : [String]){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = false
        
        self.backgroundColor = UIColor.clear
        var segementButtonTag : Int = 0
        
        for titleString in titleArray {
            
            var segementButton : UIButton! = UIButton(type: .custom)
            segementButton.translatesAutoresizingMaskIntoConstraints = false
            
            self.addSubview(segementButton)
            segementButton.clipsToBounds = true
            
            segementButton.titleLabel?.lineBreakMode = .byWordWrapping
            segementButton.titleLabel?.textAlignment = .center
            
            segementButton.backgroundColor = UIColor.clear
            segementButton.setTitle(titleString, for: UIControlState())
            
            
            segementButton.titleLabel?.font = UIFont(name: FontStyle.medium, size: SystemConstants.IS_IPAD ? 20.0 : 14.0)
            segementButton.setTitleColor(Color.segmentTitle.value, for: UIControlState())
            
            segementButton.tag = segementButtonTag
            segementButton.addTarget(self, action: #selector(segmentTabbed), for: .touchUpInside)
            
            segementButtonTag = segementButtonTag + 1
            segementButton = nil
        }
        self.segmentTabbed(self.subviews[0])
    }
    
    func setViewlayout(){
        
        var segementSubView, prevSegementSubView : UIView?
        var segementSubViewDictionary : [String : AnyObject]?
        var segementSubViewConstraints : Array<NSLayoutConstraint>?
        
        var control_H, control_V : Array<NSLayoutConstraint>?
        let viewDictionary = ["BBSegmentView" : self]
        let metrics = ["BBSegmentViewHeight" : segmentViewHeight]
        
        control_H = NSLayoutConstraint.constraints(withVisualFormat: "H:[BBSegmentView(>=0)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDictionary)
        
        control_V = NSLayoutConstraint.constraints(withVisualFormat: "V:[BBSegmentView(BBSegmentViewHeight)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: viewDictionary)
        
        switch segmentControlViewType {
        case .primary:
            self.addConstraints(control_H!)
            self.addConstraints(control_V!)
            break
        default:
            break
        }
        
        let segementSubViewCount = self.subviews.count
        prevSegementSubView = nil
        
        for i in 0...(segementSubViewCount - 1)
        {
            segementSubView = self.subviews[i]
            if(prevSegementSubView == nil)
            {
                segementSubViewDictionary = ["segementSubView" : segementSubView!]
                
            }else
            {
                segementSubViewDictionary = ["segementSubView" : segementSubView!,
                                             "prevSegementSubView" : prevSegementSubView!]
            }
            
            segementSubViewConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[segementSubView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: segementSubViewDictionary!)
            self.addConstraints(segementSubViewConstraints!)
            
            segementSubViewConstraints = nil
            
            if(segementSubViewCount > 2)
            {
                switch i
                {
                case 0:
                    
                    segementSubViewConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[segementSubView]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: segementSubViewDictionary!)
                    
                    break
                    
                case (segementSubViewCount - 1):
                    
                    segementSubViewConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[prevSegementSubView][segementSubView(==prevSegementSubView)]|", options:[.alignAllTop, .alignAllBottom], metrics: nil, views: segementSubViewDictionary!)
                    
                    break
                    
                default:
                    
                    segementSubViewConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[prevSegementSubView][segementSubView(==prevSegementSubView)]", options:[.alignAllTop, .alignAllBottom], metrics: nil, views: segementSubViewDictionary!)
                    
                    break
                }
                
                
            }else
            {
                switch i
                {
                    
                case 0:
                    
                    segementSubViewConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[segementSubView]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: segementSubViewDictionary!)
                    
                    break
                    
                case (segementSubViewCount - 1):
                    
                    segementSubViewConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[prevSegementSubView][segementSubView(==prevSegementSubView)]|", options:[.alignAllTop, .alignAllBottom], metrics: nil, views: segementSubViewDictionary!)
                    
                    break
                    
                default:
                    break
                }
                
            }
            
            prevSegementSubView = segementSubView
            self.addConstraints(segementSubViewConstraints!)
            
            segementSubViewConstraints = nil
            segementSubViewDictionary = nil
            segementSubView = nil
            
        }
        
        self.layoutSubviews()
    }
    
    // MARK: - Public Interface -
    
    func setTitleOnSegment(_ titleArray : [String]){
        
        if(titleArray.count <= self.subviews.count && titleArray.count != 0)
        {
            var i : Int = 0
            for titleString in titleArray
            {
                var button : UIButton! = self.subviews[i] as! UIButton
                button.setTitle(titleString, for: UIControlState())
                i = i + 1
                button = nil
            }
        }
        self.layoutIfNeeded()
        self.layoutSubviews()
    }
    
    func setSegmentTabbedEvent(_ iTabbedEventBlock : @escaping SegmentTabbedEvent)
    {
        tabbedEventBlock = iTabbedEventBlock
    }
    
    func setSegementSelectedAtIndex(_ index : Int)
    {
        if(index < self.subviews.count)
        {
            switch self.segmentControlViewType {
            case .primary:
                var currentButton : UIButton! = self.subviews[index] as! UIButton
                currentButton.setTitleColor(Color.segmentSelectedTitle.value, for: UIControlState())
                currentButton.backgroundColor = Color.segmentSelectedBG.value
                selectedindex = index
                for view in self.subviews
                {
                    var button : UIButton! = view as! UIButton
                    
                    if(button.tag != currentButton.tag)
                    {
                        button.setTitleColor(Color.segmentSelectedBG.value, for: UIControlState())
                        button.backgroundColor = UIColor.clear
                    }
                    button = nil
                }
                currentButton = nil
                break
            
            case .secondary:
                var currentButton : UIButton! = self.subviews[index] as! UIButton
                currentButton.setTitleColor(Color.segmentSelectedTitle.value, for: UIControlState())
                currentButton.backgroundColor = .clear
                selectedindex = index
                for view in self.subviews
                {
                    var button : UIButton! = view as! UIButton
                    
                    if(button.tag != currentButton.tag)
                    {
                        button.setTitleColor(.clear, for: UIControlState())
                        button.backgroundColor = UIColor.clear
                    }
                    button = nil
                }
                currentButton = nil
                break
                
            default:
                break
            }
            
            
        }
    }
    
    // MARK: - User Interaction -
    
    func segmentTabbed(_ sender : AnyObject)
    {
        switch self.segmentControlViewType {
        case .primary:
            
            var currentButton : UIButton! = (sender as? UIButton)!
            currentButton.setTitleColor(Color.segmentSelectedTitle.value, for: UIControlState())
            currentButton.backgroundColor = Color.segmentSelectedBG.value
            
            if selectedindex == currentButton.tag{
                return
            }
            
            for view in self.subviews
            {
                var button : UIButton! = view as! UIButton
                
                if(button.tag != currentButton.tag)
                {
                    button.setTitleColor(Color.segmentTitle.value, for: UIControlState())
                    button.backgroundColor = UIColor.clear
                }
                selectedindex = currentButton.tag
                button = nil
            }
            
            if(tabbedEventBlock != nil){
                tabbedEventBlock!((currentButton.tag))
            }
            currentButton = nil
            break
            
        case .secondary:
            
            var currentButton : UIButton! = (sender as? UIButton)!
            currentButton.setTitleColor(Color.segmentSelectedBG.value, for: UIControlState())
            currentButton.backgroundColor = .clear
            
            if selectedindex == currentButton.tag{
                if(tabbedEventBlock != nil){
                    tabbedEventBlock!((currentButton.tag))
                }
                return
            }
            
            for view in self.subviews
            {
                var button : UIButton! = view as! UIButton
                
                if(button.tag != currentButton.tag)
                {
                    button.setTitleColor(Color.segmentTitle.value, for: UIControlState())
                    button.backgroundColor = UIColor.clear
                }
                selectedindex = currentButton.tag
                button = nil
            }
            
            if(tabbedEventBlock != nil){
                tabbedEventBlock!((currentButton.tag))
            }
            currentButton = nil
            break
            
        default:
            break
        }
        
    }
    
    // MARK: - Internal Helpers -
    
}
