import UIKit

class FinishAuditDialogVC: UIViewController
{

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
        dialogView.heightAnchor.constraint(equalToConstant: 104).isActive = true
        dialogView.layoutIfNeeded()
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = gh.myRed
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.text = "Выйти из аудита? Несохраненный прогресс будет потерян."
        dialogView.addSubview(lbl)
        
        lbl.heightAnchor.constraint(equalToConstant: 60).isActive = true
        lbl.widthAnchor.constraint(equalTo: dialogView.widthAnchor, multiplier: 1, constant: -12).isActive = true
        lbl.topAnchor.constraint(equalTo: dialogView.topAnchor, constant: 4).isActive = true
        lbl.centerXAnchor.constraint(equalTo: dialogView.centerXAnchor).isActive = true
        lbl.layoutIfNeeded()
        
        
        let btnOk = redButton()
        btnOk.setTitle("Выйти", for: .normal)
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
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                let controller = storyboard.instantiateViewController(withIdentifier: "userMenu")
//                self.present(controller, animated: true, completion: nil)
                self.present(NewMainMenu(), animated: true, completion: nil)

            }
        
        btnCancel.click =
            {
                self.dismiss(animated: true, completion: nil)
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
