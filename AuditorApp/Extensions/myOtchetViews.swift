import UIKit
import Foundation

class otTableTitle : UILabel
{
    let gh = GlobalHelper.sharedInstance
    
    func customInit()
    {
        translatesAutoresizingMaskIntoConstraints = false
        self.font = UIFont.systemFont(ofSize: 17)
        textAlignment = .center
        numberOfLines = 0
        self.sizeToFit()
        
        self.layoutIfNeeded()
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

class otTableHeader : UIView
{
   
    
    var lblVop : UILabel!
    var lblOtv : UILabel!
    var lblDop : UILabel!
    
    let lightGray = UIColor(displayP3Red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
    let fontSize : CGFloat = 13
    
    func customInit()
    {
        translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = lightGray
        
        lblVop = UILabel()
        lblVop.translatesAutoresizingMaskIntoConstraints = false
        lblVop.text = "Вопрос"
        self.lblVop.backgroundColor = UIColor.clear
        self.lblVop.font = UIFont.systemFont(ofSize: fontSize)
        lblVop.textAlignment = .center
        lblVop.layer.borderWidth = 0.4
        
        addSubview(lblVop)
        
        lblVop.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        lblVop.heightAnchor.constraint(equalToConstant: 26).isActive = true
        lblVop.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25, constant: 0).isActive = true
        lblVop.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        lblVop.layoutIfNeeded()
        
        
        lblOtv = UILabel()
        lblOtv.translatesAutoresizingMaskIntoConstraints = false
        lblOtv.text = "Ответ"
        self.lblOtv.backgroundColor = UIColor.clear
        self.lblOtv.font = UIFont.systemFont(ofSize: fontSize)
        lblOtv.textAlignment = .center
        lblOtv.layer.borderWidth = 0.4
        
        addSubview(lblOtv)
        
        lblOtv.leftAnchor.constraint(equalTo: lblVop.rightAnchor, constant: 0).isActive = true
        lblOtv.heightAnchor.constraint(equalToConstant: 26).isActive = true
        lblOtv.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3, constant: 0).isActive = true
        lblOtv.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        lblOtv.layoutIfNeeded()
        
        
        
        lblDop = UILabel()
        lblDop.translatesAutoresizingMaskIntoConstraints = false
        lblDop.text = "Дополнительно"
        self.lblDop.backgroundColor = UIColor.clear
        lblDop.font = UIFont.systemFont(ofSize: fontSize)
        lblDop.textAlignment = .center
        lblDop.layer.borderWidth = 0.4
        
        addSubview(lblDop)
        
        lblDop.leftAnchor.constraint(equalTo: lblOtv.rightAnchor, constant: 0).isActive = true
        lblDop.heightAnchor.constraint(equalToConstant: 26).isActive = true
        lblDop.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.45, constant: 0).isActive = true
        lblDop.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        lblDop.layoutIfNeeded()
        
        self.layoutIfNeeded()
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

class otchetQuestion : UIView
{

    let gh = GlobalHelper.sharedInstance
    var lbl : UILabel!
    var quest : Model_Question!
    
    var lblQuest : UILabel!
    var lblOtv : UILabel!
    var lblDop : UILabel!
    
    let green = UIColor(displayP3Red: 79/255, green: 201/255, blue: 150/255, alpha: 1)
    let red = UIColor(displayP3Red: 215/255, green: 91/255, blue: 95/255, alpha: 1)
    
    func customInit()
    {
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        
        lblOtv = UILabel()
        lblDop = UILabel()
        
        var answerStr : String!
        
        if quest.questionType != 2
        {
            var selectedInt = 0
            
            for btn in quest.auditButtons
            {
                if btn.isOn
                {
                    selectedInt = quest.auditButtons.index(of: btn)!
                    break
                }
            }
            
            if quest.questionType == 0
            {
                switch selectedInt
                {
                    case 0 :
                        answerStr = "Да"
                        self.lblOtv.backgroundColor = green
                    case 1 :
                        answerStr = "Нет"
                        self.lblOtv.backgroundColor = red
                    case 2:
                        answerStr = "Без Ответа"
                        self.lblOtv.textColor = UIColor.red
                    default:
                        break
                }
            }
            
            
            if quest.questionType == 1
            {
                switch selectedInt
                {
                case 0 :
                    answerStr = "Безопасно"
                    self.lblOtv.backgroundColor = green
                case 1 :
                    answerStr = "Рискованно"
                    self.lblOtv.backgroundColor = red
                case 2:
                    answerStr = "Без Ответа"
                    self.lblOtv.textColor = UIColor.red
                default:
                    break
                }
            }
            
            
        }
        
        if quest.questionType == 2
        {
            var selectedInt = 0
            
            for btn in quest.auditButtons
            {
                if btn.isOn
                {
                    selectedInt = quest.auditButtons.index(of: btn)!
                    break
                }
            }
            
            answerStr = quest.answerVariants[selectedInt]
        }
        
        
        layer.borderWidth = 2
        
        lblQuest = UILabel()
        lblQuest.numberOfLines = 0
        lblQuest.translatesAutoresizingMaskIntoConstraints = false
        lblQuest.layer.borderWidth = 0.4
        lblQuest.numberOfLines = 0
        //lblQuest.text = quest.text!
        lblQuest.text = "dsafasdf"
        
       
        
        addSubview(lblQuest)
        
        lblQuest.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25, constant: 0).isActive = true
        lblQuest.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        lblQuest.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        lblQuest.layoutIfNeeded()
        lblQuest.sizeToFit()
        
        
        lblOtv.translatesAutoresizingMaskIntoConstraints = false
        lblOtv.textAlignment = .center
        lblOtv.numberOfLines = 0
        lblOtv.text = answerStr!
        lblOtv.layer.borderWidth = 0.4
        
        addSubview(lblOtv)
        
        lblOtv.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3, constant: 0).isActive = true
        lblOtv.leftAnchor.constraint(equalTo: lblQuest.rightAnchor).isActive = true
        lblOtv.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        lblOtv.layoutIfNeeded()
        lblOtv.sizeToFit()
        
        
        lblDop.translatesAutoresizingMaskIntoConstraints = false
        lblDop.layer.borderWidth = 0.4
        lblDop.numberOfLines = 0 
        
        addSubview(lblDop)
        
        lblDop.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.45, constant: 0).isActive = true
        lblDop.leftAnchor.constraint(equalTo: lblOtv.rightAnchor).isActive = true
        lblDop.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        lblDop.layoutIfNeeded()
        lblDop.sizeToFit()
        
        self.sizeToFit()
    }
    
    init(question : Model_Question)
    {
        super.init(frame: CGRect.zero)
        self.quest = question
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


class otTableLabeCell : UILabel
{
    let gh = GlobalHelper.sharedInstance
    let padding = UIEdgeInsets(top: 2, left: 4, bottom: 2, right: 4)
    
    
    func customInit()
    {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.font = UIFont.systemFont(ofSize: 11)
        self.numberOfLines = 0
        self.sizeToFit()
        self.layer.borderWidth = 0.4
        
        self.layoutIfNeeded()
    }
    
    
    override func drawText(in rect: CGRect)
    {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, padding))
    }
    
    override var intrinsicContentSize : CGSize
    {
        let superContentSize = super.intrinsicContentSize
        let width = superContentSize.width + padding.left + padding.right
        let heigth = superContentSize.height + padding.top + padding.bottom
        return CGSize(width: width, height: heigth)
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


class otImagePreview : UIView
{
    let gh = GlobalHelper.sharedInstance
    var imgView : UIImageView!
    
    func customInit()
    {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.imgView = UIImageView()
        self.imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        
        self.addSubview(imgView)
        self.imgView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1, constant: -6).isActive = true
        self.imgView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1, constant: -6).isActive = true
        self.imgView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.imgView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.imgView.layoutIfNeeded()
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


class otCheckBoxYes : UIView
{
    let gh = GlobalHelper.sharedInstance
    var imgView : UIImageView!
    
    func customInit()
    {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.borderWidth = 0.4
        
        self.imgView = UIImageView()
        self.imgView.translatesAutoresizingMaskIntoConstraints = false
        self.imgView.image = UIImage(named: "checkBoxYes")
        
        
        self.addSubview(imgView)
        self.imgView.widthAnchor.constraint(equalToConstant: 28).isActive = true
        self.imgView.heightAnchor.constraint(equalToConstant: 28).isActive = true
        self.imgView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.imgView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.imgView.layoutIfNeeded()
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




class otCheckBoxNo : UIView
{
    let gh = GlobalHelper.sharedInstance
    var imgView : UIImageView!
    
    func customInit()
    {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.borderWidth = 0.4
        
        self.imgView = UIImageView()
        self.imgView.translatesAutoresizingMaskIntoConstraints = false
        self.imgView.image = UIImage(named: "checkBoxNo")
        
        self.addSubview(imgView)
        self.imgView.widthAnchor.constraint(equalToConstant: 28).isActive = true
        self.imgView.heightAnchor.constraint(equalToConstant: 28).isActive = true
        self.imgView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.imgView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.imgView.layoutIfNeeded()
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














