import UIKit
import FirebaseAuth

class NewFirstVC: UIViewController
{
    var gh : GlobalHelper!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        gh = GlobalHelper.sharedInstance
        
        for fontFamilyName in UIFont.familyNames{
            for fontName in UIFont.fontNames(forFamilyName: fontFamilyName){
                print("Family: \(fontFamilyName)     Font: \(fontName)")
            }
        }
        
        let bgImgV = UIImageView()
        bgImgV.translatesAutoresizingMaskIntoConstraints = false
        bgImgV.image = UIImage(named: "backgroundBG")
        view.addSubview(bgImgV)
        
        bgImgV.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        bgImgV.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        bgImgV.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bgImgV.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        bgImgV.layoutIfNeeded()
        
        
        let statusView = UIView()
        statusView.translatesAutoresizingMaskIntoConstraints = false
        statusView.backgroundColor = gh.myRed
        self.view.addSubview(statusView)
        
        statusView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        statusView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        statusView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        statusView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        statusView.layoutIfNeeded()
        
        
        let btnUser = fawButton()
        btnUser.layer.cornerRadius = 28
        btnUser.lbl.text  = "Я исполнитель"
        btnUser.lblIcon.text = myFawStrings.chevronRight
        btnUser.lblIcon.font = btnUser.lblIcon.font.withSize(20)
        self.view.addSubview(btnUser)
        
        btnUser.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -28).isActive = true
        btnUser.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 28).isActive = true
        btnUser.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -136).isActive = true
        btnUser.heightAnchor.constraint(equalToConstant: 56).isActive = true
        btnUser.layoutIfNeeded()
        btnUser.lbl.adjustsFontSizeToFitWidth = true
        btnUser.lbl.minimumScaleFactor = 0.5
        btnUser.lbl.numberOfLines = 1
        
//        let btnAdmin = fawButton()
//        btnAdmin.layer.cornerRadius = 28
//        btnAdmin.lbl.text  = "Я администратор"
//        btnAdmin.lblIcon.text = myFawStrings.chevronRight
//        btnAdmin.lblIcon.font = btnAdmin.lblIcon.font.withSize(20)
//        self.view.addSubview(btnAdmin)
//
//        btnAdmin.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -28).isActive = true
//        btnAdmin.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 28).isActive = true
//        btnAdmin.bottomAnchor.constraint(equalTo: btnUser.topAnchor, constant: -12).isActive = true
//        btnAdmin.heightAnchor.constraint(equalToConstant: 56).isActive = true
//        btnAdmin.layoutIfNeeded()
//        btnAdmin.lbl.adjustsFontSizeToFitWidth = true
//        btnAdmin.lbl.minimumScaleFactor = 0.5
//        btnAdmin.lbl.numberOfLines = 1
        
        
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
        
        let lblFooter = UILabel()
        lblFooter.translatesAutoresizingMaskIntoConstraints = false
        lblFooter.text = "Автор : Евдокимов И.С.\nИзготовлено для\nООО \"Эй Кей Ресторантс Раша\""
        lblFooter.numberOfLines = 3
        lblFooter.font = UIFont.systemFont(ofSize: 14)
        lblFooter.textColor = UIColor.white
        self.view.addSubview(lblFooter)
        
        lblFooter.widthAnchor.constraint(equalToConstant: 226).isActive = true
        lblFooter.heightAnchor.constraint(equalToConstant: 56).isActive = true
        lblFooter.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -4).isActive = true
        lblFooter.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -4).isActive = true
        lblFooter.layoutIfNeeded()
        
        gh.addShadow(viewArray: [lblFooter,lblAlisa,lblSamoaudit])
        
        
        btnUser.click =
            {
                if(Auth.auth().currentUser == nil || self.gh.currentUser()[0] == nil || self.gh.currentUser()[1] == nil)
                {
                    self.present(NewUserMenuVC(), animated: true, completion: nil)
                    return
                }
                self.present(NewMainMenu(), animated: true, completion: nil)
            }
        
//        btnAdmin.click =
//            {
//                self.gh.showToast(message: "Сервис администратора в разработке.", view: self.view)
//            }
        
    }



}
