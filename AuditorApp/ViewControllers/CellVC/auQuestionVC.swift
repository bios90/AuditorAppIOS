import UIKit

class auQuestionVC: UIView
{
    @IBOutlet weak var myRootView: UIView!
    @IBOutlet weak var imgObyaz: UIImageView!
    
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var btn0: UIButton!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    
    
    class func makeNib() -> auQuestionVC
    {
        let view =  UINib(nibName: "audit_question", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! auQuestionVC
        return view
    }
    
    
    @IBAction func actSkrepka(_ sender: Any)
    {
    }
    
    @IBAction func actComment(_ sender: Any)
    {
    }
    
    @IBAction func actAddPhoto(_ sender: Any)
    {
    }
}
