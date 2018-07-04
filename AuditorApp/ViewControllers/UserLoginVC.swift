import UIKit
import Toast_Swift

class UserLoginVC: UIViewController
{
    @IBOutlet weak var lblEnterPass: UILabel!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnEnterView: UIView!
    @IBOutlet weak var btnBackView: UIView!
    
    
    
    var viewArray = [UIView]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        viewArray = [lblEnterPass,tfPassword,btnEnterView,btnBackView]
    
        GlobalHelper.sharedInstance.addShadow(viewArray: viewArray)
        GlobalHelper.sharedInstance.makeRound(viewArray: [btnEnterView])
        
        tfPassword.isSecureTextEntry = true
        tfPassword.returnKeyType = UIReturnKeyType.done
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

    @IBAction func actBackButton(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actDonePressed(_ sender: Any)
    {
        performUserMenu()
    }
    @IBAction func actEnterPressed(_ sender: Any)
    {
        performUserMenu()
    }
    
    @objc func performUserMenu()
    {
        if(tfPassword.text == "123")
        {
            self.performSegue(withIdentifier: GlobalHelper.sharedInstance.segueToUserMEnu, sender: self)
        }
        
        else
        {
           GlobalHelper.sharedInstance.showToast(message: "Неправильный пароль, повторите ввод", view: view)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}
