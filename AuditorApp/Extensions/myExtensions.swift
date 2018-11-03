import UIKit
import Foundation
import Firebase
import CoreData

let AvenirMedium : String = "Avenir-Medium"
let segueToUserMEnu : String = "toUserMenu"






extension UIView
{
    func visiblity(gone: Bool, dimension: CGFloat = 0.0, attribute: NSLayoutAttribute = .height) -> Void {
        if let constraint = (self.constraints.filter{$0.firstAttribute == attribute}.first) {
            constraint.constant = gone ? 0.0 : dimension
            //self.layoutIfNeeded()
            self.isHidden = gone
        }
    }
}

extension String
{
    func trim() -> String
    {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
}

extension UIImage
{
    enum JPEGQuality: CGFloat
    {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    func jpeg(_ quality: JPEGQuality) -> Data?
    {
        return UIImageJPEGRepresentation(self, quality.rawValue)
    }
}

extension UIView
{
    
    func asImage() -> UIImage
    {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image
            {
                rendererContext in
                layer.render(in: rendererContext.cgContext)
            }
    }
}

extension UIImage
{
    
    func resizeByByte(maxByte: Int) {
        var compressQuality: CGFloat = 1
        var imageByte = UIImageJPEGRepresentation(self, 1)?.count
        
        while imageByte! > maxByte {
            imageByte = UIImageJPEGRepresentation(self, compressQuality)?.count
            compressQuality -= 0.1
        }
    }
}


extension UIResponder
{
    var parentViewController: UIViewController?
    {
        return (self.next as? UIViewController) ?? self.next?.parentViewController
    }
}

extension Date
{
    func timeStrFromDate (date : Date) -> String
    {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        
        let hourStr = hour < 10 ? "0\(hour)" : String(hour)
        let minStr = minutes < 10 ? "0\(minutes)" : String(minutes)
        
        let dateStr = "\(hourStr):\(minStr)"
        return dateStr
    }
}

extension String
{
    
    func isValidURL() -> Bool
    {
        
        if let url = URL(string: self) {
            
            return UIApplication.shared.canOpenURL(url)
        }
        
        return false
    }
}

extension UIViewController : btnDownloadDelegate
{
    func timeStrFromDate (date : Date) -> String
    {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        
        let hourStr = hour < 10 ? "0\(hour)" : String(hour)
        let minStr = minutes < 10 ? "0\(minutes)" : String(minutes)
        
        let dateStr = "\(hourStr):\(minStr)"
        return dateStr
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
        }
    }
    
    func btnPressed(shablon: Model_Shablon)
    {
        downloadAudit(fbId: shablon.fbId!)
    }
    
    
    func downloadAudit(fbId : String)
    {
        let dialog = myDialog()
        let currentVc = UIApplication.topViewController()
        
        dialog.show(message: "Загрузка", view: (currentVc?.view!)!)
        
        let shablon = Model_Shablon()

        //GlobalHelper.sharedInstance.dbShablonRef.child(fbId).observe(.value)
        GlobalHelper.sharedInstance.dbShablonRef.child(fbId).observeSingleEvent(of: .value)
        {
            (snapshot) in
            
            let fbId = snapshot.key
            let name = snapshot.childSnapshot(forPath: FBNames.shIn.SHABLON_NAME).value as! String
            let pass = snapshot.childSnapshot(forPath: FBNames.shIn.SHABLON_PASSWORD).value as! String
            let place = snapshot.childSnapshot(forPath: FBNames.shIn.SHABLON_PLACE).value as! String
            let author = snapshot.childSnapshot(forPath: FBNames.shIn.SHABLON_AUTHOR).value as! String
            if snapshot.hasChild(FBNames.shIn.SHABLON_LOGO_URL)
            {
                let logoUrl = snapshot.childSnapshot(forPath: FBNames.shIn.SHABLON_LOGO_URL).value as! String
                shablon.logoUrl = logoUrl
            }
        
            shablon.fbId = fbId
            shablon.name = name
            shablon.place = place
            shablon.author = author
            shablon.password = pass
            

            for categSnapshot in snapshot.childSnapshot(forPath: FBNames.shIn.CATEG).children
            {
                let categ = Model_Categ()
                
                let categSnap = categSnapshot as! DataSnapshot
                let categName = categSnap.childSnapshot(forPath: FBNames.shIn.CATEG_NAME).value as! String
                categ.name = categName
                let categNum = Int(categSnap.key)
                print(categNum!)
                
                for questSnapshot in categSnap.childSnapshot(forPath: FBNames.shIn.QUESTIONS).children
                {
                    let question = Model_Question()
                    
                    let questSnap = questSnapshot as! DataSnapshot
                    
                    let text = questSnap.childSnapshot(forPath: FBNames.shIn.TEXT).value as! String
                    let obyaz = questSnap.childSnapshot(forPath: FBNames.shIn.OBYAZ).value as! Int
                    let position = questSnap.childSnapshot(forPath: FBNames.shIn.POSITION).value as! Int
                    
                    let weight = questSnap.childSnapshot(forPath: FBNames.shIn.WEIGHT).value as! Int
                    
                    let questID = questSnap.childSnapshot(forPath: FBNames.shIn.QUESTION_ID).value as! String
                    let questType = questSnap.childSnapshot(forPath: FBNames.shIn.QUESTION_TYPE).value as! Int
                    
                    var fatalNum = 0;
                    
                    if questSnap.hasChild(FBNames.shIn.IS_FATAL)
                    {
                        fatalNum = questSnap.childSnapshot(forPath: FBNames.shIn.IS_FATAL).value as! Int
                    }

                    
                    question.text = text
                    question.obyaz = obyaz
                    question.positionInLa = position
                    question.weight = weight
                    
                    question.questionRandomID = questID
                    question.questionType = questType
                    
                    question.categNum = categNum
                    question.fbId = fbId
                    
                    question.isFatal = fatalNum;
                    
                    if questType == 2
                    {
                        for answSnap in questSnap.childSnapshot(forPath: FBNames.shIn.ANSWERS).children
                        {
                            let answer = (answSnap as! DataSnapshot).value as! String
                            question.answerVariants.append(answer)
                        }
                        
                        for pmSnap in questSnap.childSnapshot(forPath: FBNames.shIn.ANSWERS_PM).children
                        {
                            let pm = (pmSnap as! DataSnapshot).value as! Int
                            question.plusMinus.append(pm)
                        }
                    }
                    
                    categ.questions.append(question)
                }
                
                for  adressSnapshot in categSnap.childSnapshot(forPath: FBNames.shIn.ADRESSES).children
                {
                    let adress = Model_Adress()
                    
                    let adressSnap = adressSnapshot as! DataSnapshot
                    
                    let text = adressSnap.childSnapshot(forPath: FBNames.shIn.TEXT).value as! String
                    let obyaz = adressSnap.childSnapshot(forPath: FBNames.shIn.OBYAZ).value as! Int
                    let position = adressSnap.childSnapshot(forPath: FBNames.shIn.POSITION).value as! Int
                
                    adress.text = text
                    adress.obyaz = obyaz
                    adress.positionInLa = position
                
                    adress.categNum = categNum
                    adress.fbId = fbId
                    
                    categ.adresses.append(adress)
                }
                
                for  checkBoxSnapshot in categSnap.childSnapshot(forPath: FBNames.shIn.CHECKBOXES).children
                {
                    let checkBox = Model_CheckBox()
                    
                    let checkBoxSnap = checkBoxSnapshot as! DataSnapshot
                    
                    let text = checkBoxSnap.childSnapshot(forPath: FBNames.shIn.TEXT).value as! String
                    let obyaz = checkBoxSnap.childSnapshot(forPath: FBNames.shIn.OBYAZ).value as! Int
                    let position = checkBoxSnap.childSnapshot(forPath: FBNames.shIn.POSITION).value as! Int
                    
                    let weight = checkBoxSnap.childSnapshot(forPath: FBNames.shIn.WEIGHT).value as! Int
                    
                    checkBox.text = text
                    checkBox.obyaz = obyaz
                    checkBox.positionInLa = position
                    
                    checkBox.weight = weight
                    
                    checkBox.categNum = categNum
                    checkBox.fbId = fbId
                    
                    categ.checkBoxes.append(checkBox)
                }
                
                for dateSnapshot in categSnap.childSnapshot(forPath: FBNames.shIn.DATES).children
                {
                    let date = Model_Date()
                    
                    let dateSnap = dateSnapshot as! DataSnapshot
                    
                    let text = dateSnap.childSnapshot(forPath: FBNames.shIn.TEXT).value as! String
                    let obyaz = dateSnap.childSnapshot(forPath: FBNames.shIn.OBYAZ).value as! Int
                    let position = dateSnap.childSnapshot(forPath: FBNames.shIn.POSITION).value as! Int
                    
                    let showDate = dateSnap.childSnapshot(forPath: FBNames.shIn.SHOW_DATE).value as! Int
                    let showTime = dateSnap.childSnapshot(forPath: FBNames.shIn.SHOW_TIME).value as! Int
                    
                    date.text = text
                    date.obyaz = obyaz
                    date.positionInLa = position
                    
                    date.categNum = categNum
                    date.fbId = fbId
                    
                    date.showDate = showDate
                    date.showTime = showTime
                    
                    categ.dates.append(date)
                }
                
                for infoSnapshot in categSnap.childSnapshot(forPath: FBNames.shIn.INFOS).children
                {
                    let info = Model_Info()
                    
                    let infoSnap = infoSnapshot as! DataSnapshot
                    
                    let text = infoSnap.childSnapshot(forPath: FBNames.shIn.TEXT).value as! String
                    let position = infoSnap.childSnapshot(forPath: FBNames.shIn.POSITION).value as! Int
                    
                    let urlStr = infoSnap.childSnapshot(forPath: FBNames.shIn.URL_STR).value as! String
                    let imgUrl = infoSnap.childSnapshot(forPath: FBNames.shIn.IMG_URL).value as? String
                    let forOtchet = infoSnap.childSnapshot(forPath: FBNames.shIn.FOR_OTCHET).value  as! Int
                    let forAudit = infoSnap.childSnapshot(forPath: FBNames.shIn.FOR_AUDIT).value as! Int
                    
                    info.text = text
                    info.positionInLa = position
                    
                    info.categNum = categNum
                    info.fbId = fbId
                    
                    info.urlStr = urlStr
                    info.imgUrl = imgUrl
                    info.forAudit = forAudit
                    info.forOtchet = forOtchet
                    
                    categ.infos.append(info)
                }
                
                for medisSnapshot in categSnap.childSnapshot(forPath: FBNames.shIn.MEDIAS).children
                {
                    let media = Model_Media()
                    
                    let mediaSnap = medisSnapshot as! DataSnapshot
                    
                    let text = mediaSnap.childSnapshot(forPath: FBNames.shIn.TEXT).value as! String
                    let obyaz = mediaSnap.childSnapshot(forPath: FBNames.shIn.OBYAZ).value as! Int
                    let position = mediaSnap.childSnapshot(forPath: FBNames.shIn.POSITION).value as! Int
                    
                    media.text = text
                    media.obyaz = obyaz
                    media.positionInLa = position
                    
                    media.categNum = categNum
                    media.fbId = fbId
                    
                    categ.medias.append(media)
                    
                }
                
                for podpisSnapshot in categSnap.childSnapshot(forPath: FBNames.shIn.PODPISES).children
                {
                    let podpis = Model_Podpis()
                    
                    let podpisSnap = podpisSnapshot as! DataSnapshot
                    
                    let text = podpisSnap.childSnapshot(forPath: FBNames.shIn.TEXT).value as! String
                    let obyaz = podpisSnap.childSnapshot(forPath: FBNames.shIn.OBYAZ).value as! Int
                    let position = podpisSnap.childSnapshot(forPath: FBNames.shIn.POSITION).value as! Int
                    
                    let writeTime = podpisSnap.childSnapshot(forPath: FBNames.shIn.WRITE_TIME).value as! Int
                    
                    podpis.text = text
                    podpis.obyaz = obyaz
                    podpis.positionInLa = position
                    
                    podpis.categNum = categNum
                    podpis.fbId = fbId
                    
                    podpis.writeTime = writeTime
                    
                    categ.podpises.append(podpis)
                }
                
                for questVarSnapshot in categSnap.childSnapshot(forPath: FBNames.shIn.QUESTVARS).children
                {
                    let questVar = Model_QuestVar()
                    
                    let questVarSnap = questVarSnapshot as! DataSnapshot
                    
                    let text = questVarSnap.childSnapshot(forPath: FBNames.shIn.TEXT).value as! String
                    let obyaz = questVarSnap.childSnapshot(forPath: FBNames.shIn.OBYAZ).value as! Int
                    let position = questVarSnap.childSnapshot(forPath: FBNames.shIn.POSITION).value as! Int
                    let questVarId = questVarSnap.childSnapshot(forPath: FBNames.shIn.QUESTVARID).value as! String
                    
                    var answers : [String] = []
                    var weights : [Int] = []
                    
                    for ansSnap in questVarSnap.childSnapshot(forPath: FBNames.shIn.ANSWERS).children
                    {
                        let answer = (ansSnap as! DataSnapshot).value as! String
                        answers.append(answer)
                    }
                    
                    for weightSnap in questVarSnap.childSnapshot(forPath: FBNames.shIn.ANSWERS_WEIGHTS).children
                    {
                        let asnwerWeight = (weightSnap as! DataSnapshot).value as! Int
                        weights.append(asnwerWeight)
                    }
                    
                    questVar.text = text
                    questVar.obyaz = obyaz
                    questVar.positionInLa = position
                    
                    questVar.categNum = categNum
                    questVar.fbId = fbId
                    
                    questVar.questVarRandomID = questVarId
                    questVar.answers = answers
                    questVar.weights = weights
                    
                    categ.questVars.append(questVar)
                }
                
                for seekerSnapshot in categSnap.childSnapshot(forPath: FBNames.shIn.SEEKERS).children
                {
                    let seeker = Model_Seeker()
                    
                    let seekerSnap = seekerSnapshot as! DataSnapshot
                    
                    let text = seekerSnap.childSnapshot(forPath: FBNames.shIn.TEXT).value as! String
                    let obyaz = seekerSnap.childSnapshot(forPath: FBNames.shIn.OBYAZ).value as! Int
                    let position = seekerSnap.childSnapshot(forPath: FBNames.shIn.POSITION).value as! Int
                    
                    let min = seekerSnap.childSnapshot(forPath: FBNames.shIn.MIN).value as! Double
                    let max = seekerSnap.childSnapshot(forPath: FBNames.shIn.MAX).value as! Double
                    let step = seekerSnap.childSnapshot(forPath: FBNames.shIn.STEP).value as! Double
                    
                    seeker.text = text
                    seeker.obyaz = obyaz
                    seeker.positionInLa = position
                    
                    seeker.categNum = categNum
                    seeker.fbId = fbId
                    
                    seeker.min = min
                    seeker.max = max
                    seeker.step = step
                    
                    categ.seekers.append(seeker)
                    
                }
                
                for textLargeSnapshot in categSnap.childSnapshot(forPath: FBNames.shIn.TEXTSLARGE).children
                {
                    let textLarge = Model_TextLarge()
                    
                    let textLargeSnap = textLargeSnapshot as! DataSnapshot
                    
                    let text = textLargeSnap.childSnapshot(forPath: FBNames.shIn.TEXT).value as! String
                    let obyaz = textLargeSnap.childSnapshot(forPath: FBNames.shIn.OBYAZ).value as! Int
                    let position = textLargeSnap.childSnapshot(forPath: FBNames.shIn.POSITION).value as! Int
                    
                    textLarge.text = text
                    textLarge.obyaz = obyaz
                    textLarge.positionInLa = position
                    
                    textLarge.categNum = categNum
                    textLarge.fbId = fbId
                    
                    categ.textsLarge.append(textLarge)
                }
                
                for textOneLineSnapshot in categSnap.childSnapshot(forPath: FBNames.shIn.TEXTSONELINE).children
                {
                    let textOneLine = Model_TextOneLine()
                    
                    let textOneLineSnap = textOneLineSnapshot as! DataSnapshot
                    
                    let text = textOneLineSnap.childSnapshot(forPath: FBNames.shIn.TEXT).value as! String
                    let obyaz = textOneLineSnap.childSnapshot(forPath: FBNames.shIn.OBYAZ).value as! Int
                    let position = textOneLineSnap.childSnapshot(forPath: FBNames.shIn.POSITION).value as! Int
                    
                    let format = textOneLineSnap.childSnapshot(forPath: FBNames.shIn.FORMAT).value as! Int
                    
                    textOneLine.text = text
                    textOneLine.obyaz = obyaz
                    textOneLine.positionInLa = position
                    
                    textOneLine.categNum = categNum
                    textOneLine.fbId = fbId
                    
                    textOneLine.format = format
                    
                    categ.textsOneLine.append(textOneLine)
                }
                
                for toggleSnapshot in categSnap.childSnapshot(forPath: FBNames.shIn.TOGGLES).children
                {
                    let toggle = Model_Toggle()
                    
                    let toggleSnap = toggleSnapshot as! DataSnapshot
                    
                    let text = toggleSnap.childSnapshot(forPath: FBNames.shIn.TEXT).value as! String
                    let obyaz = toggleSnap.childSnapshot(forPath: FBNames.shIn.OBYAZ).value as! Int
                    let position = toggleSnap.childSnapshot(forPath: FBNames.shIn.POSITION).value as! Int
                    
                    let weight = toggleSnap.childSnapshot(forPath: FBNames.shIn.WEIGHT).value as! Int
                    
                    toggle.text = text
                    toggle.obyaz = obyaz
                    toggle.positionInLa = position
                    toggle.weight = weight
                    
                    toggle.categNum = categNum
                    toggle.fbId = fbId
                    
                    categ.toggles.append(toggle)
                }
                
                for timerSnapshot in categSnap.childSnapshot(forPath: FBNames.shIn.TIMERS).children
                {
                    let timer = Model_Timer()
                    
                    let timerSnap = timerSnapshot as! DataSnapshot
                    
                    let text = timerSnap.childSnapshot(forPath: FBNames.shIn.TEXT).value as! String
                    let obyaz = timerSnap.childSnapshot(forPath: FBNames.shIn.OBYAZ).value as! Int
                    let position = timerSnap.childSnapshot(forPath: FBNames.shIn.POSITION).value as! Int
                    
                    timer.text = text
                    timer.obyaz = obyaz
                    timer.positionInLa = position
                    
                    timer.categNum = categNum
                    timer.fbId = fbId
                    
                    categ.timers.append(timer)
                }
                    
                    
                
                shablon.allCategs.append(categ)
            }
            
            DLShablon.downloadingShablon = shablon
            let saveTSQL = MySqlite()
            saveTSQL.saveShablon(shablon: shablon,dialog: dialog)
            
            //saveToSQLite.saveShablon(shablon: shablon)
            
        }
        
       
    }
    
    
    func makeFullAsParent(parent : UIView , child : UIView)
    {
        child.frame = parent.bounds
        child.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        parent.addSubview(child)
    }
    
}
