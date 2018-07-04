import UIKit

class myViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let model : MyModel = MyModel()
        let nibClass : MyNibClass = MyNibClass()
        let view = nibClass.instanceMyNib()
        view.addSubview(view)
    }
}
