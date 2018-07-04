import UIKit

class MyNibClass: UIView
{
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    
    func instanceMyNib() -> UIView
    {
        let view =  UINib(nibName: "myNib", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
        return view
    }
}
