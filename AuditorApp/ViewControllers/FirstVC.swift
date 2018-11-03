import UIKit
import FirebaseAuth

class ViewController: UIViewController
{
    var gh : GlobalHelper!
    @IBOutlet weak var btnAdminView: UIView!
    @IBOutlet weak var btnUserView: UIView!
    var btnArray = [UIView]()
    
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var logo: UIImageView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        gh = GlobalHelper.sharedInstance
        btnArray = [btnAdminView,btnUserView]
        
        GlobalHelper.sharedInstance.addShadow(viewArray: btnArray)
        GlobalHelper.sharedInstance.makeRound(viewArray: btnArray)
        
        
        lbl.text = "Автор : Евдокимов И.С.\nИзготовлено для\nООО \"Эй Кей Ресторантс Раша\""
        lbl.font = UIFont.systemFont(ofSize: 14)
        //lbl.textColor = GlobalHelper.sharedInstance.myRed
        lbl.textColor = UIColor.white
        lbl.adjustsFontSizeToFitWidth = true
        
        logo.isHidden = true
        
        let statusView = UIView()
        statusView.translatesAutoresizingMaskIntoConstraints = false
        statusView.backgroundColor = gh.myRed
        self.view.addSubview(statusView)
        
        statusView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        statusView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        statusView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        statusView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        statusView.layoutIfNeeded()
        
        let lblAlisa = UILabel()
        lblAlisa.translatesAutoresizingMaskIntoConstraints = false
        lblAlisa.textColor = UIColor.white
        lblAlisa.text = "А.Л.И.С.А."
        lblAlisa.font = UIFont.systemFont(ofSize: 38, weight: .bold)
        lblAlisa.textAlignment = .center
        self.view.addSubview(lblAlisa)
        
        lblAlisa.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -44).isActive = true
        lblAlisa.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 4).isActive = true
        lblAlisa.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        lblAlisa.heightAnchor.constraint(equalToConstant: 38).isActive = true
        lblAlisa.layoutIfNeeded()
        
        let lblSamoaudit = UILabel()
        lblSamoaudit.translatesAutoresizingMaskIntoConstraints = false
        lblSamoaudit.textColor = UIColor.white
        lblSamoaudit.numberOfLines = 2
        lblSamoaudit.text = "Автоматизированный Личный Инструмент\nдля Самоаудитов и Аудитов"
        lblSamoaudit.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        lblSamoaudit.textAlignment = .center
        self.view.addSubview(lblSamoaudit)
        
        lblSamoaudit.topAnchor.constraint(equalTo: lblAlisa.bottomAnchor, constant: 0).isActive = true
        lblSamoaudit.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        lblSamoaudit.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        lblSamoaudit.heightAnchor.constraint(equalToConstant: 36).isActive = true
        lblSamoaudit.layoutIfNeeded()
        
        gh.addShadow(viewArray: [lbl,lblAlisa,lblSamoaudit])
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

    @IBAction func actUser(_ sender: Any)
    {
        
        if(Auth.auth().currentUser == nil || gh.currentUser()[0] == nil || gh.currentUser()[1] == nil)
        {
            self.present(NewUserMenuVC(), animated: true, completion: nil)
            return
        }
        self.present(NewMainMenu(), animated: true, completion: nil)
//        self.present(UserMenu(), animated: true, completion: nil)
//        performSegue(withIdentifier: "toUserLogin", sender: self)
//        self.performSegue(withIdentifier: "toUserLogin", sender: self)
        
    }
    
    @IBAction func actAdmin(_ sender: Any)
    {
        gh.showToast(message: "Сервис администратора в разработке.", view: self.view)
//         self.present(AdminLoginVC(), animated: true, completion: nil)
    }
    
}



