import UIKit

class MyViewController: UIViewController
{
    @IBOutlet weak var myLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

    }

    func makeVC() -> auditCategVC
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier :"auditCategId") as! auditCategVC
        return viewController
    }
}
