
import UIKit
import Alamofire
import FirebaseAuth

class RegisterVC: UIViewController, UITextFieldDelegate
{
    let gh = GlobalHelper.sharedInstance
    var tfName : myNewTextField!
    var tfPass : myNewTextField!
    var tfEmail : myNewTextField!
    var tfSurname : myNewTextField!
    var tfPhone : myNewTextField!
    
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
        
        tfName = myNewTextField()
        tfName.delegate = self
        tfName.placeholder = "*Имя..."
        
        self.view.addSubview(tfName)
        tfName.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1, constant: -56).isActive = true
        tfName.heightAnchor.constraint(equalToConstant: 56).isActive = true
        tfName.centerYAnchor.constraint(equalTo: self.view.centerYAnchor,constant: -48).isActive = true
        tfName.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        tfName.layoutIfNeeded()
        
        tfPass = myNewTextField()
        tfPass.delegate = self
        tfPass.placeholder = "*Пароль..."
        tfPass.isSecureTextEntry = true
        
        self.view.addSubview(tfPass)
        tfPass.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1, constant: -56).isActive = true
        tfPass.heightAnchor.constraint(equalToConstant: 56).isActive = true
        tfPass.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        tfPass.bottomAnchor.constraint(equalTo: tfName.topAnchor, constant: -6).isActive = true
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
        
        
        tfSurname = myNewTextField()
        tfSurname.delegate = self
        tfSurname.placeholder = "*Фамилия..."
        
        self.view.addSubview(tfSurname)
        tfSurname.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1, constant: -56).isActive = true
        tfSurname.heightAnchor.constraint(equalToConstant: 56).isActive = true
        tfSurname.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        tfSurname.topAnchor.constraint(equalTo: tfName.bottomAnchor, constant: 6).isActive = true
        tfSurname.layoutIfNeeded()
        
        
        
        tfPhone = myNewTextField()
        tfPhone.delegate = self
        tfPhone.keyboardType = .phonePad
        addDoneButtonOnKeyboard(textField: tfPhone)
        tfPhone.placeholder = "*Телефон..."
        
        self.view.addSubview(tfPhone)
        tfPhone.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1, constant: -56).isActive = true
        tfPhone.heightAnchor.constraint(equalToConstant: 56).isActive = true
        tfPhone.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        tfPhone.topAnchor.constraint(equalTo: tfSurname.bottomAnchor, constant: 6).isActive = true
        tfPhone.layoutIfNeeded()
        
        
        let btnRegister = fawButton()
        btnRegister.lbl.text = "Регистрация"
        btnRegister.lblIcon.text = myFawStrings.userPlus
        self.view.addSubview(btnRegister)
        
        btnRegister.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1, constant: -56).isActive = true
        btnRegister.heightAnchor.constraint(equalToConstant: 56).isActive = true
        btnRegister.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        btnRegister.topAnchor.constraint(equalTo: tfPhone.bottomAnchor, constant: 40).isActive = true
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
                self.makeRegister()
            }

    }
    
    
    func makeRegister()
    {
        let firstName = tfName.text!.trim()
        let lastName = tfSurname.text!.trim()
        let email = tfEmail.text!.trim()
        let password = tfPass.text!.trim()
        let phone = tfPhone.text!.trim()
        var fbId : String = ""
        
        if(firstName.isEmpty || lastName.isEmpty || email.isEmpty || password.isEmpty || phone.isEmpty)
        {
            gh.showToast(message: "Заполните все поля", view: self.view!)
            return
        }
        
        if(!gh.isValidEmail(testStr: email))
        {
            gh.showToast(message: "Введите корректный e-mail", view: self.view!)
            return
        }
        
        if(password.count < 8)
        {
            gh.showToast(message: "Пароль должен содержать минимум 8 символов", view: self.view!)
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password, completion:
            {
                (result,error) in
                guard let user = result?.user else
                {
                    self.gh.showToast(message: "Возникла ошибка при регистрации, возможно e-mail занят", view: self.view!)
                    return
                }
                
                fbId = user.uid
                
                user.sendEmailVerification(completion: nil)
                do
                {
                    try Auth.auth().signOut()
                }
                catch let error as NSError
                {
                    print (error)
                }
                
                
                let parameters : Parameters =
                    [
                        "Email" : email,
                        "Password" : password,
                        "Name" : firstName,
                        "Surname" : lastName,
                        "Phone" : phone,
                        "Fb_Id" : fbId
                    ]
                
                Alamofire.request(self.gh.INSERT_NEW_USER_URL,method: .post, parameters: parameters)
                
                self.dismiss(animated: true, completion:
                    {
                        self.present(LoginVC(), animated: true, completion: nil)
                    })
                
                
                
            }
        )
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    

    func addDoneButtonOnKeyboard(textField: UITextField)
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Закрыть", style: UIBarButtonItemStyle.done, target: self, action: #selector(doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        textField.inputAccessoryView = doneToolbar
    }
    
    
    
    @objc func doneButtonAction(textField : UITextField)
    {
        self.tfPhone.resignFirstResponder()
    }
    
    
    
    
    
    
    
    


}
