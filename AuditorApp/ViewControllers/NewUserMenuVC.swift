import UIKit

class NewUserMenuVC: UIViewController
{

    let gh = GlobalHelper.sharedInstance
    
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
        
        let btnLogin = fawButton()
        btnLogin.lbl.text = "Войти"
        btnLogin.lblIcon.text = myFawStrings.signIn
        self.view.addSubview(btnLogin)
        
        btnLogin.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1, constant: -56).isActive = true
        btnLogin.heightAnchor.constraint(equalToConstant: 56).isActive = true
        btnLogin.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        btnLogin.bottomAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -6).isActive = true
        btnLogin.layoutIfNeeded()
        
        let btnRegister = fawButton()
        btnRegister.lbl.text = "Регистрация"
        btnRegister.lblIcon.text = myFawStrings.userPlus
        self.view.addSubview(btnRegister)
        
        btnRegister.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1, constant: -56).isActive = true
        btnRegister.heightAnchor.constraint(equalToConstant: 56).isActive = true
        btnRegister.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        btnRegister.topAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 6).isActive = true
        btnRegister.layoutIfNeeded()
        
        
        
        let backBtn = backButton()
        self.view.addSubview(backBtn)
        
        backBtn.widthAnchor.constraint(equalToConstant: 196).isActive = true
        backBtn.heightAnchor.constraint(equalToConstant: 56).isActive = true
        backBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        backBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8).isActive = true
        backBtn.layoutIfNeeded()
        
        gh.addShadow(viewArray: [backBtn])
        
        backBtn.click =
            {
                self.dismiss(animated: true, completion: nil)
            }
        
        btnRegister.click =
            {
                self.present(RegisterVC(), animated: true, completion: nil)
            }
        
        btnLogin.click =
            {
                self.present(LoginVC(), animated: true, completion: nil)
            }
    }


}
