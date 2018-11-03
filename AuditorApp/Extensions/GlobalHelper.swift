import Foundation
import UIKit
import Toast_Swift
import FirebaseDatabase
import JGProgressHUD
import Kingfisher
import BetterSegmentedControl
import SystemConfiguration
import FontAwesome_swift




struct GlobalHelper
{
    let INSERT_NEW_USER_URL = "http://www.eikei.ru/alisadb/insertNewUser.php"
    let GET_ALL_RESTARAUNTS_URL = "http://www.eikei.ru/alisadb/getAllRestoraunts.php"
    let GET_OTHCET_BY_ID = "http://www.eikei.ru/alisadb/getOtchetById.php"
    let GET_USER_ID_URL = "http://www.eikei.ru/alisadb/getUserId.php"
    let URL_TO_UPLOAD_OTHCETS = "http://www.eikei.ru/alisafiles/savefile.php"
    let INSERT_OTCHET_URL = "http://www.eikei.ru/alisadb/insertOtchet.php"
    let INSERT_CATEG_URL = "http://www.eikei.ru/alisadb/insertCateg.php"
    let GET_USER_BY_FB_ID = "http://www.eikei.ru/alisadb/getUserByFbID.php"
    
    let userName = "UserName"
    let userSurname = "UserSurname"
    let userId = "UserId"
    
    
    let uFbId = "Fb_Id"
    let uLocal_Id = "Local_Id"
    let uName = "Name"
    let uUser_Id = "User_Id"
    let uRestarauntId = "Restaraunt_Id"
    let uPercent = "Percent"
    let uLogoUrl = "Logo_Url"
    let uDate = "Date"

    
    
    let fawRegular = UIFont(name: "FontAwesome5FreeRegular", size: 20)
    let fawSolid = UIFont(name: "FontAwesome5FreeSolid", size: 20)
    let fawBrands = UIFont(name : "FontAwesome5BrandsRegular", size: 20)
    
    
    
    
    
    
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
    let toastBG : UIColor = UIColor(displayP3Red: 105/255, green: 105/255, blue: 105/255, alpha: 230/255)
    
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
    
    func isConnectedToNetwork() -> Bool
    {
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress)
        {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1)
            {
                zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false
        {
            return false
        }
        
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        return ret
    }
    
    
    func dateToInt(date : Date) -> Int
    {
        let timeInterval = date.timeIntervalSince1970
        let myInt = Int(timeInterval)
        return myInt
    }
    
    func intToDate( intDate : Int) -> Date
    {
        let timeInterval = Double(intDate)
        let date = Date(timeIntervalSince1970: timeInterval)
        return date
    }

    
    func currentUser() -> [String?]
    {
        let defaults = UserDefaults.standard
        let name = defaults.string(forKey: userName)
        let surname = defaults.string(forKey: userSurname)
        let id = defaults.string(forKey: userId)
        let answer = [name,surname,id]
        return answer
    }
    
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
    
    func isValidEmail(testStr:String) -> Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
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
    
    
    func showToastWithDuration(message : String , view : UIView, duration : Double)
    {
        var ts = ToastStyle()
        ts.backgroundColor = GlobalHelper.sharedInstance.toastBG
        ts.messageFont = UIFont.systemFont(ofSize: 16)
        ts.verticalPadding = CGFloat(8)
        ts.horizontalPadding = CGFloat(8)
        view.makeToast(message, duration : duration, style : ts)
    }
    
    
    
    
    func showToast(message : String , view : UIView)
    {
        var ts = ToastStyle()
        ts.backgroundColor = GlobalHelper.sharedInstance.toastBG
        ts.messageFont = UIFont.systemFont(ofSize: 16)
        ts.verticalPadding = CGFloat(8)
        ts.horizontalPadding = CGFloat(8)
        view.makeToast(message, duration : 3.0, style : ts)
    }
    
//    func showImageToast(message : String , view :UIView)
//    {
//        var ts = ToastStyle()
//        ts.backgroundColor = GlobalHelper.sharedInstance.toastBG
//        ts.verticalPadding = CGFloat(8)
//        ts.horizontalPadding = CGFloat(16)
//        let imgWarn = UIImage(named: "ic_warning")
//        view.makeToast("message", duration: 3.0, position: .bottom, title: nil, image: imgWarn, style : ts)
//    }
    
    
    
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
    let IS_FATAL : String = "Is_Fatal";
    
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



func dateToStr(date : Date) -> String
{
    let formatter = DateFormatter()
    formatter.locale = NSLocale(localeIdentifier: "ru_RU") as Locale?
    
    formatter.dateFormat = "yyyy-MMMM-dd"
    
    let str = formatter.string(from: date)
    return str
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



extension UIApplication
{
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController?
    {
        
        if let nav = base as? UINavigationController
        {
            return topViewController(base: nav.visibleViewController)
        }
        
        if let tab = base as? UITabBarController
        {
            let moreNavigationController = tab.moreNavigationController
            
            if let top = moreNavigationController.topViewController, top.view.window != nil
            {
                return topViewController(base: top)
            }
            else if let selected = tab.selectedViewController
            {
                return topViewController(base: selected)
            }
        }
        
        if let presented = base?.presentedViewController {
            
            return topViewController(base: presented)
        }
        
        return base
    }
}








