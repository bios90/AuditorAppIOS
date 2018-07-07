
import UIKit

class SkrepkaCommentDialog: UIViewController , UITextViewDelegate
{

    var currentQuestion : Model_Question!
    let gh  = GlobalHelper.sharedInstance
    let gc = GlobalClass.sharedInstance
    let placeHolder = "Введите текст заметки"
    var previousString : String!
    var okButton : redButton!
    
    var text : String!
    
    func customInit()
    {
        self.modalPresentationStyle = .overCurrentContext

    
        previousString = currentQuestion.commentStr
        
        let commentV = currentQuestion.commentView!
        let rootView = currentQuestion.auditView!
        let rootHeight = rootView.frame.size.height
        let commentHeight = commentV.frame.size.height
        
        print(rootHeight," root height at the begin")
        print(commentHeight, " comment height after begin")
        
        for child in commentV.subviews
        {
            child.removeFromSuperview()
        }
        
        let commentHeightCons = commentV.constraints.filter
        {
            $0.firstAttribute == NSLayoutAttribute.height
        }
        NSLayoutConstraint.deactivate(commentHeightCons)
        
        commentV.heightAnchor.constraint(equalToConstant: 0).isActive = true
        commentV.layoutIfNeeded()
        
        let rootCons = rootView.constraints.filter
        {
            $0.firstAttribute == NSLayoutAttribute.height
        }
        NSLayoutConstraint.deactivate(rootCons)
        
        rootView.heightAnchor.constraint(equalToConstant: rootHeight - commentHeight ).isActive = true
        rootView.layoutIfNeeded()
        
        print(rootView.frame.size.height ," rooot height after deleting")
        print(commentV.frame.size.height , " frame size after deleting")
        
        view.backgroundColor = UIColor.clear
        
        let darkView = UIView()
        darkView.backgroundColor = UIColor.black
        darkView.alpha = 0.6
        darkView.frame = view.bounds
        darkView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        view.addSubview(darkView)
        
        let dialogView = myAuditView()
        view.insertSubview(dialogView, at: 1)
        
        dialogView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dialogView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        dialogView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9, constant: 0).isActive = true
        dialogView.heightAnchor.constraint(equalToConstant: 248).isActive = true
        dialogView.layoutIfNeeded()
        
        let header = UILabel()
        header.translatesAutoresizingMaskIntoConstraints = false
        header.backgroundColor = gh.myRed
        header.clipsToBounds = true
        header.layer.cornerRadius = 6
        header.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        header.text = "Добавить заметку"
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
        
        let commentTextView = myTextView()
        commentTextView.clipsToBounds = true
        viewForToDo.addSubview(commentTextView)
        commentTextView.delegate = self
        commentTextView.text = placeHolder
        commentTextView.textColor = gh.myRedTrans
        
        
        commentTextView.widthAnchor.constraint(equalTo: viewForToDo.widthAnchor, multiplier: 1).isActive = true
        commentTextView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        commentTextView.centerXAnchor.constraint(equalTo: viewForToDo.centerXAnchor, constant: 0).isActive = true
        commentTextView.topAnchor.constraint(equalTo: viewForToDo.topAnchor , constant: 0).isActive = true
        commentTextView.layoutIfNeeded()
        
        
        okButton = redButton()
        dialogView.addSubview(okButton)
        okButton.setTitle("Сохранить", for: .normal)
        
        okButton.widthAnchor.constraint(equalTo: dialogView.widthAnchor, multiplier: 0.5, constant: -9).isActive = true
        okButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        okButton.topAnchor.constraint(equalTo: viewForToDo.bottomAnchor, constant: 6).isActive = true
        okButton.rightAnchor.constraint(equalTo: dialogView.rightAnchor, constant: -6).isActive = true
        okButton.layoutIfNeeded()
        
        let cancelButton = transButton()
        dialogView.addSubview(cancelButton)
        cancelButton.setTitle("Отмена", for: .normal)
        
        cancelButton.widthAnchor.constraint(equalTo: dialogView.widthAnchor, multiplier: 0.5, constant: -9).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        cancelButton.topAnchor.constraint(equalTo: viewForToDo.bottomAnchor, constant: 6).isActive = true
        cancelButton.leftAnchor.constraint(equalTo: dialogView.leftAnchor, constant: 6).isActive = true
        cancelButton.layoutIfNeeded()
        
        okButton.click =
            {
                let currentRootHeight = rootView.frame.size.height
                print(currentRootHeight, " root height ok just pressed")
                print(commentV.frame.size.height , " comment height ok just pressed")
                
                self.text = commentTextView.text
                
                if self.text == self.placeHolder || self.text == ""
                {
                    self.gc.shablonInWork.recountScrollSize()
                    self.currentQuestion.commentStr = nil
                    self.dismiss(animated: true, completion: nil)
                    return
                }
                
                if self.text != nil
                {
                    let lbl = myLabelForText()
                    lbl.textAlignment = .left
                    lbl.text = self.text
                    lbl.font = UIFont.systemFont(ofSize: 16)
                    commentV.addSubview(lbl)
                    
                    lbl.widthAnchor.constraint(equalTo: commentV.widthAnchor, multiplier: 1, constant: -6).isActive = true
                    lbl.centerXAnchor.constraint(equalTo: commentV.centerXAnchor).isActive = true
                    lbl.centerYAnchor.constraint(equalTo: commentV.centerYAnchor).isActive = true
                    lbl.layoutIfNeeded()
                    
                    let lblHeight = lbl.frame.size.height
                    
                    let commentHeightCons = commentV.constraints.filter
                    {
                        $0.firstAttribute == NSLayoutAttribute.height
                    }
                    NSLayoutConstraint.deactivate(commentHeightCons)
                    
                    commentV.heightAnchor.constraint(equalToConstant: lblHeight + 8).isActive = true
                    commentV.layoutIfNeeded()
                
                    let rootCons = rootView.constraints.filter
                    {
                        $0.firstAttribute == NSLayoutAttribute.height
                    }
                    NSLayoutConstraint.deactivate(rootCons)
                    
                    rootView.heightAnchor.constraint(equalToConstant: currentRootHeight + commentV.frame.size.height).isActive = true
                    rootView.layoutIfNeeded()
                    
                    print(rootView.frame.size.height, " root final resize")
                    print(commentV.frame.size.height , " comment final resize")
                    
                    self.currentQuestion.commentStr = self.text
                    
                    self.gc.shablonInWork.recountScrollSize()
                    self.dismiss(animated: true, completion: nil)
                }
                
                if self.text == nil
                {
                    self.gc.shablonInWork.recountScrollSize()
                    self.currentQuestion.commentStr = nil
                    self.dismiss(animated: true, completion: nil)
                    return
                }
                
            }
        
        cancelButton.click =
            {
                if self.previousString != nil
                {
                    self.gc.shablonInWork.recountScrollSize()
                    commentTextView.text = self.previousString
                    self.okButton.click?()
                }
                else
                {
                    
                     self.dismiss(animated: true, completion: nil)
                }
            }
        
        if currentQuestion.commentStr != nil
        {
            commentTextView.text = currentQuestion.commentStr!
            commentTextView.textColor = gh.myRed
        }
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    {
        if(text == "\n")
        {
            self.view.endEditing(true)
            textView.resignFirstResponder()
            self.okButton.click?()
            return true
        }
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        if (textView.text == placeHolder)
        {
            textView.text = ""
            textView.textColor = gh.myRed
        }
        textView.becomeFirstResponder()
    }
    
    func textViewDidEndEditing(_ textView: UITextView)
    {
        if (textView.text == "")
        {
            textView.text = placeHolder
            textView.textColor = gh.myRedTrans
        }
        textView.resignFirstResponder()
    }
    
    
    init(quest : Model_Question)
    {
        super.init(nibName: nil, bundle: nil)
        currentQuestion = quest
        customInit()
    }
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        customInit()
    }


}
