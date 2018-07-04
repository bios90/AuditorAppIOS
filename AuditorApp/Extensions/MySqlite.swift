import Foundation
import UIKit
import SQLite
import Kingfisher

extension UIViewController
{
    class MySqlite
    {
        let background = DispatchQueue.global()
        
        var shablonToSave : Model_Shablon!
        
        let DBDirName = "DataBaseDir"
        let DBFileName = "AuditAppDB"
        var db : Connection!
        var fm : FileManager!
        
        
        
        // ---------- All Tables--------------
         let tableShablons = Table(FBNames.shIn.SHABLONS)
         let tableCategs = Table(FBNames.shIn.CATEGS)
        
         let tableQuestions = Table(FBNames.shIn.QUESTIONS)
         let tableAdresses = Table(FBNames.shIn.ADRESSES)
         let tableCheckBoxes = Table(FBNames.shIn.CHECKBOXES)
         let tableDates = Table(FBNames.shIn.DATES)
         let tableInfos = Table(FBNames.shIn.INFOS)
         let tableQuestVars = Table(FBNames.shIn.QUESTVARS)
         let tableMedias = Table(FBNames.shIn.MEDIAS)
         let tablePodpises = Table(FBNames.shIn.PODPISES)
         let tableSeekers = Table(FBNames.shIn.SEEKERS)
         let tableToggles = Table(FBNames.shIn.TOGGLES)
         let tableTextsLarge = Table(FBNames.shIn.TEXTSLARGE)
         let tableTextOneLine = Table(FBNames.shIn.TEXTSONELINE)
         let tableTimers = Table(FBNames.shIn.TIMERS)
        
         let tableQuestAnswers = Table("QuestAnswers")
         let tableQVarAnswers = Table("QVarAnswers")
        
         let tableOtchet = Table("Otchets")
        //----------------------------------------------------
        
        
        
        //---------------All Colums---------------
         let colFbId = Expression<String?>("FbID")
        
         let colShablonName  = Expression<String?>(FBNames.shIn.SHABLON_NAME)
         let colShablonAuthor  = Expression<String?>(FBNames.shIn.SHABLON_AUTHOR)
         let colShablonPlace  = Expression<String?>(FBNames.shIn.SHABLON_PLACE)
         let colShablonPassword = Expression<String?>(FBNames.shIn.SHABLON_PASSWORD)
         let colShablonLogoName = Expression<String?>("LocalLogoFileName")
        
         let colCategName = Expression<String?>(FBNames.shIn.CATEG_NAME)
         let colCategPosition = Expression<Int?>("CategPosition")
    
         let colText = Expression<String?>(FBNames.shIn.TEXT)
         let colObyaz = Expression<Int?>(FBNames.shIn.OBYAZ)
         let colPosition = Expression<Int?>(FBNames.shIn.POSITION)
         let colWeight = Expression<Int?>(FBNames.shIn.WEIGHT)
         let colCategNum = Expression<Int?>("CategNum")
        
         let colQuestionId = Expression<String?>(FBNames.shIn.QUESTION_ID)
         let colQuestionType = Expression<Int?>(FBNames.shIn.QUESTION_TYPE)
        
         let colAnswerPM = Expression<Int?>(FBNames.shIn.ANSWERS_PM)
 
         let colShowDate = Expression<Int?>(FBNames.shIn.SHOW_DATE)
         let colShowTime = Expression<Int?>(FBNames.shIn.SHOW_TIME)
        
         let colUrlStr = Expression<String?>(FBNames.shIn.URL_STR)
         let colImgUrl = Expression<String?>(FBNames.shIn.IMG_URL)
         let colImgLocalName = Expression<String?>("InfoImgLocalName")
         let colForOtchet = Expression<Int?>(FBNames.shIn.FOR_OTCHET)
         let colForAudit = Expression<Int?>(FBNames.shIn.FOR_AUDIT)
  
         let colWriteTime = Expression<Int?>(FBNames.shIn.WRITE_TIME)
        
         let colAnswerWeight = Expression<Int?>("AnswerWeight")
    
         let colMin = Expression<Double?>(FBNames.shIn.MIN)
         let colMax = Expression<Double?>(FBNames.shIn.MAX)
         let colStep = Expression<Double?>(FBNames.shIn.STEP)

         let colFormat = Expression<Int?>(FBNames.shIn.FORMAT)
        
         let colOtchetId = Expression<String?>("OtchetID")
         let colOtchetName = Expression<String?>("OtchetName")
         let colOtchetDate = Expression<Int?>("OtchetDate")
         let colOtchetPercent = Expression<Int?>("OtchetPercent")
         let colOtchetLogoFileName = Expression<String?>("OtchetLogoFileName")
         let colOtchetPdfFileName = Expression<String?>("OtchetPdfFileName")
        //----------------------------------------
        
        func saveShablon(shablon : Model_Shablon)
        {
            print("BEgin to SAvEEEEEEE")
            self.shablonToSave = shablon
            
            saveShabLogo()
            checkForInfoImages()
            
            prepareDB()
            
            createTables()
            
            //deleteIfExists()
        
            savingAllElements()
        }
        
        func prepareDB()
        {
            self.fm = FileManager.default
            do
            {
                let documentDir = try fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                
                let dbDirUrl = documentDir.appendingPathComponent(DBDirName)
                let dbFile = dbDirUrl.appendingPathComponent(DBFileName).appendingPathExtension("sqlite3")
                
                let exists = fm.fileExists(atPath: dbFile.path)
                
                if exists == false
                {
                    print("dataBase not exixts, creating")
                    do
                    {
                        try fm.createDirectory(atPath: dbDirUrl.path, withIntermediateDirectories: true, attributes: nil)
                        try fm.createFile(atPath: dbFile.path, contents: nil, attributes: nil)
                    }
                    catch
                    {
                        
                    }
                }
                else
                {
                    print("Existsssss Yeeee")
                }
                
                let database = try Connection(dbFile.path)
                self.db = database
                
                print("Finally connected!!!!")
                
                
            }
            catch
            {
                
                print(error)
            }
        }
        
        func saveShabLogo()
        {
            let imgUrl = shablonToSave.logoUrl
            if imgUrl != nil
            {
                let filename = randomString()
                shablonToSave.localImageName = filename
                
                background.async
                    {
                        print("Saving Shanlon Logo")
                        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                        let dataPath = documentsDirectory.appendingPathComponent("LocalShablonLogos")
                        
                        do
                        {
                            try FileManager.default.createDirectory(atPath: dataPath.path, withIntermediateDirectories: true, attributes: nil)
                        }
                        catch
                        {
                            print("cant Create Local Shab Logo Directory")
                        }
                        
                        let url = URL(string: imgUrl!)
                        
                        if let data = try? Data(contentsOf: url!)
                        {
                            let image: UIImage = UIImage(data: data)!
                            
                            let fileURL = dataPath.appendingPathComponent("\(filename).jpg")
                            
                            let data = UIImageJPEGRepresentation(image, 1)
                            
                            if let data = UIImageJPEGRepresentation(image, 1.0),
                                !FileManager.default.fileExists(atPath: fileURL.path)
                            {
                                do
                                {
                                    try data.write(to: fileURL)
                                    print("Shablon Logo saved")
                                } catch
                                {
                                    print("error saving sahblon logo file:", error)
                                }
                            }
                        }
                    }
            }
        }
        
        func checkForInfoImages()
        {
            var imgUrls : [String] = []
            var fileNames : [String] = []
            
            for categ in shablonToSave.allCategs
            {
                for info in categ.infos
                {
                    if info.imgUrl != nil
                    {
                        var name = randomString()
                        
                        imgUrls.append(info.imgUrl)
                        fileNames.append(name)
                        
                        info.localFileName = name
                    }
                }
            }
            
            if imgUrls.count != 0
            {
                background.async
                    {
                        for a in 0..<imgUrls.count
                        {
                            print("Trynin to download in background, Try number ---- \(a)")
                            
                            let urlStr = imgUrls[a]
                            let filename = fileNames[a]
                            
                            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                            let dataPath = documentsDirectory.appendingPathComponent("LocalInfos")
                            
                            do
                            {
                                try FileManager.default.createDirectory(atPath: dataPath.path, withIntermediateDirectories: true, attributes: nil)
                            }
                            catch 
                            {
                                print("cant create InfosDirectory")
                                
                            }
                            

                            let url = URL(string:urlStr)
                            if let data = try? Data(contentsOf: url!)
                            {
                                let image: UIImage = UIImage(data: data)!
                           
                        
                            // create the destination file url to save your image
                            let fileURL = dataPath.appendingPathComponent("\(filename).jpg")
                                
                            let data = UIImageJPEGRepresentation(image, 1)
                            // get your UIImage jpeg data representation and check if the destination file url already exists
                            if let data = UIImageJPEGRepresentation(image, 1.0),
                                !FileManager.default.fileExists(atPath: fileURL.path)
                                {
                                    do
                                    {
                                        // writes the image data to disk
                                        try data.write(to: fileURL)
                                        print("file saved")
                                    } catch
                                    {
                                        print("error saving file:", error)
                                    }
                                }
                            }
                    
                    
                }
                }
            }
        }
        
        func createTables()
        {
            let createShabRB = tableShablons.create { (table) in
                table.column(colFbId)
                table.column(colShablonName)
                table.column(colShablonAuthor)
                table.column(colShablonPassword)
                table.column(colShablonPlace)
                table.column(colShablonLogoName)
            }
            
            let createCategTB = tableCategs.create { (table) in
                table.column(colFbId)
                table.column(colCategName)
                table.column(colCategPosition)
            }
            
            let createQuestTB = tableQuestions.create { (table) in
                table.column(colFbId)
                table.column(colQuestionId)
                table.column(colCategNum)
                table.column(colPosition)
                table.column(colQuestionType)
                table.column(colText)
                table.column(colObyaz)
                table.column(colWeight)
            }
            
            let createQuestAnswerTB = tableQuestAnswers.create { (table) in
                table.column(colQuestionId)
                table.column(colFbId)
                table.column(colText)
                table.column(colAnswerPM)
            }
            
            let createQuestVarAnswerTB = tableQVarAnswers.create { (table) in
                table.column(colQuestionId)
                table.column(colFbId)
                table.column(colText)
                table.column(colAnswerWeight)
            }
            
            let createAdressesTB = tableAdresses.create { (table) in
                table.column(colFbId)
                table.column(colCategNum)
                table.column(colPosition)
                table.column(colText)
                table.column(colObyaz)
            }
            
            let createCheckBoxTB = tableCheckBoxes.create { (table) in
                table.column(colFbId)
                table.column(colCategNum)
                table.column(colPosition)
                table.column(colText)
                table.column(colObyaz)
                
                table.column(colWeight)
            }
            
            let createDatesTB = tableDates.create { (table) in
                table.column(colFbId)
                table.column(colCategNum)
                table.column(colPosition)
                table.column(colText)
                table.column(colObyaz)
                
                table.column(colShowDate)
                table.column(colShowTime)
            }
            
            let createInfoTB = tableInfos.create { (table) in
                table.column(colFbId)
                table.column(colCategNum)
                table.column(colPosition)
                table.column(colText)
                
                table.column(colUrlStr)
                table.column(colImgUrl)
                table.column(colImgLocalName)
                table.column(colForAudit)
                table.column(colForOtchet)
            }
            
            let createQuestVarTB = tableQuestVars.create { (table) in
                table.column(colFbId)
                table.column(colQuestionId)
                table.column(colCategNum)
                table.column(colPosition)
                table.column(colText)
                table.column(colObyaz)
            }
            
            let createMediaTB = tableMedias.create { (table) in
                table.column(colFbId)
                table.column(colCategNum)
                table.column(colPosition)
                table.column(colText)
                table.column(colObyaz)
            }
            
            let createPodpisTB = tablePodpises.create { (table) in
                table.column(colFbId)
                table.column(colCategNum)
                table.column(colPosition)
                table.column(colText)
                table.column(colObyaz)
                
                table.column(colWriteTime)
            }
            
            let createSeekerTB = tableSeekers.create { (table) in
                table.column(colFbId)
                table.column(colCategNum)
                table.column(colPosition)
                table.column(colText)
                table.column(colObyaz)
                
                table.column(colMin)
                table.column(colMax)
                table.column(colStep)
            }
            
            let createTogglesTB = tableToggles.create { (table) in
                table.column(colFbId)
                table.column(colCategNum)
                table.column(colPosition)
                table.column(colText)
                table.column(colObyaz)
                
                table.column(colWeight)
            }
            
            let createTextOLTB = tableTextOneLine.create { (table) in
                table.column(colFbId)
                table.column(colCategNum)
                table.column(colPosition)
                table.column(colText)
                table.column(colObyaz)
               
                table.column(colFormat)
            }
            
            let createTextLargeTB = tableTextsLarge.create { (table) in
                table.column(colFbId)
                table.column(colCategNum)
                table.column(colPosition)
                table.column(colText)
                table.column(colObyaz)
            }
            
            let createTimerTB = tableTimers.create { (table) in
                table.column(colFbId)
                table.column(colCategNum)
                table.column(colPosition)
                table.column(colText)
                table.column(colObyaz)
            }
            
            let createOthcetTB = tableOtchet.create { (table) in
                table.column(colOtchetId)
                table.column(colOtchetName)
                table.column(colOtchetDate)
                table.column(colOtchetPercent)
                table.column(colOtchetLogoFileName)
                table.column(colOtchetPdfFileName)
            }
            
            do
            {
                try db.run(createShabRB)
                try db.run(createCategTB)

                try db.run(createQuestTB)
                try db.run(createQuestAnswerTB)
                try db.run(createQuestVarAnswerTB)
                try db.run(createAdressesTB)
                try db.run(createCheckBoxTB)
                try db.run(createDatesTB)
                try db.run(createInfoTB)
                try db.run(createMediaTB)
                try db.run(createPodpisTB)
                try db.run(createQuestVarTB)
                try db.run(createSeekerTB)
                try db.run(createTextLargeTB)
                try db.run(createTextOLTB)
                try db.run(createTogglesTB)
                try db.run(createTimerTB)

                try db.run(createOthcetTB)

                print("Tables Created Succesfully")
            }
            catch
            {
                print("Error while creating Tables")
            }
            
        }
        
        func deleteIfExists()
        {
            //------------------------------------------Sdelat Ydalenie Foto!!!!!_----------------------------------------
            let fbId = shablonToSave.fbId!
            
            do
            {
                let deleteShablons = tableShablons.filter(colFbId == fbId)
                let deleteCategs = tableCategs.filter(colFbId == fbId)
                let deleteQuestions = tableQuestions.filter(colFbId == fbId)
                let deleteQuestAnswers = tableQuestAnswers.filter(colFbId == fbId)
                let deleteQuestVarAnswers = tableQVarAnswers.filter(colFbId == fbId)
                let deleteAdresses = tableAdresses.filter(colFbId == fbId)
                let deleteCheckBoxes = tableCheckBoxes.filter(colFbId == fbId)
                let deleteDates = tableDates.filter(colFbId == fbId)
                let deleteInfos = tableInfos.filter(colFbId == fbId)
                let deleteMedia = tableMedias.filter(colFbId == fbId)
                let deletePodpis = tablePodpises.filter(colFbId == fbId)
                let deleteQuestVars = tableQuestVars.filter(colFbId == fbId)
                let deleteSeekers = tableSeekers.filter(colFbId == fbId)
                let deleteTextLarge = tableTextsLarge.filter(colFbId == fbId)
                let deleteTextOneLine = tableTextOneLine.filter(colFbId == fbId)
                let deleteToggle = tableToggles.filter(colFbId == fbId)
                let deleteTimer  = tableTimers.filter(colFbId == fbId)
            
                try db.run(deleteShablons.delete())
                try db.run(deleteCategs.delete())
                try db.run(deleteQuestions.delete())
                try db.run(deleteQuestAnswers.delete())
                try db.run(deleteQuestVarAnswers.delete())
                try db.run(deleteAdresses.delete())
                try db.run(deleteCheckBoxes.delete())
                try db.run(deleteDates.delete())
                try db.run(deleteInfos.delete())
                try db.run(deleteMedia.delete())
                try db.run(deletePodpis.delete())
                try db.run(deleteQuestVars.delete())
                try db.run(deleteSeekers.delete())
                try db.run(deleteTextLarge.delete())
                try db.run(deleteTextOneLine.delete())
                try db.run(deleteToggle.delete())
                try db.run(deleteTimer.delete())
                
                print("Delete if Exists Completed!!!")
            }
            catch
            {
                
            }
        }
        
        func savingAllElements()
        {
            let fbId = shablonToSave.fbId!
            do
            {
                
                
                try db.run(tableShablons.insert(colFbId <- fbId, colShablonName <- shablonToSave.name,
                                                colShablonAuthor <- shablonToSave.author,
                                                colShablonPassword <- shablonToSave.password,
                                                colShablonPlace <- shablonToSave.place,
                                                colShablonLogoName <- shablonToSave.localImageName
                                                ))
                
                for categ in shablonToSave.allCategs
                {
                    let categNum = shablonToSave.allCategs.index(of: categ)
                    
                    try db.run(tableCategs.insert(colFbId <- fbId,colCategPosition <- categNum,colCategName <- categ.name,
                                                  colCategPosition <- categ.categPosition))
                    
                    for question in categ.questions
                    {
                        try db.run(tableQuestions.insert(colFbId <- fbId, colQuestionId <- question.questionRandomID,
                                                         colCategNum <- categNum, colPosition <- question.positionInLa,
                                                         colQuestionType <- question.questionType,
                                                         colText <- question.text,colObyaz <- question.obyaz,
                                                         colWeight <- question.weight))
                        
                        if question.questionType == 2
                        {
                            for a in 0..<question.answerVariants.count
                            {
                                try db.run(tableQuestAnswers.insert(colQuestionId <- question.questionRandomID, colFbId <- fbId, colText <- question.answerVariants[a],colAnswerPM <- question.plusMinus[a]))
                            }
                        }
                    }
                    
                    for adress in categ.adresses
                    {
                        try db.run(tableAdresses.insert(colFbId <- fbId,colCategNum <- categNum,
                                                        colPosition <- adress.positionInLa,colText <- adress.text,
                                                        colObyaz <- adress.obyaz))
                    }
                    
                    for checkBox in categ.checkBoxes
                    {
                        try db.run(tableCheckBoxes.insert(colFbId <- fbId,colCategNum <- categNum,
                                                        colPosition <- checkBox.positionInLa,colText <- checkBox.text,
                                                        colObyaz <- checkBox.obyaz, colWeight <- checkBox.weight))
                    }
                    
                    for date in categ.dates
                    {
                        try db.run(tableDates.insert(colFbId <- fbId,colCategNum <- categNum,
                                                        colPosition <- date.positionInLa,colText <- date.text,
                                                        colObyaz <- date.obyaz, colShowDate <- date.showDate,
                                                        colShowTime <- date.showTime))
                    }
                    
                    for info in categ.infos
                    {
                        try db.run(tableInfos.insert(colFbId <- fbId,colCategNum <- categNum,
                                                     colPosition <- info.positionInLa, colText<-info.text,
                                                     colUrlStr <- info.urlStr, colImgUrl <- info.imgUrl,
                                                     colImgLocalName <- info.localFileName, colForAudit <- info.forAudit,
                                                     colForOtchet <- info.forOtchet))
                    }
                    
                    for media in categ.medias
                    {
                        try db.run(tableMedias.insert(colFbId <- fbId,colCategNum <- categNum,
                                                        colPosition <- media.positionInLa,colText <- media.text,
                                                        colObyaz <- media.obyaz))
                    }
                    
                    for podpis in categ.podpises
                    {
                        try db.run(tablePodpises.insert(colFbId <- fbId,colCategNum <- categNum,
                                                      colPosition <- podpis.positionInLa,colText <- podpis.text,
                                                      colObyaz <- podpis.obyaz, colWriteTime <- podpis.writeTime))
                    }
                    
                    for questVar in categ.questVars
                    {
                        try db.run(tableQuestVars.insert(colFbId <- fbId, colCategNum <- categNum,
                                                         colQuestionId <- questVar.questVarRandomID,
                                                         colPosition <- questVar.positionInLa, colText <- questVar.text,
                                                         colObyaz <- questVar.obyaz))
                        
                        for a in 0..<questVar.answers.count
                        {
                            try db.run(tableQVarAnswers.insert(colQuestionId <- questVar.questVarRandomID,colFbId <- fbId,
                                                               colText <- questVar.answers[a],colAnswerWeight <- questVar.weights[a]))
                        }
                    }
                    
                    for seeker in categ.seekers
                    {
                        try db.run(tableSeekers.insert(colFbId <- fbId,colCategNum <- categNum,
                                                      colPosition <- seeker.positionInLa,colText <- seeker.text,
                                                      colObyaz <- seeker.obyaz,
                                                      colMin <- seeker.min,colMax <- seeker.max,
                                                      colStep <- seeker.step))
                    }
                    
                    for textLarge in categ.textsLarge
                    {
                        try db.run(tableTextsLarge.insert(colFbId <- fbId,colCategNum <- categNum,
                                                      colPosition <- textLarge.positionInLa,colText <- textLarge.text,
                                                      colObyaz <- textLarge.obyaz))
                    }
                    
                    for textOneLine in categ.textsOneLine
                    {
                        try db.run(tableTextOneLine.insert(colFbId <- fbId,colCategNum <- categNum,
                                                      colPosition <- textOneLine.positionInLa,colText <- textOneLine.text,
                                                      colObyaz <- textOneLine.obyaz, colFormat <- textOneLine.format))
                    }
                    
                    for toggle in categ.toggles
                    {
                        try db.run(tableToggles.insert(colFbId <- fbId,colCategNum <- categNum,
                                                           colPosition <- toggle.positionInLa,colText <- toggle.text,
                                                           colObyaz <- toggle.obyaz, colWeight <- toggle.weight))
                    }
                    
                    for timer in categ.timers
                    {
                        try db.run(tableTimers.insert(colFbId <- fbId,colCategNum <- categNum,
                                                          colPosition <- timer.positionInLa,colText <- timer.text,
                                                          colObyaz <- timer.obyaz))
                    }
                }
            
            print("shablon saves succesfully!!!")
            
            }
            catch
            {
                print(error)
            }
        }
        
        func getAllSkachannie() -> [Model_Shablon]
        {
            var allShablons : [Model_Shablon] = []
            
            prepareDB()
            
            do
            {
                let shablons = try self.db.prepare(self.tableShablons)
                for shab in shablons
                {
                    let shablon = Model_Shablon()
                    shablon.name = shab[colShablonName]!
                    shablon.author = shab[colShablonAuthor]!
                    shablon.place = shab[colShablonPlace]!
                    shablon.localImageName = shab[colShablonLogoName]
                    shablon.fbId = shab[colFbId]
                    
                    allShablons.append(shablon)
                }
            }
            catch
            {
                print("getSomeError")
                print(error)
            }
            return allShablons
        }
        
        func getFullShablon(notFullShablon : Model_Shablon) -> Model_Shablon
        {
            var fullShablon = notFullShablon
            let fbId = fullShablon.fbId!
            
            prepareDB()
            
            do
            {
                for categRow in try db.prepare(tableCategs.filter(colFbId == fbId))
                {
                    let categName = categRow[colCategName]!
                    let shablonName = fullShablon.name!
                    let categNum = categRow[colCategPosition]!
                    
                    let newCateg = Model_Categ()
                    newCateg.name = categName
                    newCateg.shabName = fullShablon.name!
                    newCateg.fbId = fbId
                    
                    print(fbId,categNum)
                    
                    for questRow in try db.prepare(tableQuestions.filter(colFbId == fbId && colCategNum == categNum))
                    {
                        let text = questRow[colText]!
                        let position = questRow[colPosition]!
                        let obyaz = questRow[colObyaz]!
                        let weight = questRow[colWeight]!
                        
                        let questRandId = questRow[colQuestionId]!
                        let questType = questRow[colQuestionType]!
                        
                        let question = Model_Question()

                        question.categNum = categNum
                        question.fbId = fbId
                        
                        question.text = text
                        question.positionInLa = position
                        question.obyaz = obyaz
                        question.weight = weight
                        
                        question.questionRandomID = questRandId
                        question.questionType = questType
                        
                        if questType == 2
                        {
                            for answerRow in try db.prepare(tableQuestAnswers.filter(colQuestionId == questRandId))
                            {
                                let answer = answerRow[colText]!
                                let pm = answerRow[colAnswerPM]!
                                
                                question.answerVariants.append(answer)
                                question.plusMinus.append(pm)
                            }
                        }
                        
                        newCateg.questions.append(question)
                    }
                    
                    for adressRow in try db.prepare(tableAdresses.filter(colFbId == fbId && colCategNum == categNum))
                    {
                        let text = adressRow[colText]!
                        let position = adressRow[colPosition]!
                        let obyaz = adressRow[colObyaz]!
                        
                        let adress = Model_Adress()
                        
                        adress.fbId = fbId
                        adress.categNum = categNum
                        
                        adress.text = text
                        adress.positionInLa = position
                        adress.obyaz = obyaz
                        
                        newCateg.adresses.append(adress)
                    }
                    
                    for checkBoxRow in try db.prepare(tableCheckBoxes.filter(colFbId == fbId && colCategNum == categNum))
                    {
                        let text = checkBoxRow[colText]!
                        let position = checkBoxRow[colPosition]!
                        let obyaz = checkBoxRow[colObyaz]!
                        let weight = checkBoxRow[colWeight]!
                        
                        let checkBox = Model_CheckBox()
                        
                        checkBox.fbId = fbId
                        checkBox.categNum = categNum
                        
                        checkBox.text = text
                        checkBox.positionInLa = position
                        checkBox.obyaz = obyaz
                        checkBox.weight = weight
                        
                        newCateg.checkBoxes.append(checkBox)
                    }
                    
                    for dateRow in try db.prepare(tableDates.filter(colFbId == fbId && colCategNum == categNum))
                    {
                        let text = dateRow[colText]!
                        let position = dateRow[colPosition]!
                        let obyaz = dateRow[colObyaz]!
                        
                        let showTime = dateRow[colShowTime]!
                        let showDate = dateRow[colShowDate]!
                        
                        let date = Model_Date()
                        
                        date.fbId = fbId
                        date.categNum = categNum
                        
                        date.text = text
                        date.positionInLa = position
                        date.obyaz = obyaz
                        
                        date.showDate = showDate
                        date.showTime = showTime
                        
                        newCateg.dates.append(date)
                    }
                    
                    for infoRow in try db.prepare(tableInfos.filter(colFbId == fbId && colCategNum == categNum))
                    {
                        let text = infoRow[colText]!
                        let position = infoRow[colPosition]!
                        
                        let urlStr = infoRow[colUrlStr]
                        let imgUrl = infoRow[colImgUrl]
                        let imgLocalName = infoRow[colImgLocalName]
                        let forOtchet = infoRow[colForOtchet]!
                        let forAudit = infoRow[colForAudit]!
                        
                        let info = Model_Info()
                        
                        info.fbId = fbId
                        info.categNum = categNum
                        
                        info.text = text
                        info.positionInLa = position
                        info.urlStr = urlStr
                        info.imgUrl = imgUrl
                        info.localFileName = imgLocalName!
                        info.forAudit = forAudit
                        info.forOtchet = forOtchet
                        
                        newCateg.infos.append(info)
                    }
                    
                    for mediaRow in try db.prepare(tableMedias.filter(colFbId == fbId && colCategNum == categNum))
                    {
                        let text = mediaRow[colText]!
                        let position = mediaRow[colPosition]!
                        let obyaz = mediaRow[colObyaz]!
                        
                        let media = Model_Media()
                        
                        media.fbId = fbId
                        media.categNum = categNum
                        
                        media.text = text
                        media.positionInLa = position
                        media.obyaz = obyaz
                        
                        newCateg.medias.append(media)
                    }
                    
                    for podpisRow in try db.prepare(tablePodpises.filter(colFbId == fbId && colCategNum == categNum))
                    {
                        let text = podpisRow[colText]!
                        let position = podpisRow[colPosition]!
                        let obyaz = podpisRow[colObyaz]!
                        
                        let writeTime = podpisRow[colWriteTime]!
                        
                        let podpis = Model_Podpis()
                        
                        podpis.fbId = fbId
                        podpis.categNum = categNum
                        
                        podpis.text = text
                        podpis.positionInLa = position
                        podpis.obyaz = obyaz
                        
                        podpis.writeTime = writeTime
                        
                        newCateg.podpises.append(podpis)
                    }
                    
                    for questVarRow in try db.prepare(tableQuestVars.filter(colFbId == fbId && colCategNum == categNum))
                    {
                        let text = questVarRow[colText]!
                        let position = questVarRow[colPosition]!
                        let obyaz = questVarRow[colObyaz]!
                        
                        let randomId = questVarRow[colQuestionId]!
                        
                        let questVar = Model_QuestVar()
                        
                        questVar.fbId = fbId
                        questVar.categNum = categNum
                        
                        questVar.text = text
                        questVar.positionInLa = position
                        questVar.obyaz = obyaz
                        
                        questVar.questVarRandomID = randomId
                        
                        for answerRow in try db.prepare(tableQVarAnswers.filter(colQuestionId == randomId))
                        {
                            let answer = answerRow[colText]!
                            let answerWeight = answerRow[colAnswerWeight]!
                            
                            questVar.answers.append(answer)
                            questVar.weights.append(answerWeight)
                        }
                        
                        newCateg.questVars.append(questVar)
                    }
                    
                    for seekerRow in try db.prepare(tableSeekers.filter(colFbId == fbId && colCategNum == categNum))
                    {
                        let text = seekerRow[colText]!
                        let position = seekerRow[colPosition]!
                        let obyaz = seekerRow[colObyaz]!
                        
                        let min = seekerRow[colMin]!
                        let max = seekerRow[colMax]!
                        let step = seekerRow[colStep]!
                        
                        let seeker = Model_Seeker()
                        
                        seeker.fbId = fbId
                        seeker.categNum = categNum
                        
                        seeker.text = text
                        seeker.positionInLa = position
                        seeker.obyaz = obyaz
                        
                        seeker.min = min
                        seeker.max = max
                        seeker.step = step
                        
                        newCateg.seekers.append(seeker)
                    }
                    
                    for textLargeRow in try db.prepare(tableTextsLarge.filter(colFbId == fbId && colCategNum == categNum))
                    {
                        let text = textLargeRow[colText]!
                        let position = textLargeRow[colPosition]!
                        let obyaz = textLargeRow[colObyaz]!
                        
                        let textLarge = Model_TextLarge()
                        
                        textLarge.fbId = fbId
                        textLarge.categNum = categNum
                        
                        textLarge.text = text
                        textLarge.positionInLa = position
                        textLarge.obyaz = obyaz
                        
                        newCateg.textsLarge.append(textLarge)
                    }
                    
                    for textOnelineRow in try db.prepare(tableTextOneLine.filter(colFbId == fbId && colCategNum == categNum))
                    {
                        let text = textOnelineRow[colText]!
                        let position = textOnelineRow[colPosition]!
                        let obyaz = textOnelineRow[colObyaz]!
                        
                        let format = textOnelineRow[colFormat]
                        
                        let textOneline = Model_TextOneLine()
                        
                        textOneline.fbId = fbId
                        textOneline.categNum = categNum
                        
                        textOneline.text = text
                        textOneline.positionInLa = position
                        textOneline.obyaz = obyaz
                        
                        textOneline.format = format
                        
                        newCateg.textsOneLine.append(textOneline)
                    }
                    
                    for toggleRow in try db.prepare(tableToggles.filter(colFbId == fbId && colCategNum == categNum))
                    {
                        let text = toggleRow[colText]!
                        let position = toggleRow[colPosition]!
                        let obyaz = toggleRow[colObyaz]!
                        let weight = toggleRow[colWeight]!
                        
                        let toggle = Model_Toggle()
                        
                        toggle.fbId = fbId
                        toggle.categNum = categNum
                        
                        toggle.text = text
                        toggle.positionInLa = position
                        toggle.obyaz = obyaz
                        toggle.weight = weight
                        
                        newCateg.toggles.append(toggle)
                    }
                    
                    for timerRow in try db.prepare(tableTimers.filter(colFbId == fbId && colCategNum == categNum))
                    {
                        let text = timerRow[colText]!
                        let position = timerRow[colPosition]!
                        let obyaz = timerRow[colObyaz]!
                        
                        let timer = Model_Timer()
                        
                        timer.fbId = fbId
                        timer.categNum = categNum
                        
                        timer.text = text
                        timer.positionInLa = position
                        timer.obyaz = obyaz
                        
                        newCateg.timers.append(timer)
                    }
                
                    print(newCateg.questions.count,"Suuma vsegVoprosov v categorii!!!")
                    
                    newCateg.sumAllElements()
                    newCateg.sortElements()
                    
                    fullShablon.allCategs.append(newCateg)
                }
            }
            catch
            {
                print(error)
            }
            
            
            
            
            
            
            
            
            
            
            return fullShablon
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }

}
