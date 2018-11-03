import UIKit
import RSSelectionMenu


class UploadDialogVC: UIViewController
{
    let gh = GlobalHelper.sharedInstance
    let gc = GlobalClass.sharedInstance
    var allRestaraunts : [Model_Restaraunt] = []
    var dropDownView : UIView!
    var restarauntNames : [String] = []
    var selectionMenu : RSSelectionMenu<String>!
    var simpleSelectedArray = [String]()
    var btnLbl : UILabel!
    
    func customInit()
    {
        self.modalPresentationStyle = .overCurrentContext
        super.viewDidLoad()
        
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
//        dialogView.heightAnchor.constraint(equalToConstant: 220).isActive = true
        dialogView.layoutIfNeeded()
        
        
        let redHeader = UIView()
        redHeader.translatesAutoresizingMaskIntoConstraints = false
        dialogView.addSubview(redHeader)
        redHeader.widthAnchor.constraint(equalTo: dialogView.widthAnchor, multiplier: 1).isActive = true
        redHeader.heightAnchor.constraint(equalToConstant: 46).isActive = true
        redHeader.centerXAnchor.constraint(equalTo: dialogView.centerXAnchor).isActive = true
        redHeader.topAnchor.constraint(equalTo: dialogView.topAnchor).isActive = true
        redHeader.layoutIfNeeded()
        
        let rectShape = CAShapeLayer()
        rectShape.bounds = redHeader.frame
        rectShape.position = redHeader.center
        rectShape.path = UIBezierPath(roundedRect: redHeader.bounds, byRoundingCorners: [.topRight, .topLeft], cornerRadii: CGSize(width: 8, height: 8)).cgPath
        
        redHeader.backgroundColor = gh.myRed
        redHeader.layer.mask = rectShape
        
        
        let titleView = otTableLabeCell()
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.textColor = gh.myBejColor
        titleView.textAlignment = .center
        titleView.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleView.text = "Отправка отчета"
        redHeader.addSubview(titleView)
        
        titleView.widthAnchor.constraint(equalTo: redHeader.widthAnchor).isActive = true
        titleView.heightAnchor.constraint(equalTo: redHeader.heightAnchor).isActive = true
        titleView.centerXAnchor.constraint(equalTo: redHeader.centerXAnchor).isActive = true
        titleView.centerYAnchor.constraint(equalTo: redHeader.centerYAnchor).isActive = true
        titleView.layoutIfNeeded()
        
        
        
        
        let shabName2 = otTableLabeCell()
        shabName2.translatesAutoresizingMaskIntoConstraints = false
        shabName2.textColor = gh.myRed
        shabName2.textAlignment = .center
        shabName2.font = UIFont.systemFont(ofSize: 17)
        shabName2.layer.borderColor = gh.myRed.cgColor
        shabName2.layer.borderWidth = 1
        shabName2.text = gc.otchetToUpload.name!
        shabName2.numberOfLines = 0
        dialogView.addSubview(shabName2)
        
        shabName2.widthAnchor.constraint(equalTo: dialogView.widthAnchor, multiplier: 0.5).isActive = true
//        shabName2.heightAnchor.constraint(equalToConstant: 28).isActive = true
        shabName2.rightAnchor.constraint(equalTo: dialogView.rightAnchor).isActive = true
        shabName2.topAnchor.constraint(equalTo: titleView.bottomAnchor).isActive = true
        shabName2.sizeToFit()
        shabName2.layoutIfNeeded()
        
        if(shabName2.frame.size.height < 28)
        {
            let heightCon = shabName2.constraints.filter
            {
                $0.firstAttribute == NSLayoutAttribute.height
            }
            NSLayoutConstraint.deactivate(heightCon)
            
            shabName2.heightAnchor.constraint(equalToConstant: 28).isActive = true
            shabName2.layoutIfNeeded()
        }
        
        
        let shabName = otTableLabeCell()
        shabName.translatesAutoresizingMaskIntoConstraints = false
        shabName.textColor = gh.myRed
        shabName.textAlignment = .center
        shabName.font = UIFont.systemFont(ofSize: 17)
        shabName.text = "Шаблон"
        shabName.layer.borderColor = gh.myRed.cgColor
        shabName.layer.borderWidth = 1
        dialogView.addSubview(shabName)
        
        shabName.widthAnchor.constraint(equalTo: dialogView.widthAnchor, multiplier: 0.5).isActive = true
        shabName.heightAnchor.constraint(equalTo: shabName2.heightAnchor, multiplier: 1).isActive = true
        shabName.leftAnchor.constraint(equalTo: dialogView.leftAnchor).isActive = true
        shabName.topAnchor.constraint(equalTo: titleView.bottomAnchor).isActive = true
        shabName.layoutIfNeeded()
        
        
        
        
        
        
        
        let auditorName2 = otTableLabeCell()
        auditorName2.translatesAutoresizingMaskIntoConstraints = false
        auditorName2.textColor = gh.myRed
        auditorName2.textAlignment = .center
        auditorName2.font = UIFont.systemFont(ofSize: 17)
        auditorName2.layer.borderColor = gh.myRed.cgColor
        auditorName2.layer.borderWidth = 1
        auditorName2.text = "\(gh.currentUser()[0]!) \(gh.currentUser()[1]!)"
        auditorName2.numberOfLines = 0
        dialogView.addSubview(auditorName2)
        
        auditorName2.widthAnchor.constraint(equalTo: dialogView.widthAnchor, multiplier: 0.5).isActive = true
        auditorName2.rightAnchor.constraint(equalTo: dialogView.rightAnchor).isActive = true
        auditorName2.topAnchor.constraint(equalTo: shabName.bottomAnchor).isActive = true
        auditorName2.sizeToFit()
        auditorName2.layoutIfNeeded()
        
        
        if(auditorName2.frame.size.height < 28)
        {
            let heightCon = auditorName2.constraints.filter
            {
                $0.firstAttribute == NSLayoutAttribute.height
            }
            NSLayoutConstraint.deactivate(heightCon)
            
            auditorName2.heightAnchor.constraint(equalToConstant: 28).isActive = true
            auditorName2.layoutIfNeeded()
        }
        
        
        
        let auditorName = otTableLabeCell()
        auditorName.translatesAutoresizingMaskIntoConstraints = false
        auditorName.textColor = gh.myRed
        auditorName.textAlignment = .center
        auditorName.font = UIFont.systemFont(ofSize: 17)
        auditorName.text = "Проверяющий"
        auditorName.layer.borderColor = gh.myRed.cgColor
        auditorName.layer.borderWidth = 1
        dialogView.addSubview(auditorName)
        
        auditorName.widthAnchor.constraint(equalTo: dialogView.widthAnchor, multiplier: 0.5).isActive = true
        auditorName.heightAnchor.constraint(equalTo: auditorName2.heightAnchor, multiplier: 1).isActive = true
        auditorName.leftAnchor.constraint(equalTo: dialogView.leftAnchor).isActive = true
        auditorName.topAnchor.constraint(equalTo: shabName.bottomAnchor).isActive = true
        auditorName.layoutIfNeeded()
        
        
        
        
        
        
        let lblPercent = otTableLabeCell()
        lblPercent.translatesAutoresizingMaskIntoConstraints = false
        lblPercent.textColor = gh.myRed
        lblPercent.textAlignment = .center
        lblPercent.font = UIFont.systemFont(ofSize: 17)
        lblPercent.text = "Успех"
        lblPercent.layer.borderColor = gh.myRed.cgColor
        lblPercent.layer.borderWidth = 1
        dialogView.addSubview(lblPercent)
        
        lblPercent.widthAnchor.constraint(equalTo: dialogView.widthAnchor, multiplier: 0.5).isActive = true
        lblPercent.heightAnchor.constraint(equalToConstant: 28).isActive = true
        lblPercent.leftAnchor.constraint(equalTo: dialogView.leftAnchor).isActive = true
        lblPercent.topAnchor.constraint(equalTo: auditorName.bottomAnchor).isActive = true
        lblPercent.layoutIfNeeded()
        
        let lblPercent2 = otTableLabeCell()
        lblPercent2.translatesAutoresizingMaskIntoConstraints = false
        lblPercent2.textColor = gh.myRed
        lblPercent2.textAlignment = .center
        lblPercent2.font = UIFont.systemFont(ofSize: 17)
        lblPercent2.layer.borderColor = gh.myRed.cgColor
        lblPercent2.layer.borderWidth = 1
        lblPercent2.text = "\(gc.otchetToUpload.percent!)%"
        dialogView.addSubview(lblPercent2)
        
        lblPercent2.widthAnchor.constraint(equalTo: dialogView.widthAnchor, multiplier: 0.5).isActive = true
        lblPercent2.heightAnchor.constraint(equalToConstant: 28).isActive = true
        lblPercent2.rightAnchor.constraint(equalTo: dialogView.rightAnchor).isActive = true
        lblPercent2.topAnchor.constraint(equalTo: auditorName.bottomAnchor).isActive = true
        lblPercent2.layoutIfNeeded()
        
        
        let btnShow = transButton()
        btnShow.setTitle("", for: .normal)
        dialogView.addSubview(btnShow)
        
        btnShow.widthAnchor.constraint(equalTo: dialogView.widthAnchor, multiplier: 1, constant: -12).isActive = true
        btnShow.heightAnchor.constraint(equalToConstant: 32).isActive = true
        btnShow.centerXAnchor.constraint(equalTo: dialogView.centerXAnchor).isActive = true
        btnShow.topAnchor.constraint(equalTo: lblPercent.bottomAnchor, constant: 8).isActive = true
        btnShow.layoutIfNeeded()
        
        
        btnLbl = UILabel()
        btnLbl.translatesAutoresizingMaskIntoConstraints = false
        btnLbl.textColor = gh.myRed
        btnLbl.textAlignment = .center
        btnLbl.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        btnLbl.text = "Выберите ресторан"
        dialogView.addSubview(btnLbl)
        
        btnLbl.widthAnchor.constraint(equalTo: btnShow.widthAnchor, multiplier: 1,constant: -40).isActive = true
        btnLbl.heightAnchor.constraint(equalTo: btnShow.heightAnchor).isActive = true
        btnLbl.centerYAnchor.constraint(equalTo: btnShow.centerYAnchor).isActive = true
        btnLbl.centerXAnchor.constraint(equalTo: btnShow.centerXAnchor).isActive = true
        btnLbl.layoutIfNeeded()
        
        
        let lblIcon = fawLabel()
        lblIcon.textColor = gh.myRed
        lblIcon.textAlignment = .center
        lblIcon.translatesAutoresizingMaskIntoConstraints = false
        lblIcon.text = myFawStrings.chevronDown
        lblIcon.font = lblIcon.font.withSize(20)
        
        dialogView.addSubview(lblIcon)
        
        lblIcon.widthAnchor.constraint(equalToConstant: 32).isActive = true
        lblIcon.heightAnchor.constraint(equalToConstant: 32).isActive = true
        lblIcon.rightAnchor.constraint(equalTo: btnShow.rightAnchor, constant: -4).isActive = true
        lblIcon.centerYAnchor.constraint(equalTo: btnShow.centerYAnchor).isActive = true
        lblIcon.layoutIfNeeded()
        
        
        let phpSqlHelper = PhpSqlHelper()
        phpSqlHelper.getAllRestaraunts
            {
                (restaraunts) in
                self.allRestaraunts = restaraunts
                self.loadRestarauntsView()
                btnShow.click =
                    {
                        self.selectionMenu.show(style: .Formsheet, from: self)
                    }
        }
        
        
        let btnOk = redButton()
        btnOk.setTitle("Отправить", for: .normal)
        dialogView.addSubview(btnOk)
        
        btnOk.widthAnchor.constraint(equalTo: dialogView.widthAnchor, multiplier: 0.5, constant: -9).isActive = true
        btnOk.heightAnchor.constraint(equalToConstant: 36).isActive = true
        btnOk.topAnchor.constraint(equalTo: btnShow.bottomAnchor, constant: 6).isActive = true
        btnOk.rightAnchor.constraint(equalTo: dialogView.rightAnchor, constant: -6).isActive = true
        btnOk.layoutIfNeeded()
        
        
        let btnCancel = transButton()
        btnCancel.setTitle("Отмена", for: .normal)
        dialogView.addSubview(btnCancel)
        
        btnCancel.widthAnchor.constraint(equalTo: dialogView.widthAnchor, multiplier: 0.5, constant: -9).isActive = true
        btnCancel.heightAnchor.constraint(equalToConstant: 36).isActive = true
        btnCancel.topAnchor.constraint(equalTo: btnShow.bottomAnchor, constant: 6).isActive = true
        btnCancel.leftAnchor.constraint(equalTo: dialogView.leftAnchor, constant: 6).isActive = true
        btnCancel.layoutIfNeeded()
        
        dialogView.bottomAnchor.constraint(equalTo: btnOk.bottomAnchor, constant: 6).isActive = true
        
        btnOk.click =
            {
                
                if(self.simpleSelectedArray.count == 0)
                {
                    self.gh.showToast(message: "Выберите ресторан", view: self.view!)
                    return
                }
                let selectedRestName = self.simpleSelectedArray[0]
                let index = self.restarauntNames.index(of: selectedRestName)
                if index == nil
                {
                    self.gh.showToast(message: "Index of restaraunt is nil!", view: self.view!)
                    return
                }
                
                let restarauntId  = self.allRestaraunts[index!].id!
                
                self.gc.otchetToUpload.restarauntId = restarauntId
                
                btnOk.isEnabled = false
                Dialog.shIn.show(message: "Отправка отчета", view: (UIApplication.topViewController()?.view)!)
                
                let upClass = UploadOthcetClass()
                upClass.upload(finishedVoid:
                    {(answer) in 
                        btnOk.isEnabled = true
                        Dialog.shIn.hide(afterTime: 0.2)
                        
                        var mess = ""
                        if(answer == "success")
                        {
                            mess = "Успешно отправлено"
                        }
                        else if(answer == "error")
                        {
                            mess = "Ошибка при отправке, повторите позже"
                        }
                        
                        self.dismiss(animated: true, completion:
                            {
                                self.gh.showToast(message: mess, view: (UIApplication.topViewController()?.view!)!)
                                
                            })
                    })
                
        }
        
        btnCancel.click =
            {
                self.dismiss(animated: true, completion: nil)
            }
        

    }
    
    func loadRestarauntsView()
    {
        for rest in allRestaraunts
        {
            restarauntNames.append(rest.name!)
        }
        selectionMenu =  RSSelectionMenu(dataSource: restarauntNames)
        { (cell, object, indexPath) in
            cell.textLabel?.text = object
            cell.tintColor = self.gh.myRed
        }
        
        selectionMenu.setSelectedItems(items: simpleSelectedArray)
        { (text, isSelected, selectedItems) in
            
            self.simpleSelectedArray = selectedItems
            self.btnLbl.text = self.simpleSelectedArray[0]
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
