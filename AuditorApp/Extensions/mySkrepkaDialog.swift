import UIKit
import StepSlider

class mySkrepkaDialog: UIViewController , UITextViewDelegate , UITextFieldDelegate
{
    let gh = GlobalHelper.sharedInstance
    let todoPlaceHolder = "Что вы хотите сделать?"
    
    var currentElement: Audit_Element!
    
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
        dialogView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        dialogView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9, constant: 0).isActive = true
        dialogView.heightAnchor.constraint(equalToConstant: 516).isActive = true
        dialogView.layoutIfNeeded()
        
        let header = UILabel()
        header.translatesAutoresizingMaskIntoConstraints = false
        header.backgroundColor = gh.myRed
        header.clipsToBounds = true
        header.layer.cornerRadius = 6
        header.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        header.text = "Добавить действие"
        header.font = gh.globalFont18
        header.textAlignment = .center
        header.textColor = gh.myBejColor
        
        dialogView.addSubview(header)
        header.topAnchor.constraint(equalTo: dialogView.topAnchor, constant: 0).isActive = true
        header.heightAnchor.constraint(equalToConstant: 36).isActive = true
        header.widthAnchor.constraint(equalTo: dialogView.widthAnchor, multiplier: 1).isActive = true
        header.centerXAnchor.constraint(equalTo: dialogView.centerXAnchor, constant: 0).isActive = true
        header.layoutIfNeeded()
        
        let viewForToDo = myAuditView()
        dialogView.addSubview(viewForToDo)
        
        viewForToDo.widthAnchor.constraint(equalTo: dialogView.widthAnchor, multiplier: 1, constant: -12).isActive = true
        viewForToDo.heightAnchor.constraint(equalToConstant: 160).isActive = true
        viewForToDo.centerXAnchor.constraint(equalTo: dialogView.centerXAnchor, constant: 0).isActive = true
        viewForToDo.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 4).isActive = true
        viewForToDo.layoutIfNeeded()
        
        let toDoTextView = myTextView()
        toDoTextView.clipsToBounds = true
        viewForToDo.addSubview(toDoTextView)
        toDoTextView.delegate = self
        toDoTextView.text = todoPlaceHolder
        toDoTextView.textColor = gh.myRedTrans
        
        toDoTextView.widthAnchor.constraint(equalTo: viewForToDo.widthAnchor, multiplier: 1).isActive = true
        toDoTextView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        toDoTextView.centerXAnchor.constraint(equalTo: viewForToDo.centerXAnchor, constant: 0).isActive = true
        toDoTextView.topAnchor.constraint(equalTo: viewForToDo.topAnchor , constant: 0).isActive = true
        toDoTextView.layoutIfNeeded()
        
        let textFieldWho = myTextFieldOneLine()
        textFieldWho.delegate = self
        textFieldWho.attributedPlaceholder = NSAttributedString(string: "Ответсвенный за действие",
                                                                attributes: [NSAttributedStringKey.foregroundColor: gh.myRedTrans])
        dialogView.addSubview(textFieldWho)
        
        
        textFieldWho.widthAnchor.constraint(equalTo: dialogView.widthAnchor, multiplier: 1, constant: -12).isActive = true
        textFieldWho.heightAnchor.constraint(equalToConstant: 36).isActive = true
        textFieldWho.centerXAnchor.constraintEqualToSystemSpacingAfter(dialogView.centerXAnchor, multiplier: 1).isActive = true
        textFieldWho.topAnchor.constraint(equalTo: viewForToDo.bottomAnchor, constant: 4).isActive = true
        textFieldWho.layoutIfNeeded()
        
        let prioritetView = myAuditView()
        dialogView.addSubview(prioritetView)
        
        prioritetView.widthAnchor.constraint(equalTo: dialogView.widthAnchor, multiplier: 1, constant: -12).isActive = true
        prioritetView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        prioritetView.centerXAnchor.constraint(equalTo: dialogView.centerXAnchor, constant: 0).isActive = true
        prioritetView.topAnchor.constraint(equalTo: textFieldWho.bottomAnchor, constant: 4).isActive = true
        prioritetView.layoutIfNeeded()
        
        let lblPriotitet = myLabelForText()
        lblPriotitet.text = "Приоритет"
        lblPriotitet.backgroundColor = UIColor.clear
        lblPriotitet.font = lblPriotitet.font.withSize(16)
        prioritetView.addSubview(lblPriotitet)
        
        lblPriotitet.widthAnchor.constraint(equalTo: prioritetView.widthAnchor, multiplier: 1, constant: 0).isActive = true
        lblPriotitet.heightAnchor.constraint(equalToConstant: 36).isActive = true
        lblPriotitet.centerXAnchor.constraint(equalTo: prioritetView.centerXAnchor).isActive = true
        lblPriotitet.topAnchor.constraint(equalTo: prioritetView.topAnchor).isActive = true
        lblPriotitet.layoutIfNeeded()
        
        
        let slider = StepSlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.maxCount = UInt(4)
        slider.trackHeight = 3
        slider.trackCircleRadius = 4
        slider.trackColor = gh.myRedTrans
        slider.sliderCircleRadius = 8
        slider.sliderCircleColor = gh.myRed
        slider.tintColor = gh.myRed
        
        prioritetView.insertSubview(slider, at: 1)
        slider.widthAnchor.constraint(equalTo: prioritetView.widthAnchor, multiplier: 1, constant: -24).isActive = true
        slider.heightAnchor.constraint(equalToConstant: 36).isActive = true
        slider.centerXAnchor.constraint(equalTo: prioritetView.centerXAnchor).isActive = true
        slider.topAnchor.constraint(equalTo: lblPriotitet.bottomAnchor).isActive = true
        slider.layoutIfNeeded()
        
        let sliderWidth = slider.frame.size.width
        
        let lblNo = myLabelForText()
        lblNo.text = "нет"
        lblNo.font = gh.avenirLight
        lblNo.textAlignment = .left
        prioritetView.addSubview(lblNo)
        
        lblNo.widthAnchor.constraint(equalTo: prioritetView.widthAnchor, multiplier: 0.25, constant: 0).isActive = true
        lblNo.heightAnchor.constraint(equalToConstant: 20).isActive = true
        lblNo.leftAnchor.constraint(equalTo: slider.leftAnchor, constant: 0).isActive = true
        lblNo.topAnchor.constraint(equalTo: slider.topAnchor, constant: 12).isActive=true
        lblNo.layoutIfNeeded()
        
        let lblLow = myLabelForText()
        lblLow.text = "низкий"
        lblLow.font = gh.avenirLight
        lblLow.textAlignment = .center
        prioritetView.addSubview(lblLow)
        
        lblLow.widthAnchor.constraint(equalTo: prioritetView.widthAnchor, multiplier: 0.25, constant: 0).isActive = true
        lblLow.heightAnchor.constraint(equalToConstant: 20).isActive = true
        lblLow.centerXAnchor.constraint(equalTo: slider.centerXAnchor, constant: -(sliderWidth/6 - 4)).isActive = true
        lblLow.topAnchor.constraint(equalTo: slider.topAnchor, constant: 12).isActive=true
        lblLow.layoutIfNeeded()
        
        let lblMid = myLabelForText()
        lblMid.text = "средний"
        lblMid.font = gh.avenirLight
        lblMid.textAlignment = .center
        prioritetView.addSubview(lblMid)
        
        lblMid.widthAnchor.constraint(equalTo: prioritetView.widthAnchor, multiplier: 0.25, constant: 0).isActive = true
        lblMid.heightAnchor.constraint(equalToConstant: 20).isActive = true
        lblMid.centerXAnchor.constraint(equalTo: slider.centerXAnchor, constant: (sliderWidth/6 - 4)).isActive = true
        lblMid.topAnchor.constraint(equalTo: slider.topAnchor, constant:12).isActive=true
        lblMid.layoutIfNeeded()
        
        
        let lblHigh = myLabelForText()
        lblHigh.text = "высокий"
        lblHigh.font = gh.avenirLight
        lblHigh.textAlignment = .right
        prioritetView.addSubview(lblHigh)
        
        lblHigh.widthAnchor.constraint(equalTo: prioritetView.widthAnchor, multiplier: 0.25, constant: 0).isActive = true
        lblHigh.heightAnchor.constraint(equalToConstant: 20).isActive = true
        lblHigh.rightAnchor.constraint(equalTo: slider.rightAnchor, constant: 8).isActive = true
        lblHigh.topAnchor.constraint(equalTo: slider.topAnchor, constant: 12).isActive=true
        lblHigh.layoutIfNeeded()
        
        
        let viewForSrok = myAuditView()
        dialogView.addSubview(viewForSrok)
        
        viewForSrok.widthAnchor.constraint(equalTo: dialogView.widthAnchor, multiplier: 1, constant: -12).isActive = true
        viewForSrok.heightAnchor.constraint(equalToConstant: 152).isActive = true
        viewForSrok.centerXAnchor.constraint(equalTo: dialogView.centerXAnchor).isActive = true
        viewForSrok.topAnchor.constraint(equalTo: prioritetView.bottomAnchor, constant: 4).isActive = true
        viewForSrok.layoutIfNeeded()
        
        let lblSrok = myLabelForText()
        lblSrok.shadowColor = UIColor.clear
        lblSrok.font = lblSrok.font.withSize(16)
        lblSrok.text = "Срок Выполнения"
        viewForSrok.addSubview(lblSrok)
        
        lblSrok.widthAnchor.constraint(equalTo: viewForSrok.widthAnchor, multiplier: 1, constant: 0).isActive = true
        lblSrok.heightAnchor.constraint(equalToConstant: 36).isActive = true
        lblSrok.topAnchor.constraint(equalTo: viewForSrok.topAnchor).isActive = true
        lblSrok.centerXAnchor.constraint(equalTo: viewForSrok.centerXAnchor).isActive = true
        lblSrok.layoutIfNeeded()
        
        let datePicker = myDatePick()
        viewForSrok.addSubview(datePicker)
        datePicker.layer.borderColor = UIColor.white.cgColor
        datePicker.datePickerMode = .date

        datePicker.topAnchor.constraint(equalTo: lblSrok.bottomAnchor, constant: -8).isActive = true
        datePicker.widthAnchor.constraint(equalTo: viewForSrok.widthAnchor, constant: 0).isActive = true
        datePicker.heightAnchor.constraint(equalToConstant: 116).isActive = true
        datePicker.centerXAnchor.constraint(equalTo: viewForSrok.centerXAnchor).isActive = true

        let okButton = redButton()
        okButton.setTitle("Добавить", for: .normal)
        
        dialogView.addSubview(okButton)
        okButton.widthAnchor.constraint(equalTo: viewForSrok.widthAnchor, multiplier: 0.5, constant: -6).isActive = true
        okButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        okButton.topAnchor.constraint(equalTo: viewForSrok.bottomAnchor, constant: 6).isActive = true
        okButton.rightAnchor.constraint(equalTo: viewForSrok.rightAnchor, constant: 0).isActive = true
        
        let cancelButton = transButton()
        cancelButton.setTitle("Отмена", for: .normal)
        
        dialogView.addSubview(cancelButton)
        cancelButton.widthAnchor.constraint(equalTo: viewForSrok.widthAnchor, multiplier: 0.5, constant: -6).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        cancelButton.topAnchor.constraint(equalTo: viewForSrok.bottomAnchor, constant: 6).isActive = true
        cancelButton.leftAnchor.constraint(equalTo: viewForSrok.leftAnchor, constant: 0).isActive = true
        
        okButton.click =
            {
                let todo = toDoTextView.text
                let who = textFieldWho.text
                let prioritet = slider.index
                let srok = datePicker.date
                
                if todo == nil
                {
                    self.gh.showToast(message: "Введите действие", view: self.view)
                    return
                }
                
                let skrepkaView = mySkrepkaView()
                
                skrepkaView.actionLbl.lbl.text = todo!
                
                if who != nil
                {
                    skrepkaView.lblWho.lbl.text = who!
                }
                else
                {
                    skrepkaView.lblWho.lbl.text = "не назначен"
                }
            
                
                
                switch prioritet
                {
                    case 0:
                        skrepkaView.lblPrioritet.lbl.text = "нет"
                    case 1:
                        skrepkaView.lblPrioritet.lbl.text = "низкий"
                    case 2:
                        skrepkaView.lblPrioritet.lbl.text = "средний"
                    case 3:
                        skrepkaView.lblPrioritet.lbl.text = "высокий"
                    default:
                        break
                }
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd.MM.yyyy"
                let dateStr = dateFormatter.string(from: srok)
                
                skrepkaView.lblSrok.lbl.text = dateStr
                let rootview = self.currentElement.auditView!
                
                if self.currentElement.skrepka == nil
                {
                    let currentHeight = rootview.frame.size.height
                    let cons = rootview.constraints.filter
                    {
                        $0.firstAttribute == NSLayoutAttribute.height
                    }
                    NSLayoutConstraint.deactivate(cons)
                    
                    rootview.heightAnchor.constraint(equalToConstant: currentHeight + 172).isActive = true
                    (rootview.superview as! UIScrollView).contentSize.height += 172
                }
                
                else
                {
                    let currentSkrepka = rootview.viewWithTag(self.gh.tagSkrepkaView)
                    currentSkrepka?.removeFromSuperview()
                }
                
                self.currentElement.auditView.addSubview(skrepkaView)
                
                skrepkaView.widthAnchor.constraint(equalTo: rootview.widthAnchor, multiplier: 1, constant: -8).isActive = true
                skrepkaView.heightAnchor.constraint(equalToConstant: 164).isActive = true
                skrepkaView.centerXAnchor.constraint(equalTo: rootview.centerXAnchor).isActive = true
                skrepkaView.bottomAnchor.constraint(equalTo: rootview.bottomAnchor, constant: -6).isActive = true
                
                let skrepkaData = Skrepka_Data()
                
                skrepkaData.strTodo = todo
                skrepkaData.whoTodo = who
                skrepkaData.prioritet = Int(prioritet)
                skrepkaData.dateToDo = srok
                
                self.currentElement.skrepka = skrepkaData
                
                self.dismiss(animated: true, completion: nil)
            }
        
        cancelButton.click =
            {
                self.dismiss(animated: true, completion: nil)
            }
        
        if currentElement.skrepka != nil
        {
            let skrp = currentElement.skrepka!
            
            if skrp.strTodo != nil
            {
                toDoTextView.text = skrp.strTodo
                toDoTextView.textColor = gh.myRed
            }
            
            if skrp.whoTodo != nil
            {
                textFieldWho.text = skrp.whoTodo
            }
            
            slider.setIndex(UInt(skrp.prioritet), animated: true)
            
            datePicker.setDate(skrp.dateToDo!, animated: true)
        }
        
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    {
        if(text == "\n")
        {
            self.view.endEditing(true)
            textView.resignFirstResponder()
            return true
        }
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        if (textView.text == todoPlaceHolder)
        {
            textView.text = ""
            textView.textColor = gh.myRed
        }
        textView.becomeFirstResponder() //Optional
    }
    
    func textViewDidEndEditing(_ textView: UITextView)
    {
        if (textView.text == "")
        {
            textView.text = todoPlaceHolder
            textView.textColor = gh.myRedTrans
        }
        textView.resignFirstResponder()
    }
    
    init(elem : Audit_Element)
    {
        super.init(nibName: nil, bundle: nil)
        currentElement = elem
        customInit()
    }
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        customInit()
    }

}
