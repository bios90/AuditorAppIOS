import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var btnAdminView: UIView!
    @IBOutlet weak var btnUserView: UIView!
    var btnArray = [UIView]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        btnArray = [btnAdminView,btnUserView]
        
        GlobalHelper.sharedInstance.addShadow(viewArray: btnArray)
        GlobalHelper.sharedInstance.makeRound(viewArray: btnArray)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

    @IBAction func actUser(_ sender: Any)
    {
        performSegue(withIdentifier: "toUserLogin", sender: self)
    }
}



