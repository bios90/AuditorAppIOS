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
    
    
    func test()
    {
//        let fullHeight : CGFloat = 240
//        let smallHeight : CGFloat = 44
//        
//        let currentHeigth  = rootView.frame.size.height //I use this to get current height and understand expanded view or not
//
//        let heighCons = rootView.constraints.filter //I use this to deactivate current height Anchor constraint
//        {
//            $0.firstAttribute == NSLayoutAttribute.height
//        }
//        NSLayoutConstraint.deactivate(heighCons)
//        rootView.layoutIfNeeded()
//        
//        if currentHeigth == smallHeight
//        {
//            rootView.heightAnchor.constraint(equalToConstant: fullHeight).isActive = true
//            rootView.setNeedsLayout()
//            
//            UIView.animate(withDuration: 0.5)
//            {
//                rootView.layoutIfNeeded() //animation itself
//            }
//            
//        }
//        else
//        {
//            rootView.heightAnchor.constraint(equalToConstant: smallHeight).isActive = true
//            rootView.setNeedsLayout()
//            
//            UIView.animate(withDuration: 0.5)
//            {
//                rootView.layoutIfNeeded() //animation itself
//            }
//        }
        
    }
}
