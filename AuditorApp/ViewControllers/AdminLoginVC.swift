import UIKit

class AdminLoginVC: UIViewController
{
    let gh = GlobalHelper.sharedInstance
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        let statusView = UIView()
        statusView.translatesAutoresizingMaskIntoConstraints = false
        statusView.backgroundColor = gh.myRed
        self.view.addSubview(statusView)
        
        statusView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        statusView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        statusView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        statusView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        statusView.layoutIfNeeded()
        
        let bgImgV = UIImageView()
        bgImgV.translatesAutoresizingMaskIntoConstraints = false
        bgImgV.image = UIImage(named: "backgroundBG")
        view.addSubview(bgImgV)
        
        bgImgV.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        bgImgV.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        bgImgV.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bgImgV.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        bgImgV.layoutIfNeeded()
        
        
        let lbl = UILabel()
        gh.setFont(viewArray: [lbl], size: 19)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Введите пароль администратора"
        lbl.textAlignment = .center
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = UIColor.white
        view.addSubview(lbl)
        
        
        lbl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -28).isActive = true
        lbl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 28).isActive = true
        lbl.heightAnchor.constraint(equalToConstant: 56).isActive = true
        lbl.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        lbl.layoutIfNeeded()
        
        gh.addShadow(viewArray: [lbl])
        
    
        
        let tf = UITextField()
        tf.backgroundColor = UIColor.white
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Введите пароль"
        tf.textAlignment = .center
        tf.isEnabled = false
        view.addSubview(tf)
        
        tf.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -28).isActive = true
        tf.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 28).isActive = true
        tf.heightAnchor.constraint(equalToConstant: 56).isActive = true
        tf.topAnchor.constraint(equalTo: lbl.bottomAnchor, constant: 16).isActive = true
        tf.layoutIfNeeded()
        
        
        gh.makeLittleCorners(viewArray: [tf], radius: 8)
        gh.addShadow(viewArray: [tf])
        
        
        let enterBtn = enterBtnView()
        view.addSubview(enterBtn)
        
        enterBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -28).isActive = true
        enterBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 28).isActive = true
        enterBtn.heightAnchor.constraint(equalToConstant: 56).isActive = true
        enterBtn.topAnchor.constraint(equalTo: tf.bottomAnchor, constant: 16).isActive = true
        enterBtn.layoutIfNeeded()
        
        gh.makeRound(viewArray: [enterBtn])
        gh.addShadow(viewArray: [enterBtn])
        
        
        let backBtn = backButton()
        view.addSubview(backBtn)
        
        backBtn.widthAnchor.constraint(equalToConstant: 196).isActive = true
        backBtn.heightAnchor.constraint(equalToConstant: 56).isActive = true
        backBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        backBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8).isActive = true
        backBtn.layoutIfNeeded()
        
        gh.addShadow(viewArray: [backBtn])
        
        backBtn.click =
            {
                self.dismiss(animated: true, completion: nil)
            }
    }

}

class backButton : UIView
{
    let gh = GlobalHelper.sharedInstance
    var lbl : UILabel!
    
    var click : (()->Void)?
    
    func customInit()
    {
        tag = gh.tagViewAsLabel
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        
        lbl = myLabelForText()
        lbl.text = "Назад"
        lbl.textColor = UIColor.white
        self.addSubview(lbl)
        
        lbl.widthAnchor.constraint(equalTo: self.widthAnchor, constant: 0).isActive = true
        lbl.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1, constant: 0).isActive = true
        lbl.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        lbl.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        lbl.layoutIfNeeded()
        
        
        let arrowImg = UIImageView()
        arrowImg.translatesAutoresizingMaskIntoConstraints = false
        arrowImg.image = UIImage(named: "ic_leftArrow")
        self.addSubview(arrowImg)
        
        arrowImg.widthAnchor.constraint(equalToConstant: 38).isActive = true
        arrowImg.heightAnchor.constraint(equalToConstant: 38).isActive = true
        arrowImg.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        arrowImg.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        arrowImg.layoutIfNeeded()
        
        let gr = UITapGestureRecognizer(target: self, action: #selector(recognize))
        self.addGestureRecognizer(gr)
    }
    
    
    @objc func recognize()
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

class enterBtnView : UIView
{
    let gh = GlobalHelper.sharedInstance
    var lbl : UILabel!
    
    var click : (()->Void)?
    
    func customInit()
    {
        tag = gh.tagViewAsLabel
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = gh.myRed
        
        lbl = myLabelForText()
        lbl.text = "Войти"
        lbl.textColor = UIColor.white
        self.addSubview(lbl)
        
        lbl.widthAnchor.constraint(equalTo: self.widthAnchor, constant: 0).isActive = true
        lbl.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1, constant: 0).isActive = true
        lbl.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        lbl.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        lbl.layoutIfNeeded()
        
        
        let arrowImg = UIImageView()
        arrowImg.translatesAutoresizingMaskIntoConstraints = false
        arrowImg.image = UIImage(named: "ic_rightArrow")
        self.addSubview(arrowImg)
        
        arrowImg.widthAnchor.constraint(equalToConstant: 38).isActive = true
        arrowImg.heightAnchor.constraint(equalToConstant: 38).isActive = true
        arrowImg.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        arrowImg.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        arrowImg.layoutIfNeeded()
        
        let gr = UITapGestureRecognizer(target: self, action: #selector(recognize))
        self.addGestureRecognizer(gr)
    }
    
    
    @objc func recognize()
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





















