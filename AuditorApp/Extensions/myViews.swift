import UIKit
import M13Checkbox
import StepSlider
import BetterSegmentedControl
import Tabman
import JGProgressHUD
import Font_Awesome_Swift
import FontAwesome_swift




class fawLabel : UILabel
{
    let gh = GlobalHelper.sharedInstance
    var click : (() -> Void)?
    
    func customInit()
    {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textColor = gh.myBejColor
        self.font = gh.fawSolid
        self.font = self.font.withSize(26)
        self.textAlignment = .center
        
        let tg = UITapGestureRecognizer(target: self, action: #selector(self.pressed))
        self.isUserInteractionEnabled = false
        self.addGestureRecognizer(tg)
    }
    
    
    @objc func pressed()
    {
        click?()
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        customInit()
    }
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        customInit()
    }
}


class userNameView : UIView
{
    let gh = GlobalHelper.sharedInstance
    var exitClick : (() -> Void)?
    
    func customInit()
    {
        self.backgroundColor = gh.myRedTrans
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let lblIcon = UILabel()
        lblIcon.textColor = gh.myRed
        lblIcon.textAlignment = .center
        lblIcon.translatesAutoresizingMaskIntoConstraints = false
        lblIcon.backgroundColor = gh.myBejColor
        lblIcon.layer.masksToBounds = true
        lblIcon.layer.cornerRadius = 4
        lblIcon.setFAIcon(icon: .FAUser, iconSize: 36)
        
        self.addSubview(lblIcon)
        
        lblIcon.widthAnchor.constraint(equalToConstant: 40).isActive = true
        lblIcon.heightAnchor.constraint(equalToConstant: 40).isActive = true
        lblIcon.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 6).isActive = true
        lblIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        lblIcon.layoutIfNeeded()
        
        let btnExit = UIButton()
        btnExit.translatesAutoresizingMaskIntoConstraints = false
        btnExit.setTitle("Выйти", for: .normal)
        btnExit.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        btnExit.layer.cornerRadius = 16
        btnExit.backgroundColor = gh.myRed
        btnExit.setTitleColor(UIColor.white, for: .normal)
        self.addSubview(btnExit)
        
        btnExit.heightAnchor.constraint(equalToConstant: 36).isActive = true
        btnExit.widthAnchor.constraint(equalToConstant: 96).isActive = true
        btnExit.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -6).isActive = true
        btnExit.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        btnExit.layoutIfNeeded()
        
        btnExit.addTarget(self, action: #selector(self.exitPressed), for: .touchUpInside)
        
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "\(gh.currentUser()[0]!) \(gh.currentUser()[1]!)"
        nameLabel.textColor = gh.myBejColor
        nameLabel.font = UIFont.systemFont(ofSize: 16)
        self.addSubview(nameLabel)
        
        nameLabel.leftAnchor.constraint(equalTo: lblIcon.rightAnchor, constant: 4).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: btnExit.leftAnchor, constant: -4).isActive = true
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 4).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4).isActive = true
        nameLabel.layoutIfNeeded()
        
        
    
    }
    
    @objc func exitPressed()
    {
        exitClick?()
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        customInit()
    }
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        customInit()
    }
    
}

class pdfHeader : UIView
{
    let gh = GlobalHelper.sharedInstance
    var backClick : (() -> Void)?
    var titleView : UILabel!
    
    func customInit()
    {
        self.backgroundColor = gh.myRed
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let btnArrow = UIButton()
        let arrowImage = UIImage(named: "ic_leftArrow")
        btnArrow.setImage(arrowImage, for: .normal)
        btnArrow.translatesAutoresizingMaskIntoConstraints = false
        btnArrow.addTarget(self, action: #selector(self.arrowPressed), for: .touchUpInside)
        
        self.addSubview(btnArrow)
        btnArrow.widthAnchor.constraint(equalToConstant: 36).isActive = true
        btnArrow.heightAnchor.constraint(equalToConstant: 36).isActive = true
        btnArrow.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 4).isActive = true
        btnArrow.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        btnArrow.layoutIfNeeded()
        
        titleView = UILabel()
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.textColor = gh.myBejColor
        titleView.textAlignment = .center
        titleView.font = UIFont.systemFont(ofSize: 18)
        titleView.text = "Руководство по приложению"
        
        self.addSubview(titleView)
        titleView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -80).isActive = true
        titleView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        titleView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        titleView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleView.layoutIfNeeded()
    }
    
    @objc func arrowPressed()
    {
        backClick?()
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        customInit()
    }
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        customInit()
    }
}

class myRotateImg : UIImageView
{
    let gh = GlobalHelper.sharedInstance
    var click : (() -> Void)?
    
    func customInit()
    {
        self.image = UIImage(named: "ic_arrowUp")
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.backgroundColor = gh.myRed.cgColor
        self.layer.cornerRadius = 36 / 2
        self.isUserInteractionEnabled = true
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.taped))
        self.addGestureRecognizer(gesture)
    }
    
    @objc func taped(sender : UITapGestureRecognizer)
    {
        click?()
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        customInit()
    }
}

class myObyazImage : UIImageView
{
    func customInit()
    {
        image = UIImage(named: "ic_warning")
        translatesAutoresizingMaskIntoConstraints = false
    }

    init()
    {
        super.init(frame : CGRect(x: 8, y: 8, width: 8, height: 8))
        customInit()
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        customInit()
    }
    
}

class myAuditView : UIView
{
    let gh = GlobalHelper.sharedInstance
    var click : (() -> Void)?
    
    func customInit()
    {
        tag = gh.tagMyAuditView
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.white
        gh.makeLittleCorners(viewArray: [self], radius: 8)
        gh.addShadow(viewArray: [self])
        
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.taped))
        addGestureRecognizer(gesture)
    }
    
    @objc func taped(sender : UITapGestureRecognizer)
    {
        click?()
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        customInit()
    }
}

class mySkrepkaButton : UIButton
{
    let gh = GlobalHelper.sharedInstance
    var click : (() -> Void)?
    
    func customInit()
    {
        setImage(UIImage(named: "ic_clip_red"), for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
        
        addTarget(self, action: #selector(pressed), for: .touchUpInside)
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        customInit()
    }
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        customInit()
    }
    
    @objc func pressed()
    {
        click?()
    }
}

class myCommentButton : UIButton
{
    let gh = GlobalHelper.sharedInstance
    var click : (() -> Void)?
    
    func customInit()
    {
        setImage(UIImage(named: "ic_comment"), for: .normal)
        //backgroundColor = UIColor.white
        translatesAutoresizingMaskIntoConstraints = false
        //gh.addShadow(viewArray: [self])
        //gh.makeLittleCorners(viewArray: [self], radius: 4)
        
        addTarget(self, action: #selector(pressed), for: .touchUpInside)
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        customInit()
    }
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        customInit()
    }
    
    @objc func pressed()
    {
        click?()
    }
}

class myAddPhotoButton : UIButton
{
    let gh = GlobalHelper.sharedInstance
    var click : (() -> Void)?
    
    func customInit()
    {
        setImage(UIImage(named: "ic_add_photo_red"), for: .normal)
        translatesAutoresizingMaskIntoConstraints = false

        addTarget(self, action: #selector(pressed), for: .touchUpInside)
    }
    
    @objc func pressed()
    {
        click?()
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        customInit()
    }
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        customInit()
    }
}

class myLabelForText : UILabel
{
    let gh = GlobalHelper.sharedInstance
    var tapActon : (() -> Void)?
    
    func customInit()
    {
        tag = gh.tagMyLabel
        
        translatesAutoresizingMaskIntoConstraints = false
        gh.setFont(viewArray: [self], size: gh.sizeMiddle)
        textColor = gh.myRed
        textAlignment = .center
        numberOfLines = 0
        sizeToFit()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.lablePressed))
        isUserInteractionEnabled = false
        addGestureRecognizer(tap)
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        customInit()
    }
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        customInit()
    }
    
    @objc func lablePressed()
    {
        tapActon?()
    }
}

class myBtnTogg : UIButton
{
    let gh = GlobalHelper.sharedInstance
    var isOn = false
    let myRed = GlobalHelper.sharedInstance.myRed.cgColor
    let myBej = GlobalHelper.sharedInstance.myBejColor.cgColor
    var click : (() -> Void)?
    
    
    func customInit()
    {
        layer.borderColor = myRed
        layer.borderWidth = 2.0
        layer.cornerRadius = 6
        
        translatesAutoresizingMaskIntoConstraints = false
        
        setTitleColor(UIColor(cgColor: myRed), for: .normal)
        addTarget(self, action:#selector(myBtnTogg.buttonPresed), for: .touchUpInside)
        
        titleLabel?.minimumScaleFactor = 0.5
        titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    @objc func buttonPresed()
    {
        self.isOn = !isOn
        onOffTogg()
        click?()
    }
    
    func onOffTogg()
    {
        if isOn
        {
            layer.backgroundColor = myRed
            setTitleColor(UIColor(cgColor: myBej), for: .normal)
        }
        else
        {
            layer.backgroundColor = UIColor.clear.cgColor
            setTitleColor(UIColor(cgColor: myRed), for: .normal)
        }
    }
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        customInit()
    }
    
}

class myTypeImage : UIImageView
{
    let gh = GlobalHelper.sharedInstance
    var type : Int?
    
    func customInit()
    {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = gh.myRed
        layer.cornerRadius = 18
        switch type!
        {
        case gh.typeQuestion:
            image = UIImage(named: "ic_question_bej")
        case gh.typeAdress :
            image = UIImage(named: "ic_adress_bej")
        case gh.typeDate:
            image = UIImage(named: "ic_date_bej")
        case gh.typeCheckBox:
            image = UIImage(named: "ic_checkbox_bej")
        default:
            break
        }
    }
    
    init(typeInt : Int)
    {
        super.init(frame : CGRect(x: 8, y: 8, width: 8, height: 8))
        self.type = typeInt
        customInit()
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        customInit()
    }
}

class myTextFieldOneLine: UITextField
{
    let gh = GlobalHelper.sharedInstance
    
    func customInit()
    {
        translatesAutoresizingMaskIntoConstraints = false
        gh.setFont(viewArray: [self], size: gh.sizeMiddleMinus1)
        textColor = gh.myRed
        textAlignment = .left
        sizeToFit()
        backgroundColor = UIColor.white
        gh.addShadow(viewArray: [self])
        gh.makeLittleCorners(viewArray: [self], radius: 6)
        placeholder = "Введите ответ..."
        
        returnKeyType = .done
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 8, y: bounds.origin.y, width: bounds.width - 16, height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 8, y: bounds.origin.y, width: bounds.width - 16, height: bounds.height)
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        customInit()
    }
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        customInit()
    }
}


class mySwitch : BetterSegmentedControl
{
    let gh = GlobalHelper.sharedInstance
    var click : (() -> Void)?
    
    func customInit()
    {
        translatesAutoresizingMaskIntoConstraints = false

        addTarget(self, action: #selector(mySwitch.changed), for: .valueChanged)
        
    }
    
    @objc func changed()
    {
        switch index
        {
        case 0:
            self.backgroundColor = gh.myRedTrans
        case 1 :
            self.backgroundColor = gh.myRed
        default:
            break
        }
        click?()
    }
    
    override init(frame: CGRect, titles: [String], index: UInt, options: [BetterSegmentedControlOption]?)
    {
        super.init(frame: frame, titles: ["Нет","Да"], index: 1, options: [.backgroundColor(gh.myRed),
                                                                      .titleColor(gh.myBejColor),
                                                                      .indicatorViewBackgroundColor(gh.myBejColor),
                                                                      .selectedTitleColor(gh.myRed),
                                                                      .indicatorViewInset(4),
                                                                      .cornerRadius(6),
                                                                      .titleFont(UIFont(name: "HelveticaNeue", size: 14.0)!),
                                                                      .selectedTitleFont(UIFont(name: "HelveticaNeue-Medium", size: 18)!)])
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        customInit()
    }
}


class myCheckBox : M13Checkbox
{
    let gh = GlobalHelper.sharedInstance
    
    func customInit()
    {
        translatesAutoresizingMaskIntoConstraints = false
        markType = .checkmark
        boxType = .square
        tintColor = gh.myRed
        boxLineWidth = 3.0
        checkmarkLineWidth = 3.0
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        customInit()
    }
}

class myDateDialog : UIView
{
    let gh = GlobalHelper.sharedInstance
    
    var mdate : Model_Date!
    var lbl : UILabel!
    var dPicker : UIDatePicker!
    
    func customInit()
    {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        
        let darkView = UIView()
        darkView.backgroundColor = UIColor.black
        darkView.alpha = 0.5
        darkView.frame = bounds
        darkView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        self.addSubview(darkView)
        
        let dialogView = myAuditView()
        insertSubview(dialogView, at: self.subviews.count)
        
        dialogView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        dialogView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        dialogView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85, constant: 0).isActive = true
        dialogView.heightAnchor.constraint(equalToConstant: 256).isActive = true
        
        let datePicker = myDatePick()
        dialogView.addSubview(datePicker)
        self.dPicker = datePicker
        
        if mdate.showTime == 1 && mdate.showDate == 1
        {
            datePicker.datePickerMode = .dateAndTime
        }
        else if mdate.showTime == 1
        {
            datePicker.datePickerMode = .time
        }
        else if mdate.showDate == 1
        {
            datePicker.datePickerMode = .date
        }
        
        datePicker.topAnchor.constraint(equalTo: dialogView.topAnchor, constant: 8).isActive = true
        datePicker.widthAnchor.constraint(equalTo: dialogView.widthAnchor, constant: -16).isActive = true
        datePicker.heightAnchor.constraint(equalToConstant: 200).isActive = true
        datePicker.leftAnchor.constraint(equalTo: dialogView.leftAnchor, constant: 8).isActive = true
        
        let okBtn = redButton()
        dialogView.addSubview(okBtn)
        okBtn.setTitle("Добавить", for: .normal)
        
        okBtn.widthAnchor.constraint(equalTo: datePicker.widthAnchor, multiplier: 0.5, constant: -4).isActive = true
        okBtn.rightAnchor.constraint(equalTo: datePicker.rightAnchor).isActive = true
        okBtn.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 8).isActive = true
        okBtn.widthAnchor.constraint(equalToConstant: 36).isActive = true
        
        let cancelButton = transButton()
        dialogView.addSubview(cancelButton)
        cancelButton.setTitle("Отмена", for: .normal)
        
        cancelButton.widthAnchor.constraint(equalTo: datePicker.widthAnchor, multiplier: 0.5, constant: -4).isActive = true
        cancelButton.leftAnchor.constraint(equalTo: datePicker.leftAnchor).isActive = true
        cancelButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 8).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 36).isActive = true
        
//        okBtn.addTarget(self, action: #selector(myDateDialog.okPressed), for: .touchUpInside)
//        cancelButton.addTarget(self, action: #selector(myDateDialog.cancelPressed), for: .touchUpInside)
        
        okBtn.click =
            {
                let dateFormatter = DateFormatter()
                if self.mdate.showDate == 1 && self.mdate.showTime == 1
                {
                    dateFormatter.dateFormat = "dd.MM.yy HH:mm"
                }
                else if self.mdate.showTime == 1
                {
                    dateFormatter.dateFormat = "HH:mm"
                }
                else if self.mdate.showDate == 1
                {
                    dateFormatter.dateFormat = "dd.MM.yyyy"
                }
                let dateStr = dateFormatter.string(from: self.dPicker.date)
                self.lbl.text = dateStr
                self.mdate.selectedDate = self.dPicker.date
                self.removeFromSuperview()
            }
        
    }
    
    @objc func okPressed()
    {
        let dateFormatter = DateFormatter()
        if mdate.showDate == 1 && mdate.showTime == 1
        {
            dateFormatter.dateFormat = "dd.MM.yy HH:mm"
        }
        else if mdate.showTime == 1
        {
            dateFormatter.dateFormat = "HH:mm"
        }
        else if mdate.showDate == 1
        {
            dateFormatter.dateFormat = "dd.MM.yyyy"
        }
        let dateStr = dateFormatter.string(from: dPicker.date)
        lbl.text = dateStr
        self.removeFromSuperview()
    }
    
    @objc func cancelPressed()
    {
        self.removeFromSuperview()
    }
    
    init(mDate : Model_Date, lblForDate : UILabel)
    {
        super.init(frame: CGRect(x: 8, y: 8, width: 8, height: 8))
        mdate = mDate
        lbl = lblForDate
        customInit()
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        customInit()
    }
}

class myDatePick : UIDatePicker
{
    let gh = GlobalHelper.sharedInstance
    
    
    func customInit()
    {
        translatesAutoresizingMaskIntoConstraints = false
        timeZone = NSTimeZone.local
        backgroundColor = UIColor.white
        setValue(gh.myRed, forKey: "textColor")
        datePickerMode = .date
        self.locale = Locale(identifier: "ru")
        layer.masksToBounds = true
        layer.cornerRadius = 6
        layer.borderWidth = 1
        layer.borderColor = gh.myRed.cgColor
        gh.addShadow(viewArray: [self])
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        customInit()
    }
}

class transButton : UIButton
{
    let gh = GlobalHelper.sharedInstance
    var click : (() -> Void)?
    
    func customInit()
    {
        
        layer.borderColor = gh.myRed.cgColor
        layer.borderWidth = 2.0
        layer.cornerRadius = 6
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        setTitleColor(UIColor(cgColor: gh.myRed.cgColor), for: .normal)
        setTitle("Отмена", for: .normal)
        
        addTarget(self, action: #selector(transButton.btnPressed), for: .touchUpInside)
    }
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        customInit()
    }
    
    @objc func btnPressed()
    {
        click?()
    }
}

class myInfoButton : UIButton
{
    let gh = GlobalHelper.sharedInstance
    var click : (() -> Void)?
    var lblTitle : UILabel!
    var imgV : UIImageView!
    
    func customInit()
    {
        layer.cornerRadius = 6
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = gh.myRed
        setTitleColor(UIColor(cgColor: gh.myBejColor.cgColor), for: .normal)
//        self.setTitle("Как работать с приложением", for: .normal)
        
        addTarget(self, action: #selector(redButton.btnPressed), for: .touchUpInside)

    
        lblTitle = UILabel()
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        lblTitle.textColor = UIColor.white
        lblTitle.textAlignment = .center
        lblTitle.numberOfLines = 0
        lblTitle.text = "А.Л.И.С.А. Информация"
        lblTitle.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        lblTitle.sizeToFit()
        addSubview(lblTitle)
        
        lblTitle.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1, constant: -72).isActive = true
        lblTitle.heightAnchor.constraint(equalToConstant: 36).isActive = true
        lblTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        lblTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        lblTitle.layoutIfNeeded()
        
        
        imgV = UIImageView(image: UIImage(named: "ic_info_bej"))
        imgV.backgroundColor = gh.myRed
        imgV.layer.cornerRadius = 16
        imgV.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imgV)
        
        imgV.widthAnchor.constraint(equalToConstant: 36).isActive = true
        imgV.heightAnchor.constraint(equalToConstant: 36).isActive = true
        imgV.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imgV.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -4).isActive = true
        imgV.layoutIfNeeded()
    }
    
    @objc func btnPressed()
    {
        click?()
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        customInit()
    }
}

class myNewTextField : UITextField
{
    let gh = GlobalHelper.sharedInstance
    
    var click : (()->Void)?
    
    func customInit()
    {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.white
        self.textAlignment = .center
        self.font = UIFont.systemFont(ofSize: 18)
        self.textColor = gh.myRed
        self.returnKeyType = .done
        
        gh.makeLittleCorners(viewArray: [self], radius: 8)
        gh.addShadow(viewArray: [self])
    }

    override init(frame: CGRect)
    {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        customInit()
    }
}

class fawButton : UIView
{
    let gh = GlobalHelper.sharedInstance
    var lblIcon : UILabel!
    var lbl : UILabel!
    
    var click : (()->Void)?
    
    func customInit()
    {
        tag = gh.tagViewAsLabel
        translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 8
        backgroundColor = gh.myRed
        
        lbl = myLabelForText()
        lbl.text = "Войти"
        lbl.textColor = UIColor.white
        self.addSubview(lbl)
        
        lbl.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -86).isActive = true
        lbl.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1, constant: 0).isActive = true
        lbl.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        lbl.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        lbl.layoutIfNeeded()
        
        
        self.lblIcon = fawLabel()
        self.lblIcon.textColor = gh.myBejColor
        self.lblIcon.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(lblIcon)
        
        lblIcon.widthAnchor.constraint(equalToConstant: 36).isActive = true
        lblIcon.heightAnchor.constraint(equalToConstant: 36).isActive = true
        lblIcon.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -6).isActive = true
        lblIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        lblIcon.layoutIfNeeded()
        
        let gr = UITapGestureRecognizer(target: self, action: #selector(recognize))
        self.addGestureRecognizer(gr)
        
        
        gh.addShadow(viewArray: [self])
    }
    
    
    @objc func recognize()
    {
        click?()
    }
    
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        customInit()
    }
}


//class fawRedButton : UIButton
//{
//    let gh = GlobalHelper.sharedInstance
//    var lblIcon : UILabel!
//    var click : (() -> Void)?
//
//    func customInit()
//    {
//        self.layer.cornerRadius = 6
//
//        self.translatesAutoresizingMaskIntoConstraints = false
//        self.backgroundColor = gh.myRed
//        self.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
//        self.setTitleColor(UIColor(cgColor: gh.myBejColor.cgColor), for: .normal)
//        self.setTitle("Ок", for: .normal)
//
//        self.lblIcon = UILabel()
//        self.lblIcon.textColor = gh.myBejColor
//        self.lblIcon.translatesAutoresizingMaskIntoConstraints = false
//        self.lblIcon.setFAIcon(icon: .FAGithub, iconSize: 26)
//
//        self.addSubview(lblIcon)
//
//        lblIcon.widthAnchor.constraint(equalToConstant: 36).isActive = true
//        lblIcon.heightAnchor.constraint(equalToConstant: 36).isActive = true
//        lblIcon.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -6).isActive = true
//        lblIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
//        lblIcon.layoutIfNeeded()
//
//        addTarget(self, action: #selector(redButton.btnPressed), for: .touchUpInside)
//    }
//
//    @objc func btnPressed()
//    {
//        click?()
//    }
//
//    override init(frame: CGRect)
//    {
//        super.init(frame: frame)
//        customInit()
//    }
//
//    required init?(coder aDecoder: NSCoder)
//    {
//        super.init(coder: aDecoder)
//        customInit()
//    }
//}

class redButton : UIButton
{
    let gh = GlobalHelper.sharedInstance
    var click : (() -> Void)?
    
    func customInit()
    {
        layer.cornerRadius = 6
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = gh.myRed
        setTitleColor(UIColor(cgColor: gh.myBejColor.cgColor), for: .normal)
        setTitle("Ок", for: .normal)
        
        addTarget(self, action: #selector(redButton.btnPressed), for: .touchUpInside)
    }
    
    @objc func btnPressed()
    {
        click?()
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        customInit()
    }
}

class myDatePickerBtn : UIButton
{
    let gh  = GlobalHelper.sharedInstance
    var date : Model_Date?
    var lbl : myLabelForText?
    var mainView : UIView?
    
    func customInit()
    {
        layer.cornerRadius = 6
        
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = gh.myRed
        setTitleColor(UIColor(cgColor: gh.myBejColor.cgColor), for: .normal)
        addTarget(self, action:#selector(myDatePickerBtn.dateButtonPresed), for: .touchUpInside)
    }
    
    init(mDate : Model_Date, lblToShow : myLabelForText, vcRootView : UIView)
    {
        super.init(frame: CGRect(x: 8, y: 8, width: 8, height: 8))
        date = mDate
        lbl = lblToShow
        mainView = vcRootView
        customInit()
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        customInit()
    }
    
    @objc func dateButtonPresed()
    {
        let dialog = myDateDialog(mDate: date!, lblForDate: lbl!)
        mainView?.addSubview(dialog)
        
        dialog.widthAnchor.constraint(equalTo: (mainView?.widthAnchor)!, multiplier: 1).isActive = true
        dialog.heightAnchor.constraint(equalTo: (mainView?.heightAnchor)!, multiplier: 1).isActive = true
        dialog.centerYAnchor.constraint(equalTo: (mainView?.centerYAnchor)!).isActive = true
        dialog.centerXAnchor.constraint(equalTo: (mainView?.centerXAnchor)!).isActive = true
    }
}

class infoImageView : UIImageView
{
    let gh = GlobalHelper.sharedInstance
    
    func customInit()
    {
        tag = gh.tagInfoImge
        translatesAutoresizingMaskIntoConstraints = false
        gh.addShadow(viewArray: [self])
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        customInit()
    }
}

class myGalleryButton : UIButton
{
    let gh  = GlobalHelper.sharedInstance
    var click : (() -> Void)?
    
    func customInit()
    {
        tag = gh.tagBtnGallery
        layer.cornerRadius = 6
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = gh.myRed
        setTitleColor(UIColor(cgColor: gh.myBejColor.cgColor), for: .normal)
        setTitle("Галлерея", for: .normal)
        addTarget(self, action:#selector(myGalleryButton.btnPressed), for: .touchUpInside)
        
        let imgV = UIImageView(image: UIImage(named: "ic_media_bej"))
        imgV.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imgV)
        
        imgV.widthAnchor.constraint(equalToConstant: 36).isActive = true
        imgV.heightAnchor.constraint(equalToConstant: 36).isActive = true
        imgV.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imgV.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -2).isActive = true
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        customInit()
    }
    
    @objc func btnPressed()
    {
        click?()
    }
}


class myCameraButton : UIButton
{
    let gh  = GlobalHelper.sharedInstance
    var click : (() -> Void)?
    
    func customInit()
    {
        tag = gh.tagBtnCamera
        
        layer.cornerRadius = 6
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = gh.myRed
        setTitleColor(UIColor(cgColor: gh.myBejColor.cgColor), for: .normal)
        setTitle("Камера", for: .normal)
        addTarget(self, action:#selector(myCameraButton.btnPressed), for: .touchUpInside)
        
        let imgV = UIImageView(image: UIImage(named: "ic_addphoto_bej"))
        imgV.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imgV)
        
        imgV.widthAnchor.constraint(equalToConstant: 36).isActive = true
        imgV.heightAnchor.constraint(equalToConstant: 36).isActive = true
        imgV.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imgV.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -2).isActive = true
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        customInit()
    }
    
    @objc func btnPressed()
    {
        print("clickeddd")
        click?()
    }
}

class myRemoveButton : UIButton
{
    let gh  = GlobalHelper.sharedInstance
    var click : (() -> Void)?
    
    func customInit()
    {
        tag = gh.tagBtnRemove
        
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 14
        backgroundColor = gh.myRed
        setImage(UIImage(named: "ic_cross_bej"), for: .normal)
        
        addTarget(self, action:#selector(myRemoveButton.removePressed), for: .touchUpInside)
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        customInit()
    }
    
    @objc func removePressed()
    {
        click?()
    }
}


class myBtnMakePodpis : UIButton
{
    let gh  = GlobalHelper.sharedInstance
    var click : (() -> Void)?
    
    func customInit()
    {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 6
        backgroundColor = gh.myRed
        setTitle("Сделать подпись", for: .normal)
        
        let imgV = UIImageView(image: UIImage(named: "ic_podpis_bej"))
        imgV.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imgV)
        
        imgV.widthAnchor.constraint(equalToConstant: 36).isActive = true
        imgV.heightAnchor.constraint(equalToConstant: 36).isActive = true
        imgV.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imgV.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        addTarget(self, action:#selector(myRemoveButton.removePressed), for: .touchUpInside)
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        customInit()
    }
    
    @objc func removePressed()
    {
        click?()
    }
}

class myVerticalStackView : UIStackView
{
    let gh = GlobalHelper.sharedInstance
    
    func customInit()
    {
        print("trying to make stakc")
        self.tag = gh.tagMyStackView
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.axis  = UILayoutConstraintAxis.vertical
        self.distribution  = UIStackViewDistribution.equalSpacing
        self.alignment = UIStackViewAlignment.center
        self.spacing   = 8
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        customInit()
    }
    
    required init(coder: NSCoder)
    {
        super.init(coder: coder)
        customInit()
    }
}

class mySliderView : UIView
{
    var thisSeeker : Model_Seeker!
    let gh = GlobalHelper.sharedInstance
    var valChange : (() -> Void)?
    var slider : StepSlider!
    var changedValue : Double!
    
    var min : Double!
    var max : Double!
    var step : Double!
    
    func customInit()
    {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        min = thisSeeker.min!
        max = thisSeeker.max!
        step = thisSeeker.step!
        
        let diff = abs(min - max)
        let tickNum = diff/step + 1
        
        slider = StepSlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.maxCount = UInt(tickNum)
        slider.trackHeight = 4
        slider.trackCircleRadius = 0
        slider.trackColor = gh.myRedTrans
        slider.sliderCircleColor = gh.myRed
        slider.tintColor = gh.myRedTrans
        slider.addTarget(self, action: #selector(self.changed), for: .valueChanged)
        
        self.addSubview(slider)
        slider.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        slider.heightAnchor.constraint(equalToConstant: 36).isActive = true
        slider.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        slider.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        slider.layoutIfNeeded()
        
        let minLbl = UILabel()
        minLbl.translatesAutoresizingMaskIntoConstraints = false
        minLbl.text = String(min)
        minLbl.textAlignment = .center
        minLbl.textColor = gh.myRed
        gh.setFont(viewArray: [minLbl], size: gh.sizeMiddleMinus1)
        
        self.addSubview(minLbl)
        
        minLbl.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.15).isActive = true
        minLbl.heightAnchor.constraint(equalToConstant: 36).isActive = true
        minLbl.rightAnchor.constraint(equalTo: slider.leftAnchor).isActive = true
        minLbl.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -12).isActive = true
        minLbl.layoutIfNeeded()
        
        
        
        let maxLbl = UILabel()
        maxLbl.translatesAutoresizingMaskIntoConstraints = false
        maxLbl.text = String(max)
        maxLbl.textAlignment = .center
        maxLbl.textColor = gh.myRed
        gh.setFont(viewArray: [maxLbl], size: gh.sizeMiddleMinus1)
        
        self.addSubview(maxLbl)
        
        maxLbl.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.15).isActive = true
        maxLbl.heightAnchor.constraint(equalToConstant: 36).isActive = true
        maxLbl.leftAnchor.constraint(equalTo: slider.rightAnchor).isActive = true
        maxLbl.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -12).isActive = true
        maxLbl.layoutIfNeeded()
        
        slider.index = UInt(tickNum/2)
        thisSeeker.lastSliderIndex = Int(tickNum/2)
    }
    
    init (seeker : Model_Seeker)
    {
        super.init(frame: CGRect(x: 8, y: 8, width: 8, height: 8))
        self.thisSeeker = seeker
        customInit()
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        customInit()
    }
    
    @objc func changed()
    {
        let val = slider.index
        let valueToShow = min + (step*Double(val))
        changedValue = valueToShow
        valChange?()
    }
}

class myTextView : UITextView
{
    let gh = GlobalHelper.sharedInstance
    
    func customInit()
    {
        translatesAutoresizingMaskIntoConstraints = false
        gh.setFont(viewArray: [self], size: gh.sizeMiddleMinus1)
        textColor = gh.myRed
        textAlignment = .left
        sizeToFit()
        backgroundColor = UIColor.white
        gh.addShadow(viewArray: [self])
        gh.makeLittleCorners(viewArray: [self], radius: 6)
        
        returnKeyType = .done
    }
    
    
    
    
    override init(frame: CGRect, textContainer: NSTextContainer?)
    {
        super.init(frame: frame, textContainer: textContainer)
        customInit()
    }
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        customInit()
    }
}

class myTimerButton : UIButton
{
    let gh  = GlobalHelper.sharedInstance
    var click : (() -> Void)?
    var img : UIImage!
    var timerSch : Timer!
    var timerVoid : (() -> Void)?
    
    func customInit()
    {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 6
        backgroundColor = gh.myRed
        contentMode = .scaleAspectFit
        
        let btnImage = UIImageView(image: img)
        btnImage.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(btnImage)
        
        btnImage.widthAnchor.constraint(equalToConstant: 36).isActive = true
        btnImage.heightAnchor.constraint(equalToConstant: 36).isActive = true
        btnImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        btnImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        btnImage.layoutIfNeeded()
        
        addTarget(self, action:#selector(myTimerButton.removePressed), for: .touchUpInside)
        
        timerSch = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(myTimerButton.timerFunc), userInfo: nil, repeats: true)
    }
    
    init(image : UIImage)
    {
        super.init(frame: CGRect(x: 8, y: 8, width: 8, height: 8))
        self.img = image
        customInit()
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        customInit()
    }
    
    @objc func removePressed()
    {
        click?()
    }
    
    @objc func timerFunc()
    {
        timerVoid?()
    }
    
}

class mySkrepkaView : UIView
{
    let gh = GlobalHelper.sharedInstance
    var actionLbl : myViewAsLabel!
    var lblWho : myViewAsLabel!
    var lblSrok : myViewAsLabel!
    var lblPrioritet : myViewAsLabel!
    let recomendedHeight : CGFloat = 124
    
    var removeClick : (()->Void)?
    
    func customInit()
    {
        tag = gh.tagSkrepkaView
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.white
        gh.makeLittleCorners(viewArray: [self], radius: 8)
        gh.addShadow(viewArray: [self])
        
        let header = myLabelForText()
        header.text = "Дейсвие"
        self.addSubview(header)
        
        header.widthAnchor.constraint(equalTo: self.widthAnchor, constant: 0).isActive = true
        header.heightAnchor.constraint(equalToConstant: 28).isActive = true
        header.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        header.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        header.layoutIfNeeded()
        
        actionLbl = myViewAsLabel()
        actionLbl.lbl.text = "adfjslgksdjfgljdfg"
        actionLbl.lbl.font = UIFont.systemFont(ofSize: 16)
        addSubview(actionLbl)
        
        actionLbl.widthAnchor.constraint(equalTo: header.widthAnchor, multiplier: 1, constant: -12).isActive = true
        actionLbl.heightAnchor.constraint(equalToConstant: 28).isActive = true
        actionLbl.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        actionLbl.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 4).isActive = true
        actionLbl.layoutIfNeeded()
        
        let headerWho = myLabelForText()
        headerWho.text = "Ответсвенный"
        headerWho.font = headerWho.font.withSize(14)
        addSubview(headerWho)
        
        headerWho.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.35, constant: -9).isActive = true
        headerWho.heightAnchor.constraint(equalToConstant: 28).isActive = true
        headerWho.topAnchor.constraint(equalTo: actionLbl.bottomAnchor, constant: 4).isActive = true
        headerWho.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 6).isActive = true
        headerWho.layoutIfNeeded()
        
        lblWho = myViewAsLabel()
        lblWho.lbl.text = "hzhzhzhz"
        lblWho.lbl.font = UIFont.systemFont(ofSize: 16)
        addSubview(lblWho)
        
        lblWho.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.65, constant: -9).isActive = true
        lblWho.heightAnchor.constraint(equalToConstant: 28).isActive = true
        lblWho.topAnchor.constraint(equalTo: actionLbl.bottomAnchor, constant: 4).isActive = true
        lblWho.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -6).isActive = true
        lblWho.layoutIfNeeded()
        
        let headerSrok = myLabelForText()
        headerSrok.text = "Срок"
        headerSrok.font = headerSrok.font.withSize(14)
        addSubview(headerSrok)
        
        headerSrok.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.35, constant: -9).isActive = true
        headerSrok.heightAnchor.constraint(equalToConstant: 28).isActive = true
        headerSrok.topAnchor.constraint(equalTo: headerWho.bottomAnchor, constant: 4).isActive = true
        headerSrok.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 6).isActive = true
        headerSrok.layoutIfNeeded()
        
        lblSrok = myViewAsLabel()
        lblSrok.lbl.text = "2342134"
        lblSrok.lbl.font = UIFont.systemFont(ofSize: 16)
        addSubview(lblSrok)
        
        lblSrok.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.65, constant: -9).isActive = true
        lblSrok.heightAnchor.constraint(equalToConstant: 28).isActive = true
        lblSrok.topAnchor.constraint(equalTo: headerWho.bottomAnchor, constant: 4).isActive = true
        lblSrok.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -6).isActive = true
        lblSrok.layoutIfNeeded()
        
        let headerPrioritet = myLabelForText()
        headerPrioritet.text = "Приотриет"
        headerPrioritet.font = headerPrioritet.font.withSize(14)
        addSubview(headerPrioritet)
        
        headerPrioritet.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.35, constant: -9).isActive = true
        headerPrioritet.heightAnchor.constraint(equalToConstant: 28).isActive = true
        headerPrioritet.topAnchor.constraint(equalTo: headerSrok.bottomAnchor, constant: 4).isActive = true
        headerPrioritet.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 6).isActive = true
        headerPrioritet.layoutIfNeeded()
        
        lblPrioritet = myViewAsLabel()
        lblPrioritet.lbl.text = "ывфаывфа"
        lblPrioritet.lbl.font = UIFont.systemFont(ofSize: 16)
        addSubview(lblPrioritet)
        
        lblPrioritet.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.65, constant: -9).isActive = true
        lblPrioritet.heightAnchor.constraint(equalToConstant: 28).isActive = true
        lblPrioritet.topAnchor.constraint(equalTo: headerSrok.bottomAnchor, constant: 4).isActive = true
        lblPrioritet.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -6).isActive = true
        lblPrioritet.layoutIfNeeded()
        
        let removeBtn = myRemoveButton()
        removeBtn.layer.cornerRadius = 12
        addSubview(removeBtn)
        
        removeBtn.widthAnchor.constraint(equalToConstant: 24).isActive = true
        removeBtn.heightAnchor.constraint(equalToConstant: 24).isActive = true
        removeBtn.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        removeBtn.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        
        removeBtn.addTarget(self, action: #selector(self.removePressed), for: .touchUpInside)
    }
    
    @objc func removePressed()
    {
        removeClick?()
    }

    override init(frame: CGRect)
    {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        customInit()
    }
}

class myViewAsLabel : UIView
{
    
    let gh = GlobalHelper.sharedInstance
    var lbl : UILabel!
    
    func customInit()
    {
        tag = gh.tagViewAsLabel
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.white
        gh.makeLittleCorners(viewArray: [self], radius: 8)
        gh.addShadow(viewArray: [self])
        
        lbl = myLabelForText()
        lbl.text = "Hz"
        self.addSubview(lbl)
        
        lbl.widthAnchor.constraint(equalTo: self.widthAnchor, constant: 0).isActive = true
        lbl.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1, constant: 0).isActive = true
        lbl.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        lbl.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        lbl.layoutIfNeeded()
    }
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        customInit()
    }
}



class myQuestionImagesView : myAuditView
{
    var lbl : UILabel!
    
    var imagesToShow : [UIImage] = []
    var firstRow : UIStackView!
    var secondRow : UIStackView!
    var imgViewArray : [UIImageView] = []
    
    func customInit2()
    {
        tag = gh.tagQuestImages
        translatesAutoresizingMaskIntoConstraints = false
        
        
        let imgv1 = UIImageView()
        imgv1.translatesAutoresizingMaskIntoConstraints = false
        
        
        firstRow = UIStackView()
        firstRow.backgroundColor = UIColor.red
        firstRow.translatesAutoresizingMaskIntoConstraints = false
        
        firstRow.axis  = UILayoutConstraintAxis.horizontal
        firstRow.distribution  = UIStackViewDistribution.equalSpacing
        firstRow.alignment = UIStackViewAlignment.center
        firstRow.spacing   = 4
        
        let width = self.frame.size.width
        let rowHeight = (width / 2) * 1.78
        
        addSubview(firstRow)
        firstRow.topAnchor.constraint(equalTo: self.topAnchor, constant: 4).isActive = true
        firstRow.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 4).isActive = true
        firstRow.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -4).isActive = true
        firstRow.heightAnchor.constraint(equalToConstant: rowHeight).isActive = true
        firstRow.layoutIfNeeded()
        
        
        for i in 0...3
        {
            let imgView = UIImageView()
            imgView.translatesAutoresizingMaskIntoConstraints = false
            firstRow.addArrangedSubview(imgView)
            
            imgView.image = UIImage(named: "defSrc")
            imgView.widthAnchor.constraint(equalToConstant: (firstRow.frame.size.width - 12) / 4).isActive = true
            imgView.heightAnchor.constraint(equalToConstant: rowHeight).isActive = true
            imgView.centerYAnchor.constraint(equalTo: firstRow.centerYAnchor).isActive = true
            imgView.layoutIfNeeded()
            
            firstRow.layoutIfNeeded()
            imgViewArray.append(imgView)
        }
        
      
        
    }
    
    init(imgAr : [UIImage])
    {
        super.init(frame: CGRect.zero)
        imagesToShow  = imgAr
        customInit2()
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        customInit2()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        customInit2()
    }
}


class mySkachannieCell : UIView
{
    let gh = GlobalHelper.sharedInstance
    var lbl : UILabel!
    var logoView : UIImageView!
    var lblTitle : UILabel!
    var lblAuthor : UILabel!
    var lblPlace : UILabel!
    var btnBegin : myShareButton!
    var btnDelete : UIButton!
    
    var begin : (()->Void)!
    var delete : (()->Void)!
    
    func customInit()
    {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 6
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.backgroundColor = UIColor.white
        
        
        
        let viewForLogo = UIView()
        viewForLogo.translatesAutoresizingMaskIntoConstraints = false
        viewForLogo.layer.cornerRadius = 6
        viewForLogo.layer.shadowColor = UIColor.black.cgColor
        viewForLogo.layer.shadowOpacity = 0.5
        viewForLogo.layer.shadowOffset = CGSize(width: 2, height: 2)
        viewForLogo.backgroundColor = UIColor.white
        self.addSubview(viewForLogo)
        
        viewForLogo.widthAnchor.constraint(equalToConstant: 64).isActive = true
        viewForLogo.heightAnchor.constraint(equalToConstant: 100).isActive = true
        viewForLogo.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        viewForLogo.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 6).isActive = true
        viewForLogo.layoutIfNeeded()
        
        
        
        self.logoView = UIImageView()
        self.logoView.translatesAutoresizingMaskIntoConstraints = false
        self.logoView.contentMode = .scaleAspectFit
        viewForLogo.addSubview(logoView)
        
        self.logoView.widthAnchor.constraint(equalTo: viewForLogo.widthAnchor, multiplier: 0.95, constant: 0).isActive = true
        self.logoView.heightAnchor.constraint(equalTo: viewForLogo.heightAnchor, multiplier: 0.95, constant: 0).isActive = true
        self.logoView.centerXAnchor.constraint(equalTo: viewForLogo.centerXAnchor).isActive = true
        self.logoView.centerYAnchor.constraint(equalTo: viewForLogo.centerYAnchor).isActive = true
        self.logoView.layoutIfNeeded()
        
        
        
        self.lblTitle = UILabel()
        self.lblTitle.translatesAutoresizingMaskIntoConstraints = false
        self.lblTitle.textColor = gh.myRed
        self.lblTitle.textAlignment = .center
        self.lblTitle.numberOfLines = 0
        self.lblTitle.text = "sdfasdfsd "
        self.lblTitle.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        self.lblTitle.sizeToFit()
        self.addSubview(lblTitle)
        
        self.lblTitle.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1, constant: -152).isActive = true
        self.lblTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.lblTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 6).isActive = true
        self.lblTitle.layoutIfNeeded()
        
        
        self.lblAuthor = UILabel()
        self.lblAuthor.translatesAutoresizingMaskIntoConstraints = false
        self.lblAuthor.textColor = gh.myRed
        self.lblAuthor.textAlignment = .left
        self.lblAuthor.numberOfLines = 0
        self.lblAuthor.font = UIFont.systemFont(ofSize: 15)
        self.lblAuthor.text = "Дата : 25 июля 2018"
        self.lblAuthor.sizeToFit()
        self.addSubview(lblAuthor)
        
        
        self.lblAuthor.leftAnchor.constraint(equalTo: viewForLogo.rightAnchor, constant: 6).isActive = true
        self.lblAuthor.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -46).isActive = true
        self.lblAuthor.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 6).isActive = true
        self.lblAuthor.layoutIfNeeded()
        
        
        
        
        self.lblPlace = UILabel()
        self.lblPlace.translatesAutoresizingMaskIntoConstraints = false
        self.lblPlace.textColor = gh.myRed
        self.lblPlace.textAlignment = .left
        self.lblPlace.numberOfLines = 0
        self.lblPlace.text = "Набранные баллы : 68%"
        self.lblPlace.font = UIFont.systemFont(ofSize: 15)
        self.lblPlace.sizeToFit()
        self.addSubview(lblPlace)
        
        self.lblPlace.leftAnchor.constraint(equalTo: viewForLogo.rightAnchor, constant: 6).isActive = true
        self.lblPlace.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -46).isActive = true
        self.lblPlace.topAnchor.constraint(equalTo: lblAuthor.bottomAnchor, constant: 6).isActive = true
        self.lblPlace.layoutIfNeeded()
        
        
        
        
        
        self.btnDelete = myDeleteButton()
        self.addSubview(btnDelete)
        
        self.btnDelete.widthAnchor.constraint(equalToConstant: 36).isActive = true
        self.btnDelete.heightAnchor.constraint(equalToConstant: 36).isActive = true
        self.btnDelete.topAnchor.constraint(equalTo: self.topAnchor, constant: 13).isActive = true
        self.btnDelete.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12).isActive = true
        self.btnDelete.layoutIfNeeded()
        
        
        self.btnBegin = myShareButton()
        self.btnBegin.imgV.image = UIImage(named: "ic_rightarrow_red")
        self.addSubview(btnBegin)
        
        self.btnBegin.widthAnchor.constraint(equalToConstant: 30).isActive = true
        self.btnBegin.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.btnBegin.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -13).isActive = true
        self.btnBegin.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12).isActive = true
        self.btnBegin.layoutIfNeeded()
        
        
        self.btnBegin.addTarget(self, action: #selector(self.beginPressed), for: .touchUpInside)
        self.btnDelete.addTarget(self, action: #selector(self.deletePressed), for: .touchUpInside)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.beginPressed))
        self.addGestureRecognizer(tap)
    }
    
    @objc func beginPressed()
    {
        begin?()
    }
    
    
    @objc func deletePressed()
    {
        delete?()
    }
    
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        customInit()
    }
}






class downloadCell : UIView
{
    let gh = GlobalHelper.sharedInstance
    var lbl : UILabel!
    var logoView : UIImageView!
    var lblTitle : UILabel!
    var lblAuthor : UILabel!
    var lblPlace : UILabel!
    var btnDownload : myShareButton!
    
    var download : (()->Void)!
    
    func customInit()
    {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 6
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.backgroundColor = UIColor.white
        
        
        
        let viewForLogo = UIView()
        viewForLogo.translatesAutoresizingMaskIntoConstraints = false
        viewForLogo.layer.cornerRadius = 6
        viewForLogo.layer.shadowColor = UIColor.black.cgColor
        viewForLogo.layer.shadowOpacity = 0.5
        viewForLogo.layer.shadowOffset = CGSize(width: 2, height: 2)
        viewForLogo.backgroundColor = UIColor.white
        self.addSubview(viewForLogo)
        
        viewForLogo.widthAnchor.constraint(equalToConstant: 64).isActive = true
        viewForLogo.heightAnchor.constraint(equalToConstant: 100).isActive = true
        viewForLogo.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        viewForLogo.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 6).isActive = true
        viewForLogo.layoutIfNeeded()
        
        
        
        self.logoView = UIImageView()
        self.logoView.translatesAutoresizingMaskIntoConstraints = false
        self.logoView.contentMode = .scaleAspectFit
        viewForLogo.addSubview(logoView)
        
        self.logoView.widthAnchor.constraint(equalTo: viewForLogo.widthAnchor, multiplier: 0.95, constant: 0).isActive = true
        self.logoView.heightAnchor.constraint(equalTo: viewForLogo.heightAnchor, multiplier: 0.95, constant: 0).isActive = true
        self.logoView.centerXAnchor.constraint(equalTo: viewForLogo.centerXAnchor).isActive = true
        self.logoView.centerYAnchor.constraint(equalTo: viewForLogo.centerYAnchor).isActive = true
        self.logoView.layoutIfNeeded()
        
        
        
        self.lblTitle = UILabel()
        self.lblTitle.translatesAutoresizingMaskIntoConstraints = false
        self.lblTitle.textColor = gh.myRed
        self.lblTitle.textAlignment = .center
        self.lblTitle.numberOfLines = 0
        self.lblTitle.text = "sdfasdfsd "
        self.lblTitle.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        self.lblTitle.sizeToFit()
        self.addSubview(lblTitle)
        
        self.lblTitle.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1, constant: -152).isActive = true
        self.lblTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.lblTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 6).isActive = true
        self.lblTitle.layoutIfNeeded()
        
        
        self.lblAuthor = UILabel()
        self.lblAuthor.translatesAutoresizingMaskIntoConstraints = false
        self.lblAuthor.textColor = gh.myRed
        self.lblAuthor.textAlignment = .left
        self.lblAuthor.numberOfLines = 0
        self.lblAuthor.font = UIFont.systemFont(ofSize: 15)
        self.lblAuthor.text = "Дата : 25 июля 2018"
        self.lblAuthor.sizeToFit()
        self.addSubview(lblAuthor)
        
        
        self.lblAuthor.leftAnchor.constraint(equalTo: viewForLogo.rightAnchor, constant: 6).isActive = true
        self.lblAuthor.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -46).isActive = true
        self.lblAuthor.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 6).isActive = true
        self.lblAuthor.layoutIfNeeded()
        
        
        
        
        self.lblPlace = UILabel()
        self.lblPlace.translatesAutoresizingMaskIntoConstraints = false
        self.lblPlace.textColor = gh.myRed
        self.lblPlace.textAlignment = .left
        self.lblPlace.numberOfLines = 0
        self.lblPlace.text = "Набранные баллы : 68%"
        self.lblPlace.font = UIFont.systemFont(ofSize: 15)
        self.lblPlace.sizeToFit()
        self.addSubview(lblPlace)
        
        self.lblPlace.leftAnchor.constraint(equalTo: viewForLogo.rightAnchor, constant: 6).isActive = true
        self.lblPlace.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -46).isActive = true
        self.lblPlace.topAnchor.constraint(equalTo: lblAuthor.bottomAnchor, constant: 6).isActive = true
        self.lblPlace.layoutIfNeeded()
        
        
        
    
        
        
        
        self.btnDownload = myShareButton()
        self.btnDownload.imgV.image = UIImage(named: "ic_download_red")
        self.addSubview(btnDownload)
        
        self.btnDownload.widthAnchor.constraint(equalToConstant: 38).isActive = true
        self.btnDownload.heightAnchor.constraint(equalToConstant: 38).isActive = true
        self.btnDownload.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.btnDownload.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12).isActive = true
        self.btnDownload.layoutIfNeeded()
        
        
        self.btnDownload.addTarget(self, action: #selector(self.downloadPressed), for: .touchUpInside)
       }
    
    @objc func downloadPressed()
    {
        download?()
    }

    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        customInit()
    }
}
















class otchetCell : UIView
{
    let gh = GlobalHelper.sharedInstance
    var lbl : UILabel!
    var logoView : UIImageView!
    var lblTitle : UILabel!
    var lblDate : UILabel!
    var lblPercent : UILabel!
    var btnShare : UIButton!
    var btnDelete : UIButton!
    
    var share : (()->Void)!
    var delete : (()->Void)!
    
    var cellClick : (()->Void)!
    
    func customInit()
    {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 6
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.backgroundColor = UIColor.white
        
        
        
        let viewForLogo = UIView()
        viewForLogo.translatesAutoresizingMaskIntoConstraints = false
        viewForLogo.layer.cornerRadius = 6
        viewForLogo.layer.shadowColor = UIColor.black.cgColor
        viewForLogo.layer.shadowOpacity = 0.5
        viewForLogo.layer.shadowOffset = CGSize(width: 2, height: 2)
        viewForLogo.backgroundColor = UIColor.white
        self.addSubview(viewForLogo)
        
        viewForLogo.widthAnchor.constraint(equalToConstant: 64).isActive = true
        viewForLogo.heightAnchor.constraint(equalToConstant: 100).isActive = true
        viewForLogo.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        viewForLogo.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 6).isActive = true
        viewForLogo.layoutIfNeeded()
        
        
        
        self.logoView = UIImageView()
        self.logoView.translatesAutoresizingMaskIntoConstraints = false
        self.logoView.contentMode = .scaleAspectFit
        viewForLogo.addSubview(logoView)
        
        self.logoView.widthAnchor.constraint(equalTo: viewForLogo.widthAnchor, multiplier: 0.95, constant: 0).isActive = true
        self.logoView.heightAnchor.constraint(equalTo: viewForLogo.heightAnchor, multiplier: 0.95, constant: 0).isActive = true
        self.logoView.centerXAnchor.constraint(equalTo: viewForLogo.centerXAnchor).isActive = true
        self.logoView.centerYAnchor.constraint(equalTo: viewForLogo.centerYAnchor).isActive = true
        self.logoView.layoutIfNeeded()
        
        
        
        self.lblTitle = UILabel()
        self.lblTitle.translatesAutoresizingMaskIntoConstraints = false
        self.lblTitle.textColor = gh.myRed
        self.lblTitle.textAlignment = .center
        self.lblTitle.numberOfLines = 0
        self.lblTitle.text = "sdfasdfsd "
        self.lblTitle.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        self.lblTitle.sizeToFit()
        self.addSubview(lblTitle)

        self.lblTitle.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1, constant: -152).isActive = true
        self.lblTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.lblTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 6).isActive = true
        self.lblTitle.layoutIfNeeded()


        self.lblDate = UILabel()
        self.lblDate.translatesAutoresizingMaskIntoConstraints = false
        self.lblDate.textColor = gh.myRed
        self.lblDate.textAlignment = .left
        self.lblDate.numberOfLines = 0
        self.lblDate.font = UIFont.systemFont(ofSize: 15)
        self.lblDate.text = "Дата : 25 июля 2018"
        self.lblDate.sizeToFit()
        self.addSubview(lblDate)

        
        self.lblDate.leftAnchor.constraint(equalTo: viewForLogo.rightAnchor, constant: 6).isActive = true
        self.lblDate.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -46).isActive = true
        self.lblDate.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 6).isActive = true
        self.lblDate.layoutIfNeeded()

        
        
        
        self.lblPercent = UILabel()
        self.lblPercent.translatesAutoresizingMaskIntoConstraints = false
        self.lblPercent.textColor = gh.myRed
        self.lblPercent.textAlignment = .left
        self.lblPercent.numberOfLines = 0
        self.lblPercent.text = "Набранные баллы : 68%"
        self.lblPercent.font = UIFont.systemFont(ofSize: 15)
        self.lblPercent.sizeToFit()
        self.addSubview(lblPercent)

        self.lblPercent.leftAnchor.constraint(equalTo: viewForLogo.rightAnchor, constant: 6).isActive = true
        self.lblPercent.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -46).isActive = true
        self.lblPercent.topAnchor.constraint(equalTo: lblDate.bottomAnchor, constant: 6).isActive = true
        self.lblPercent.layoutIfNeeded()

        
        
        
        
        self.btnDelete = myDeleteButton()
        self.addSubview(btnDelete)
        
        self.btnDelete.widthAnchor.constraint(equalToConstant: 36).isActive = true
        self.btnDelete.heightAnchor.constraint(equalToConstant: 36).isActive = true
        self.btnDelete.topAnchor.constraint(equalTo: self.topAnchor, constant: 13).isActive = true
        self.btnDelete.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12).isActive = true
        self.btnDelete.layoutIfNeeded()
        
        
        
        
        self.btnShare = myShareButton()
        self.addSubview(btnShare)
        
        self.btnShare.widthAnchor.constraint(equalToConstant: 30).isActive = true
        self.btnShare.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.btnShare.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -13).isActive = true
        self.btnShare.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12).isActive = true
        self.btnShare.layoutIfNeeded()
        
        
        self.btnShare.addTarget(self, action: #selector(self.sharePressed), for: .touchUpInside)
        self.btnDelete.addTarget(self, action: #selector(self.deletePressed), for: .touchUpInside)
        
        
        let gestRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.cellTaped))
        self.addGestureRecognizer(gestRecognizer)
    }
    
    @objc func cellTaped()
    {
        cellClick?()
    }
    
    @objc func sharePressed()
    {
        share?()
    }
    
    
    @objc func deletePressed()
    {
        delete?()
    }
    
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        customInit()
    }
}







class myShareButton : UIButton
{
    let gh  = GlobalHelper.sharedInstance
    var click : (() -> Void)?
    var imgV : UIImageView!
    
    func customInit()
    {
        translatesAutoresizingMaskIntoConstraints = false
        
        imgV = UIImageView(image: UIImage(named: "ic_share_red"))
        imgV.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imgV)
        
        imgV.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
        imgV.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
        imgV.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imgV.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        addTarget(self, action:#selector(myRemoveButton.removePressed), for: .touchUpInside)
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        customInit()
    }
    
    @objc func removePressed()
    {
        click?()
    }
}






class myDeleteButton : UIButton
{
    let gh  = GlobalHelper.sharedInstance
    var click : (() -> Void)?
    
    func customInit()
    {
        translatesAutoresizingMaskIntoConstraints = false

        let imgV = UIImageView(image: UIImage(named: "ic_delete_red"))
        imgV.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imgV)
        
        imgV.widthAnchor.constraint(equalToConstant: 36).isActive = true
        imgV.heightAnchor.constraint(equalToConstant: 36).isActive = true
        imgV.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imgV.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        addTarget(self, action:#selector(myRemoveButton.removePressed), for: .touchUpInside)
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        customInit()
    }
    
    @objc func removePressed()
    {
        click?()
    }
}











class myBackArrowButton : UIButton
{
    let gh  = GlobalHelper.sharedInstance
    var click : (() -> Void)?
    
    func customInit()
    {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 6
        
        
        let imgV = UIImageView(image: UIImage(named: "ic_leftArrow"))
        imgV.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imgV)
        
        imgV.widthAnchor.constraint(equalToConstant: 36).isActive = true
        imgV.heightAnchor.constraint(equalToConstant: 36).isActive = true
        imgV.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imgV.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        addTarget(self, action:#selector(myRemoveButton.removePressed), for: .touchUpInside)
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        customInit()
    }
    
    @objc func removePressed()
    {
        click?()
    }
}


class myDialog
{
    //static let shIn = Dialog()
    
    let hud = JGProgressHUD(style: .dark)
    
    func show(message:String, view : UIView)
    {
        hud.textLabel.text = message
        hud.show(in: view)
    }
    
    func hide(afterTime : Double)
    {
        hud.dismiss(afterDelay: afterTime, animated: true)
    }
}


