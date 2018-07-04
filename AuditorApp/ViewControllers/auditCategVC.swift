import UIKit

class auditCategVC: UIViewController {

    @IBOutlet weak var rootScroll: UIScrollView!
    
    
    

    
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
