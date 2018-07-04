import UIKit
import M13Checkbox
import StepSlider
import BetterSegmentedControl
import Tabman

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
    func customInit()
    {
        setImage(UIImage(named: "ic_comment"), for: .normal)
        //backgroundColor = UIColor.white
        translatesAutoresizingMaskIntoConstraints = false
        //gh.addShadow(viewArray: [self])
        //gh.makeLittleCorners(viewArray: [self], radius: 4)
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

class myAddPhotoButton : UIButton
{
    let gh = GlobalHelper.sharedInstance
    func customInit()
    {
        setImage(UIImage(named: "ic_add_photo_red"), for: .normal)
        //backgroundColor = UIColor.white
        translatesAutoresizingMaskIntoConstraints = false
        //gh.addShadow(viewArray: [self])
        //gh.makeLittleCorners(viewArray: [self], radius: 4)
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
        translatesAutoresizingMaskIntoConstraints = false
        gh.addShadow(viewArray: [self])
        tag = gh.tagInfoImge
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






