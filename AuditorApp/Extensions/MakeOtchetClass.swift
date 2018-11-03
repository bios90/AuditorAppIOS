import UIKit
import PDFKit
import PDFGenerator

let gh = GlobalHelper.sharedInstance
let gc = GlobalClass.sharedInstance

var pageWidth : CGFloat!
var pageHeight : CGFloat!

let height26 : CGFloat = 26

var currentShablon : Model_Shablon!

var lastView : UIView!

var currentPage : UIView!
var listOfPages : [UIView] = []


let widthMinus : CGFloat = 44
let beginTopMargin : CGFloat = 20

let bezOtvetaStr = "Без ответа"

var listAddedSkrepka : [Skrepka_Data] = []
var listAddedImagesGroup : [[UIImage]] = []


var lblProcent : UILabel!


let green = UIColor(displayP3Red: 79/255, green: 201/255, blue: 150/255, alpha: 1)
let red = UIColor(displayP3Red: 215/255, green: 91/255, blue: 95/255, alpha: 1)

class MakeOtchetClass
{
    func makePdf(shablon : Model_Shablon)
    {
        listAddedImagesGroup.removeAll()
        listAddedSkrepka.removeAll()
        currentShablon = shablon
        countWeight()
        
        pageWidth = 595.2
        pageHeight = 841.8
        
        currentPage = UIView(frame: CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight))
        currentPage.backgroundColor = UIColor.white
        
        
        let shablonNameLbl = UILabel()
        shablonNameLbl.translatesAutoresizingMaskIntoConstraints = false
        shablonNameLbl.text = shablon.name
        shablonNameLbl.textAlignment = .center
        shablonNameLbl.font = UIFont.systemFont(ofSize: 25)
        currentPage.addSubview(shablonNameLbl)
        
        shablonNameLbl.widthAnchor.constraint(equalTo: currentPage.widthAnchor, multiplier: 1, constant: 0).isActive = true
        shablonNameLbl.heightAnchor.constraint(equalToConstant: height26).isActive = true
        shablonNameLbl.centerXAnchor.constraint(equalTo: currentPage.centerXAnchor).isActive = true
        shablonNameLbl.topAnchor.constraint(equalTo: currentPage.topAnchor, constant: 48).isActive = true
        shablonNameLbl.layoutIfNeeded()
        
        let whoLbl = UILabel()
        whoLbl.translatesAutoresizingMaskIntoConstraints = false
        whoLbl.text = "Проверяющий : \(gh.currentUser()[0]!) \(gh.currentUser()[1]!)"
        whoLbl.textAlignment = .left
        whoLbl.font = UIFont.systemFont(ofSize: 13)
        currentPage.addSubview(whoLbl)
        
        whoLbl.widthAnchor.constraint(equalTo: currentPage.widthAnchor, multiplier: 0.5, constant: -22).isActive = true
        whoLbl.heightAnchor.constraint(equalToConstant: height26).isActive = true
        whoLbl.leftAnchor.constraint(equalTo: currentPage.leftAnchor, constant: 22).isActive = true
        whoLbl.topAnchor.constraint(equalTo: shablonNameLbl.bottomAnchor, constant : 20).isActive = true
        whoLbl.layoutIfNeeded()
        
        let lblBeginTime = UILabel()
        lblBeginTime.translatesAutoresizingMaskIntoConstraints = false
        lblBeginTime.text = "Время начала - \(shablon.beginTime!)"
        lblBeginTime.textAlignment = .left
        lblBeginTime.font = UIFont.systemFont(ofSize: 13)
        currentPage.addSubview(lblBeginTime)
        
        lblBeginTime.widthAnchor.constraint(equalTo: currentPage.widthAnchor, multiplier: 0.5, constant: -22).isActive = true
        lblBeginTime.heightAnchor.constraint(equalToConstant: height26).isActive = true
        lblBeginTime.leftAnchor.constraint(equalTo: currentPage.leftAnchor, constant: 22).isActive = true
        lblBeginTime.topAnchor.constraint(equalTo: whoLbl.bottomAnchor).isActive = true
        lblBeginTime.layoutIfNeeded()
        
        let lblEndTime = UILabel()
        lblEndTime.translatesAutoresizingMaskIntoConstraints = false
        lblEndTime.text = "Время окончания - \(timeStrFromDate(date: Date()))"
        lblEndTime.textAlignment = .left
        lblEndTime.font = UIFont.systemFont(ofSize: 13)
        currentPage.addSubview(lblEndTime)
        
        lblEndTime.widthAnchor.constraint(equalTo: currentPage.widthAnchor, multiplier: 0.5, constant: -22).isActive = true
        lblEndTime.heightAnchor.constraint(equalToConstant: height26).isActive = true
        lblEndTime.leftAnchor.constraint(equalTo: currentPage.leftAnchor, constant: 22).isActive = true
        lblEndTime.topAnchor.constraint(equalTo: lblBeginTime.bottomAnchor).isActive = true
        lblEndTime.layoutIfNeeded()
        
        let lblPlace = UILabel()
        lblPlace.translatesAutoresizingMaskIntoConstraints = false
        lblPlace.text = "Место проведения - \(shablon.place!)"
        lblPlace.textAlignment = .left
        lblPlace.font = UIFont.systemFont(ofSize: 13)
        currentPage.addSubview(lblPlace)
        
        lblPlace.widthAnchor.constraint(equalTo: currentPage.widthAnchor, multiplier: 0.5, constant: -22).isActive = true
        lblPlace.heightAnchor.constraint(equalToConstant: height26).isActive = true
        lblPlace.leftAnchor.constraint(equalTo: currentPage.leftAnchor, constant: 22).isActive = true
        lblPlace.topAnchor.constraint(equalTo: lblEndTime.bottomAnchor).isActive = true
        lblPlace.layoutIfNeeded()
        
        
        
        let lblCategNum = UILabel()
        lblCategNum.translatesAutoresizingMaskIntoConstraints = false
        lblCategNum.text = "Колличество разделов - \(shablon.allCategs.count)"
        lblCategNum.textAlignment = .left
        lblCategNum.font = UIFont.systemFont(ofSize: 13)
        currentPage.addSubview(lblCategNum)
        
        lblCategNum.widthAnchor.constraint(equalTo: currentPage.widthAnchor, multiplier: 0.5, constant: -22).isActive = true
        lblCategNum.heightAnchor.constraint(equalToConstant: height26).isActive = true
        lblCategNum.leftAnchor.constraint(equalTo: currentPage.leftAnchor, constant: 22).isActive = true
        lblCategNum.topAnchor.constraint(equalTo: lblPlace.bottomAnchor).isActive = true
        lblCategNum.layoutIfNeeded()
        
        
        let lblAllBallsNum = UILabel()
        lblAllBallsNum.translatesAutoresizingMaskIntoConstraints = false
        lblAllBallsNum.text = "Общее колличество баллов - \(shablon.weightSum)"
        lblAllBallsNum.textAlignment = .left
        lblAllBallsNum.font = UIFont.systemFont(ofSize: 13)
        currentPage.addSubview(lblAllBallsNum)
        
        lblAllBallsNum.widthAnchor.constraint(equalTo: currentPage.widthAnchor, multiplier: 0.5, constant: -22).isActive = true
        lblAllBallsNum.heightAnchor.constraint(equalToConstant: height26).isActive = true
        lblAllBallsNum.leftAnchor.constraint(equalTo: currentPage.leftAnchor, constant: 22).isActive = true
        lblAllBallsNum.topAnchor.constraint(equalTo: lblCategNum.bottomAnchor).isActive = true
        lblAllBallsNum.layoutIfNeeded()
        
        
        
        
        let lblGetBalls = UILabel()
        lblGetBalls.translatesAutoresizingMaskIntoConstraints = false
        lblGetBalls.text = "Колличество набранных баллов - \(shablon.weightGet)"
        lblGetBalls.textAlignment = .left
        lblGetBalls.font = UIFont.systemFont(ofSize: 13)
        currentPage.addSubview(lblGetBalls)
        
        lblGetBalls.widthAnchor.constraint(equalTo: currentPage.widthAnchor, multiplier: 0.5, constant: -22).isActive = true
        lblGetBalls.heightAnchor.constraint(equalToConstant: height26).isActive = true
        lblGetBalls.leftAnchor.constraint(equalTo: currentPage.leftAnchor, constant: 22).isActive = true
        lblGetBalls.topAnchor.constraint(equalTo: lblAllBallsNum.bottomAnchor).isActive = true
        lblGetBalls.layoutIfNeeded()
        
        
        
        
        
        lblProcent = UILabel()
        lblProcent.translatesAutoresizingMaskIntoConstraints = false
        lblProcent.text = "Успех в процентах - \(shablon.weightPercent)%"
        lblProcent.textAlignment = .left
        lblProcent.font = UIFont.systemFont(ofSize: 13)
        currentPage.addSubview(lblProcent)
        
        lblProcent.widthAnchor.constraint(equalTo: currentPage.widthAnchor, multiplier: 0.5, constant: -22).isActive = true
        lblProcent.heightAnchor.constraint(equalToConstant: height26).isActive = true
        lblProcent.leftAnchor.constraint(equalTo: currentPage.leftAnchor, constant: 22).isActive = true
        lblProcent.topAnchor.constraint(equalTo: lblGetBalls.bottomAnchor).isActive = true
        lblProcent.layoutIfNeeded()
        
        
        if shablon.localImageName != nil
        {
            let auditLogo = infoImageView(frame: CGRect.zero)
            auditLogo.contentMode = .scaleAspectFit
            currentPage.addSubview(auditLogo)
            
            let fileName = "\(shablon.localImageName!).jpg"
            let fm = FileManager.default
            let docDir = fm.urls(for: .documentDirectory, in: .userDomainMask).first!
            let logoPath = docDir.appendingPathComponent("LocalShablonLogos")
            let imageURL = URL(fileURLWithPath: logoPath.path).appendingPathComponent(fileName)
            let image    = UIImage(contentsOfFile: imageURL.path)
            
            auditLogo.image = image
            
            auditLogo.topAnchor.constraint(equalTo: whoLbl.topAnchor, constant: 6).isActive = true
            auditLogo.leftAnchor.constraint(equalTo: currentPage.centerXAnchor, constant: 10).isActive = true
            auditLogo.rightAnchor.constraint(equalTo: currentPage.rightAnchor, constant: -10).isActive = true
            auditLogo.bottomAnchor.constraint(equalTo: lblProcent.bottomAnchor, constant: -6).isActive = true
            auditLogo.layoutIfNeeded()
        }
        
        
        lastView  = lblProcent
        
        for categ in shablon.allCategs
        {
            let headerStr = "\(categ.name!) - Оценка(\(categ.weightGet!)/\(categ.weightSum!)) \(categ.weightPercent!)%"
            let lblTitle = otTableTitle()
            lblTitle.text = headerStr
            
            currentPage.addSubview(lblTitle)
            
            lblTitle.widthAnchor.constraint(equalTo: currentPage.widthAnchor, multiplier: 1, constant: -widthMinus).isActive = true
            //lblTitle.heightAnchor.constraint(equalToConstant: height26).isActive = true
            lblTitle.centerXAnchor.constraint(equalTo: currentPage.centerXAnchor, constant: 0).isActive = true
            lblTitle.topAnchor.constraint(equalTo: lastView.bottomAnchor, constant: 120).isActive = true
            lblTitle.layoutIfNeeded()
            
            lastView = lblTitle
            chechForPage(lastView: lastView)
            
            
            let tableHeader = otTableHeader()
            currentPage.addSubview(tableHeader)
            
            tableHeader.widthAnchor.constraint(equalTo: currentPage.widthAnchor, multiplier: 1, constant: -widthMinus).isActive = true
            tableHeader.heightAnchor.constraint(equalToConstant: height26).isActive = true
            tableHeader.centerXAnchor.constraint(equalTo: currentPage.centerXAnchor).isActive = true
            tableHeader.topAnchor.constraint(equalTo: lastView.bottomAnchor, constant: 8).isActive = true
            
            lastView = tableHeader
            chechForPage(lastView: lastView)
            
            
            
            for element in categ.allElementsSorted
            {
                if element is Model_Question
                {
                    let quest = element as! Model_Question
                    
                    print("Fatal is \(quest.isFatal!)")
                    var heightArray : [CGFloat] = []
                    
                    let viewForRow = UIView()
                    viewForRow.translatesAutoresizingMaskIntoConstraints = false
                    
                    currentPage.addSubview(viewForRow)
                    
                    viewForRow.widthAnchor.constraint(equalTo: lastView.widthAnchor, multiplier: 1, constant: 0).isActive = true
                    viewForRow.centerXAnchor.constraint(equalTo: currentPage.centerXAnchor).isActive = true
                    viewForRow.topAnchor.constraint(equalTo: lastView.bottomAnchor).isActive = true
                    
                    let cellQuest = otTableLabeCell()
                    cellQuest.text = quest.text!
                    
                    
                    viewForRow.addSubview(cellQuest)
                    
                    cellQuest.widthAnchor.constraint(equalTo: viewForRow.widthAnchor, multiplier: 0.25, constant: 0).isActive = true
                    cellQuest.topAnchor.constraint(equalTo: viewForRow.topAnchor).isActive = true
                    cellQuest.leftAnchor.constraint(equalTo: viewForRow.leftAnchor).isActive = true
                    cellQuest.layoutIfNeeded()
                    
                    heightArray.append(cellQuest.frame.size.height)
                    
                    
                    
                    let cellAnswer = otTableLabeCell()
                    cellAnswer.text = getAnswerFromQuestion(quest: quest)
                    if cellAnswer.text == bezOtvetaStr
                    {
                        cellAnswer.textColor = UIColor.red
                    }
                    cellAnswer.backgroundColor = getQuestionColor(quest: quest)
                    cellAnswer.textAlignment = .center
                    cellAnswer.font = UIFont.systemFont(ofSize: 13)
                    
                    viewForRow.addSubview(cellAnswer)
                    
                    cellAnswer.widthAnchor.constraint(equalTo: viewForRow.widthAnchor, multiplier: 0.3, constant: 0).isActive = true
                    cellAnswer.topAnchor.constraint(equalTo: viewForRow.topAnchor).isActive = true
                    cellAnswer.leftAnchor.constraint(equalTo: cellQuest.rightAnchor).isActive = true
                    cellAnswer.layoutIfNeeded()
                    
                    heightArray.append(cellAnswer.frame.size.height)
                    
                    
                    
                    
                    let cellDop = otTableLabeCell()
                    cellDop.textAlignment = .left
                    cellDop.text = getQuestionDopStr(quest: quest)
                    
                    viewForRow.addSubview(cellDop)
                    cellDop.widthAnchor.constraint(equalTo: viewForRow.widthAnchor, multiplier: 0.45, constant: 0).isActive = true
                    cellDop.topAnchor.constraint(equalTo: viewForRow.topAnchor).isActive = true
                    cellDop.leftAnchor.constraint(equalTo: cellAnswer.rightAnchor).isActive = true
                    cellDop.layoutIfNeeded()
                    
                    heightArray.append(cellDop.frame.size.height)
                    
                    print(heightArray)
                    let max = heightArray.max()!
                    print(max)
                    
                    
                    cellQuest.heightAnchor.constraint(equalToConstant: max).isActive = true
                    cellAnswer.heightAnchor.constraint(equalToConstant: max).isActive = true
                    cellDop.heightAnchor.constraint(equalToConstant: max).isActive = true
                    viewForRow.heightAnchor.constraint(equalToConstant: max).isActive = true
                    
                    viewForRow.layoutIfNeeded()
                    
                    lastView = viewForRow
                    chechForPage(lastView: lastView)
                    
                    if quest.addedImages.count > 0
                    {
                        let imagesRow = UIView()
                        imagesRow.translatesAutoresizingMaskIntoConstraints = false
                        imagesRow.layer.borderWidth = 0.4
                        
                        currentPage.addSubview(imagesRow)
                        
                        let rowHeight = (tableHeader.frame.size.width / 8) * 1.78
                        let rowWidth = tableHeader.frame.size.width
                        
                        imagesRow.widthAnchor.constraint(equalTo: lastView.widthAnchor, multiplier: 1, constant: 0).isActive = true
                        imagesRow.centerXAnchor.constraint(equalTo: currentPage.centerXAnchor).isActive = true
                        imagesRow.topAnchor.constraint(equalTo: lastView.bottomAnchor).isActive = true
                        imagesRow.heightAnchor.constraint(equalToConstant: rowHeight).isActive = true
                        imagesRow.layoutIfNeeded()
                        
                        var lastAddedImage : UIView!
                        
                        
                        for img in quest.addedImages
                        {
                            let imgV = otImagePreview()
                            imgV.imgView.image = img
                            
                            imagesRow.addSubview(imgV)
                            
                            imgV.widthAnchor.constraint(equalTo: imagesRow.widthAnchor, multiplier: 0.125, constant: 0).isActive = true
                            imgV.heightAnchor.constraint(equalTo: imagesRow.heightAnchor, multiplier: 1, constant: 0).isActive = true
                            imgV.centerYAnchor.constraint(equalTo: imagesRow.centerYAnchor).isActive = true
                            
                            if lastAddedImage == nil
                            {
                                imgV.leftAnchor.constraint(equalTo: imagesRow.leftAnchor).isActive = true
                            }
                            else
                            {
                                imgV.leftAnchor.constraint(equalTo: lastAddedImage.rightAnchor).isActive = true
                            }
                            imgV.layoutIfNeeded()
                            
                            lastAddedImage = imgV
                        }
                        
                        
                        
                        
                        lastView = imagesRow
                        chechForPage(lastView: lastView)
                    }
                    
                    if quest.isFatal == 1
                    {
                        print("entered fatal check!")
                        if quest.questionType == 0 || quest.questionType == 1
                        {
                            if quest.auditButtons[1].isOn
                            {
                                cellQuest.backgroundColor = red
                                cellAnswer.backgroundColor = red
                                cellDop.backgroundColor = red
                                currentShablon.failed = true;
                            }
                        }
                        else if quest.questionType == 2
                        {
                            var selectedIndex : Int!
                            for btn in quest.auditButtons
                            {
                                if btn.isOn
                                {
                                    selectedIndex = quest.auditButtons.index(of: btn)
                                }
                            }
                            
                            if selectedIndex != nil
                            {
                                let pm = quest.plusMinus[selectedIndex]
                                if pm == 0
                                {
                                    cellQuest.backgroundColor = red
                                    cellAnswer.backgroundColor = red
                                    cellDop.backgroundColor = red
                                    currentShablon.failed = true;
                                }
                            }
                        }
                    }
                }
                
                
                if element is Model_Adress
                {
                    let adress = element as! Model_Adress
                    
                    var heightArray : [CGFloat] = []
                    
                    let viewForRow = UIView()
                    viewForRow.translatesAutoresizingMaskIntoConstraints = false
                    
                    currentPage.addSubview(viewForRow)
                    
                    viewForRow.widthAnchor.constraint(equalTo: lastView.widthAnchor, multiplier: 1, constant: 0).isActive = true
                    viewForRow.centerXAnchor.constraint(equalTo: currentPage.centerXAnchor).isActive = true
                    viewForRow.topAnchor.constraint(equalTo: lastView.bottomAnchor).isActive = true
                    
                    let cellQuest = otTableLabeCell()
                    cellQuest.text = adress.text!
                    
                    
                    viewForRow.addSubview(cellQuest)
                    
                    cellQuest.widthAnchor.constraint(equalTo: viewForRow.widthAnchor, multiplier: 0.25, constant: 0).isActive = true
                    cellQuest.topAnchor.constraint(equalTo: viewForRow.topAnchor).isActive = true
                    cellQuest.leftAnchor.constraint(equalTo: viewForRow.leftAnchor).isActive = true
                    cellQuest.layoutIfNeeded()
                    
                    heightArray.append(cellQuest.frame.size.height)
                    
                    
                    
                    
                    
                    ////////////////////
                    let cellAnswer = otTableLabeCell()
                    
                    var answerStr : String!
                    
                    if adress.auditTF.text == nil || adress.auditTF.text == ""
                    {
                        answerStr = bezOtvetaStr
                        cellAnswer.textColor = UIColor.red
                    }
                    else
                    {
                        answerStr = adress.auditTF.text!
                    }
                    
                    
                    
                    
                    cellAnswer.text = answerStr
                    cellAnswer.textAlignment = .center
                    cellAnswer.font = UIFont.systemFont(ofSize: 13)
                    
                    viewForRow.addSubview(cellAnswer)
                    
                    cellAnswer.widthAnchor.constraint(equalTo: viewForRow.widthAnchor, multiplier: 0.3, constant: 0).isActive = true
                    cellAnswer.topAnchor.constraint(equalTo: viewForRow.topAnchor).isActive = true
                    cellAnswer.leftAnchor.constraint(equalTo: cellQuest.rightAnchor).isActive = true
                    cellAnswer.layoutIfNeeded()
                    
                    heightArray.append(cellAnswer.frame.size.height)
                    
                    let cellDop = otTableLabeCell()
                    cellDop.textAlignment = .left
                    cellDop.text = getElementDopStr(element: adress)
                    
                    viewForRow.addSubview(cellDop)
                    cellDop.widthAnchor.constraint(equalTo: viewForRow.widthAnchor, multiplier: 0.45, constant: 0).isActive = true
                    cellDop.topAnchor.constraint(equalTo: viewForRow.topAnchor).isActive = true
                    cellDop.leftAnchor.constraint(equalTo: cellAnswer.rightAnchor).isActive = true
                    cellDop.layoutIfNeeded()
                    
                    heightArray.append(cellDop.frame.size.height)
                    
                    print(heightArray)
                    let max = heightArray.max()!
                    print(max)
                    
                    
                    cellQuest.heightAnchor.constraint(equalToConstant: max).isActive = true
                    cellAnswer.heightAnchor.constraint(equalToConstant: max).isActive = true
                    cellDop.heightAnchor.constraint(equalToConstant: max).isActive = true
                    viewForRow.heightAnchor.constraint(equalToConstant: max).isActive = true
                    
                    viewForRow.layoutIfNeeded()
                    
                    lastView = viewForRow
                    chechForPage(lastView: lastView)
                    
                }
                
                if element is Model_CheckBox
                {
                    let checkBox = element as! Model_CheckBox
                    var heightArray : [CGFloat] = []
                    
                    let viewForRow = UIView()
                    viewForRow.translatesAutoresizingMaskIntoConstraints = false
                    
                    currentPage.addSubview(viewForRow)
                    
                    viewForRow.widthAnchor.constraint(equalTo: lastView.widthAnchor, multiplier: 1, constant: 0).isActive = true
                    viewForRow.centerXAnchor.constraint(equalTo: currentPage.centerXAnchor).isActive = true
                    viewForRow.topAnchor.constraint(equalTo: lastView.bottomAnchor).isActive = true
                    
                    let cellQuest = otTableLabeCell()
                    cellQuest.text = checkBox.text!
                    
                    
                    viewForRow.addSubview(cellQuest)
                    
                    cellQuest.widthAnchor.constraint(equalTo: viewForRow.widthAnchor, multiplier: 0.25, constant: 0).isActive = true
                    cellQuest.topAnchor.constraint(equalTo: viewForRow.topAnchor).isActive = true
                    cellQuest.leftAnchor.constraint(equalTo: viewForRow.leftAnchor).isActive = true
                    cellQuest.layoutIfNeeded()
                    
                    heightArray.append(cellQuest.frame.size.height)
                    
                    
                    
                    var checkBoxAnswerCell : UIView!
                    
                    if checkBox.neOzenBtn.isOn == false
                    {
                        if checkBox.auditCheckBox!.checkState == .checked
                        {
                            checkBoxAnswerCell = otCheckBoxYes()
                        }
                        else
                        {
                            checkBoxAnswerCell = otCheckBoxNo()
                        }
                    
                    }
                    else
                    {
                        checkBoxAnswerCell = otTableLabeCell()
                        (checkBoxAnswerCell as! otTableLabeCell).text = "Не оценивается"
                        (checkBoxAnswerCell as! otTableLabeCell).textColor = UIColor.red
                        (checkBoxAnswerCell as! otTableLabeCell).textAlignment = .center
                        (checkBoxAnswerCell as! otTableLabeCell).font = UIFont.systemFont(ofSize: 13)
                    }
                    
                    
                    
                    
                    viewForRow.addSubview(checkBoxAnswerCell)
                    
                    checkBoxAnswerCell.widthAnchor.constraint(equalTo: viewForRow.widthAnchor, multiplier: 0.3, constant: 0).isActive = true
                    checkBoxAnswerCell.topAnchor.constraint(equalTo: viewForRow.topAnchor).isActive = true
                    checkBoxAnswerCell.leftAnchor.constraint(equalTo: cellQuest.rightAnchor).isActive = true
                    if checkBox.neOzenBtn.isOn == true
                    {
                        checkBoxAnswerCell.heightAnchor.constraint(equalToConstant: 36).isActive = true
                    }
                    checkBoxAnswerCell.layoutIfNeeded()
                    
                    heightArray.append(checkBoxAnswerCell.frame.size.height)
                    
                    let cellDop = otTableLabeCell()
                    cellDop.textAlignment = .left
                    cellDop.text = getElementDopStr(element: checkBox)
                    
                    viewForRow.addSubview(cellDop)
                    cellDop.widthAnchor.constraint(equalTo: viewForRow.widthAnchor, multiplier: 0.45, constant: 0).isActive = true
                    cellDop.topAnchor.constraint(equalTo: viewForRow.topAnchor).isActive = true
                    cellDop.leftAnchor.constraint(equalTo: checkBoxAnswerCell.rightAnchor).isActive = true
                    cellDop.layoutIfNeeded()
                    
                    heightArray.append(cellDop.frame.size.height)
                    
                    print(heightArray)
                    var max = heightArray.max()!
                    if max < 36
                    {
                        max = 36
                    }
                    
                    
                    cellQuest.heightAnchor.constraint(equalToConstant: max).isActive = true
                    checkBoxAnswerCell.heightAnchor.constraint(equalToConstant: max).isActive = true
                    cellDop.heightAnchor.constraint(equalToConstant: max).isActive = true
                    viewForRow.heightAnchor.constraint(equalToConstant: max).isActive = true
                    
                    viewForRow.layoutIfNeeded()
                    
                    lastView = viewForRow
                    chechForPage(lastView: lastView)
                }
                
                if element is Model_Date
                {
                    let date = element as! Model_Date
                    
                    var heightArray : [CGFloat] = []
                    
                    let viewForRow = UIView()
                    viewForRow.translatesAutoresizingMaskIntoConstraints = false
                    
                    currentPage.addSubview(viewForRow)
                    
                    viewForRow.widthAnchor.constraint(equalTo: lastView.widthAnchor, multiplier: 1, constant: 0).isActive = true
                    viewForRow.centerXAnchor.constraint(equalTo: currentPage.centerXAnchor).isActive = true
                    viewForRow.topAnchor.constraint(equalTo: lastView.bottomAnchor).isActive = true
                    
                    let cellQuest = otTableLabeCell()
                    cellQuest.text = date.text!
                    
                    
                    viewForRow.addSubview(cellQuest)
                    
                    cellQuest.widthAnchor.constraint(equalTo: viewForRow.widthAnchor, multiplier: 0.25, constant: 0).isActive = true
                    cellQuest.topAnchor.constraint(equalTo: viewForRow.topAnchor).isActive = true
                    cellQuest.leftAnchor.constraint(equalTo: viewForRow.leftAnchor).isActive = true
                    cellQuest.layoutIfNeeded()
                    
                    heightArray.append(cellQuest.frame.size.height)
                    
                    
                    let answerStr = getDateStr(modelDate: date)
                    
                    let cellAnswer = otTableLabeCell()
                    cellAnswer.text = answerStr
                    if answerStr == bezOtvetaStr
                    {
                        cellAnswer.textColor = UIColor.red
                    }
                    cellAnswer.textAlignment = .center
                    cellAnswer.font = UIFont.systemFont(ofSize: 13)
                    
                    viewForRow.addSubview(cellAnswer)
                    
                    cellAnswer.widthAnchor.constraint(equalTo: viewForRow.widthAnchor, multiplier: 0.3, constant: 0).isActive = true
                    cellAnswer.topAnchor.constraint(equalTo: viewForRow.topAnchor).isActive = true
                    cellAnswer.leftAnchor.constraint(equalTo: cellQuest.rightAnchor).isActive = true
                    cellAnswer.layoutIfNeeded()
                    
                    heightArray.append(cellAnswer.frame.size.height)
                    
                    let cellDop = otTableLabeCell()
                    cellDop.textAlignment = .left
                    cellDop.text = getElementDopStr(element: date)
                    
                    viewForRow.addSubview(cellDop)
                    cellDop.widthAnchor.constraint(equalTo: viewForRow.widthAnchor, multiplier: 0.45, constant: 0).isActive = true
                    cellDop.topAnchor.constraint(equalTo: viewForRow.topAnchor).isActive = true
                    cellDop.leftAnchor.constraint(equalTo: cellAnswer.rightAnchor).isActive = true
                    cellDop.layoutIfNeeded()
                    
                    heightArray.append(cellDop.frame.size.height)
                    
                    print(heightArray)
                    let max = heightArray.max()!
                    print(max)
                    
                    cellQuest.heightAnchor.constraint(equalToConstant: max).isActive = true
                    cellAnswer.heightAnchor.constraint(equalToConstant: max).isActive = true
                    cellDop.heightAnchor.constraint(equalToConstant: max).isActive = true
                    viewForRow.heightAnchor.constraint(equalToConstant: max).isActive = true
                    
                    viewForRow.layoutIfNeeded()
                    
                    lastView = viewForRow
                    chechForPage(lastView: lastView)
                    
                }
                
                if element is Model_Info
                {
                    let info = element as! Model_Info
                    
                    if info.forOtchet == 1
                    {
                        if info.localFileName != nil
                        {
                            var heightArray : [CGFloat] = []
                            
                            let viewForRow = UIView()
                            viewForRow.translatesAutoresizingMaskIntoConstraints = false
                            
                            currentPage.addSubview(viewForRow)
                            
                            let imageWidth = lastView.frame.size.width / 4
                            let imageHeight = imageWidth * 1.2
                            
                            viewForRow.widthAnchor.constraint(equalTo: lastView.widthAnchor, multiplier: 1, constant: 0).isActive = true
                            viewForRow.heightAnchor.constraint(equalToConstant: imageHeight).isActive = true
                            viewForRow.centerXAnchor.constraint(equalTo: currentPage.centerXAnchor).isActive = true
                            viewForRow.topAnchor.constraint(equalTo: lastView.bottomAnchor).isActive = true
                            viewForRow.layoutIfNeeded()
                            
                            let fileName = "\(info.localFileName!).jpg"
                            let fm = FileManager.default
                            let docDir = fm.urls(for: .documentDirectory, in: .userDomainMask).first!
                            let infosPath = docDir.appendingPathComponent("LocalInfos")
                            let imageURL = URL(fileURLWithPath: infosPath.path).appendingPathComponent(fileName)
                            let image = UIImage(contentsOfFile: imageURL.path)
                            
                            let imgV = otImagePreview()
                            imgV.imgView.image = image
                            imgV.layer.borderWidth = 0.4
                            imgV.imgView.contentMode = .scaleAspectFit
                            
                            viewForRow.addSubview(imgV)
                            
                            imgV.widthAnchor.constraint(equalTo: viewForRow.widthAnchor, multiplier: 0.25, constant: 0).isActive = true
                            imgV.heightAnchor.constraint(equalTo: viewForRow.heightAnchor, multiplier: 1, constant: 0).isActive = true
                            imgV.leftAnchor.constraint(equalTo: viewForRow.leftAnchor).isActive = true
                            imgV.topAnchor.constraint(equalTo: viewForRow.topAnchor).isActive = true
                            imgV.layoutIfNeeded()
                            
                            
                            let cellAnswer = otTableLabeCell()
                            cellAnswer.text = getInfoStr(modelInfo: info)
                            cellAnswer.textAlignment = .center
                            cellAnswer.font = UIFont.systemFont(ofSize: 13)
                            
                            viewForRow.addSubview(cellAnswer)
                            
                            cellAnswer.widthAnchor.constraint(equalTo: viewForRow.widthAnchor, multiplier: 0.75, constant: 0).isActive = true
                            cellAnswer.topAnchor.constraint(equalTo: viewForRow.topAnchor).isActive = true
                            cellAnswer.leftAnchor.constraint(equalTo: imgV.rightAnchor).isActive = true
                            cellAnswer.heightAnchor.constraint(equalTo: viewForRow.heightAnchor, multiplier: 1, constant: 0).isActive = true
                            cellAnswer.layoutIfNeeded()
                            
                            lastView = viewForRow
                            chechForPage(lastView: lastView)
                        }
                        else
                        {
                            
                            let viewForRow = UIView()
                            viewForRow.translatesAutoresizingMaskIntoConstraints = false
                            
                            currentPage.addSubview(viewForRow)
                            
                            viewForRow.widthAnchor.constraint(equalTo: lastView.widthAnchor, multiplier: 1, constant: 0).isActive = true
                            viewForRow.centerXAnchor.constraint(equalTo: currentPage.centerXAnchor).isActive = true
                            viewForRow.topAnchor.constraint(equalTo: lastView.bottomAnchor).isActive = true
                            
                            let cellAnswer = otTableLabeCell()
                            cellAnswer.text = getInfoStr(modelInfo: info)
                            cellAnswer.textAlignment = .center
                            cellAnswer.font = UIFont.systemFont(ofSize: 13)
                            
                            viewForRow.addSubview(cellAnswer)
                            
                            cellAnswer.widthAnchor.constraint(equalTo: viewForRow.widthAnchor, multiplier: 1, constant: 0).isActive = true
                            cellAnswer.topAnchor.constraint(equalTo: viewForRow.topAnchor).isActive = true
                            cellAnswer.centerXAnchor.constraint(equalTo: viewForRow.centerXAnchor).isActive = true
                            cellAnswer.layoutIfNeeded()
                            
                            viewForRow.heightAnchor.constraint(equalTo: cellAnswer.heightAnchor, multiplier: 1, constant: 0).isActive = true
                            
                            lastView = viewForRow
                            chechForPage(lastView: lastView)
                        }
                        
                    }
                }
                
                if element is Model_Media
                {
                    let media = element as! Model_Media
                    
                    var heightArray : [CGFloat] = []
                    
                    let viewForRow = UIView()
                    viewForRow.translatesAutoresizingMaskIntoConstraints = false
                    
                    currentPage.addSubview(viewForRow)
                    
                    viewForRow.widthAnchor.constraint(equalTo: lastView.widthAnchor, multiplier: 1, constant: 0).isActive = true
                    viewForRow.centerXAnchor.constraint(equalTo: currentPage.centerXAnchor).isActive = true
                    viewForRow.topAnchor.constraint(equalTo: lastView.bottomAnchor).isActive = true
                    
                    let cellQuest = otTableLabeCell()
                    cellQuest.text = media.text!
                    
                    
                    viewForRow.addSubview(cellQuest)
                    
                    cellQuest.widthAnchor.constraint(equalTo: viewForRow.widthAnchor, multiplier: 0.25, constant: 0).isActive = true
                    cellQuest.topAnchor.constraint(equalTo: viewForRow.topAnchor).isActive = true
                    cellQuest.leftAnchor.constraint(equalTo: viewForRow.leftAnchor).isActive = true
                    cellQuest.layoutIfNeeded()
                    
                    heightArray.append(cellQuest.frame.size.height)
                    
                    
                    var answerCell : UIView!
                    
                    if media.addedPhoto != nil
                    {
                        let imageWidth = lastView.frame.size.width / 3
                        let imageHeight = imageWidth * 1.2
                        
                        answerCell = otImagePreview()
                        (answerCell as! otImagePreview).imgView.image = media.addedPhoto!
                        answerCell.layer.borderWidth = 0.4
                        viewForRow.addSubview(answerCell)
                        
                        answerCell.widthAnchor.constraint(equalTo: viewForRow.widthAnchor, multiplier: 0.3, constant: 0).isActive = true
                        answerCell.heightAnchor.constraint(equalToConstant: imageHeight).isActive = true
                        answerCell.leftAnchor.constraint(equalTo: cellQuest.rightAnchor, constant: 0).isActive = true
                        answerCell.topAnchor.constraint(equalTo: viewForRow.topAnchor, constant: 0).isActive = true
                        answerCell.layoutIfNeeded()
                    }
                    else
                    {
                        answerCell = otTableLabeCell()
                        viewForRow.addSubview(answerCell)
                        (answerCell as! otTableLabeCell).text = bezOtvetaStr
                        (answerCell as! otTableLabeCell).textColor = UIColor.red
                        (answerCell as! otTableLabeCell).font = UIFont.systemFont(ofSize: 13)
                        (answerCell as! otTableLabeCell).textAlignment = .center
                        
                        answerCell.widthAnchor.constraint(equalTo: viewForRow.widthAnchor, multiplier: 0.3, constant: 0).isActive = true
                        answerCell.leftAnchor.constraint(equalTo: cellQuest.rightAnchor, constant: 0).isActive = true
                        answerCell.topAnchor.constraint(equalTo: viewForRow.topAnchor, constant: 0).isActive = true
                        answerCell.layoutIfNeeded()
                    }
                    
                    heightArray.append(answerCell.frame.size.height)
                    
                    let cellDop = otTableLabeCell()
                    cellDop.textAlignment = .left
                    cellDop.text = getElementDopStr(element: media)
                    
                    viewForRow.addSubview(cellDop)
                    cellDop.widthAnchor.constraint(equalTo: viewForRow.widthAnchor, multiplier: 0.45, constant: 0).isActive = true
                    cellDop.topAnchor.constraint(equalTo: viewForRow.topAnchor).isActive = true
                    cellDop.leftAnchor.constraint(equalTo: answerCell.rightAnchor).isActive = true
                    cellDop.layoutIfNeeded()
                    
                    heightArray.append(cellDop.frame.size.height)
                    
                    print(heightArray)
                    let max = heightArray.max()!
                    print(max)
                    
                    
                    cellQuest.heightAnchor.constraint(equalToConstant: max).isActive = true
                    answerCell.heightAnchor.constraint(equalToConstant: max).isActive = true
                    cellDop.heightAnchor.constraint(equalToConstant: max).isActive = true
                    viewForRow.heightAnchor.constraint(equalToConstant: max).isActive = true
                    
                    viewForRow.layoutIfNeeded()
                    
                    lastView = viewForRow
                    chechForPage(lastView: lastView)
                    
                }
                
                if element is Model_Podpis
                {
                    let podpis = element as! Model_Podpis
                    
                    var heightArray : [CGFloat] = []
                    
                    let viewForRow = UIView()
                    viewForRow.translatesAutoresizingMaskIntoConstraints = false
                    
                    currentPage.addSubview(viewForRow)
                    
                    viewForRow.widthAnchor.constraint(equalTo: lastView.widthAnchor, multiplier: 1, constant: 0).isActive = true
                    viewForRow.centerXAnchor.constraint(equalTo: currentPage.centerXAnchor).isActive = true
                    viewForRow.topAnchor.constraint(equalTo: lastView.bottomAnchor).isActive = true
                    
                    let cellQuest = otTableLabeCell()
                    cellQuest.text = podpis.text!
                    
                    
                    viewForRow.addSubview(cellQuest)
                    
                    cellQuest.widthAnchor.constraint(equalTo: viewForRow.widthAnchor, multiplier: 0.25, constant: 0).isActive = true
                    cellQuest.topAnchor.constraint(equalTo: viewForRow.topAnchor).isActive = true
                    cellQuest.leftAnchor.constraint(equalTo: viewForRow.leftAnchor).isActive = true
                    cellQuest.layoutIfNeeded()
                    
                    heightArray.append(cellQuest.frame.size.height)
                    
                    
                    var answerCell : UIView!
                    
                    if podpis.addSign != nil
                    {
                        let imageWidth = lastView.frame.size.width / 3
                        let imageHeight = imageWidth * 0.6
                        
                        answerCell = otImagePreview()
                        (answerCell as! otImagePreview).imgView.image = podpis.addSign
                        (answerCell as! otImagePreview).imgView.contentMode = .scaleAspectFit
                        answerCell.layer.borderWidth = 0.4
                        viewForRow.addSubview(answerCell)
                        
                        answerCell.widthAnchor.constraint(equalTo: viewForRow.widthAnchor, multiplier: 0.3, constant: 0).isActive = true
                        answerCell.heightAnchor.constraint(equalToConstant: imageHeight).isActive = true
                        answerCell.leftAnchor.constraint(equalTo: cellQuest.rightAnchor, constant: 0).isActive = true
                        answerCell.topAnchor.constraint(equalTo: viewForRow.topAnchor, constant: 0).isActive = true
                        answerCell.layoutIfNeeded()
                    }
                    else
                    {
                        answerCell = otTableLabeCell()
                        viewForRow.addSubview(answerCell)
                        (answerCell as! otTableLabeCell).text = bezOtvetaStr
                        (answerCell as! otTableLabeCell).textColor = UIColor.red
                        (answerCell as! otTableLabeCell).font = UIFont.systemFont(ofSize: 13)
                        (answerCell as! otTableLabeCell).textAlignment = .center
                        
                        answerCell.widthAnchor.constraint(equalTo: viewForRow.widthAnchor, multiplier: 0.3, constant: 0).isActive = true
                        answerCell.leftAnchor.constraint(equalTo: cellQuest.rightAnchor, constant: 0).isActive = true
                        answerCell.topAnchor.constraint(equalTo: viewForRow.topAnchor, constant: 0).isActive = true
                        answerCell.layoutIfNeeded()
                    }
                    
                    heightArray.append(answerCell.frame.size.height)
                    
                    let cellDop = otTableLabeCell()
                    cellDop.textAlignment = .left
                    cellDop.text = getElementDopStr(element: podpis)
                    
                    viewForRow.addSubview(cellDop)
                    cellDop.widthAnchor.constraint(equalTo: viewForRow.widthAnchor, multiplier: 0.45, constant: 0).isActive = true
                    cellDop.topAnchor.constraint(equalTo: viewForRow.topAnchor).isActive = true
                    cellDop.leftAnchor.constraint(equalTo: answerCell.rightAnchor).isActive = true
                    cellDop.layoutIfNeeded()
                    
                    heightArray.append(cellDop.frame.size.height)
                    
                    print(heightArray)
                    let max = heightArray.max()!
                    print(max)
                    
                    
                    cellQuest.heightAnchor.constraint(equalToConstant: max).isActive = true
                    answerCell.heightAnchor.constraint(equalToConstant: max).isActive = true
                    cellDop.heightAnchor.constraint(equalToConstant: max).isActive = true
                    viewForRow.heightAnchor.constraint(equalToConstant: max).isActive = true
                    
                    viewForRow.layoutIfNeeded()
                    
                    lastView = viewForRow
                    chechForPage(lastView: lastView)
                    
                }
                
                
                if element is Model_QuestVar
                {
                    let questVar = element as! Model_QuestVar
                    
                    var heightArray : [CGFloat] = []
                    
                    let viewForRow = UIView()
                    viewForRow.translatesAutoresizingMaskIntoConstraints = false
                    
                    currentPage.addSubview(viewForRow)
                    
                    viewForRow.widthAnchor.constraint(equalTo: lastView.widthAnchor, multiplier: 1, constant: 0).isActive = true
                    viewForRow.centerXAnchor.constraint(equalTo: currentPage.centerXAnchor).isActive = true
                    viewForRow.topAnchor.constraint(equalTo: lastView.bottomAnchor).isActive = true
                    
                    let cellQuest = otTableLabeCell()
                    cellQuest.text = questVar.text!
                    
                    
                    viewForRow.addSubview(cellQuest)
                    
                    cellQuest.widthAnchor.constraint(equalTo: viewForRow.widthAnchor, multiplier: 0.25, constant: 0).isActive = true
                    cellQuest.topAnchor.constraint(equalTo: viewForRow.topAnchor).isActive = true
                    cellQuest.leftAnchor.constraint(equalTo: viewForRow.leftAnchor).isActive = true
                    cellQuest.layoutIfNeeded()
                    
                    heightArray.append(cellQuest.frame.size.height)
                    
                    
                    let answerStr = getQuestVarAnswer(qVar: questVar)
                    
                    let cellAnswer = otTableLabeCell()
                    cellAnswer.text = answerStr
                    if answerStr == bezOtvetaStr
                    {
                        cellAnswer.textColor = UIColor.red
                    }
                    cellAnswer.textAlignment = .center
                    cellAnswer.font = UIFont.systemFont(ofSize: 13)
                    
                    viewForRow.addSubview(cellAnswer)
                    
                    cellAnswer.widthAnchor.constraint(equalTo: viewForRow.widthAnchor, multiplier: 0.3, constant: 0).isActive = true
                    cellAnswer.topAnchor.constraint(equalTo: viewForRow.topAnchor).isActive = true
                    cellAnswer.leftAnchor.constraint(equalTo: cellQuest.rightAnchor).isActive = true
                    cellAnswer.layoutIfNeeded()
                    
                    heightArray.append(cellAnswer.frame.size.height)
                    
                    let cellDop = otTableLabeCell()
                    cellDop.textAlignment = .left
                    cellDop.text = getElementDopStr(element: questVar)
                    
                    viewForRow.addSubview(cellDop)
                    cellDop.widthAnchor.constraint(equalTo: viewForRow.widthAnchor, multiplier: 0.45, constant: 0).isActive = true
                    cellDop.topAnchor.constraint(equalTo: viewForRow.topAnchor).isActive = true
                    cellDop.leftAnchor.constraint(equalTo: cellAnswer.rightAnchor).isActive = true
                    cellDop.layoutIfNeeded()
                    
                    heightArray.append(cellDop.frame.size.height)
                    
                    print(heightArray)
                    let max = heightArray.max()!
                    print(max)
                    
                    cellQuest.heightAnchor.constraint(equalToConstant: max).isActive = true
                    cellAnswer.heightAnchor.constraint(equalToConstant: max).isActive = true
                    cellDop.heightAnchor.constraint(equalToConstant: max).isActive = true
                    viewForRow.heightAnchor.constraint(equalToConstant: max).isActive = true
                    
                    viewForRow.layoutIfNeeded()
                    
                    lastView = viewForRow
                    chechForPage(lastView: lastView)
                    
                }
                
                if element is Model_Seeker
                {
                    let seeker = element as! Model_Seeker
                    
                    var heightArray : [CGFloat] = []
                    
                    let viewForRow = UIView()
                    viewForRow.translatesAutoresizingMaskIntoConstraints = false
                    
                    currentPage.addSubview(viewForRow)
                    
                    viewForRow.widthAnchor.constraint(equalTo: lastView.widthAnchor, multiplier: 1, constant: 0).isActive = true
                    viewForRow.centerXAnchor.constraint(equalTo: currentPage.centerXAnchor).isActive = true
                    viewForRow.topAnchor.constraint(equalTo: lastView.bottomAnchor).isActive = true
                    
                    let cellQuest = otTableLabeCell()
                    cellQuest.text = seeker.text!
                    
                    
                    viewForRow.addSubview(cellQuest)
                    
                    cellQuest.widthAnchor.constraint(equalTo: viewForRow.widthAnchor, multiplier: 0.25, constant: 0).isActive = true
                    cellQuest.topAnchor.constraint(equalTo: viewForRow.topAnchor).isActive = true
                    cellQuest.leftAnchor.constraint(equalTo: viewForRow.leftAnchor).isActive = true
                    cellQuest.layoutIfNeeded()
                    
                    heightArray.append(cellQuest.frame.size.height)
                    
                    
                    let answerStr = getSliderStr(seek: seeker)
                    
                    let cellAnswer = otTableLabeCell()
                    cellAnswer.text = answerStr
                    if answerStr == bezOtvetaStr
                    {
                        cellAnswer.textColor = UIColor.red
                    }
                    cellAnswer.textAlignment = .center
                    cellAnswer.font = UIFont.systemFont(ofSize: 13)
                    
                    viewForRow.addSubview(cellAnswer)
                    
                    cellAnswer.widthAnchor.constraint(equalTo: viewForRow.widthAnchor, multiplier: 0.3, constant: 0).isActive = true
                    cellAnswer.topAnchor.constraint(equalTo: viewForRow.topAnchor).isActive = true
                    cellAnswer.leftAnchor.constraint(equalTo: cellQuest.rightAnchor).isActive = true
                    cellAnswer.layoutIfNeeded()
                    
                    heightArray.append(cellAnswer.frame.size.height)
                    
                    let cellDop = otTableLabeCell()
                    cellDop.textAlignment = .left
                    cellDop.text = getElementDopStr(element: seeker)
                    
                    viewForRow.addSubview(cellDop)
                    cellDop.widthAnchor.constraint(equalTo: viewForRow.widthAnchor, multiplier: 0.45, constant: 0).isActive = true
                    cellDop.topAnchor.constraint(equalTo: viewForRow.topAnchor).isActive = true
                    cellDop.leftAnchor.constraint(equalTo: cellAnswer.rightAnchor).isActive = true
                    cellDop.layoutIfNeeded()
                    
                    heightArray.append(cellDop.frame.size.height)
                    
                    print(heightArray)
                    let max = heightArray.max()!
                    print(max)
                    
                    cellQuest.heightAnchor.constraint(equalToConstant: max).isActive = true
                    cellAnswer.heightAnchor.constraint(equalToConstant: max).isActive = true
                    cellDop.heightAnchor.constraint(equalToConstant: max).isActive = true
                    viewForRow.heightAnchor.constraint(equalToConstant: max).isActive = true
                    
                    viewForRow.layoutIfNeeded()
                    
                    lastView = viewForRow
                    chechForPage(lastView: lastView)
                }
                
                if element is Model_TextLarge
                {
                    let textLarge = element as! Model_TextLarge
                    
                    var heightArray : [CGFloat] = []
                    
                    let viewForRow = UIView()
                    viewForRow.translatesAutoresizingMaskIntoConstraints = false
                    
                    currentPage.addSubview(viewForRow)
                    
                    viewForRow.widthAnchor.constraint(equalTo: lastView.widthAnchor, multiplier: 1, constant: 0).isActive = true
                    viewForRow.centerXAnchor.constraint(equalTo: currentPage.centerXAnchor).isActive = true
                    viewForRow.topAnchor.constraint(equalTo: lastView.bottomAnchor).isActive = true
                    
                    let cellQuest = otTableLabeCell()
                    cellQuest.text = textLarge.text!
                    
                    
                    viewForRow.addSubview(cellQuest)
                    
                    cellQuest.widthAnchor.constraint(equalTo: viewForRow.widthAnchor, multiplier: 0.25, constant: 0).isActive = true
                    cellQuest.topAnchor.constraint(equalTo: viewForRow.topAnchor).isActive = true
                    cellQuest.leftAnchor.constraint(equalTo: viewForRow.leftAnchor).isActive = true
                    cellQuest.layoutIfNeeded()
                    
                    heightArray.append(cellQuest.frame.size.height)
                    
                    var answerStr = textLarge.auditTextView.text
                    
                    if answerStr == nil || answerStr == ""
                    {
                        answerStr = bezOtvetaStr
                    }
                    
                    let cellAnswer = otTableLabeCell()
                    cellAnswer.font = UIFont.systemFont(ofSize: 13)
                    cellAnswer.text = answerStr
                    cellAnswer.textAlignment = .left
                    if answerStr == bezOtvetaStr
                    {
                        cellAnswer.textColor = UIColor.red
                        cellAnswer.textAlignment = .center
                    }
                    
                    cellAnswer.font = UIFont.systemFont(ofSize: 13)
                    
                    viewForRow.addSubview(cellAnswer)
                    
                    cellAnswer.widthAnchor.constraint(equalTo: viewForRow.widthAnchor, multiplier: 0.75, constant: 0).isActive = true
                    cellAnswer.topAnchor.constraint(equalTo: viewForRow.topAnchor).isActive = true
                    cellAnswer.leftAnchor.constraint(equalTo: cellQuest.rightAnchor).isActive = true
                    cellAnswer.sizeToFit()
                    cellAnswer.layoutIfNeeded()
                    
                    heightArray.append(cellAnswer.frame.size.height)
                    
                    let max = heightArray.max()!
                    
                    cellAnswer.heightAnchor.constraint(equalToConstant: max).isActive = true
                    cellQuest.heightAnchor.constraint(equalToConstant: max).isActive = true
                    viewForRow.heightAnchor.constraint(equalToConstant: max).isActive = true
                    
                    lastView = viewForRow
                    chechForPage(lastView: lastView)
                    
                    if textLarge.skrepka != nil
                    {
                        let cellDop = otTableLabeCell()
                        cellDop.text = getElementDopStr(element: textLarge)
                        cellDop.textAlignment = .left
                        currentPage.addSubview(cellDop)
                        
                        cellDop.widthAnchor.constraint(equalTo: lastView.widthAnchor, multiplier: 1).isActive = true
                        cellDop.centerXAnchor.constraint(equalTo: lastView.centerXAnchor).isActive = true
                        cellDop.topAnchor.constraint(equalTo: lastView.bottomAnchor).isActive = true
                        cellDop.sizeToFit()
                        cellDop.layoutIfNeeded()
                        
                        lastView = cellDop
                        chechForPage(lastView: lastView)
                    }
                    
                }
                
                
                
                if element is Model_TextOneLine
                {
                    let textOneLine = element as! Model_TextOneLine
                    
                    var heightArray : [CGFloat] = []
                    
                    let viewForRow = UIView()
                    viewForRow.translatesAutoresizingMaskIntoConstraints = false
                    
                    currentPage.addSubview(viewForRow)
                    
                    viewForRow.widthAnchor.constraint(equalTo: lastView.widthAnchor, multiplier: 1, constant: 0).isActive = true
                    viewForRow.centerXAnchor.constraint(equalTo: currentPage.centerXAnchor).isActive = true
                    viewForRow.topAnchor.constraint(equalTo: lastView.bottomAnchor).isActive = true
                    
                    let cellQuest = otTableLabeCell()
                    cellQuest.text = textOneLine.text!
                    
                    
                    viewForRow.addSubview(cellQuest)
                    
                    cellQuest.widthAnchor.constraint(equalTo: viewForRow.widthAnchor, multiplier: 0.25, constant: 0).isActive = true
                    cellQuest.topAnchor.constraint(equalTo: viewForRow.topAnchor).isActive = true
                    cellQuest.leftAnchor.constraint(equalTo: viewForRow.leftAnchor).isActive = true
                    cellQuest.layoutIfNeeded()
                    
                    heightArray.append(cellQuest.frame.size.height)
                    
                    var answerStr = textOneLine.auditTextField.text
                    
                    if answerStr == nil || answerStr == ""
                    {
                        answerStr = bezOtvetaStr
                    }
                    
                    let cellAnswer = otTableLabeCell()
                    cellAnswer.font = UIFont.systemFont(ofSize: 13)
                    cellAnswer.text = answerStr
                    cellAnswer.textAlignment = .left
                    if answerStr == bezOtvetaStr
                    {
                        cellAnswer.textColor = UIColor.red
                        cellAnswer.textAlignment = .center
                    }
                    
                    cellAnswer.font = UIFont.systemFont(ofSize: 13)
                    
                    viewForRow.addSubview(cellAnswer)
                    
                    cellAnswer.widthAnchor.constraint(equalTo: viewForRow.widthAnchor, multiplier: 0.75, constant: 0).isActive = true
                    cellAnswer.topAnchor.constraint(equalTo: viewForRow.topAnchor).isActive = true
                    cellAnswer.leftAnchor.constraint(equalTo: cellQuest.rightAnchor).isActive = true
                    cellAnswer.sizeToFit()
                    cellAnswer.layoutIfNeeded()
                    
                    heightArray.append(cellAnswer.frame.size.height)
                    
                    let max = heightArray.max()!
                    
                    cellAnswer.heightAnchor.constraint(equalToConstant: max).isActive = true
                    cellQuest.heightAnchor.constraint(equalToConstant: max).isActive = true
                    viewForRow.heightAnchor.constraint(equalToConstant: max).isActive = true
                    
                    lastView = viewForRow
                    chechForPage(lastView: lastView)
                    
                    if textOneLine.skrepka != nil
                    {
                        let cellDop = otTableLabeCell()
                        cellDop.text = getElementDopStr(element: textOneLine)
                        cellDop.textAlignment = .left
                        currentPage.addSubview(cellDop)
                        
                        cellDop.widthAnchor.constraint(equalTo: lastView.widthAnchor, multiplier: 1).isActive = true
                        cellDop.centerXAnchor.constraint(equalTo: lastView.centerXAnchor).isActive = true
                        cellDop.topAnchor.constraint(equalTo: lastView.bottomAnchor).isActive = true
                        cellDop.sizeToFit()
                        cellDop.layoutIfNeeded()
                        
                        lastView = cellDop
                        chechForPage(lastView: lastView)
                    }
                    
                }
                
                
                
                
                if element is Model_Toggle
                {
                    let toggle = element as! Model_Toggle
                    var heightArray : [CGFloat] = []
                    
                    let viewForRow = UIView()
                    viewForRow.translatesAutoresizingMaskIntoConstraints = false
                    
                    currentPage.addSubview(viewForRow)
                    
                    viewForRow.widthAnchor.constraint(equalTo: lastView.widthAnchor, multiplier: 1, constant: 0).isActive = true
                    viewForRow.centerXAnchor.constraint(equalTo: currentPage.centerXAnchor).isActive = true
                    viewForRow.topAnchor.constraint(equalTo: lastView.bottomAnchor).isActive = true
                    
                    let cellQuest = otTableLabeCell()
                    cellQuest.text = toggle.text!
                    
                    
                    viewForRow.addSubview(cellQuest)
                    
                    cellQuest.widthAnchor.constraint(equalTo: viewForRow.widthAnchor, multiplier: 0.25, constant: 0).isActive = true
                    cellQuest.topAnchor.constraint(equalTo: viewForRow.topAnchor).isActive = true
                    cellQuest.leftAnchor.constraint(equalTo: viewForRow.leftAnchor).isActive = true
                    cellQuest.layoutIfNeeded()
                    
                    heightArray.append(cellQuest.frame.size.height)
                    
                    
                    
                    var checkBoxAnswerCell : UIView!
                    
                    if toggle.auditToggle.index == 1
                    {
                        checkBoxAnswerCell = otCheckBoxYes()
                    }
                    else
                    {
                        checkBoxAnswerCell = otCheckBoxNo()
                    }
                    
                    
                    
                    
                    viewForRow.addSubview(checkBoxAnswerCell)
                    
                    checkBoxAnswerCell.widthAnchor.constraint(equalTo: viewForRow.widthAnchor, multiplier: 0.3, constant: 0).isActive = true
                    checkBoxAnswerCell.topAnchor.constraint(equalTo: viewForRow.topAnchor).isActive = true
                    checkBoxAnswerCell.leftAnchor.constraint(equalTo: cellQuest.rightAnchor).isActive = true
                    checkBoxAnswerCell.layoutIfNeeded()
                    
                    heightArray.append(checkBoxAnswerCell.frame.size.height)
                    
                    let cellDop = otTableLabeCell()
                    cellDop.textAlignment = .left
                    cellDop.text = getElementDopStr(element: toggle)
                    
                    viewForRow.addSubview(cellDop)
                    cellDop.widthAnchor.constraint(equalTo: viewForRow.widthAnchor, multiplier: 0.45, constant: 0).isActive = true
                    cellDop.topAnchor.constraint(equalTo: viewForRow.topAnchor).isActive = true
                    cellDop.leftAnchor.constraint(equalTo: checkBoxAnswerCell.rightAnchor).isActive = true
                    cellDop.layoutIfNeeded()
                    
                    heightArray.append(cellDop.frame.size.height)
                    
                    print(heightArray)
                    var max = heightArray.max()!
                    if max < 36
                    {
                        max = 36
                    }
                    
                    
                    cellQuest.heightAnchor.constraint(equalToConstant: max).isActive = true
                    checkBoxAnswerCell.heightAnchor.constraint(equalToConstant: max).isActive = true
                    cellDop.heightAnchor.constraint(equalToConstant: max).isActive = true
                    viewForRow.heightAnchor.constraint(equalToConstant: max).isActive = true
                    
                    viewForRow.layoutIfNeeded()
                    
                    lastView = viewForRow
                    chechForPage(lastView: lastView)
                }
                
                if element is Model_Timer
                {
                    let timer = element as! Model_Timer
                    
                    var heightArray : [CGFloat] = []
                    
                    let viewForRow = UIView()
                    viewForRow.translatesAutoresizingMaskIntoConstraints = false
                    
                    currentPage.addSubview(viewForRow)
                    
                    viewForRow.widthAnchor.constraint(equalTo: lastView.widthAnchor, multiplier: 1, constant: 0).isActive = true
                    viewForRow.centerXAnchor.constraint(equalTo: currentPage.centerXAnchor).isActive = true
                    viewForRow.topAnchor.constraint(equalTo: lastView.bottomAnchor).isActive = true
                    
                    let cellQuest = otTableLabeCell()
                    cellQuest.text = timer.text!
                    
                    
                    viewForRow.addSubview(cellQuest)
                    
                    cellQuest.widthAnchor.constraint(equalTo: viewForRow.widthAnchor, multiplier: 0.25, constant: 0).isActive = true
                    cellQuest.topAnchor.constraint(equalTo: viewForRow.topAnchor).isActive = true
                    cellQuest.leftAnchor.constraint(equalTo: viewForRow.leftAnchor).isActive = true
                    cellQuest.layoutIfNeeded()
                    
                    heightArray.append(cellQuest.frame.size.height)
                    
                    
                    let answerStr = getTimerString(timer: timer)
                    
                    let cellAnswer = otTableLabeCell()
                    cellAnswer.text = answerStr
                    if answerStr == bezOtvetaStr
                    {
                        cellAnswer.textColor = UIColor.red
                    }
                    cellAnswer.textAlignment = .center
                    cellAnswer.font = UIFont.systemFont(ofSize: 13)
                    
                    viewForRow.addSubview(cellAnswer)
                    
                    cellAnswer.widthAnchor.constraint(equalTo: viewForRow.widthAnchor, multiplier: 0.3, constant: 0).isActive = true
                    cellAnswer.topAnchor.constraint(equalTo: viewForRow.topAnchor).isActive = true
                    cellAnswer.leftAnchor.constraint(equalTo: cellQuest.rightAnchor).isActive = true
                    cellAnswer.layoutIfNeeded()
                    
                    heightArray.append(cellAnswer.frame.size.height)
                    
                    let cellDop = otTableLabeCell()
                    cellDop.textAlignment = .left
                    cellDop.text = getElementDopStr(element: timer)
                    
                    viewForRow.addSubview(cellDop)
                    cellDop.widthAnchor.constraint(equalTo: viewForRow.widthAnchor, multiplier: 0.45, constant: 0).isActive = true
                    cellDop.topAnchor.constraint(equalTo: viewForRow.topAnchor).isActive = true
                    cellDop.leftAnchor.constraint(equalTo: cellAnswer.rightAnchor).isActive = true
                    cellDop.layoutIfNeeded()
                    
                    heightArray.append(cellDop.frame.size.height)
                    
                    print(heightArray)
                    let max = heightArray.max()!
                    print(max)
                    
                    cellQuest.heightAnchor.constraint(equalToConstant: max).isActive = true
                    cellAnswer.heightAnchor.constraint(equalToConstant: max).isActive = true
                    cellDop.heightAnchor.constraint(equalToConstant: max).isActive = true
                    viewForRow.heightAnchor.constraint(equalToConstant: max).isActive = true
                    
                    viewForRow.layoutIfNeeded()
                    
                    lastView = viewForRow
                    chechForPage(lastView: lastView)
                }
                
              
            }
            
            
         
            
        }
        
        if currentShablon.failed == true
        {
            lblProcent.text = "Underperforming"
            lblProcent.textColor = UIColor.red
            lblProcent.font = UIFont.systemFont(ofSize: 15)
            currentShablon.weightPercent = 0;
        }
        
        if listAddedImagesGroup.count > 0 && (gc.writeBigPhotos == true)
        {
            print("Added images group more than 0 wil add now. Groupcount is \(listAddedImagesGroup.count)")
            
            let photoTitle = otTableTitle()
            photoTitle.textAlignment = .center
            photoTitle.text = "Добавленные фото"
            photoTitle.font = UIFont.systemFont(ofSize: 20)
            currentPage.addSubview(photoTitle)
            
            photoTitle.widthAnchor.constraint(equalTo: lastView.widthAnchor, multiplier: 1, constant: 0).isActive = true
            photoTitle.centerXAnchor.constraint(equalTo: currentPage.centerXAnchor).isActive = true
            photoTitle.topAnchor.constraint(equalTo: lastView.bottomAnchor, constant: 80).isActive = true
            photoTitle.layoutIfNeeded()
            
            lastView = photoTitle
            chechForPage(lastView: lastView)
        }
        
        
        if listAddedImagesGroup.count > 0 && (gc.writeBigPhotos == true)
        {
        
        for imgArray in listAddedImagesGroup
        {
            
            let num = listAddedImagesGroup.index(of: imgArray)! + 1
            print("Adding big images group number \(num)")
            
            let groupHeader = otTableLabeCell()
            groupHeader.textAlignment = .center
            groupHeader.font = UIFont.systemFont(ofSize: 16)
            groupHeader.text = "Приложение №\(num)"
            
            currentPage.addSubview(groupHeader)
            
            groupHeader.widthAnchor.constraint(equalTo: lastView.widthAnchor, multiplier: 1, constant: 0).isActive = true
            groupHeader.topAnchor.constraint(equalTo: lastView.bottomAnchor, constant: 40).isActive = true
            groupHeader.centerXAnchor.constraint(equalTo: lastView.centerXAnchor, constant: 0).isActive = true
            groupHeader.sizeToFit()
            groupHeader.layoutIfNeeded()
            
            
            
            let width = groupHeader.frame.size.width
            let height = width * 0.6
            let rightAnchor = groupHeader.rightAnchor
            let leftAnchor = groupHeader.leftAnchor
            
            lastView = groupHeader
            chechForPage(lastView: lastView)
            
//            var resizedImages : [UIImage] = []
            
//            for img in imgArray
//            {
////                let data = UIImageJPEGRepresentation(img, 0.1)!
////                resizedImages.append(UIImage(data: data)!)
//                resizedImages.append(img);
//            }
            
            let rowView1 = otImageRowView()
            currentPage.addSubview(rowView1)
            rowView1.imgLeft.imgView.image = imgArray[0]
            if imgArray.count > 1
            {
                rowView1.imgRight.imgView.image = imgArray[1]
            }

            rowView1.widthAnchor.constraint(equalToConstant: width).isActive = true
            rowView1.heightAnchor.constraint(equalToConstant: height).isActive = true
            rowView1.centerXAnchor.constraint(equalTo: currentPage.centerXAnchor).isActive = true
            rowView1.topAnchor.constraint(equalTo: lastView.bottomAnchor).isActive = true
            rowView1.layoutIfNeeded()

            lastView = rowView1
            chechForPage(lastView: lastView)




            if imgArray.count > 2
            {
                let rowView2 = otImageRowView()
                currentPage.addSubview(rowView2)
                rowView2.imgLeft.imgView.image = imgArray[2]
                if imgArray.count > 3
                {
                    rowView2.imgRight.imgView.image = imgArray[3]
                }

                rowView2.widthAnchor.constraint(equalToConstant: width).isActive = true
                rowView2.heightAnchor.constraint(equalToConstant: height).isActive = true
                rowView2.centerXAnchor.constraint(equalTo: currentPage.centerXAnchor).isActive = true
                rowView2.topAnchor.constraint(equalTo: lastView.bottomAnchor).isActive = true
                rowView2.layoutIfNeeded()

                lastView = rowView2
                chechForPage(lastView: lastView)
            }


            if imgArray.count > 4
            {
                let rowView3 = otImageRowView()
                currentPage.addSubview(rowView3)
                rowView3.imgLeft.imgView.image = imgArray[4]
                if imgArray.count > 5
                {
                    rowView3.imgRight.imgView.image = imgArray[5]
                }

                rowView3.widthAnchor.constraint(equalToConstant: width).isActive = true
                rowView3.heightAnchor.constraint(equalToConstant: height).isActive = true
                rowView3.centerXAnchor.constraint(equalTo: currentPage.centerXAnchor).isActive = true
                rowView3.topAnchor.constraint(equalTo: lastView.bottomAnchor).isActive = true
                rowView3.layoutIfNeeded()

                lastView = rowView3
                chechForPage(lastView: lastView)
            }

            if imgArray.count > 6
            {
                let rowView4 = otImageRowView()
                currentPage.addSubview(rowView4)
                rowView4.imgLeft.imgView.image = imgArray[6]
                if imgArray.count > 7
                {
                    rowView4.imgRight.imgView.image = imgArray[7]
                }

                rowView4.widthAnchor.constraint(equalToConstant: width).isActive = true
                rowView4.heightAnchor.constraint(equalToConstant: height).isActive = true
                rowView4.centerXAnchor.constraint(equalTo: currentPage.centerXAnchor).isActive = true
                rowView4.topAnchor.constraint(equalTo: lastView.bottomAnchor).isActive = true
                rowView4.layoutIfNeeded()

                lastView = rowView4
                chechForPage(lastView: lastView)
            }
            
        }
        
        }
            
        if listAddedSkrepka.count > 0
        {
            let skrepkaTitle = otTableTitle()
            skrepkaTitle.textAlignment = .center
            skrepkaTitle.text = "Назначенные действия"
            skrepkaTitle.font = UIFont.systemFont(ofSize: 20)
            currentPage.addSubview(skrepkaTitle)
            
            skrepkaTitle.widthAnchor.constraint(equalTo: lastView.widthAnchor, multiplier: 1, constant: 0).isActive = true
            skrepkaTitle.centerXAnchor.constraint(equalTo: currentPage.centerXAnchor).isActive = true
            skrepkaTitle.topAnchor.constraint(equalTo: lastView.bottomAnchor, constant: 80).isActive = true
            skrepkaTitle.layoutIfNeeded()
            
            lastView = skrepkaTitle
            chechForPage(lastView: lastView)
        
        }
        
        for skrepka in listAddedSkrepka
        {
            
            var labelHeights : [CGFloat] = []
            let answers = getSkrepkaTextArray(skrepka: skrepka)
            
            let headerlbl = otTableLabeCell()
            headerlbl.text = "Действие №\(listAddedSkrepka.index(of: skrepka)! + 1)"
            headerlbl.textAlignment = .center
            headerlbl.layer.borderWidth = 0
            headerlbl.font = UIFont.systemFont(ofSize: 14)
            currentPage.addSubview(headerlbl)
            
            headerlbl.widthAnchor.constraint(equalTo: lastView.widthAnchor, multiplier: 1, constant: 0).isActive = true
            headerlbl.topAnchor.constraint(equalTo: lastView.bottomAnchor, constant: 40).isActive = true
            headerlbl.centerXAnchor.constraint(equalTo: currentPage.centerXAnchor).isActive = true
            headerlbl.layoutIfNeeded()
            
            lastView = headerlbl
            chechForPage(lastView: lastView)
            
            
            
            let row1 = UIView()
            row1.translatesAutoresizingMaskIntoConstraints = false
            currentPage.addSubview(row1)
            
            row1.widthAnchor.constraint(equalTo: lastView.widthAnchor, multiplier: 1, constant: 0).isActive = true
            row1.topAnchor.constraint(equalTo: lastView.bottomAnchor, constant: 0).isActive = true
            row1.centerXAnchor.constraint(equalTo: currentPage.centerXAnchor).isActive = true
            
            ///
            
            let cellActionHeader = otTableLabeCell()
            cellActionHeader.text = "Действие"
            cellActionHeader.textAlignment = .center
            row1.addSubview(cellActionHeader)
            
            cellActionHeader.widthAnchor.constraint(equalTo: row1.widthAnchor, multiplier: 0.4, constant: 0).isActive = true
            cellActionHeader.topAnchor.constraint(equalTo: row1.topAnchor, constant: 0).isActive = true
            cellActionHeader.leftAnchor.constraint(equalTo: row1.leftAnchor).isActive = true
            cellActionHeader.layoutIfNeeded()
            
            let cellWhoHeader = otTableLabeCell()
            cellWhoHeader.text = "Ответственный"
            cellWhoHeader.textAlignment = .center
            row1.addSubview(cellWhoHeader)
            
            cellWhoHeader.widthAnchor.constraint(equalTo: row1.widthAnchor, multiplier: 0.2, constant: 0).isActive = true
            cellWhoHeader.topAnchor.constraint(equalTo: row1.topAnchor, constant: 0).isActive = true
            cellWhoHeader.leftAnchor.constraint(equalTo: cellActionHeader.rightAnchor).isActive = true
            cellWhoHeader.layoutIfNeeded()
            
            
            let cellDateHeader = otTableLabeCell()
            cellDateHeader.text = "Выполнить до"
            cellDateHeader.textAlignment = .center
            row1.addSubview(cellDateHeader)
            
            cellDateHeader.widthAnchor.constraint(equalTo: row1.widthAnchor, multiplier: 0.2, constant: 0).isActive = true
            cellDateHeader.topAnchor.constraint(equalTo: row1.topAnchor, constant: 0).isActive = true
            cellDateHeader.leftAnchor.constraint(equalTo: cellWhoHeader.rightAnchor).isActive = true
            cellDateHeader.layoutIfNeeded()
            
            
            
            let cellPrioritetHeader = otTableLabeCell()
            cellPrioritetHeader.text = "Приоритет"
            cellPrioritetHeader.textAlignment = .center
            row1.addSubview(cellPrioritetHeader)
            
            cellPrioritetHeader.widthAnchor.constraint(equalTo: row1.widthAnchor, multiplier: 0.2, constant: 0).isActive = true
            cellPrioritetHeader.topAnchor.constraint(equalTo: row1.topAnchor, constant: 0).isActive = true
            cellPrioritetHeader.leftAnchor.constraint(equalTo: cellDateHeader.rightAnchor).isActive = true
            cellPrioritetHeader.layoutIfNeeded()
            
            row1.heightAnchor.constraint(equalTo: cellActionHeader.heightAnchor, multiplier: 1, constant: 0).isActive = true
            row1.layoutIfNeeded()
            
            lastView = row1
            chechForPage(lastView: lastView)
            
            
            
            
            let row2 = UIView()
            row2.translatesAutoresizingMaskIntoConstraints = false
            currentPage.addSubview(row2)
            
            row2.widthAnchor.constraint(equalTo: lastView.widthAnchor, multiplier: 1, constant: 0).isActive = true
            row2.topAnchor.constraint(equalTo: lastView.bottomAnchor, constant: 0).isActive = true
            row2.centerXAnchor.constraint(equalTo: currentPage.centerXAnchor).isActive = true
            
            
            let lblAction = otTableLabeCell()
            lblAction.text = answers[0]
            row2.addSubview(lblAction)
            
            lblAction.widthAnchor.constraint(equalTo: row2.widthAnchor, multiplier: 0.4, constant: 0).isActive = true
            lblAction.topAnchor.constraint(equalTo: row2.topAnchor, constant: 0).isActive = true
            lblAction.leftAnchor.constraint(equalTo: row2.leftAnchor).isActive = true
            lblAction.layoutIfNeeded()
            
            labelHeights.append(lblAction.frame.size.height)
            
            
            let lblWho = otTableLabeCell()
            lblWho.textAlignment = .center
            lblWho.text = answers[1]
            if answers[1] == bezOtvetaStr
            {
                lblWho.textColor = UIColor.red
            }
            row2.addSubview(lblWho)
            
            lblWho.widthAnchor.constraint(equalTo: row2.widthAnchor, multiplier: 0.2, constant: 0).isActive = true
            lblWho.topAnchor.constraint(equalTo: row2.topAnchor, constant: 0).isActive = true
            lblWho.leftAnchor.constraint(equalTo: lblAction.rightAnchor).isActive = true
            lblWho.layoutIfNeeded()
            
            labelHeights.append(lblWho.frame.size.height)
            
            
            let lblDate = otTableLabeCell()
            lblDate.textAlignment = .center
            lblDate.text = answers[2]

            row2.addSubview(lblDate)
            
            lblDate.widthAnchor.constraint(equalTo: row2.widthAnchor, multiplier: 0.2, constant: 0).isActive = true
            lblDate.topAnchor.constraint(equalTo: row2.topAnchor, constant: 0).isActive = true
            lblDate.leftAnchor.constraint(equalTo: lblWho.rightAnchor).isActive = true
            lblDate.layoutIfNeeded()
            
            labelHeights.append(lblDate.frame.size.height)
            
            
            let lblPrioritet = otTableLabeCell()
            lblPrioritet.textAlignment = .center
            lblPrioritet.text = answers[3]
            
            row2.addSubview(lblPrioritet)
            
            lblPrioritet.widthAnchor.constraint(equalTo: row2.widthAnchor, multiplier: 0.2, constant: 0).isActive = true
            lblPrioritet.topAnchor.constraint(equalTo: row2.topAnchor, constant: 0).isActive = true
            lblPrioritet.leftAnchor.constraint(equalTo: lblDate.rightAnchor).isActive = true
            lblPrioritet.layoutIfNeeded()
            
            
            if skrepka.prioritet == 1
            {
                lblPrioritet.textColor = gh.otLime
            }
            
            if skrepka.prioritet == 2
            {
                lblPrioritet.textColor = gh.otYellow
            }
            
            if skrepka.prioritet == 3
            {
                lblPrioritet.textColor = UIColor.red
            }
        
            
            labelHeights.append(lblPrioritet.frame.size.height)
            
            let max = labelHeights.max()!
            
            row2.heightAnchor.constraint(equalToConstant: max).isActive = true
            lblAction.heightAnchor.constraint(equalToConstant: max).isActive = true
            lblWho.heightAnchor.constraint(equalToConstant: max).isActive = true
            lblDate.heightAnchor.constraint(equalToConstant: max).isActive = true
            lblPrioritet.heightAnchor.constraint(equalToConstant: max).isActive = true
            
            lastView = row1
            chechForPage(lastView: lastView)
        }
        
        
        
        
        
        listOfPages.append(currentPage)
        currentPage.layoutIfNeeded()
        
        print(listOfPages.count,"pagesss counttt")
        
        if listOfPages.count != 0
        {
            
            var viewsAsImages : [UIImage] = []

            for view in listOfPages
            {
                let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
                let image = renderer.image
                {
                    ctx in
                    //CGRect(x: 0, y: 0, width: view.bounds.width / 2, height: view.bounds.height/2)
                    print("converting view to image")
                    view.drawHierarchy(in: view.bounds , afterScreenUpdates: true)
                }
                viewsAsImages.append( image)
            }
    
            
            
            let fileName = randomString()
            
            let fm = FileManager.default
            let docDir = fm.urls(for: .documentDirectory, in: .userDomainMask).first!
            
            let dataPath = docDir.appendingPathComponent("Otchets")
            do
            {
                try FileManager.default.createDirectory(atPath: dataPath.path, withIntermediateDirectories: true, attributes: nil)
            }
            catch
            {
                print("Otchet dir Already Exists")
            }
            
            var testImages : [UIImage] = []
            //Resizing Final pages as Images!!
            for img in viewsAsImages
            {
                let newImg = UIImageJPEGRepresentation(img, 0.7);
                testImages.append(UIImage(data: newImg!)!)
            }
            
            ///////////////////////////
            
            
            let url = URL(fileURLWithPath: dataPath.path).appendingPathComponent("\(fileName).pdf")
            do
            {
                //try PDFGenerator.generate(listOfPages, to: url)
//                try PDFGenerator.generate(viewsAsImages, to: url)
                try PDFGenerator.generate(testImages, to: url)
            }
            catch
            {
                print("Exception on creating")
            }
            
            
            
            
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let filePath = documentsURL.appendingPathComponent("pathLocation").path

            
            let otchet = Model_Otchet()
            
            otchet.name = shablon.name!
            otchet.date = Date()
            if currentShablon.localImageName != nil
            {
                otchet.logoFileName = currentShablon.localImageName!
            }
            otchet.percent = currentShablon.weightPercent
            otchet.pdfFileName = fileName
            otchet.fbId = shablon.fbId!
            otchet.Id = fileName
            
            for cat in shablon.allCategs
            {
                otchet.categNames.append(cat.name!)
                otchet.catagPercents.append(cat.weightPercent!)
            }
            
            let sql = MySqlite()
            sql.saveOtchet(otchet: otchet)
            
            let currentView = UIApplication.topViewController()?.view!
            
            gh.showToastWithDuration(message: "Отчёт успешно сохранен, вы можете продолжить аудит и сохранить несколько отчетов", view: currentView!, duration: 4.0)
        
            listOfPages.removeAll()
        }
        else
        {
            print("now nilll 00")
        }
        
    }
        
        
    func countWeight()
    {
        for categ in currentShablon.allCategs
        {
            var categSum : Int = 0
            var categGet : Int = 0
            
            for element in categ.allElementsSorted
            {
                if element is Model_Question
                {
                    let question = element as! Model_Question
                    categSum += question.weight
                    
                    if question.questionType == 0 || question.questionType == 1
                    {
                        for btn in question.auditButtons
                        {
                            if btn.isOn
                            {
                                let index = question.auditButtons.index(of: btn)
                                
                                if index == 0
                                {
                                    categGet += question.weight
                                }
                                
                                if index == 2
                                {
                                    categSum -= question.weight
                                }
                            }
                        }
                    }
                    
                    
                    if question.questionType == 2
                    {
                        for btn in question.auditButtons
                        {
                            if btn.isOn
                            {
                                let index = question.auditButtons.index(of: btn)!
                                
                                let pm = question.plusMinus[index]
                                
                                if pm == 1
                                {
                                    categGet += question.weight
                                }
                            }
                        }
                    }
                }
            
                if element is Model_CheckBox
                {
                    
                    let checkBox = element as! Model_CheckBox
                    
                    if checkBox.neOzenBtn.isOn == false
                    {
                        let weight = checkBox.weight!
                        
                        if checkBox.neOzenBtn.isOn == false
                        {
                            categSum += weight
                            
                            if checkBox.auditCheckBox.checkState == .checked
                            {
                                categGet += weight
                            }
                        }
                    }
                }
            
                if element is Model_QuestVar
                {
                    let questVar = element as! Model_QuestVar
                    
                    for weight in questVar.weights
                    {
                        categSum += weight
                    }
                    
                    for btn in questVar.auditToggButtons
                    {
                        if btn.isOn
                        {
                            let index = questVar.auditToggButtons.index(of: btn)!
                            
                            let weit = questVar.weights[index]
                            
                            categGet += weit
                        }
                    }
                }
            
                
                if element is Model_Toggle
                {
                    let toggle = element as! Model_Toggle
                    
                    let weight = toggle.weight!
                    
                    categSum += weight
                    
                    if toggle.auditToggle.index == 1
                    {
                        categGet += weight
                    }
                }
            
            }
        
            categ.weightSum = categSum
            categ.weightGet = categGet
            
            let max = Double(categ.weightSum)
            let get = Double(categ.weightGet)
            var percent = 0
            if max != 0
            {
                percent = Int((get/max) * 100)
            }
            
            categ.weightPercent = percent
            
            currentShablon.weightSum += categSum
            currentShablon.weightGet += categGet
        }
        
        let max : Double = Double(currentShablon.weightSum)
        let get : Double = Double(currentShablon.weightGet)

        currentShablon.weightPercent = Int((get/max) * 100)
    }
        
        
        
        
        
        
        
        func getAnswerFromQuestion (quest : Model_Question) -> String
        {
            var answerStr : String!
            
            if quest.questionType != 2
            {
                var selectedInt = 999
                
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
                    case 1 :
                        answerStr = "Нет"
                    case 2:
                        answerStr = "Н/А"
                    case 999:
                        answerStr = bezOtvetaStr
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
                    case 1 :
                        answerStr = "Рискованно"
                    case 2:
                        answerStr = "Н/А"
                    case 999:
                        answerStr = bezOtvetaStr
                    default:
                        break
                    }
                }
                
                
            }
            
            if quest.questionType == 2
            {
                var selectedInt = 999
                
                for btn in quest.auditButtons
                {
                    if btn.isOn
                    {
                        selectedInt = quest.auditButtons.index(of: btn)!
                        break
                    }
                }
                
                if selectedInt == 999
                {
                    answerStr = bezOtvetaStr
                }
                else
                {
                    answerStr = quest.answerVariants[selectedInt]
                }
            }
            
            return answerStr
        }
        
        
        
        
        
        
        func getQuestionColor(quest : Model_Question) -> UIColor
        {
            
            
            
            
            
            var answerColor : UIColor!
            
            if quest.questionType != 2
            {
                var selectedInt = 999
                
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
                        answerColor = green
                    case 1 :
                        answerColor = red
                    case 2:
                        answerColor = UIColor.clear
                    case 999:
                        answerColor = UIColor.clear
                    default:
                        answerColor = UIColor.clear
                    }
                }
                
                
                if quest.questionType == 1
                {
                    switch selectedInt
                    {
                    case 0 :
                        answerColor = green
                    case 1 :
                        answerColor = red
                    case 2:
                        answerColor = UIColor.clear
                    case 999:
                        answerColor = UIColor.clear
                    default:
                        answerColor = UIColor.clear
                    }
                }
                
                
            }
            
            if quest.questionType == 2
            {
                answerColor = UIColor.clear
            }
            
            return answerColor
        }
        
        
        
        
        func getQuestionDopStr (quest : Model_Question) -> String
        {
            var dopString = ""
            
            if quest.skrepka != nil
            {
                listAddedSkrepka.append(quest.skrepka!)
                dopString = "Назначено действие : действие №\(listAddedSkrepka.count)"
            }
            
            if quest.addedImages.count > 0
            {
                print("quest has images will add to ImagesArray")
                listAddedImagesGroup.append(quest.addedImages)
                
                if  quest.skrepka != nil
                {
                    dopString += "\n"
                }
                dopString += "Добавлены фотографии : приложение №\(listAddedImagesGroup.count)"
            }
            
            if quest.commentStr != nil
            {
                if quest.skrepka != nil || quest.addedImages.count > 0
                {
                    dopString += "\n"
                }
                dopString += "Заметка аудитора : \(quest.commentStr!)"
            }
            
            return dopString
        }
        
        
        
        func getElementDopStr(element : Audit_Element) -> String
        {
            var dopString = ""
            if element.skrepka != nil
            {
                listAddedSkrepka.append(element.skrepka!)
                dopString = "Назначено действие : действие №\(listAddedSkrepka.count)"
            }
            
            if element is Model_Media
            {
                if (element as! Model_Media).addedPhoto != nil
                {
                    if element.skrepka != nil
                    {
                        dopString += "\n"
                    }
                    
                    listAddedImagesGroup.append([(element as! Model_Media).addedPhoto])
                    dopString += "Добавлены фотографии : приложение №\(listAddedImagesGroup.count)"
                }
            }
            
            if element is Model_CheckBox
            {
                let cheb = element as! Model_CheckBox
                if cheb.commentStr != nil
                {
                    if element.skrepka != nil
                    {
                        dopString += "\n"
                        dopString += "Заметка аудитора : \(cheb.commentStr)"
                    }
                }
            }
            
            return dopString
        }
        
        
        func getDateStr (modelDate : Model_Date) -> String
        {
            var dateStr = ""
            if modelDate.selectedDate != nil
            {
                let formatter = DateFormatter()
                formatter.locale = NSLocale(localeIdentifier: "ru_RU") as Locale?
                if modelDate.showDate == 1 && modelDate.showTime == 1
                {
                    formatter.dateFormat = "yyyy-MMMM-dd HH:mm"
                }
                else
                {
                    if modelDate.showTime == 1
                    {
                        formatter.dateFormat = "HH:mm"
                    }
                    
                    if modelDate.showDate == 1
                    {
                        formatter.dateFormat = "yyyy-MMMM-dd"
                    }
                }
                
                dateStr = formatter.string(from: modelDate.selectedDate!)
            }
            else
            {
                dateStr = bezOtvetaStr
            }
            
            return dateStr
        }
        
        
        func getInfoStr(modelInfo : Model_Info) -> String
        {
            var answerStr = ""
            if modelInfo.text != nil
            {
                answerStr += modelInfo.text!
            }
            if modelInfo.urlStr != nil
            {
                if modelInfo.text != nil
                {
                    answerStr += "\n"
                }
                answerStr += modelInfo.urlStr
            }
            
            return answerStr
        }
        
        
        
        func getQuestVarAnswer(qVar : Model_QuestVar) -> String
        {
            var answerStr = ""
            
            for btn in qVar.auditToggButtons
            {
                if btn.isOn
                {
                    let index = qVar.auditToggButtons.index(of: btn)
                    
                    if answerStr != ""
                    {
                        answerStr += "\n"
                    }
                    
                    answerStr += qVar.answers[index!]
                }
            }
            
            if answerStr == ""
            {
                answerStr = bezOtvetaStr
            }
            
            return answerStr
        }
        
        
        func getSliderStr(seek : Model_Seeker) -> String
        {
            var answerStr = ""
            
            let min = seek.min!
            let step = seek.step!
            let val = Double(seek.lastSliderIndex)
            let valueToShow = min + (step * val)
            
            answerStr = String(valueToShow)
            return answerStr
        }
        
        func getTimerString(timer : Model_Timer) -> String
        {
            let seconds = timer.timerSeconds
            var minutes = Int(seconds / 60)
            
            minutes = Int(seconds / 60)
            
            var secStr : String
            
            var minStr : String
            
            if minutes < 10
            {
                minStr = String(minutes)
            }
            else
            {
                minStr = String(minutes)
            }
            
            if (seconds % 60) < 10
            {
                secStr = "0\(seconds % 60)"
            }
            else
            {
                secStr = String(seconds % 60)
            }
            
            let finalStr = "\(minStr):\(secStr)"
            
            return finalStr
        }
        
        
        func chechForPage(lastView : UIView)
        {
            currentPage.layoutIfNeeded()
            let viewMinY = lastView.frame.origin.y + lastView.frame.size.height
            
            if viewMinY > 830
            {
                let lastViewHeight = lastView.frame.size.height
                let lastViewWidth = lastView.frame.size.width
                
                lastView.removeFromSuperview()
                
                let finishedPage = currentPage!
                listOfPages.append(finishedPage)
                
                currentPage = UIView(frame: CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight))
                currentPage.backgroundColor = UIColor.white
                currentPage.addSubview(lastView)
                
                lastView.widthAnchor.constraint(equalTo: currentPage.widthAnchor, multiplier: 1, constant: -widthMinus).isActive = true
                lastView.heightAnchor.constraint(equalToConstant: lastViewHeight).isActive = true
                lastView.centerXAnchor.constraint(equalTo: currentPage.centerXAnchor, constant: 0).isActive = true
                lastView.topAnchor.constraint(equalTo: currentPage.topAnchor, constant: beginTopMargin).isActive = true
                lastView.layoutIfNeeded()
            }
            
        }
    
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
    
    
    func getSkrepkaTextArray (skrepka : Skrepka_Data) -> [String]
    {
        var answers : [String] = []
        
        answers.append(skrepka.strTodo!)
        if skrepka.whoTodo != nil && skrepka.whoTodo! != ""
        {
            answers.append(skrepka.whoTodo!)
        }
        else
        {
            answers.append(bezOtvetaStr)
        }
        
        let formatter = DateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "ru_RU") as Locale?

        formatter.dateFormat = "yyyy-MMMM-dd"
        
        answers.append(formatter.string(from: skrepka.dateToDo!))
        
        switch skrepka.prioritet
        {
            case 0:
                answers.append("Без приоритета")
            case 1:
                answers.append("Низкий")
            case 2:
                answers.append("Средний")
            case 3:
                answers.append("Высокий")
            default:
                break
        }
        
        return answers
    }
    

    
    
    
}




