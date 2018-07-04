import UIKit

@IBDesignable
class SkachannieCell: UIView
{
    @IBOutlet weak var view: UIView!
    
    
    @IBOutlet weak var cellRootView: UIView!
    @IBOutlet weak var rootImageView: UIView!
    @IBOutlet weak var rootLblView: UIView!
    @IBOutlet weak var rootButtonsView: UIView!
    
    @IBOutlet weak var stackForLAbels: UIStackView!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var lblPlace: UILabel!
    
    @IBOutlet weak var imgLogo: UIImageView!
    
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnBegin: UIButton!
    
    var thisShablon : Model_Shablon?
    
    var onClickCallback: (() -> Void)?
    
    func instanceFromNib() -> SkachannieCell
    {
        let view =  UINib(nibName: "skachanniiElement", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! SkachannieCell
        return view
    }
    
    
    @IBAction func actDeletePressed(_ sender: Any) {
    }
    
    @IBAction func actBeginPressed(_ sender: Any)
    {
        onClickCallback?()
    }
    
}
