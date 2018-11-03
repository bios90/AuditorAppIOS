import UIKit
import Toast_Swift

class UserLoginVC: UIViewController
{
    @IBOutlet weak var lblEnterPass: UILabel!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnEnterView: UIView!
    @IBOutlet weak var btnBackView: UIView!
    
    @IBOutlet weak var imgInfo: UIImageView!
    
    
    var viewArray = [UIView]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        viewArray = [lblEnterPass,tfPassword,btnEnterView,btnBackView]
    
        GlobalHelper.sharedInstance.addShadow(viewArray: viewArray)
        GlobalHelper.sharedInstance.makeRound(viewArray: [btnEnterView])
        
        tfPassword.isSecureTextEntry = true
        tfPassword.returnKeyType = UIReturnKeyType.done
        tfPassword.addTarget(self, action: #selector(self.tfChanged), for: .editingChanged)
        
        
        
        let statusView = UIView()
        statusView.translatesAutoresizingMaskIntoConstraints = false
        statusView.backgroundColor = gh.myRed
        self.view.addSubview(statusView)
        
        statusView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        statusView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        statusView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        statusView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        statusView.layoutIfNeeded()
    }
    
    @objc func tfChanged()
    {
        let text = tfPassword.text!
        if(text == "337321")
        {
            self.performSegue(withIdentifier: GlobalHelper.sharedInstance.segueToUserMEnu, sender: self)
        }
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
        if(tfPassword.text == "337321")
        {
            self.performSegue(withIdentifier: GlobalHelper.sharedInstance.segueToUserMEnu, sender: self)
        }
        
        else
        {
           GlobalHelper.sharedInstance.showToast(message: "Неправильный пароль, повторите ввод", view: view)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}
