import UIKit
import FirebaseAuth

class NewMainMenu: UIViewController
{
    let gh = GlobalHelper.sharedInstance
    var btnDownload : fawButton!
    var btnSkachannie : fawButton!
    var btnFinished : fawButton!
    var btnInfo : fawButton!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

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
        
        
        btnSkachannie = fawButton()
        btnSkachannie.lbl.text = "Скачанные Шаблоны"
        btnSkachannie.lblIcon.text = myFawStrings.floppyO
        self.view.addSubview(btnSkachannie)
        
        btnSkachannie.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1, constant: -56).isActive = true
        btnSkachannie.heightAnchor.constraint(equalToConstant: 56).isActive = true
        btnSkachannie.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        btnSkachannie.bottomAnchor.constraint(equalTo: self.view.centerYAnchor , constant: -12).isActive = true
        btnSkachannie.layoutIfNeeded()
        btnSkachannie.lbl.adjustsFontSizeToFitWidth = true
        btnSkachannie.lbl.minimumScaleFactor = 0.5
        btnSkachannie.lbl.numberOfLines = 1
        
        btnDownload = fawButton()
        btnDownload.lbl.text = "Загрузить Шаблоны"
        btnDownload.lblIcon.text = myFawStrings.download
        self.view.addSubview(btnDownload)
        
        btnDownload.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1, constant: -56).isActive = true
        btnDownload.heightAnchor.constraint(equalToConstant: 56).isActive = true
        btnDownload.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        btnDownload.bottomAnchor.constraint(equalTo: btnSkachannie.topAnchor , constant: -12).isActive = true
        btnDownload.layoutIfNeeded()
        btnDownload.lbl.adjustsFontSizeToFitWidth = true
        btnDownload.lbl.minimumScaleFactor = 0.5
        btnDownload.lbl.numberOfLines = 1
        
        btnFinished = fawButton()
        btnFinished.lbl.text = "Завершенные Аудиты"
        btnFinished.lblIcon.text = myFawStrings.checkDouble
        self.view.addSubview(btnFinished)
        
        btnFinished.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1, constant: -56).isActive = true
        btnFinished.heightAnchor.constraint(equalToConstant: 56).isActive = true
        btnFinished.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        btnFinished.topAnchor.constraint(equalTo: btnSkachannie.bottomAnchor , constant: 12).isActive = true
        btnFinished.layoutIfNeeded()
        btnFinished.lbl.adjustsFontSizeToFitWidth = true
        btnFinished.lbl.minimumScaleFactor = 0.5
        btnFinished.lbl.numberOfLines = 1
        
        
        
        btnInfo = fawButton()
        btnInfo.lbl.text = "А.Л.И.С.А. Инфо"
        btnInfo.lblIcon.text = myFawStrings.infoCircle
        self.view.addSubview(btnInfo)
        
        btnInfo.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1, constant: -56).isActive = true
        btnInfo.heightAnchor.constraint(equalToConstant: 56).isActive = true
        btnInfo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        btnInfo.topAnchor.constraint(equalTo: btnFinished.bottomAnchor , constant: 12).isActive = true
        btnInfo.layoutIfNeeded()
        btnInfo.lbl.adjustsFontSizeToFitWidth = true
        btnInfo.lbl.minimumScaleFactor = 0.5
        btnInfo.lbl.numberOfLines = 1
        
        
        btnSkachannie.click =
            {
                self.present(NewSkachannieVC(), animated:  true, completion: nil)
            }
        
        btnDownload.click =
            {
                self.present(DownloadVC(), animated:  true, completion: nil)
            }
        
        btnFinished.click =
            {
                self.present(FinishedVC(), animated:  true, completion: nil)
            }
        
        btnInfo.click =
            {
                self.present(InfoPassRequest(), animated:  true, completion: nil)
            }
        
        
        let topView = userNameView()
        self.view.addSubview(topView)
        
        topView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        topView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        topView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        topView.layoutIfNeeded()
        
        topView.exitClick =
            {
                do
                {
                    try Auth.auth().signOut()
                }
                catch let error as NSError
                {
                    print (error)
                }
                
                let defaults = UserDefaults.standard
                
                defaults.removeObject(forKey: self.gh.userName)
                defaults.removeObject(forKey: self.gh.userSurname)
                
                self.present(NewFirstVC(), animated: true, completion: nil)
            }
        
        
        
        let backBtn = backButton()
        self.view.addSubview(backBtn)
        
        backBtn.widthAnchor.constraint(equalToConstant: 196).isActive = true
        backBtn.heightAnchor.constraint(equalToConstant: 56).isActive = true
        backBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        backBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        backBtn.layoutIfNeeded()
        
        gh.addShadow(viewArray: [backBtn])
        
        backBtn.click =
            {
                self.present(NewFirstVC(), animated: true, completion: nil)
            }
        
        
    }



}
