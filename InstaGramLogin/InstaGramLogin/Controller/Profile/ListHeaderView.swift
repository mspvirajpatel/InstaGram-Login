

import UIKit

class ListHeaderView: UICollectionReusableView {

    // Mark: - Attributes -
    var lblDes : BaseLabel!
    
    // MARK: - Lifecycle -
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.loadViewControls()
        self.setViewlayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        print("ListHeaderView deinit called")
        
        if lblDes.superview != nil && lblDes != nil {
            lblDes.removeFromSuperview()
            lblDes = nil
        }
    }
    
    // MARK: - Layout -
    func loadViewControls() {
        self.backgroundColor = .red
        
        lblDes = BaseLabel(labelType: .large, superView: self)
        lblDes.numberOfLines = 0
        lblDes.text = ""
    }
    
    func setViewlayout() {
        
        lblDes.edgeToSuperView(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    override func layoutSubviews() {
        self.frame.size.height = 250.0
    }
    
    // MARK: - Internal Helpers -
    
    

}
