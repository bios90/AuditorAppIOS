import UIKit

class AuditorNameVC: UIViewController, UITextFieldDelegate
{
    let gh = GlobalHelper.sharedInstance
    let gc = GlobalClass.sharedInstance
    
    var currentShablon : Model_Shablon!
    var btnOk : redButton!
    
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
        dialogView.heightAnchor.constraint(equalToConstant: 124).isActive = true
        dialogView.layoutIfNeeded()
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = gh.myRed
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.text = "Введите ваши Ф.И.О."
        dialogView.addSubview(lbl)
        
        lbl.heightAnchor.constraint(equalToConstant: 36).isActive = true
        lbl.widthAnchor.constraint(equalTo: dialogView.widthAnchor, multiplier: 1, constant: -12).isActive = true
        lbl.topAnchor.constraint(equalTo: dialogView.topAnchor, constant: 4).isActive = true
        lbl.centerXAnchor.constraint(equalTo: dialogView.centerXAnchor).isActive = true
        lbl.layoutIfNeeded()
        
        
        
        let tf = myTextFieldOneLine()
        tf.placeholder = "Фамилия.. Имя.. Отчество.."
        dialogView.addSubview(tf)
        
        tf.widthAnchor.constraint(equalTo: dialogView.widthAnchor, multiplier: 1, constant: -12).isActive = true
        tf.heightAnchor.constraint(equalToConstant: 36).isActive = true
        tf.topAnchor.constraint(equalTo: lbl.bottomAnchor, constant: 4).isActive = true
        tf.centerXAnchor.constraint(equalTo: dialogView.centerXAnchor).isActive = true
        tf.layoutIfNeeded()
        
        tf.delegate = self
        
        
        
        btnOk = redButton()
        btnOk.setTitle("Начать", for: .normal)
        dialogView.addSubview(btnOk)
        
        btnOk.widthAnchor.constraint(equalTo: dialogView.widthAnchor, multiplier: 0.5, constant: -9).isActive = true
        btnOk.heightAnchor.constraint(equalToConstant: 36).isActive = true
        btnOk.bottomAnchor.constraint(equalTo: dialogView.bottomAnchor, constant: -4).isActive = true
        btnOk.rightAnchor.constraint(equalTo: dialogView.rightAnchor, constant: -6).isActive = true
        btnOk.layoutIfNeeded()
        
        
        let btnCancel = transButton()
        btnCancel.setTitle("Отмена", for: .normal)
        dialogView.addSubview(btnCancel)
        
        btnCancel.widthAnchor.constraint(equalTo: dialogView.widthAnchor, multiplier: 0.5, constant: -9).isActive = true
        btnCancel.heightAnchor.constraint(equalToConstant: 36).isActive = true
        btnCancel.bottomAnchor.constraint(equalTo: dialogView.bottomAnchor, constant: -4).isActive = true
        btnCancel.leftAnchor.constraint(equalTo: dialogView.leftAnchor, constant: 6).isActive = true
        btnCancel.layoutIfNeeded()
        
        btnOk.click =
            {
                if tf.text != nil && tf.text != ""
                {
                    self.gc.auditorName = tf.text
                    self.gc.shablonToBegin = self.currentShablon
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let controller = storyboard.instantiateViewController(withIdentifier: "beginAudit")
                    self.present(controller, animated: true, completion: nil)
                }
                else
                {
                    self.gh.showToast(message: "Введите ваши Ф.И.О.", view: self.view!)
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
    
    
    
    init(shablon : Model_Shablon)
    {
        super.init(nibName: nil, bundle: nil)
        currentShablon = shablon
        customInit()
    }
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        customInit()
    }
    
    
    
}
