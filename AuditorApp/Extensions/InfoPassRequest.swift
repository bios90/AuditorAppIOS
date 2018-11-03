import UIKit

class InfoPassRequest: UIViewController, UITextFieldDelegate
{
    
    let gh = GlobalHelper.sharedInstance
    let gc = GlobalClass.sharedInstance
    
    var currentShablon : Model_Shablon!
    var btnOk : redButton!
    var tf:UITextField!
    
    func customInit()
    {
        self.modalPresentationStyle = .overCurrentContext
        view.backgroundColor = UIColor.clear
        
        let darkView = UIView()
        darkView.backgroundColor = UIColor.black
        darkView.alpha = 0.8
        darkView.frame = view.bounds
        darkView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        view.addSubview(darkView)
        
        let dialogView = myAuditView()
        view.insertSubview(dialogView, at: 1)
        
        dialogView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dialogView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        dialogView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9, constant: 0).isActive = true
        //dialogView.heightAnchor.constraint(equalToConstant: 124).isActive = true
        //dialogView.layoutIfNeeded()
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = gh.myRed
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.text = "Введите пароль аудитора"
        dialogView.addSubview(lbl)
        
        lbl.heightAnchor.constraint(equalToConstant: 36).isActive = true
        lbl.widthAnchor.constraint(equalTo: dialogView.widthAnchor, multiplier: 1, constant: -12).isActive = true
        lbl.topAnchor.constraint(equalTo: dialogView.topAnchor, constant: 4).isActive = true
        lbl.centerXAnchor.constraint(equalTo: dialogView.centerXAnchor).isActive = true
        lbl.layoutIfNeeded()
        
        
        
        tf = myTextFieldOneLine()
        tf.placeholder = "Пароль..."
        tf.textAlignment = .center
        dialogView.addSubview(tf)
        
        tf.widthAnchor.constraint(equalTo: dialogView.widthAnchor, multiplier: 1, constant: -12).isActive = true
        tf.heightAnchor.constraint(equalToConstant: 36).isActive = true
        tf.topAnchor.constraint(equalTo: lbl.bottomAnchor, constant: 4).isActive = true
        tf.centerXAnchor.constraint(equalTo: dialogView.centerXAnchor).isActive = true
        tf.layoutIfNeeded()
        
        tf.isSecureTextEntry = true
        
        tf.delegate = self
        
        tf.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        
        
        btnOk = redButton()
        btnOk.setTitle("Ок", for: .normal)
        dialogView.addSubview(btnOk)
        
        btnOk.widthAnchor.constraint(equalTo: dialogView.widthAnchor, multiplier: 0.5, constant: -9).isActive = true
        btnOk.heightAnchor.constraint(equalToConstant: 36).isActive = true
        btnOk.topAnchor.constraint(equalTo: tf.bottomAnchor, constant: 12).isActive = true
        //btnOk.bottomAnchor.constraint(equalTo: dialogView.bottomAnchor, constant: -4).isActive = true
        btnOk.rightAnchor.constraint(equalTo: dialogView.rightAnchor, constant: -6).isActive = true
        btnOk.layoutIfNeeded()
        
        
        let btnCancel = transButton()
        btnCancel.setTitle("Отмена", for: .normal)
        dialogView.addSubview(btnCancel)
        
        btnCancel.widthAnchor.constraint(equalTo: dialogView.widthAnchor, multiplier: 0.5, constant: -9).isActive = true
        btnCancel.heightAnchor.constraint(equalToConstant: 36).isActive = true
        btnCancel.topAnchor.constraint(equalTo: tf.bottomAnchor, constant: 12).isActive = true
        //btnCancel.bottomAnchor.constraint(equalTo: dialogView.bottomAnchor, constant: -4).isActive = true
        btnCancel.leftAnchor.constraint(equalTo: dialogView.leftAnchor, constant: 6).isActive = true
        btnCancel.layoutIfNeeded()
        
        dialogView.bottomAnchor.constraint(equalTo: btnOk.bottomAnchor, constant: 6).isActive = true
        dialogView.layoutIfNeeded()
        
        btnOk.click =
            {
                if self.tf.text != nil && self.tf.text == "337321"
                {
                    self.dismiss(animated: false, completion:
                        {
                            self.present(howToWorkVC(), animated:  true, completion: nil)
                        })
                    
                    
                }
                else
                {
                    self.gh.showToast(message: "Пароль не верен", view: self.view)
                }
        }
        
        btnCancel.click =
            {
                self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        
        textField.resignFirstResponder()
        btnOk.click?()
        return true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField)
    {
        if self.tf.text != nil && self.tf.text == "337321"
        {
            self.present(howToWorkVC(), animated: true, completion: nil)
        }
    }
    
    
    
    init()
    {
        super.init(nibName: nil, bundle: nil)
        customInit()
    }
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        customInit()
    }
    

}
