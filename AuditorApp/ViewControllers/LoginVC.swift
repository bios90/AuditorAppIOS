import UIKit
import FirebaseAuth
import Alamofire
import SwiftyJSON

class LoginVC: UIViewController,UITextFieldDelegate
{
    let gh = GlobalHelper.sharedInstance
    var tfEmail: myNewTextField!
    var tfPass : myNewTextField!
    var userFbId : String!
    
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
        btnLogin.topAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 40).isActive = true
        btnLogin.layoutIfNeeded()
        
        
        tfPass = myNewTextField()
        tfPass.delegate = self
        tfPass.placeholder = "*Пароль..."
        tfPass.isSecureTextEntry = true
        
        self.view.addSubview(tfPass)
        tfPass.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1, constant: -56).isActive = true
        tfPass.heightAnchor.constraint(equalToConstant: 56).isActive = true
        tfPass.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        tfPass.bottomAnchor.constraint(equalTo: btnLogin.topAnchor, constant: -40).isActive = true
        tfPass.layoutIfNeeded()
        
        tfEmail = myNewTextField()
        tfEmail.delegate = self
        tfEmail.placeholder = "*Email..."
        
        self.view.addSubview(tfEmail)
        tfEmail.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1, constant: -56).isActive = true
        tfEmail.heightAnchor.constraint(equalToConstant: 56).isActive = true
        tfEmail.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        tfEmail.bottomAnchor.constraint(equalTo: tfPass.topAnchor, constant: -6).isActive = true
        tfEmail.layoutIfNeeded()
        
        btnLogin.click =
            {
                self.makeLogin()
            }
        
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
    }
    
    
    
    func makeLogin()
    {
        let email = tfEmail.text!.trim()
        let password = tfPass.text!.trim()

        
        if (email.isEmpty || password.isEmpty)
        {
            gh.showToast(message: "Заполните все поля", view: self.view!)
            return
        }
        
        if(!gh.isValidEmail(testStr: email))
        {
            gh.showToast(message: "Введите корректный e-mail", view: self.view!)
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password)
        {
            (result, error) in
            if(result == nil)
            {
                self.gh.showToast(message: "Ошибка входа, проверьте введенные данные", view: self.view!)
                return
            }
            
            let user = result?.user
            
            if(!(user?.isEmailVerified)!)
            {
                self.gh.showToast(message: "Необходимо подтвердить Email", view: self.view!)
                
                do
                {
                    try Auth.auth().signOut()
                }
                catch let error as NSError
                {
                    print (error)
                }
                return
            }
            
            self.userFbId = user?.uid
            self.getAllInfo()
            
        }
        
    }
    
    
    func getAllInfo()
    {
        let parameters : Parameters =
            [
                "Fb_Id" : userFbId!
            ]
        
        Alamofire.request(self.gh.GET_USER_BY_FB_ID,method: .get, parameters: parameters)
            .responseJSON
            {
                (response:DataResponse<Any>) in
                if let value = response.result.value
                {
                    print(value)
                    let json = JSON(value)
                    let name = json[0]["Name"].stringValue
                    let surname = json[0]["Surname"].stringValue
                    let userId = json[0]["Id"].intValue
                    
                    let defaults = UserDefaults.standard
                    defaults.set(name, forKey: self.gh.userName)
                    defaults.set(surname, forKey: self.gh.userSurname)
                    defaults.set(userId, forKey: self.gh.userId)
                    
                    self.present(NewMainMenu(), animated: true, completion: nil)
                }
            }
    
    }
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }



}
