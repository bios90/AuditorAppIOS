import Foundation
import UIKit
import Toast_Swift
import FirebaseDatabase
import JGProgressHUD
import Kingfisher
import BetterSegmentedControl




struct GlobalHelper
{
    let tagHeader = 9000
    let tagInfoImge = 9001
    let tagMyLabel = 9002
    let tagBtnCamera = 9003
    let tagBtnGallery = 9004
    let tagBtnRemove = 9005
    let tagAnyMyImageView = 9006
    let tagMyAuditView = 9007
    let tagMyToggButton = 9008
    let tagMyStackView = 9009
    let tagMyScrollView = 9010
    let tagSkrepkaView = 9011
    let tagViewAsLabel = 9012
    let tagQuestImages = 9014
    
    let typeQuestion = 0
    let typeAdress = 1
    let typeCheckBox = 2
    let typeDate = 3
    let typeInfo = 4
    let typeMedia = 5
    let typePodpis = 6
    let typeQuestVar = 7
    let typeSeeker = 8
    let typeTextLaerge = 9
    let typeTextOneLine = 10
    let typeToggle = 11
    let typeTimer = 12
    
    let mainBG = UIImage(named: "backgroundBG")
    let imgObyaz = UIImage(named: "ic_warning")
    
    var shablonToBegin : Model_Shablon!
    
    let dbRootRef = Database.database().reference()
    let dbShablonRef = Database.database().reference().child("Shablons")

    let AvenirMedium : String = "Avenir-Medium"
    
    let sizeTitle : CGFloat = 22
    let sizeMiddle : CGFloat = 18
    let sizeMiddleMinus1 : CGFloat = 16
    
    let myBejColor : UIColor = UIColor(displayP3Red: 255/1, green: 248/1, blue: 242/1, alpha: 1)
    let myRed : UIColor = UIColor(displayP3Red: 171/255, green: 26/255, blue: 47/255, alpha: 1)
    let myRedTrans = UIColor(displayP3Red: 171/255, green: 26/255, blue: 47/255, alpha: 0.5)
    let toastBG : UIColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 150/255)
    
    let otGreen = UIColor(displayP3Red: 79/255, green: 201/255, blue: 150/255, alpha: 1)
    let otRed = UIColor(displayP3Red: 215/255, green: 91/255, blue: 95/255, alpha: 1)
    
    let otLime = UIColor(displayP3Red: 50/255, green: 205/255, blue: 50/255, alpha: 1)
    let otYellow = UIColor(displayP3Red: 253/255, green: 170/255, blue: 28/255, alpha: 1)

    
    // MARK: - Segues
    let segueToUserMEnu : String = "toUserMenu"
    let segueToFirstScreen : String = "toFirstScreen"
    let segueToDownloadAudits : String = "toDownloadAudits"
    let segueToSkachannie : String = "toSkachannie"
    let segueToBeginAudit : String = "toBeginAudit"
    //
    
    let globalFont18 = UIFont(name: "Avenir-Medium", size: 18)
    let globalFont20 = UIFont(name: "Avenir-Medium", size: 20)
    
    let avenirLight = UIFont(name: "Avenir-Light", size: 12)
    
    static let sharedInstance = GlobalHelper()

    func addShadow( viewArray : [UIView])
    {
        for item in viewArray
        {
            item.layer.shadowColor = UIColor.black.cgColor
            item.layer.shadowOpacity = 0.5
            item.layer.shadowOffset = CGSize(width: 2, height: 2)
        }
    }
    
    func addShadowToLayer(viewArray : [UIView])
    {
        for item in viewArray
        {
            
        }
    }
   
    
    func makeRound(viewArray : [UIView])
    {
        for item in viewArray
        {
            item.layer.masksToBounds = false
            item.layer.cornerRadius = item.frame.size.height / 2
        }
    }
    
    func makeLittleCorners(viewArray : [UIView], radius: CGFloat)
    {
        for item in viewArray
        {
            item.layer.masksToBounds = false
            item.layer.cornerRadius = radius
        }
    }
    
    func setFont(viewArray : [UIView], size: CGFloat )
    {
        for item in viewArray
        {
            if item is UIButton
            {
                let btn : UIButton = item as! UIButton
                btn.titleLabel?.font = UIFont(name: AvenirMedium, size: size)
            }
            
            if item is UILabel
            {
                let lbl : UILabel = item as! UILabel
                lbl.font = UIFont(name: AvenirMedium, size: size)
            }
            
            if item is UITextView
            {
                let tv : UITextView = item as! UITextView
                tv.font = UIFont(name: AvenirMedium, size: size)
            }
            
            if item is UITextField
            {
                let tf : UITextField = item as! UITextField
                tf.font = UIFont(name: AvenirMedium, size: size)
            }
        }
    }
    
    func setTextColor(viewArray : [UIView], col : UIColor)
    {
        for item in viewArray
        {
            if item is UIButton
            {
                let btn : UIButton = item as! UIButton
                btn.setTitleColor(col, for: .normal)
            }
            
            if item is UILabel
            {
                let lbl : UILabel = item as! UILabel
                lbl.textColor = col
            }
        }
    }
    
    func showToast(message : String , view : UIView)
    {
        var ts = ToastStyle()
        ts.backgroundColor = GlobalHelper.sharedInstance.toastBG
        ts.verticalPadding = CGFloat(16)
        ts.horizontalPadding = CGFloat(16)
        view.makeToast(message, duration : 2.0, style : ts)
    }
}

struct FBNames
{
    static let shIn = FBNames()
    
    let SHABLONS : String = "Shablons"
    let CATEGS : String = "Categs"
    
    let SHABLON_NAME : String = "Shablon_Name"
    let SHABLON_AUTHOR : String = "Shablon_Author"
    let SHABLON_PLACE : String = "Shablon_Place"
    let SHABLON_PASSWORD : String = "Shablon_Password"
    let SHABLON_LOGO_URL : String = "Shablon_Logo_Url"
    
    let CATEG : String = "Categs"
    let CATEG_NAME : String = "Categ_Name"
    
    let TEXT : String = "Text"
    let OBYAZ : String = "Obyaz"
    let POSITION : String = "Position"
    let WEIGHT : String = "Weight"
    
    let QUESTIONS : String = "Questions"
    let QUESTION_ID : String = "Question_Id"
    let QUESTION_TYPE : String = "Question_Type"
    let ANSWERS : String = "Answers"
    let ANSWERS_PM : String = "Answers_Pm"
    
    let ADRESSES : String = "Adresses"
    
    let CHECKBOXES : String = "CheckBoxes"
    
    let DATES : String = "Dates"
    let SHOW_DATE : String = "Show_Date"
    let SHOW_TIME : String = "Show_Time"
    
    let INFOS : String = "Infos"
    let URL_STR : String = "Url_Str"
    let IMG_URL : String = "Img_Uri"
    let FOR_OTCHET : String = "For_Otchet"
    let FOR_AUDIT : String = "For_Audit"
    
    let MEDIAS : String = "Medias"
    
    let PODPISES : String = "Podpises"
    let WRITE_TIME : String = "Write_Time"
    
    let QUESTVARS : String = "QuestVars"
    let ANSWERS_WEIGHTS : String = "Answers_Weights"
    let QUESTVARID : String = "Questvar_Id"
    
    let SEEKERS : String = "Seekers"
    let MIN : String = "MIN"
    let MAX : String = "MAX"
    let STEP : String = "STEP"
    
    let TEXTSLARGE : String = "TextsLarge"
    
    let TEXTSONELINE : String = "TextsOneLine"
    let FORMAT : String = "Format"
    
    let TOGGLES : String = "Toggles"
    
    let TIMERS : String = "Timers"
}

struct Dialog
{
    static let shIn = Dialog()
    
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

struct ImgHelper
{
    static let shIn = ImgHelper()
    
    func loadImageFromURL(urlStr : String , imgView : UIImageView)
    {
        let url = URL(string: urlStr)
        imgView.kf.setImage(with: url)
    }
}

struct DLShablon
{
    static let shIn = DLShablon()
    
    static var downloadingShablon : Model_Shablon = Model_Shablon()
    
    
    
}




func randomString() -> String
{
    let charSet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    var c = Array(charSet)
    
    var s:String = ""
    for n in 0...20
    {
        let randomInt = Int(arc4random_uniform(UInt32(c.count)))
        s.append(c[randomInt])
    }
    return s
}












