import UIKit
import Tabman
import Pageboy
import SignaturePad

class beginAuVC: TabmanViewController, PageboyViewControllerDataSource, UIImagePickerControllerDelegate , UINavigationControllerDelegate,SignaturePadDelegate,UITextFieldDelegate,UITextViewDelegate
{
    var listOfVC : [UIViewController] = []
    var listOfPageName : [String] = []
    var shablonToShow : Model_Shablon!
    var listOfScrolls : [UIScrollView] = []
    
    var currentPage : UIViewController!
    var currentScroll : UIScrollView!
    
    var scrollHeight : CGFloat = 0
    
    var testView : UIView!
    
    var lastLiftedHeight : CGFloat!
    
    let gc = GlobalClass.sharedInstance
    let gh = GlobalHelper.sharedInstance
    
    let sideMargin8 : CGFloat  = 8
    let sideInnerMargin4 :CGFloat = 4
    let topMargin4 : CGFloat = 4
    let squareSize36 : CGFloat = 36
    let textViewMargin16 : CGFloat = 16
    let textViewTopMargin8 : CGFloat = 8
    let textViewSideMargin8 : CGFloat = 8
    let buttonSideMargin : CGFloat = 100
    let checkBoxRightMargin : CGFloat = 56
    
    var lastRequestedMedia : Model_Media!
    //var lastViewToAddMedia : UIView!
    var lastEditedCateg : Model_Categ!
    
    var lastRightRoot : UIView!
    
    var overallSeconds : Int = 0
    var timer : Timer!
    var i :Int!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(sender:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(sender:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        shablonToShow = gc.shablonToBegin
        
        view.backgroundColor = UIColor.purple
        
        
        let bgImg = UIImageView()
        makeFullAsParent(parent: view, child: bgImg)
        bgImg.image = gh.mainBG
        bgImg.contentMode = .scaleToFill
        self.view.insertSubview(bgImg, at: 0)
        
        prepareVC()
        self.dataSource = self
        
        
        self.view.clipsToBounds = true
        self.bar.appearance = TabmanBar.Appearance({ (appearance) in
            appearance.layout.minimumItemWidth = view.frame.size.width/3
            appearance.layout.interItemSpacing = 8
            appearance.layout.edgeInset = 0
            appearance.state.color = UIColor.lightGray
            appearance.state.selectedColor = gh.myBejColor
            appearance.style.background = TabmanBar.BackgroundView.Style.solid(color: gh.myRed)
            appearance.indicator.color = gh.myBejColor
            appearance.text.font = gh.globalFont18?.withSize(16)
            appearance.text.selectedFont = gh.globalFont20
        })

        self.bar.style = .scrollingButtonBar
        var listOfItems : [Item] = []

        for str in listOfPageName
        {
            let item = Item(title: str)
            listOfItems.append(item)
        }

        self.bar.items = listOfItems
        
    }
    

    
    
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int
    {
        return listOfVC.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController?
    {
        currentPage = listOfVC[index]
        currentScroll = listOfScrolls[index]
        return listOfVC[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page?
    {
        return nil
    }
    
    
    
    func prepareVC()
    {
        for categ in shablonToShow.allCategs
        {
            
            var lastAdded : UIView!
            let name = categ.name
            listOfPageName.append(name!)

            let categView = UIViewController()
            
            
            let bgImg = UIImageView()
            makeFullAsParent(parent: categView.view, child: bgImg)
            bgImg.image = gh.mainBG
            bgImg.contentMode = .scaleToFill
            categView.view.addSubview(bgImg)
            
            let categScroll = UIScrollView()
            listOfScrolls.append(categScroll)
            
            categScroll.translatesAutoresizingMaskIntoConstraints  = false
            categScroll.tag = gh.tagMyScrollView
            categView.view.addSubview(categScroll)
            categScroll.bounces = false
            
            categScroll.widthAnchor.constraint(equalTo: categView.view.widthAnchor, multiplier: 1, constant: 0).isActive = true
            categScroll.centerXAnchor.constraint(equalTo: categView.view.centerXAnchor).isActive = true
            categScroll.topAnchor.constraint(equalTo: categView.view.topAnchor ,constant : 0).isActive = true
            categScroll.bottomAnchor.constraint(equalTo: categView.view.bottomAnchor).isActive = true
            
            
            var fullScrollHeight : CGFloat = 0
            
            for element in categ.allElementsSorted
            {
                if element is Model_Question
                {
                    let question = element as! Model_Question
                    var elementHeight : CGFloat = 0
                    
                    let rootView = myAuditView()
                    categScroll.addSubview(rootView)
                    print("added question")
                    
                    rootView.widthAnchor.constraint(equalTo: categScroll.widthAnchor, multiplier: 1, constant: -sideMargin8).isActive = true
                    rootView.centerXAnchor.constraint(equalTo: categScroll.centerXAnchor).isActive = true
                    rootView.leftAnchor.constraint(equalTo: categScroll.leftAnchor, constant: topMargin4).isActive = true
                  
                    if(lastAdded == nil)
                    {
                    rootView.topAnchor.constraint(equalTo: categScroll.topAnchor, constant: topMargin4).isActive = true
                    }
                    else
                    {
                        rootView.topAnchor.constraint(equalTo: lastAdded.bottomAnchor, constant: topMargin4).isActive = true
                    }
                    
                    print("RootView added")
                    let typeImage = myTypeImage(typeInt: gh.typeQuestion)
                    
                    rootView.addSubview(typeImage)
                    typeImage.widthAnchor.constraint(equalToConstant: squareSize36).isActive = true
                    typeImage.heightAnchor.constraint(equalToConstant: squareSize36).isActive = true
                    typeImage.leftAnchor.constraint(equalTo: rootView.leftAnchor, constant: topMargin4).isActive = true
                    typeImage.topAnchor.constraint(equalTo: rootView.topAnchor, constant: topMargin4).isActive = true
                    typeImage.layoutIfNeeded()
                    
                    
                    if question.obyaz! == 1
                    {
                        let obyazImage = myObyazImage()
                        rootView.addSubview(obyazImage)

                        obyazImage.widthAnchor.constraint(equalToConstant: squareSize36).isActive = true
                        obyazImage.heightAnchor.constraint(equalToConstant: squareSize36).isActive = true
                        obyazImage.leftAnchor.constraint(equalTo: typeImage.rightAnchor, constant: sideInnerMargin4).isActive = true
                        obyazImage.topAnchor.constraint(equalTo: rootView.topAnchor, constant: sideInnerMargin4).isActive = true
                        obyazImage.layoutIfNeeded()
                    }


                    let btnSkrepka = mySkrepkaButton()
                    rootView.addSubview(btnSkrepka)

                    btnSkrepka.widthAnchor.constraint(equalToConstant: squareSize36).isActive = true
                    btnSkrepka.heightAnchor.constraint(equalToConstant: squareSize36).isActive = true
                    btnSkrepka.rightAnchor.constraint(equalTo: rootView.rightAnchor, constant: -sideInnerMargin4).isActive = true
                    btnSkrepka.topAnchor.constraint(equalTo: rootView.topAnchor, constant: topMargin4).isActive = true
                    btnSkrepka.layoutIfNeeded()

                    elementHeight += squareSize36+topMargin4
                    
                    
                    let btnComment = myCommentButton()
                    rootView.addSubview(btnComment)

                    btnComment.widthAnchor.constraint(equalToConstant: squareSize36).isActive = true
                    btnComment.heightAnchor.constraint(equalToConstant: squareSize36).isActive = true
                    btnComment.rightAnchor.constraint(equalTo: btnSkrepka.leftAnchor, constant: -sideInnerMargin4).isActive = true
                    btnComment.topAnchor.constraint(equalTo: rootView.topAnchor, constant: topMargin4).isActive = true
                    btnComment.layoutIfNeeded()
                    
                    let btnAddPhoto = myAddPhotoButton()
                    rootView.addSubview(btnAddPhoto)

                    btnAddPhoto.widthAnchor.constraint(equalToConstant: squareSize36).isActive = true
                    btnAddPhoto.heightAnchor.constraint(equalToConstant: squareSize36).isActive = true
                    btnAddPhoto.rightAnchor.constraint(equalTo: btnComment.leftAnchor, constant: -sideInnerMargin4).isActive = true
                    btnAddPhoto.topAnchor.constraint(equalTo: rootView.topAnchor, constant: topMargin4).isActive = true
                    btnAddPhoto.layoutIfNeeded()

                    let viewForText = myAuditView()

                    rootView.addSubview(viewForText)

                    viewForText.widthAnchor.constraint(equalTo: rootView.widthAnchor, multiplier: 1, constant: -textViewMargin16).isActive = true
                    viewForText.centerXAnchor.constraint(equalTo: rootView.centerXAnchor, constant: 0).isActive = true
                    viewForText.topAnchor.constraint(equalTo: typeImage.bottomAnchor, constant: topMargin4).isActive = true
                    
                    
                    let lblText = myLabelForText()
                    lblText.text = question.text!
                    viewForText.addSubview(lblText)

                    lblText.widthAnchor.constraint(equalTo: viewForText.widthAnchor, multiplier: 1, constant: -textViewSideMargin8).isActive = true
                    lblText.centerXAnchor.constraint(equalTo: viewForText.centerXAnchor).isActive = true
                    lblText.leftAnchor.constraint(equalTo: viewForText.leftAnchor, constant: sideInnerMargin4).isActive = true
                    lblText.topAnchor.constraint(equalTo: viewForText.topAnchor, constant: topMargin4).isActive = true
                    
                    lblText.layoutIfNeeded()
                    let height = lblText.frame.size.height
                    
                    viewForText.heightAnchor.constraint(equalToConstant: height+textViewTopMargin8).isActive = true
                    viewForText.layoutIfNeeded()
                    
                    elementHeight += height+topMargin4
                    
                    if question.questionType != 2
                    {
                        let togg0 = myBtnTogg()
                        rootView.addSubview(togg0)
                       
                        togg0.widthAnchor.constraint(equalTo: rootView.widthAnchor, multiplier: 1, constant: -buttonSideMargin).isActive = true
                        togg0.heightAnchor.constraint(equalToConstant: squareSize36).isActive = true
                        togg0.centerXAnchor.constraint(equalTo: rootView.centerXAnchor).isActive = true
                        togg0.topAnchor.constraint(equalTo: viewForText.bottomAnchor, constant: topMargin4).isActive = true
                        togg0.layoutIfNeeded()
                        togg0.layer.cornerRadius = togg0.frame.height / 6
                        
                        let togg1 = myBtnTogg()
                        rootView.addSubview(togg1)
                        
                        togg1.widthAnchor.constraint(equalTo: rootView.widthAnchor, multiplier: 1, constant: -buttonSideMargin).isActive = true
                        togg1.heightAnchor.constraint(equalToConstant: squareSize36).isActive = true
                        togg1.centerXAnchor.constraint(equalTo: rootView.centerXAnchor).isActive = true
                        togg1.topAnchor.constraint(equalTo: togg0.bottomAnchor, constant: topMargin4).isActive = true
                        togg1.layoutIfNeeded()
                        togg1.layer.cornerRadius = togg1.frame.height / 6
                        
                        let togg2 = myBtnTogg()
                        rootView.addSubview(togg2)
                        
                        togg2.widthAnchor.constraint(equalTo: rootView.widthAnchor, multiplier: 1, constant: -buttonSideMargin).isActive = true
                        togg2.heightAnchor.constraint(equalToConstant: squareSize36).isActive = true
                        togg2.centerXAnchor.constraint(equalTo: rootView.centerXAnchor).isActive = true
                        togg2.topAnchor.constraint(equalTo: togg1.bottomAnchor, constant: topMargin4).isActive = true
                        togg2.layoutIfNeeded()
                        togg2.layer.cornerRadius = togg2.frame.height / 6
                        
                        if question.questionType == 0
                        {
                            togg0.setTitle("Да", for: .normal)
                            togg1.setTitle("Нет", for: .normal)
                            togg2.setTitle("Н/А", for: .normal)
                        }
                        else if question.questionType == 1
                        {
                            togg0.setTitle("Безопасно", for: .normal)
                            togg1.setTitle("Рискованно", for: .normal)
                            togg2.setTitle("Н/А", for: .normal)
                        }
                        
                        elementHeight += (squareSize36*3) + (topMargin4*3)
                        
                        question.auditButtons.append(togg0)
                        question.auditButtons.append(togg1)
                        question.auditButtons.append(togg2)
                    }
                    else if question.questionType == 2
                    {
                        var lastAddedButton : UIButton!
                        
                        for str in question.answerVariants
                        {
                            let togg = myBtnTogg()
                            rootView.addSubview(togg)
                            
                            togg.setTitle(str, for: .normal)
                            
                            
                            if lastAddedButton == nil
                            {
                                togg.topAnchor.constraint(equalTo: viewForText.bottomAnchor, constant: topMargin4).isActive = true
                            }
                            else
                            {
                                togg.topAnchor.constraint(equalTo: lastAddedButton.bottomAnchor, constant: topMargin4).isActive = true
                            }
                            
                            togg.widthAnchor.constraint(equalTo: rootView.widthAnchor, multiplier: 1, constant: -buttonSideMargin).isActive = true
                            togg.heightAnchor.constraint(equalToConstant: squareSize36).isActive = true
                            togg.centerXAnchor.constraint(equalTo: rootView.centerXAnchor).isActive = true
                            togg.layoutIfNeeded()
                            togg.layer.cornerRadius = togg.frame.height / 6
                            
                            elementHeight += squareSize36+topMargin4
                            lastAddedButton = togg
                            
                            question.auditButtons.append(togg)
                        }
                    }
                    
                    for btn in question.auditButtons
                    {
                        btn.click =
                            {
                                let indexOfCurrent = question.auditButtons.index(of: btn)
                                
                                for butt in question.auditButtons
                                {
                                    if question.auditButtons.index(of: butt) == indexOfCurrent
                                    {
                                        print("contininini")
                                        continue
                                    }
                                    if butt.isOn
                                    {
                                        butt.isOn = false
                                        butt.onOffTogg()
                                    }

                                }
                            }
                    }
                    
                    
                    rootView.heightAnchor.constraint(equalToConstant: elementHeight+16).isActive = true
                    lastAdded = rootView
                    rootView.layoutIfNeeded()
                    question.auditView = rootView
                    
                    
                    
                    btnSkrepka.click =
                        {
                            let skrepkaDialog = mySkrepkaDialog(elem: element)
                            self.present(skrepkaDialog, animated: true, completion: nil)
                        }
                }
                
                
                if element is Model_Adress
                {
                    let adress = element as! Model_Adress
                    var elementHeight : CGFloat = 0
                    
                    let rootView = myAuditView()
                    categScroll.addSubview(rootView)
                    print("added adress")
                    
                    rootView.widthAnchor.constraint(equalTo: categScroll.widthAnchor, multiplier: 1, constant: -sideMargin8).isActive = true
                    rootView.centerXAnchor.constraint(equalTo: categScroll.centerXAnchor).isActive = true
                    rootView.leftAnchor.constraint(equalTo: categScroll.leftAnchor, constant: topMargin4).isActive = true
                    
                    if(lastAdded == nil)
                    {
                        rootView.topAnchor.constraint(equalTo: categScroll.topAnchor, constant: topMargin4).isActive = true
                    }
                    else
                    {
                        rootView.topAnchor.constraint(equalTo: lastAdded.bottomAnchor, constant: topMargin4).isActive = true
                    }
                    
                    let typeImage = myTypeImage(typeInt: gh.typeAdress)
                    
                    rootView.addSubview(typeImage)
                    typeImage.widthAnchor.constraint(equalToConstant: squareSize36).isActive = true
                    typeImage.heightAnchor.constraint(equalToConstant: squareSize36).isActive = true
                    typeImage.leftAnchor.constraint(equalTo: rootView.leftAnchor, constant: topMargin4).isActive = true
                    typeImage.topAnchor.constraint(equalTo: rootView.topAnchor, constant: topMargin4).isActive = true
                    typeImage.layoutIfNeeded()
                    
                    let btnSkrepka = mySkrepkaButton()
                    rootView.addSubview(btnSkrepka)
                    
                    btnSkrepka.widthAnchor.constraint(equalToConstant: squareSize36).isActive = true
                    btnSkrepka.heightAnchor.constraint(equalToConstant: squareSize36).isActive = true
                    btnSkrepka.rightAnchor.constraint(equalTo: rootView.rightAnchor, constant: -sideInnerMargin4).isActive = true
                    btnSkrepka.topAnchor.constraint(equalTo: rootView.topAnchor, constant: topMargin4).isActive = true
                    btnSkrepka.layoutIfNeeded()
                    
                    elementHeight += squareSize36+topMargin4
                    
                    let lblText = myLabelForText()
                    lblText.text = adress.text!
                    rootView.addSubview(lblText)
                    
                    lblText.widthAnchor.constraint(equalTo: rootView.widthAnchor, multiplier: 1, constant: -textViewSideMargin8).isActive = true
                    lblText.centerXAnchor.constraint(equalTo: rootView.centerXAnchor).isActive = true
                    lblText.topAnchor.constraint(equalTo: typeImage.bottomAnchor, constant: topMargin4).isActive = true
                    lblText.heightAnchor.constraint(equalToConstant: squareSize36).isActive = true
                    lblText.layoutIfNeeded()
                    
                    print(adress.text!,"adresssss")
                    
                    lblText.layoutIfNeeded()
                    let height = lblText.frame.size.height
                    
                    elementHeight += height+topMargin4
                    
                    let textField = myTextFieldOneLine()
                    rootView.addSubview(textField)
                    
                    textField.widthAnchor.constraint(equalTo: rootView.widthAnchor, multiplier: 1, constant: -textViewMargin16).isActive = true
                    textField.centerXAnchor.constraint(equalTo: rootView.centerXAnchor, constant: 0).isActive = true
                    textField.topAnchor.constraint(equalTo: lblText.bottomAnchor, constant: topMargin4).isActive = true
                    textField.heightAnchor.constraint(equalToConstant: squareSize36).isActive = true
                    textField.layoutIfNeeded()
                    
                    textField.delegate = self
                    
                    elementHeight += squareSize36+topMargin4
                    
                    rootView.heightAnchor.constraint(equalToConstant: elementHeight+8).isActive = true
                    
                    lastAdded = rootView
                    
                    rootView.layoutIfNeeded()
                    adress.auditView = rootView
                    
                    adress.auditTF = textField
                    
                    btnSkrepka.click =
                        {
                            let skrepkaDialog = mySkrepkaDialog(elem: element)
                            self.present(skrepkaDialog, animated: true, completion: nil)
                        }
                }
                
                if element is Model_CheckBox
                {
                    let checkBox = element as! Model_CheckBox
                    var elementHeight : CGFloat = 0
                    
                    let rootView = myAuditView()
                    categScroll.addSubview(rootView)
                    print("added checkbox")
                    
                    rootView.widthAnchor.constraint(equalTo: categScroll.widthAnchor, multiplier: 1, constant: -sideMargin8).isActive = true
                    rootView.centerXAnchor.constraint(equalTo: categScroll.centerXAnchor).isActive = true
                    rootView.leftAnchor.constraint(equalTo: categScroll.leftAnchor, constant: topMargin4).isActive = true
                    
                    if(lastAdded == nil)
                    {
                        rootView.topAnchor.constraint(equalTo: categScroll.topAnchor, constant: topMargin4).isActive = true
                    }
                    else
                    {
                        rootView.topAnchor.constraint(equalTo: lastAdded.bottomAnchor, constant: topMargin4).isActive = true
                    }
                    
                    let typeImage = myTypeImage(typeInt: gh.typeCheckBox)
                    
                    rootView.addSubview(typeImage)
                    typeImage.widthAnchor.constraint(equalToConstant: squareSize36).isActive = true
                    typeImage.heightAnchor.constraint(equalToConstant: squareSize36).isActive = true
                    typeImage.leftAnchor.constraint(equalTo: rootView.leftAnchor, constant: topMargin4).isActive = true
                    typeImage.topAnchor.constraint(equalTo: rootView.topAnchor, constant: topMargin4).isActive = true
                    typeImage.layoutIfNeeded()
                    
                    let btnSkrepka = mySkrepkaButton()
                    rootView.addSubview(btnSkrepka)
                    
                    btnSkrepka.widthAnchor.constraint(equalToConstant: squareSize36).isActive = true
                    btnSkrepka.heightAnchor.constraint(equalToConstant: squareSize36).isActive = true
                    btnSkrepka.rightAnchor.constraint(equalTo: rootView.rightAnchor, constant: -sideInnerMargin4).isActive = true
                    btnSkrepka.topAnchor.constraint(equalTo: rootView.topAnchor, constant: topMargin4).isActive = true
                    btnSkrepka.layoutIfNeeded()
                    
                    elementHeight += squareSize36+topMargin4
                    
                    let viewForCheb = myAuditView()
                    rootView.addSubview(viewForCheb)
                    
                    viewForCheb.widthAnchor.constraint(equalTo: rootView.widthAnchor, multiplier: 1, constant: -textViewMargin16).isActive = true
                    viewForCheb.topAnchor.constraint(equalTo: typeImage.bottomAnchor, constant: 4).isActive = true
                    viewForCheb.centerXAnchor.constraint(equalTo: rootView.centerXAnchor).isActive = true
                    
                    let lblQuestion = myLabelForText()
                    lblQuestion.text = checkBox.text!
                    viewForCheb.addSubview(lblQuestion)
                    
                    lblQuestion.textAlignment = .left
                    lblQuestion.widthAnchor.constraint(equalTo: viewForCheb.widthAnchor, multiplier: 1, constant: -checkBoxRightMargin).isActive = true
                    lblQuestion.heightAnchor.constraint(equalToConstant: squareSize36).isActive = true
                    lblQuestion.topAnchor.constraint(equalTo: viewForCheb.topAnchor, constant: topMargin4).isActive = true
                    lblQuestion.leftAnchor.constraint(equalTo: viewForCheb.leftAnchor, constant: 8).isActive = true
                    
                    lblQuestion.layoutIfNeeded()
                    let checkBoxTogg = myCheckBox()
                    viewForCheb.addSubview(checkBoxTogg)
                    
                    checkBoxTogg.widthAnchor.constraint(equalToConstant: squareSize36).isActive = true
                    checkBoxTogg.heightAnchor.constraint(equalToConstant: squareSize36).isActive = true
                    checkBoxTogg.centerYAnchor.constraint(equalTo: lblQuestion.centerYAnchor, constant: 0).isActive = true
                    checkBoxTogg.leftAnchor.constraint(equalTo: lblQuestion.rightAnchor, constant: 4).isActive = true
                    
        
                    viewForCheb.heightAnchor.constraint(equalToConstant: lblQuestion.frame.size.height+sideMargin8).isActive = true
                    
                    viewForCheb.layoutIfNeeded()
                    elementHeight += viewForCheb.frame.size.height + topMargin4
                    
                    rootView.heightAnchor.constraint(equalToConstant: elementHeight+8).isActive = true
                    
                    lastAdded = rootView
                    
                    rootView.layoutIfNeeded()
                    checkBox.auditView = rootView
                    
                    checkBox.auditCheckBox = checkBoxTogg
                    
                    btnSkrepka.click =
                        {
                            let skrepkaDialog = mySkrepkaDialog(elem: element)
                            self.present(skrepkaDialog, animated: true, completion: nil)
                        }
                }
                
                if element is Model_Date
                {
                    let date = element as! Model_Date
                    var elementHeight : CGFloat = 0
                    
                    let rootView = myAuditView()
                    categScroll.addSubview(rootView)
                    print("added date")
                    
                    rootView.widthAnchor.constraint(equalTo: categScroll.widthAnchor, multiplier: 1, constant: -sideMargin8).isActive = true
                    rootView.centerXAnchor.constraint(equalTo: categScroll.centerXAnchor).isActive = true
                    rootView.leftAnchor.constraint(equalTo: categScroll.leftAnchor, constant: topMargin4).isActive = true
                    
                    if(lastAdded == nil)
                    {
                        rootView.topAnchor.constraint(equalTo: categScroll.topAnchor, constant: topMargin4).isActive = true
                    }
                    else
                    {
                        rootView.topAnchor.constraint(equalTo: lastAdded.bottomAnchor, constant: topMargin4).isActive = true
                    }
                    
                    let typeImage = myTypeImage(typeInt: gh.typeDate)
                    
                    rootView.addSubview(typeImage)
                    typeImage.widthAnchor.constraint(equalToConstant: squareSize36).isActive = true
                    typeImage.heightAnchor.constraint(equalToConstant: squareSize36).isActive = true
                    typeImage.leftAnchor.constraint(equalTo: rootView.leftAnchor, constant: topMargin4).isActive = true
                    typeImage.topAnchor.constraint(equalTo: rootView.topAnchor, constant: topMargin4).isActive = true
                    typeImage.layoutIfNeeded()
                    
                    let btnSkrepka = mySkrepkaButton()
                    rootView.addSubview(btnSkrepka)
                    
                    btnSkrepka.widthAnchor.constraint(equalToConstant: squareSize36).isActive = true
                    btnSkrepka.heightAnchor.constraint(equalToConstant: squareSize36).isActive = true
                    btnSkrepka.rightAnchor.constraint(equalTo: rootView.rightAnchor, constant: -sideInnerMargin4).isActive = true
                    btnSkrepka.topAnchor.constraint(equalTo: rootView.topAnchor, constant: topMargin4).isActive = true
                    btnSkrepka.layoutIfNeeded()
                    
                    elementHeight += squareSize36+topMargin4
                    
                    let lblText = myLabelForText()
                    lblText.text = date.text!
                    rootView.addSubview(lblText)
                    
                    lblText.widthAnchor.constraint(equalTo: rootView.widthAnchor, multiplier: 1, constant: -textViewSideMargin8).isActive = true
                    lblText.centerXAnchor.constraint(equalTo: rootView.centerXAnchor).isActive = true
                    lblText.topAnchor.constraint(equalTo: typeImage.bottomAnchor, constant: 0).isActive = true
                    lblText.heightAnchor.constraint(equalToConstant: squareSize36).isActive = true
                    
                    lblText.layoutIfNeeded()
                    let height = lblText.frame.size.height
                    elementHeight += height+topMargin4
                    
                    let viewForDateShow = myAuditView()
                    rootView.addSubview(viewForDateShow)
                    
                    viewForDateShow.centerXAnchor.constraint(equalTo: rootView.centerXAnchor).isActive = true
                    viewForDateShow.widthAnchor.constraint(equalTo: rootView.widthAnchor, multiplier: 1, constant: -textViewMargin16).isActive = true
                    viewForDateShow.topAnchor.constraint(equalTo: lblText.bottomAnchor, constant: topMargin4).isActive = true
                    viewForDateShow.heightAnchor.constraint(equalToConstant: squareSize36).isActive = true
                    
                    
                    let lblForDateText = myLabelForText()
                    viewForDateShow.layoutIfNeeded()
                    viewForDateShow.addSubview(lblForDateText)
                    
                    lblForDateText.centerYAnchor.constraint(equalTo: viewForDateShow.centerYAnchor).isActive = true
                    lblForDateText.centerXAnchor.constraint(equalTo: viewForDateShow.centerXAnchor).isActive = true
                    lblForDateText.widthAnchor.constraint(equalTo: viewForDateShow.widthAnchor, multiplier: 1, constant: -sideMargin8).isActive = true
                    lblForDateText.heightAnchor.constraint(equalToConstant: squareSize36 - topMargin4).isActive = true
                    lblForDateText.layoutIfNeeded()
                    lblForDateText.text = "Ввести дату"
                    
                    
                    let showButton = myDatePickerBtn(mDate: date, lblToShow: lblForDateText, vcRootView: self.view)
                    rootView.addSubview(showButton)
                    
                    elementHeight += viewForDateShow.frame.size.height + topMargin4
                    
                    showButton.centerXAnchor.constraint(equalTo: rootView.centerXAnchor, constant: 0).isActive = true
                    showButton.widthAnchor.constraint(equalTo: rootView.widthAnchor, multiplier: 1, constant: -buttonSideMargin).isActive = true
                    showButton.heightAnchor.constraint(equalToConstant: squareSize36).isActive = true
                    showButton.topAnchor.constraint(equalTo: viewForDateShow.bottomAnchor, constant: textViewTopMargin8).isActive = true
                    showButton.setTitle("Ввести Дату", for: .normal)
                    showButton.layoutIfNeeded()
                    
                    elementHeight += showButton.frame.size.height + 6
                    
                    rootView.heightAnchor.constraint(equalToConstant: elementHeight+topMargin4).isActive = true
                    
                    lastAdded = rootView
                    
                    rootView.layoutIfNeeded()
                    date.auditView = rootView
                    
                    btnSkrepka.click =
                        {
                            let skrepkaDialog = mySkrepkaDialog(elem: element)
                            self.present(skrepkaDialog, animated: true, completion: nil)
                        }
                }
                
                if element is Model_Info
                {
                    let info = element as! Model_Info
                    
                    var elementHeight : CGFloat = 0
                    
                    let rootView = myAuditView()
                    categScroll.addSubview(rootView)
                    print("added info")
                    
                    rootView.widthAnchor.constraint(equalTo: categScroll.widthAnchor, multiplier: 1, constant: -sideMargin8).isActive = true
                    rootView.centerXAnchor.constraint(equalTo: categScroll.centerXAnchor).isActive = true
                    rootView.leftAnchor.constraint(equalTo: categScroll.leftAnchor, constant: topMargin4).isActive = true
                    
                    if(lastAdded == nil)
                    {
                        rootView.topAnchor.constraint(equalTo: categScroll.topAnchor, constant: topMargin4).isActive = true
                    }
                    else
                    {
                        rootView.topAnchor.constraint(equalTo: lastAdded.bottomAnchor, constant: topMargin4).isActive = true
                    }
                    
                    let headerView = auditHeaderView(typeInt: gh.typeInfo)
                    rootView.addSubview(headerView)

                    headerView.widthAnchor.constraint(equalTo: rootView.widthAnchor, constant: 0).isActive = true
                    headerView.heightAnchor.constraint(equalToConstant: squareSize36+topMargin4).isActive = true
                    headerView.topAnchor.constraint(equalTo: rootView.topAnchor, constant: 0).isActive = true
                    headerView.leftAnchor.constraint(equalTo: rootView.leftAnchor, constant: 0).isActive = true
                    headerView.layoutIfNeeded()
                    
                    headerView.btnSkrepka.isHidden = true
                    headerView.imgObyaz.isHidden = true
                    
                    let lblText = myLabelForText()
                    let imgView = infoImageView(frame: CGRect(x: 8, y: 8, width: 8, height: 8))
                    let lblUrl = myLabelForText()
                    
                    if info.text != nil
                    {
                        
                        rootView.addSubview(lblText)
                        lblText.text = info.text!
                        
                        lblText.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 0).isActive = true
                        lblText.widthAnchor.constraint(equalTo: rootView.widthAnchor, multiplier: 1, constant: -textViewMargin16).isActive=true
                        lblText.centerXAnchor.constraint(equalTo: rootView.centerXAnchor).isActive = true
                        
                        lblText.layoutIfNeeded()
                        let height = lblText.frame.size.height
                        
                        elementHeight += height
                    }
                    
                    if info.localFileName != nil
                    {
                        print(info.localFileName)
                        let fileName = "\(info.localFileName!).jpg"
                        let fm = FileManager.default
                        let docDir = fm.urls(for: .documentDirectory, in: .userDomainMask).first!
                        let infosPath = docDir.appendingPathComponent("LocalInfos")
                        let imageURL = URL(fileURLWithPath: infosPath.path).appendingPathComponent(fileName)
                        let image    = UIImage(contentsOfFile: imageURL.path)
                        
                        let ori = image?.imageOrientation
                        print("orientation")
                
                        imgView.translatesAutoresizingMaskIntoConstraints = false
                        imgView.image = image
                        rootView.addSubview(imgView)
                        
                        imgView.contentMode = .scaleAspectFit
                        imgView.widthAnchor.constraint(equalToConstant: 320).isActive = true
                        imgView.heightAnchor.constraint(equalToConstant: 320).isActive = true
                        if(info.text != nil)
                        {
                            imgView.topAnchor.constraint(equalTo: lblText.bottomAnchor, constant: 4).isActive = true
                        }
                        else
                        {
                             imgView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 4).isActive = true
                        }
                        imgView.centerXAnchor.constraint(equalTo: rootView.centerXAnchor, constant: 0).isActive = true
                        imgView.layoutIfNeeded()
                        
                        elementHeight += 320 + topMargin4
                    }
                    
                    if info.urlStr != nil
                    {
                        rootView.addSubview(lblUrl)
                        let urlstr = info.urlStr!
                        lblUrl.text = urlstr
                        if urlstr.isValidURL()
                        {
                            lblUrl.isUserInteractionEnabled = true
                            lblUrl.textColor = UIColor.blue
                            lblUrl.tapActon =
                                {
                                    let url = NSURL(string: urlstr)!
                                    if #available(iOS 10.0, *)
                                    {
                                        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
                                    } else
                                    {
                                        UIApplication.shared.openURL(url as URL)
                                    }
                                }
                        }
                        
                        if(info.localFileName != nil)
                        {
                            lblUrl.topAnchor.constraint(equalTo: imgView.bottomAnchor, constant: topMargin4).isActive = true
                        }
                        else if info.text != nil
                        {
                            lblUrl.topAnchor.constraint(equalTo: lblText.bottomAnchor, constant: topMargin4).isActive = true
                        }
                        else
                        {
                            lblUrl.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: topMargin4).isActive = true
                        }
                        lblUrl.widthAnchor.constraint(equalTo: rootView.widthAnchor, multiplier: 1, constant: -textViewMargin16).isActive=true
                        lblUrl.centerXAnchor.constraint(equalTo: rootView.centerXAnchor).isActive = true
                        
                        lblUrl.layoutIfNeeded()
                        let height = lblUrl.frame.size.height
                        
                        elementHeight += height+topMargin4
                    }
                    
                    
                    elementHeight += squareSize36+topMargin4
                    rootView.heightAnchor.constraint(equalToConstant: elementHeight+topMargin4).isActive = true
                    lastAdded = rootView
                    rootView.layoutIfNeeded()
                    //fullScrollHeight += rootView.frame.size.height+topMargin4
                    
                    info.auditView = rootView
                }
                
                if element is Model_Media
                {
                    let media = element as! Model_Media
                    
                    var elementHeight : CGFloat = 0
                    
                    let rootView = myAuditView()
                    categScroll.addSubview(rootView)
                    print("added media")
                    
                    rootView.widthAnchor.constraint(equalTo: categScroll.widthAnchor, multiplier: 1, constant: -sideMargin8).isActive = true
                    rootView.centerXAnchor.constraint(equalTo: categScroll.centerXAnchor).isActive = true
                    rootView.leftAnchor.constraint(equalTo: categScroll.leftAnchor, constant: topMargin4).isActive = true
                    
                    if(lastAdded == nil)
                    {
                        rootView.topAnchor.constraint(equalTo: categScroll.topAnchor, constant: topMargin4).isActive = true
                    }
                    else
                    {
                        rootView.topAnchor.constraint(equalTo: lastAdded.bottomAnchor, constant: topMargin4).isActive = true
                    }
                    
                    let headerView = auditHeaderView(typeInt: gh.typeMedia)
                    rootView.addSubview(headerView)
                    
                    headerView.widthAnchor.constraint(equalTo: rootView.widthAnchor, constant: 0).isActive = true
                    headerView.heightAnchor.constraint(equalToConstant: squareSize36+topMargin4).isActive = true
                    headerView.topAnchor.constraint(equalTo: rootView.topAnchor, constant: 0).isActive = true
                    headerView.leftAnchor.constraint(equalTo: rootView.leftAnchor, constant: 0).isActive = true
                    
                    if(media.obyaz == 0)
                    {
                        headerView.imgObyaz.isHidden = true
                    }
                    else
                    {
                        headerView.imgObyaz.isHidden = false
                    }
                    
                    elementHeight += squareSize36+topMargin4
                    
                    let lblText = myLabelForText()
                    rootView.addSubview(lblText)
                    lblText.text = media.text!
                    
                    lblText.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 0).isActive = true
                    lblText.widthAnchor.constraint(equalTo: rootView.widthAnchor, multiplier: 1, constant: -textViewMargin16).isActive=true
                    lblText.centerXAnchor.constraint(equalTo: rootView.centerXAnchor).isActive = true
                    
                    lblText.layoutIfNeeded()
                    let height = lblText.frame.size.height
                    
                    elementHeight += height
                    
                    let btnGallery = myGalleryButton()
                    rootView.addSubview(btnGallery)
                    
                    btnGallery.bottomAnchor.constraint(equalTo: rootView.bottomAnchor, constant: -topMargin4).isActive = true
                    btnGallery.widthAnchor.constraint(equalTo: rootView.widthAnchor, multiplier: 0.5, constant: -16).isActive = true
                    btnGallery.leftAnchor.constraint(equalTo: rootView.leftAnchor, constant: 12).isActive = true
                    btnGallery.heightAnchor.constraint(equalToConstant: squareSize36).isActive = true
                    
                    
                    
                    btnGallery.click =
                        {
                            self.lastRequestedMedia = media
                            self.lastEditedCateg = categ
                            
                            let imagePicker = UIImagePickerController()
                            imagePicker.delegate = self
                            imagePicker.allowsEditing = false
                            imagePicker.sourceType = .photoLibrary
                            
                            self.present(imagePicker, animated: false, completion: nil)
                        }
                    
                    let btnCamera = myCameraButton()
                    rootView.addSubview(btnCamera)
                    
                    btnCamera.bottomAnchor.constraint(equalTo: rootView.bottomAnchor, constant: -topMargin4).isActive = true
                    btnCamera.widthAnchor.constraint(equalTo: rootView.widthAnchor, multiplier: 0.5, constant: -16).isActive = true
                    btnCamera.rightAnchor.constraint(equalTo: rootView.rightAnchor, constant: -12).isActive = true
                    btnCamera.heightAnchor.constraint(equalToConstant: squareSize36).isActive = true
                    
                    btnCamera.click =
                        {
                            self.lastRequestedMedia = media
                            self.lastEditedCateg = categ
                            
                            let imagePicker = UIImagePickerController()
                            imagePicker.delegate = self
                            imagePicker.allowsEditing = false
                            imagePicker.sourceType = .camera
                            
                            self.present(imagePicker, animated: false, completion: nil)
                        }
                    
                    elementHeight+=squareSize36+textViewTopMargin8
                    
                    rootView.heightAnchor.constraint(equalToConstant: elementHeight+topMargin4).isActive = true
                    lastAdded = rootView
                    rootView.layoutIfNeeded()
                    
                    media.auditView = rootView
                    media.defRootViewHeught = rootView.frame.size.height
                    
                    
                }
            
                if element is Model_Podpis
                {
                    let podpis = element as! Model_Podpis
                    
                    var elementHeight : CGFloat = 0
                    
                    let rootView = myAuditView()
                    categScroll.addSubview(rootView)
                    print("added podpis")
                    
                    rootView.widthAnchor.constraint(equalTo: categScroll.widthAnchor, multiplier: 1, constant: -sideMargin8).isActive = true
                    rootView.centerXAnchor.constraint(equalTo: categScroll.centerXAnchor).isActive = true
                    rootView.leftAnchor.constraint(equalTo: categScroll.leftAnchor, constant: topMargin4).isActive = true
                    
                    if(lastAdded == nil)
                    {
                        rootView.topAnchor.constraint(equalTo: categScroll.topAnchor, constant: topMargin4).isActive = true
                    }
                    else
                    {
                        rootView.topAnchor.constraint(equalTo: lastAdded.bottomAnchor, constant: topMargin4).isActive = true
                    }
                    
                    let headerView = auditHeaderView(typeInt: gh.typePodpis)
                    rootView.addSubview(headerView)
                    
                    headerView.widthAnchor.constraint(equalTo: rootView.widthAnchor, constant: 0).isActive = true
                    headerView.heightAnchor.constraint(equalToConstant: squareSize36+topMargin4).isActive = true
                    headerView.topAnchor.constraint(equalTo: rootView.topAnchor, constant: 0).isActive = true
                    headerView.leftAnchor.constraint(equalTo: rootView.leftAnchor, constant: 0).isActive = true
                    
                    if(podpis.obyaz == 0)
                    {
                        headerView.imgObyaz.isHidden = true
                    }
                    else
                    {
                        headerView.imgObyaz.isHidden = false
                    }
                    
                    elementHeight += squareSize36+topMargin4
                    
                    let lblText = myLabelForText()
                    rootView.addSubview(lblText)
                    lblText.text = podpis.text!
                    
                    lblText.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 0).isActive = true
                    lblText.widthAnchor.constraint(equalTo: rootView.widthAnchor, multiplier: 1, constant: -textViewMargin16).isActive=true
                    lblText.centerXAnchor.constraint(equalTo: rootView.centerXAnchor).isActive = true
                    
                    lblText.layoutIfNeeded()
                    
                    let height = lblText.frame.size.height
                    elementHeight += height
                    
                    let viewForSignature = myAuditView()
                    rootView.addSubview(viewForSignature)
                    viewForSignature.isExclusiveTouch = true
                    
                    viewForSignature.topAnchor.constraint(equalTo: lblText.bottomAnchor, constant: 4).isActive = true
                    viewForSignature.widthAnchor.constraint(equalTo: rootView.widthAnchor, constant: -16).isActive = true
                    viewForSignature.centerXAnchor.constraint(equalTo: rootView.centerXAnchor, constant: 0).isActive = true
                    viewForSignature.heightAnchor.constraint(equalToConstant: 220).isActive = true
                    viewForSignature.layoutIfNeeded()
                    
                    let imgForSign = UIImageView()
                    imgForSign.tag = gh.tagAnyMyImageView
                    imgForSign.translatesAutoresizingMaskIntoConstraints = false
                    imgForSign.isExclusiveTouch = true
                    viewForSignature.addSubview(imgForSign)
                    
                    imgForSign.widthAnchor.constraint(equalTo: viewForSignature.widthAnchor, constant: -4).isActive = true
                    imgForSign.heightAnchor.constraint(equalTo: viewForSignature.heightAnchor, multiplier: 1, constant: -4).isActive = true
                    imgForSign.centerXAnchor.constraint(equalTo: viewForSignature.centerXAnchor).isActive = true
                    imgForSign.centerYAnchor.constraint(equalTo: viewForSignature.centerYAnchor).isActive = true
                    imgForSign.layoutIfNeeded()
                    
                    elementHeight+=220 + textViewTopMargin8
                    
                    let btnMakePodpis = myBtnMakePodpis()
                    
                    rootView.addSubview(btnMakePodpis)
                    btnMakePodpis.widthAnchor.constraint(equalTo: viewForSignature.widthAnchor, multiplier: 1, constant: 0).isActive = true
                    btnMakePodpis.heightAnchor.constraint(equalToConstant: squareSize36).isActive = true
                    btnMakePodpis.topAnchor.constraint(equalTo: viewForSignature.bottomAnchor, constant: 8).isActive = true
                    btnMakePodpis.centerXAnchor.constraint(equalTo: rootView.centerXAnchor, constant: 0).isActive = true
                    btnMakePodpis.layoutIfNeeded()
                    
                    btnMakePodpis.click =
                        {
                            let podpisDialog = myPodpisDialogVC(podpis: podpis)
                            self.present(podpisDialog, animated: true, completion: nil)
                        }
                    
                    elementHeight += squareSize36+topMargin4
                    
                    rootView.heightAnchor.constraint(equalToConstant: elementHeight+topMargin4).isActive = true
                    lastAdded = rootView
                    rootView.layoutIfNeeded()
                    
                    podpis.auditView = rootView
                    
                    headerView.click =
                        {
                            let skrepkaDialog = mySkrepkaDialog(elem: element)
                            self.present(skrepkaDialog, animated: true, completion: nil)
                        }
                }
                
                if element is Model_QuestVar
                {
                    let questVar = element as! Model_QuestVar
                    
                    var elementHeight : CGFloat = 0
                    
                    let rootView = myAuditView()
                    categScroll.addSubview(rootView)
                    print("added questVar")
                    
                    rootView.widthAnchor.constraint(equalTo: categScroll.widthAnchor, multiplier: 1, constant: -sideMargin8).isActive = true
                    rootView.centerXAnchor.constraint(equalTo: categScroll.centerXAnchor).isActive = true
                    rootView.leftAnchor.constraint(equalTo: categScroll.leftAnchor, constant: topMargin4).isActive = true
                    
                    if(lastAdded == nil)
                    {
                        rootView.topAnchor.constraint(equalTo: categScroll.topAnchor, constant: topMargin4).isActive = true
                    }
                    else
                    {
                        rootView.topAnchor.constraint(equalTo: lastAdded.bottomAnchor, constant: topMargin4).isActive = true
                    }
                    
                    let headerView = auditHeaderView(typeInt: gh.typeQuestVar)
                    rootView.addSubview(headerView)
                    
                    headerView.widthAnchor.constraint(equalTo: rootView.widthAnchor, constant: 0).isActive = true
                    headerView.heightAnchor.constraint(equalToConstant: squareSize36+topMargin4).isActive = true
                    headerView.topAnchor.constraint(equalTo: rootView.topAnchor, constant: 0).isActive = true
                    headerView.leftAnchor.constraint(equalTo: rootView.leftAnchor, constant: 0).isActive = true
                    
                    if(questVar.obyaz == 0)
                    {
                        headerView.imgObyaz.isHidden = true
                    }
                    else
                    {
                        headerView.imgObyaz.isHidden = false
                    }
                    
                    elementHeight += squareSize36+topMargin4
                    
                    let viewForLlbl = myAuditView()
                    rootView.addSubview(viewForLlbl)
                    
                    viewForLlbl.widthAnchor.constraint(equalTo: rootView.widthAnchor, multiplier: 1, constant: -16).isActive = true
                    viewForLlbl.topAnchor.constraint(equalTo: headerView.bottomAnchor,constant : 4).isActive = true
                    viewForLlbl.centerXAnchor.constraint(equalTo: rootView.centerXAnchor).isActive = true
                    
                    let lblText = myLabelForText()
                    viewForLlbl.addSubview(lblText)
                    lblText.text = questVar.text!
                    
                    lblText.widthAnchor.constraint(equalTo: viewForLlbl.widthAnchor, multiplier: 1, constant: -topMargin4).isActive=true
                    lblText.centerXAnchor.constraint(equalTo: viewForLlbl.centerXAnchor).isActive = true
                    lblText.centerYAnchor.constraint(equalTo: viewForLlbl.centerYAnchor).isActive = true
                    lblText.layoutIfNeeded()
                    
                    /////////
                    let lblHeight = lblText.frame.size.height
                    viewForLlbl.heightAnchor.constraint(equalToConstant: lblHeight+topMargin4).isActive = true
                    viewForLlbl.layoutIfNeeded()
                    
                    elementHeight += viewForLlbl.frame.size.height+textViewTopMargin8
                    ////////
                    
                    let stackForAnswers = myVerticalStackView()
                    rootView.addSubview(stackForAnswers)
                    
                    stackForAnswers.widthAnchor.constraint(equalTo: rootView.widthAnchor, multiplier: 1, constant: -buttonSideMargin).isActive = true
                    stackForAnswers.centerXAnchor.constraint(equalTo: rootView.centerXAnchor).isActive = true
                    stackForAnswers.topAnchor.constraint(equalTo: viewForLlbl.bottomAnchor, constant: textViewTopMargin8).isActive = true
                    
                    for answer in questVar.answers
                    {
                        let btn = myBtnTogg()
                        stackForAnswers.addArrangedSubview(btn)
                        btn.setTitle(answer, for: .normal)
                        
                        btn.widthAnchor.constraint(equalTo: stackForAnswers.widthAnchor, constant: 0).isActive = true
                        btn.heightAnchor.constraint(equalToConstant: squareSize36).isActive = true
                        btn.centerXAnchor.constraint(equalTo: stackForAnswers.centerXAnchor).isActive = true
                        
                        questVar.auditToggButtons.append(btn)
                    }
                    stackForAnswers.layoutIfNeeded()
                    
                    elementHeight += stackForAnswers.frame.size.height + textViewTopMargin8
                    
                    rootView.heightAnchor.constraint(equalToConstant: elementHeight+topMargin4).isActive = true
                    lastAdded = rootView
                    rootView.layoutIfNeeded()
                    questVar.auditView = rootView
                    
                    headerView.click =
                        {
                            let skrepkaDialog = mySkrepkaDialog(elem: element)
                            self.present(skrepkaDialog, animated: true, completion: nil)
                        }
                    
                }
                
                if element is Model_Seeker
                {
                    let seeker = element as! Model_Seeker
                    
                    var elementHeight : CGFloat = 0
                    
                    let rootView = myAuditView()
                    categScroll.addSubview(rootView)
                    print("added seekerd")
                    
                    rootView.widthAnchor.constraint(equalTo: categScroll.widthAnchor, multiplier: 1, constant: -sideMargin8).isActive = true
                    rootView.centerXAnchor.constraint(equalTo: categScroll.centerXAnchor).isActive = true
                    rootView.leftAnchor.constraint(equalTo: categScroll.leftAnchor, constant: topMargin4).isActive = true
                    
                    if(lastAdded == nil)
                    {
                        rootView.topAnchor.constraint(equalTo: categScroll.topAnchor, constant: topMargin4).isActive = true
                    }
                    else
                    {
                        rootView.topAnchor.constraint(equalTo: lastAdded.bottomAnchor, constant: topMargin4).isActive = true
                    }
                    
                    let headerView = auditHeaderView(typeInt: gh.typeSeeker)
                    rootView.addSubview(headerView)
                    
                    headerView.widthAnchor.constraint(equalTo: rootView.widthAnchor, constant: 0).isActive = true
                    headerView.heightAnchor.constraint(equalToConstant: squareSize36+topMargin4).isActive = true
                    headerView.topAnchor.constraint(equalTo: rootView.topAnchor, constant: 0).isActive = true
                    headerView.leftAnchor.constraint(equalTo: rootView.leftAnchor, constant: 0).isActive = true
                    
                    if(seeker.obyaz == 0)
                    {
                        headerView.imgObyaz.isHidden = true
                    }
                    else
                    {
                        headerView.imgObyaz.isHidden = false
                    }
                    
                    elementHeight += squareSize36+topMargin4
                    
                    let lblText = myLabelForText()
                    rootView.addSubview(lblText)
                    lblText.text = seeker.text!
                    
                    lblText.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 0).isActive = true
                    lblText.widthAnchor.constraint(equalTo: rootView.widthAnchor, multiplier: 1, constant: -textViewMargin16).isActive=true
                    lblText.centerXAnchor.constraint(equalTo: rootView.centerXAnchor).isActive = true
                    lblText.layoutIfNeeded()
                    
                    let height = lblText.frame.size.height
                    elementHeight += height
                    
                    
                    let viewForReslut = myAuditView()
                    rootView.addSubview(viewForReslut)
                    
                    viewForReslut.widthAnchor.constraint(equalToConstant: 68).isActive = true
                    viewForReslut.heightAnchor.constraint(equalToConstant: squareSize36).isActive = true
                    viewForReslut.topAnchor.constraint(equalTo: lblText.bottomAnchor, constant: topMargin4).isActive = true
                    viewForReslut.centerXAnchor.constraint(equalTo: rootView.centerXAnchor).isActive = true
                    viewForReslut.layoutIfNeeded()
                    //////////////
                    let lblResult = myLabelForText()
                    let diff = abs(seeker.min - seeker.max)
                    let midIndex = Int(seeker.min + diff/2)
                    lblResult.text = String(midIndex)
                    viewForReslut.addSubview(lblResult)
                    
                    lblResult.widthAnchor.constraint(equalToConstant: 60).isActive = true
                    lblResult.heightAnchor.constraint(equalToConstant: squareSize36).isActive = true
                    lblResult.centerYAnchor.constraint(equalTo: viewForReslut.centerYAnchor).isActive = true
                    lblResult.centerXAnchor.constraint(equalTo: viewForReslut.centerXAnchor, constant: 0).isActive = true
                    lblResult.layoutIfNeeded()
                    
                    elementHeight += squareSize36
                    //////////
                    
                    let sliderView = mySliderView(seeker: seeker)
                    rootView.addSubview(sliderView)
                    
                    sliderView.widthAnchor.constraint(equalTo: rootView.widthAnchor).isActive = true
                    sliderView.heightAnchor.constraint(equalToConstant: squareSize36).isActive = true
                    sliderView.centerXAnchor.constraint(equalTo: rootView.centerXAnchor).isActive = true
                    sliderView.topAnchor.constraint(equalTo: viewForReslut.bottomAnchor, constant: textViewTopMargin8).isActive = true
                    sliderView.layoutIfNeeded()
                    
                    elementHeight += squareSize36+topMargin4
                    
                    sliderView.valChange =
                        {
                            seeker.lastSettedValue = sliderView.changedValue!
                            lblResult.text = String(sliderView.changedValue!)
                        }
                    
                    
                    rootView.heightAnchor.constraint(equalToConstant: elementHeight+topMargin4).isActive = true
                    lastAdded = rootView
                    rootView.layoutIfNeeded()
                    seeker.auditView = rootView
                    
                    
                    headerView.click =
                        {
                            let skrepkaDialog = mySkrepkaDialog(elem: element)
                            self.present(skrepkaDialog, animated: true, completion: nil)
                        }
                }
                
                if element is Model_TextLarge
                {
                    let textLarge  = element as! Model_TextLarge
                    
                    var elementHeight : CGFloat = 0
                    
                    let rootView = myAuditView()
                    categScroll.addSubview(rootView)
                    print("added text Large")
                    
                    rootView.widthAnchor.constraint(equalTo: categScroll.widthAnchor, multiplier: 1, constant: -sideMargin8).isActive = true
                    rootView.centerXAnchor.constraint(equalTo: categScroll.centerXAnchor).isActive = true
                    rootView.leftAnchor.constraint(equalTo: categScroll.leftAnchor, constant: topMargin4).isActive = true
                    
                    if(lastAdded == nil)
                    {
                        rootView.topAnchor.constraint(equalTo: categScroll.topAnchor, constant: topMargin4).isActive = true
                    }
                    else
                    {
                        rootView.topAnchor.constraint(equalTo: lastAdded.bottomAnchor, constant: topMargin4).isActive = true
                    }
                    
                    let headerView = auditHeaderView(typeInt: gh.typeTextLaerge)
                    rootView.addSubview(headerView)
                    
                    headerView.widthAnchor.constraint(equalTo: rootView.widthAnchor, constant: 0).isActive = true
                    headerView.heightAnchor.constraint(equalToConstant: squareSize36+topMargin4).isActive = true
                    headerView.topAnchor.constraint(equalTo: rootView.topAnchor, constant: 0).isActive = true
                    headerView.leftAnchor.constraint(equalTo: rootView.leftAnchor, constant: 0).isActive = true
                    
                    if(textLarge.obyaz == 0)
                    {
                        headerView.imgObyaz.isHidden = true
                    }
                    else
                    {
                        headerView.imgObyaz.isHidden = false
                    }
                    
                    elementHeight += squareSize36+topMargin4
                    
                    let lblText = myLabelForText()
                    rootView.addSubview(lblText)
                    lblText.text = textLarge.text!
                    
                    lblText.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 0).isActive = true
                    lblText.widthAnchor.constraint(equalTo: rootView.widthAnchor, multiplier: 1, constant: -textViewMargin16).isActive=true
                    lblText.centerXAnchor.constraint(equalTo: rootView.centerXAnchor).isActive = true
                    lblText.layoutIfNeeded()
                    
                    let height = lblText.frame.size.height
                    elementHeight += height
                 
                    let textView = myTextView()
                    rootView.addSubview(textView)
                    
                    textView.widthAnchor.constraint(equalTo: rootView.widthAnchor, multiplier: 1, constant: -textViewTopMargin8).isActive = true
                    textView.heightAnchor.constraint(equalToConstant: 220).isActive = true
                    textView.topAnchor.constraint(equalTo: lblText.bottomAnchor, constant: topMargin4).isActive = true
                    textView.centerXAnchor.constraint(equalTo: rootView.centerXAnchor, constant: 0).isActive = true
                    textView.layoutIfNeeded()
                    
                    textView.delegate = self
                    
                    elementHeight += 228
                    
                    let removeButton = myRemoveButton()
                    rootView.addSubview(removeButton)
                    
                    removeButton.widthAnchor.constraint(equalToConstant: 28).isActive = true
                    removeButton.heightAnchor.constraint(equalToConstant: 28).isActive = true
                    removeButton.rightAnchor.constraint(equalTo: textView.rightAnchor, constant: -2).isActive = true
                    removeButton.bottomAnchor.constraint(equalTo: textView.bottomAnchor, constant: -2).isActive = true
                    removeButton.layoutIfNeeded()
                    
                    removeButton.click =
                        {
                          textView.text = ""
                        }
                    
                    rootView.heightAnchor.constraint(equalToConstant: elementHeight+topMargin4).isActive = true
                    lastAdded = rootView
                    rootView.layoutIfNeeded()
                    textLarge.auditView = rootView
                    
                    textLarge.auditTextView = textView
                    
                    
                    headerView.click =
                        {
                            let skrepkaDialog = mySkrepkaDialog(elem: element)
                            self.present(skrepkaDialog, animated: true, completion: nil)
                        }
                }
                
                if element is Model_TextOneLine
                {
                    let textOneLine = element as! Model_TextOneLine
                    
                    var elementHeight : CGFloat = 0
                    
                    let rootView = myAuditView()
                    categScroll.addSubview(rootView)
                    print("added text One Line")
                    
                    rootView.widthAnchor.constraint(equalTo: categScroll.widthAnchor, multiplier: 1, constant: -sideMargin8).isActive = true
                    rootView.centerXAnchor.constraint(equalTo: categScroll.centerXAnchor).isActive = true
                    rootView.leftAnchor.constraint(equalTo: categScroll.leftAnchor, constant: topMargin4).isActive = true
                    
                    if(lastAdded == nil)
                    {
                        rootView.topAnchor.constraint(equalTo: categScroll.topAnchor, constant: topMargin4).isActive = true
                    }
                    else
                    {
                        rootView.topAnchor.constraint(equalTo: lastAdded.bottomAnchor, constant: topMargin4).isActive = true
                    }
                    
                    let headerView = auditHeaderView(typeInt: gh.typeTextOneLine)
                    rootView.addSubview(headerView)
                    
                    headerView.widthAnchor.constraint(equalTo: rootView.widthAnchor, constant: 0).isActive = true
                    headerView.heightAnchor.constraint(equalToConstant: squareSize36+topMargin4).isActive = true
                    headerView.topAnchor.constraint(equalTo: rootView.topAnchor, constant: 0).isActive = true
                    headerView.leftAnchor.constraint(equalTo: rootView.leftAnchor, constant: 0).isActive = true
                    
                    if(textOneLine.obyaz == 0)
                    {
                        headerView.imgObyaz.isHidden = true
                    }
                    else
                    {
                        headerView.imgObyaz.isHidden = false
                    }
                    
                    elementHeight += squareSize36+topMargin4
                    
                    let lblText = myLabelForText()
                    rootView.addSubview(lblText)
                    lblText.text = textOneLine.text!
                    
                    lblText.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 0).isActive = true
                    lblText.widthAnchor.constraint(equalTo: rootView.widthAnchor, multiplier: 1, constant: -textViewMargin16).isActive=true
                    lblText.centerXAnchor.constraint(equalTo: rootView.centerXAnchor).isActive = true
                    lblText.layoutIfNeeded()
                    
                    let height = lblText.frame.size.height
                    elementHeight += height
                    
                    let textField = myTextFieldOneLine()
                    rootView.addSubview(textField)
                    
                    textField.widthAnchor.constraint(equalTo: rootView.widthAnchor, multiplier: 1, constant: -40).isActive = true
                    textField.heightAnchor.constraint(equalToConstant: squareSize36).isActive = true
                    textField.topAnchor.constraint(equalTo: lblText.bottomAnchor, constant: topMargin4).isActive = true
                    textField.leftAnchor.constraint(equalTo: rootView.leftAnchor, constant: 4).isActive = true
                    textField.layoutIfNeeded()
                    
                    textField.delegate = self
                    
                    elementHeight += 44
                    
                    let removeButton = myRemoveButton()
                    rootView.addSubview(removeButton)
                    
                    removeButton.widthAnchor.constraint(equalToConstant: 28).isActive = true
                    removeButton.heightAnchor.constraint(equalToConstant: 28).isActive = true
                    removeButton.rightAnchor.constraint(equalTo: rootView.rightAnchor, constant: -4).isActive = true
                    removeButton.centerYAnchor.constraintEqualToSystemSpacingBelow(textField.centerYAnchor, multiplier: 1).isActive = true
                    removeButton.layoutIfNeeded()
                    
                    removeButton.click =
                        {
                            textField.text = ""
                    }
                    
                    rootView.heightAnchor.constraint(equalToConstant: elementHeight+topMargin4).isActive = true
                    lastAdded = rootView
                    rootView.layoutIfNeeded()
                    textOneLine.auditView = rootView
                    
                    textOneLine.auditTextField = textField
                    
                    headerView.click =
                        {
                            let skrepkaDialog = mySkrepkaDialog(elem: element)
                            self.present(skrepkaDialog, animated: true, completion: nil)
                        }
                }
                
                if element is Model_Toggle
                {
                    let toggle = element as! Model_Toggle
                    
                    var elementHeight : CGFloat = 0
                    
                    let rootView = myAuditView()
                    categScroll.addSubview(rootView)
                    print("added text One Line")
                    
                    rootView.widthAnchor.constraint(equalTo: categScroll.widthAnchor, multiplier: 1, constant: -sideMargin8).isActive = true
                    rootView.centerXAnchor.constraint(equalTo: categScroll.centerXAnchor).isActive = true
                    rootView.leftAnchor.constraint(equalTo: categScroll.leftAnchor, constant: topMargin4).isActive = true
                    
                    if(lastAdded == nil)
                    {
                        rootView.topAnchor.constraint(equalTo: categScroll.topAnchor, constant: topMargin4).isActive = true
                    }
                    else
                    {
                        rootView.topAnchor.constraint(equalTo: lastAdded.bottomAnchor, constant: topMargin4).isActive = true
                    }
                    
                    let headerView = auditHeaderView(typeInt: gh.typeToggle)
                    rootView.addSubview(headerView)
                    
                    headerView.widthAnchor.constraint(equalTo: rootView.widthAnchor, constant: 0).isActive = true
                    headerView.heightAnchor.constraint(equalToConstant: squareSize36+topMargin4).isActive = true
                    headerView.topAnchor.constraint(equalTo: rootView.topAnchor, constant: 0).isActive = true
                    headerView.leftAnchor.constraint(equalTo: rootView.leftAnchor, constant: 0).isActive = true
                    
                    if(toggle.obyaz == 0)
                    {
                        headerView.imgObyaz.isHidden = true
                    }
                    else
                    {
                        headerView.imgObyaz.isHidden = false
                    }
                    
                    elementHeight += squareSize36+topMargin4
                    
                    
                    let viewForToggle = myAuditView()
                    rootView.addSubview(viewForToggle)
                    
                    viewForToggle.widthAnchor.constraint(equalTo: rootView.widthAnchor, multiplier: 1, constant : -textViewMargin16).isActive = true
                    
                    viewForToggle.centerXAnchor.constraint(equalTo: rootView.centerXAnchor).isActive = true
                    viewForToggle.topAnchor.constraintEqualToSystemSpacingBelow(headerView.bottomAnchor, multiplier: 1).isActive = true
                    viewForToggle.layoutIfNeeded()
                    
                    
                    let lblText = myLabelForText()
                    viewForToggle.addSubview(lblText)
                    lblText.textAlignment = .left
                    lblText.text = toggle.text!
                    
                    lblText.widthAnchor.constraint(equalTo: viewForToggle.widthAnchor, multiplier: 1, constant: -40).isActive=true
                    lblText.leftAnchor.constraint(equalTo: viewForToggle.leftAnchor, constant: 4).isActive = true
                    lblText.centerYAnchor.constraint(equalTo: viewForToggle.centerYAnchor, constant: 0).isActive = true
                    lblText.layoutIfNeeded()
                    
                    let height = lblText.frame.size.height
                    var newHeight : CGFloat = 40
                    if(height > 40)
                    {
                        newHeight = height
                    }
                    
                    viewForToggle.heightAnchor.constraint(greaterThanOrEqualToConstant: newHeight + topMargin4).isActive = true
                    viewForToggle.layoutIfNeeded()
                
                    let myToggSwithc = mySwitch()
                    viewForToggle.addSubview(myToggSwithc)
                    
                    myToggSwithc.widthAnchor.constraint(equalToConstant: 78).isActive = true
                    myToggSwithc.heightAnchor.constraint(equalToConstant: 36).isActive = true
                    myToggSwithc.rightAnchor.constraint(equalTo: viewForToggle.rightAnchor, constant: -sideInnerMargin4).isActive = true
                    myToggSwithc.centerYAnchor.constraint(equalTo: viewForToggle.centerYAnchor, constant: 0).isActive = true
                    myToggSwithc.layoutIfNeeded()
                    
                    
                    myToggSwithc.click =
                        {
                            
                        }
                    
                    
                    elementHeight += viewForToggle.frame.size.height + textViewTopMargin8+topMargin4
                    
                    rootView.heightAnchor.constraint(equalToConstant: elementHeight+topMargin4).isActive = true
                    lastAdded = rootView
                    rootView.layoutIfNeeded()
                    toggle.auditView = rootView
                    
                    toggle.auditToggle = myToggSwithc
                    
                    
                    headerView.click =
                        {
                            let skrepkaDialog = mySkrepkaDialog(elem: element)
                            self.present(skrepkaDialog, animated: true, completion: nil)
                        }
                }
                
                if element is Model_Timer
                {
                    let timer = element as! Model_Timer
                    
                    var elementHeight : CGFloat = 0
                    
                    let rootView = myAuditView()
                    categScroll.addSubview(rootView)
                    print("adding Timer!!!!")
                    
                    rootView.widthAnchor.constraint(equalTo: categScroll.widthAnchor, multiplier: 1, constant: -sideMargin8).isActive = true
                    rootView.centerXAnchor.constraint(equalTo: categScroll.centerXAnchor).isActive = true
                    rootView.leftAnchor.constraint(equalTo: categScroll.leftAnchor, constant: topMargin4).isActive = true
                    
                    if(lastAdded == nil)
                    {
                        rootView.topAnchor.constraint(equalTo: categScroll.topAnchor, constant: topMargin4).isActive = true
                    }
                    else
                    {
                        rootView.topAnchor.constraint(equalTo: lastAdded.bottomAnchor, constant: topMargin4).isActive = true
                    }
                    
                    let headerView = auditHeaderView(typeInt: gh.typeTimer)
                    rootView.addSubview(headerView)
                    
                    headerView.widthAnchor.constraint(equalTo: rootView.widthAnchor, constant: 0).isActive = true
                    headerView.heightAnchor.constraint(equalToConstant: squareSize36+topMargin4).isActive = true
                    headerView.topAnchor.constraint(equalTo: rootView.topAnchor, constant: 0).isActive = true
                    headerView.leftAnchor.constraint(equalTo: rootView.leftAnchor, constant: 0).isActive = true
                    headerView.layoutIfNeeded()
                    
                    
                    if(timer.obyaz == 0)
                    {
                        headerView.imgObyaz.isHidden = true
                    }
                    else
                    {
                        headerView.imgObyaz.isHidden = false
                    }
                    
                    elementHeight += squareSize36+topMargin4
                    
                    
                    let lblText = myLabelForText()
                    rootView.addSubview(lblText)
                    lblText.text = timer.text!
                    
                    lblText.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 0).isActive = true
                    lblText.widthAnchor.constraint(equalTo: rootView.widthAnchor, multiplier: 1, constant: -textViewMargin16).isActive=true
                    lblText.centerXAnchor.constraint(equalTo: rootView.centerXAnchor).isActive = true
                    lblText.layoutIfNeeded()
                    
                    let height = lblText.frame.size.height
                    elementHeight += height
                    
                    
                    let viewForLbl = myAuditView()
                    rootView.addSubview(viewForLbl)
                    
                    viewForLbl.widthAnchor.constraint(equalToConstant: 78).isActive = true
                    viewForLbl.heightAnchor.constraint(equalToConstant: squareSize36).isActive = true
                    viewForLbl.centerXAnchor.constraint(equalTo: rootView.centerXAnchor).isActive = true
                    viewForLbl.topAnchor.constraint(equalTo: lblText.bottomAnchor, constant: 4).isActive = true
                    viewForLbl.layoutIfNeeded()
                    
                    let lblForCount = myLabelForText()
                    lblForCount.text = "00:00"
                    viewForLbl.addSubview(lblForCount)
                    
                    lblForCount.widthAnchor.constraint(equalToConstant: 74).isActive = true
                    lblForCount.heightAnchor.constraint(equalToConstant: squareSize36).isActive = true
                    lblForCount.centerXAnchor.constraint(equalTo: viewForLbl.centerXAnchor).isActive = true
                    lblForCount.centerYAnchor.constraint(equalTo: viewForLbl.centerYAnchor).isActive = true
                    lblForCount.layoutIfNeeded()
                    
                    elementHeight += squareSize36 + topMargin4
                    
                    let viewForBtns = myAuditView()
                    viewForBtns.layer.backgroundColor = UIColor.clear.cgColor
                    viewForBtns.layer.shadowColor = UIColor.clear.cgColor
                    rootView.addSubview(viewForBtns)
                    
                    viewForBtns.widthAnchor.constraint(equalToConstant: 280).isActive = true
                    viewForBtns.heightAnchor.constraint(equalToConstant: 46).isActive = true
                    viewForBtns.centerXAnchor.constraint(equalTo: rootView.centerXAnchor).isActive = true
                    viewForBtns.topAnchor.constraint(equalTo: viewForLbl.bottomAnchor, constant: textViewTopMargin8).isActive = true
                    viewForBtns.layoutIfNeeded()
                    
                    let timerStop = myTimerButton(image : UIImage(named: "ic_stop_bej")!)
                    viewForBtns.addSubview(timerStop)
                    
                    timerStop.widthAnchor.constraint(equalToConstant: 88).isActive = true
                    timerStop.heightAnchor.constraint(equalToConstant: 40).isActive = true
                    timerStop.centerYAnchor.constraint(equalTo: viewForBtns.centerYAnchor).isActive = true
                    timerStop.leftAnchor.constraint(equalTo: viewForBtns.leftAnchor, constant: 0).isActive = true
                    timerStop.layoutIfNeeded()
                    
                    
                    let timerPlay = myTimerButton(image: UIImage(named: "ic_play_bej")!)
                    viewForBtns.addSubview(timerPlay)
                    
                    timerPlay.widthAnchor.constraint(equalToConstant: 88).isActive = true
                    timerPlay.heightAnchor.constraint(equalToConstant: 40).isActive = true
                    timerPlay.centerYAnchor.constraint(equalTo: viewForBtns.centerYAnchor).isActive = true
                    timerPlay.centerXAnchor.constraint(equalTo: viewForBtns.centerXAnchor).isActive = true
                    timerPlay.layoutIfNeeded()
                    
                    
                    let timerPause = myTimerButton(image : UIImage(named: "ic_pause_bej")!)
                    viewForBtns.addSubview(timerPause)
                    
                    timerPause.widthAnchor.constraint(equalToConstant: 88).isActive = true
                    timerPause.heightAnchor.constraint(equalToConstant: 40).isActive = true
                    timerPause.centerYAnchor.constraint(equalTo: viewForBtns.centerYAnchor).isActive = true
                    timerPause.rightAnchor.constraint(equalTo: viewForBtns.rightAnchor, constant: 0).isActive = true
                    timerPause.layoutIfNeeded()
                    
                    
                    elementHeight += 46 + textViewTopMargin8
                    
                    rootView.heightAnchor.constraint(equalToConstant: elementHeight+topMargin4).isActive = true
                    lastAdded = rootView
                    rootView.layoutIfNeeded()
                    timer.auditView = rootView
                
                    
                    var seconds : Int = 0
                    var minutes : Int = 0
                    
                    timerPlay.click =
                        {
                            
                            timerPlay.timerVoid =
                                {
                                    seconds += 1
                                
                                    minutes = Int(seconds / 60)
                                    
                                    var secStr : String
                                    if (seconds % 60) < 10
                                    {
                                        secStr = "0\(seconds % 60)"
                                    }
                                    else
                                    {
                                        secStr = String(seconds % 60)
                                    }
                                    
                                    let finalStr = "0\(minutes):\(secStr)"
                                    
                                    lblForCount.text = finalStr
                                    
                                    timer.timerSeconds = seconds
                                }
                        }
                    
                    timerPause.click =
                        {
                            timerPlay.timerVoid = nil
                        }
                    
                    timerStop.click =
                        {
                            timerPlay.timerVoid = nil
                            seconds = 0
                            minutes = 0
                            lblForCount.text = "00:00"
                            
                            timer.timerSeconds = 0
                        }
                    
                    
                    headerView.click =
                        {
                            let skrepkaDialog = mySkrepkaDialog(elem: element)
                            self.present(skrepkaDialog, animated: true, completion: nil)
                        }
                }
                
                
                
            
            
            }
            print("now will Be firs recount!!!")
            recountScrollSize(scrollV: categScroll,categ: categ)
            listOfVC.append(categView)
            
        }
        
    }
    
    @objc func dateButtonClicked(modDate : Model_Date , lblForDate : myLabelForText)
    {
        let dateDialog = myDateDialog()
        view.addSubview(dateDialog)
        
        dateDialog.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        dateDialog.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1).isActive = true
        dateDialog.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dateDialog.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        //let lastViewForImage = lastViewToAddMedia!
//        let lastRootView = lastViewForImage.superview!
//        let lastCategScroll = lastRootView.superview! as! UIScrollView
        
        let lastModelMedia = lastRequestedMedia!
        let lastMediaRootView = lastModelMedia.auditView!
        let header = lastMediaRootView.viewWithTag(gh.tagHeader)!
        let btnCamera = lastMediaRootView.viewWithTag(gh.tagBtnCamera)!
        let defRootHeight = lastModelMedia.defRootViewHeught!
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            let myInfoImgV = infoImageView(frame: CGRect(x: 8, y: 8, width: 8, height: 8))
            myInfoImgV.image = image
            myInfoImgV.contentMode = .scaleAspectFit
            
            
            var hasImageAlready = false
            for v in lastMediaRootView.subviews
            {
                if v.tag == gh.tagInfoImge
                {
                    hasImageAlready = true
                    break
                }
            }
            
            if hasImageAlready == false
            {
                lastMediaRootView.addSubview(myInfoImgV)
                
                myInfoImgV.widthAnchor.constraint(equalTo: lastMediaRootView.widthAnchor, multiplier: 1, constant: -48).isActive = true
                myInfoImgV.heightAnchor.constraint(equalToConstant: 320).isActive = true
                myInfoImgV.bottomAnchor.constraint(equalTo: btnCamera.topAnchor, constant: -8).isActive = true
                myInfoImgV.centerXAnchor.constraint(equalTo: lastMediaRootView.centerXAnchor).isActive = true
                myInfoImgV.layoutIfNeeded()
                
                let cons = lastMediaRootView.constraints.filter
                {
                    $0.firstAttribute == NSLayoutAttribute.height
                }
                NSLayoutConstraint.deactivate(cons)
                lastMediaRootView.heightAnchor.constraint(equalToConstant: defRootHeight + 320+4).isActive = true
            }
            else if hasImageAlready == true
            {
                lastMediaRootView.viewWithTag(gh.tagInfoImge)?.removeFromSuperview()
                lastMediaRootView.viewWithTag(gh.tagBtnRemove)?.removeFromSuperview()
                
                lastMediaRootView.addSubview(myInfoImgV)
                myInfoImgV.widthAnchor.constraint(equalTo: lastMediaRootView.widthAnchor, multiplier: 1, constant: -48).isActive = true
                myInfoImgV.heightAnchor.constraint(equalToConstant: 320).isActive = true
                myInfoImgV.bottomAnchor.constraint(equalTo: btnCamera.topAnchor, constant: -8).isActive = true
                myInfoImgV.centerXAnchor.constraint(equalTo: lastMediaRootView.centerXAnchor).isActive = true
                myInfoImgV.layoutIfNeeded()
            }
            
            
            let imageRect = imageCGRect(for: image, inImageViewAspectFit: myInfoImgV)
            let height = imageRect.size.height
            let width = imageRect.size.width
            
            let removeButton = myRemoveButton()
            lastMediaRootView.addSubview(removeButton)
            
            removeButton.widthAnchor.constraint(equalToConstant: 28).isActive = true
            removeButton.heightAnchor.constraint(equalToConstant: 28).isActive = true
            removeButton.centerXAnchor.constraint(equalTo: myInfoImgV.centerXAnchor, constant: width/2).isActive = true
            removeButton.centerYAnchor.constraint(equalTo: myInfoImgV.centerYAnchor, constant: -height/2).isActive = true
            removeButton.layoutIfNeeded()
            
            removeButton.click =
                {
                    lastMediaRootView.viewWithTag(self.gh.tagInfoImge)?.removeFromSuperview()
                    lastMediaRootView.viewWithTag(self.gh.tagBtnRemove)?.removeFromSuperview()
                    
                    let cons = lastMediaRootView.constraints.filter
                    {
                        $0.firstAttribute == NSLayoutAttribute.height
                    }
                    NSLayoutConstraint.deactivate(cons)
                    print("setting New Height")
                    lastMediaRootView.heightAnchor.constraint(equalToConstant: defRootHeight).isActive = true
                    lastMediaRootView.layoutIfNeeded()
                    
                    lastModelMedia.lastAddedImage = nil
                    self.recountScrollSize(scrollV: lastMediaRootView.superview as! UIScrollView, categ: self.lastEditedCateg)
                }
            
            
            lastModelMedia.addedPhoto = image
            
        }
        recountScrollSize(scrollV: lastMediaRootView.superview as! UIScrollView, categ: lastEditedCateg)
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imageCGRect(for image: UIImage, inImageViewAspectFit imageView: UIImageView) -> CGRect
    {
        let imageRatio = (image.size.width / image.size.height)
        let viewRatio = imageView.frame.size.width / imageView.frame.size.height
        if imageRatio < viewRatio {
            let scale = imageView.frame.size.height / image.size.height
            let width = scale * image.size.width
            let topLeftX = (imageView.frame.size.width - width) * 0.5
            return CGRect(x: topLeftX, y: 0, width: width, height: imageView.frame.size.height)
        } else {
            let scale = imageView.frame.size.width / image.size.width
            let height = scale * image.size.height
            let topLeftY = (imageView.frame.size.height - height) * 0.5
            return CGRect(x: 0.0, y: topLeftY, width: imageView.frame.size.width, height: height)
        }
    }
    
    
    
    func recountScrollSize(scrollV : UIScrollView, categ : Model_Categ)
    {
        var height : CGFloat = 0
        print(categ.allElementsSorted.count)
        
        for element in categ.allElementsSorted
        {
            if element.auditView != nil
            {
                element.auditView.layoutIfNeeded()
                print("open element")
                height += element.auditView!.frame.size.height+4
            }

        }

        
        scrollV.contentSize.height = height+4
    }
    
    func didStart()
    {
        for scroll in listOfScrolls
        {
            
        }
    }

    func didFinish()
    {
        for scroll in listOfScrolls
        {
            
        }
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -200 // Move view 150 points upward
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0 // Move view to original position
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
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
    
}
