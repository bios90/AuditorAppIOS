import UIKit

class UserMenu: UIViewController
{

    @IBOutlet weak var btnDownloadView: UIView!
    @IBOutlet weak var btnSkacannieView: UIView!
    @IBOutlet weak var btnFinishedView: UIView!
    @IBOutlet weak var btnExitView: UIView!
    
    @IBOutlet weak var btnDownload: UIButton!
    @IBOutlet weak var btnSkachannie: UIButton!
    @IBOutlet weak var btnFinished: UIButton!
    @IBOutlet weak var btnExit: UIButton!
    
    @IBOutlet weak var imgInfo: UIImageView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
       

        btnDownload.titleLabel?.adjustsFontSizeToFitWidth = true
        btnSkachannie.titleLabel?.adjustsFontSizeToFitWidth = true
        btnFinished.titleLabel?.adjustsFontSizeToFitWidth = true
        
        let downloadGesture = UITapGestureRecognizer(target: self, action: #selector(self.downloadPressed(sender:)))
        let skachannieGesture = UITapGestureRecognizer(target: self, action: #selector(self.skachanniePressed(sender:)))
        let finihedGesture = UITapGestureRecognizer(target: self, action: #selector(self.finishedPressed(sender:)))
        let infoGesture = UITapGestureRecognizer(target: self, action: #selector(self.infoPressed))
        
        
        btnDownloadView.addGestureRecognizer(downloadGesture)
        btnSkacannieView.addGestureRecognizer(skachannieGesture)
        btnFinishedView.addGestureRecognizer(finihedGesture)
        
        let infoButton = myInfoButton()
        infoButton.layer.cornerRadius = 10
        infoButton.backgroundColor = btnDownloadView.backgroundColor
        infoButton.imgV.layer.backgroundColor = UIColor.clear.cgColor
        self.view.addSubview(infoButton)
        
        infoButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -28).isActive = true
        infoButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 28).isActive = true
        //infoButton.widthAnchor.constraint(equalToConstant: 320).isActive = true
        infoButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
        infoButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        infoButton.topAnchor.constraint(equalTo: btnFinished.bottomAnchor, constant: 16).isActive = true
        infoButton.layoutIfNeeded()
        infoButton.lblTitle.sizeToFit()
        
        let titleCons = infoButton.lblTitle.constraints
        NSLayoutConstraint.deactivate(titleCons)
        infoButton.lblTitle.widthAnchor.constraint(equalTo: infoButton.widthAnchor, multiplier: 1, constant: -86).isActive = true
        infoButton.lblTitle.heightAnchor.constraint(equalToConstant: 56).isActive = true
        infoButton.lblTitle.centerXAnchor.constraint(equalTo: infoButton.centerXAnchor, constant: 0 ).isActive = true
        infoButton.lblTitle.centerYAnchor.constraint(equalTo: infoButton.centerYAnchor).isActive = true
        infoButton.layoutIfNeeded()
        infoButton.lblTitle.numberOfLines = 1
        infoButton.lblTitle.adjustsFontSizeToFitWidth = true
        
        let imgCons = infoButton.imgV.constraints
        NSLayoutConstraint.deactivate(imgCons)
        infoButton.imgV.widthAnchor.constraint(equalToConstant: 38).isActive = true
        infoButton.imgV.heightAnchor.constraint(equalToConstant: 38).isActive = true
        infoButton.imgV.rightAnchor.constraint(equalTo: infoButton.rightAnchor, constant: -8).isActive = true
        infoButton.imgV.centerYAnchor.constraint(equalTo: infoButton.centerYAnchor).isActive = true
        infoButton.layoutIfNeeded()
        
        infoButton.addGestureRecognizer(infoGesture)
        
        GlobalHelper.sharedInstance.setFont(viewArray: [btnDownload,btnSkachannie,btnFinished,btnExit,infoButton.lblTitle], size: 18)
        GlobalHelper.sharedInstance.setTextColor(viewArray: [btnDownload,btnSkachannie,btnFinished,btnExit,infoButton.lblTitle], col: GlobalHelper.sharedInstance.myBejColor)
        
        GlobalHelper.sharedInstance.makeLittleCorners(viewArray: [btnDownloadView,btnSkacannieView,btnFinishedView], radius: 10)
        
        GlobalHelper.sharedInstance.addShadow(viewArray: [btnDownloadView,btnSkacannieView,btnFinishedView,btnExitView,infoButton])
        
        
        
        let statusView = UIView()
        statusView.translatesAutoresizingMaskIntoConstraints = false
        statusView.backgroundColor = gh.myRed
        self.view.addSubview(statusView)
        
        statusView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        statusView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        statusView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        statusView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        statusView.layoutIfNeeded()
        
        //imgInfo.layer.cornerRadius = 19
//        imgInfo.backgroundColor = gh.myRed
//
//        gh.addShadow(viewArray: [imgInfo])
    }

    
    @objc func infoPressed()
    {
        self.present(howToWorkVC(), animated:  true, completion: nil)
    }
    
    
    @objc func downloadPressed(sender : UITapGestureRecognizer)
    {
        //self.performSegue(withIdentifier: GlobalHelper.sharedInstance.segueToDownloadAudits, sender: self)
        self.present(DownloadVC(), animated:  true, completion: nil)
    }
    
    @objc func skachanniePressed(sender : UITapGestureRecognizer)
    {
        self.performSegue(withIdentifier: GlobalHelper.sharedInstance.segueToSkachannie, sender: self)
    }
    
    @objc func finishedPressed(sender : UITapGestureRecognizer)
    {
        self.present(FinishedVC(), animated: true, completion: nil)
    }
    
    
    
    @IBAction func actDownloadPressed(_ sender: Any)
    {
        //self.performSegue(withIdentifier: GlobalHelper.sharedInstance.segueToDownloadAudits, sender: self)
        self.present(DownloadVC(), animated:  true, completion: nil)
    }
    @IBAction func actSkachanniePressed(_ sender: Any)
    {
         self.performSegue(withIdentifier: GlobalHelper.sharedInstance.segueToSkachannie, sender: self)
    }
    @IBAction func actFinishedPressed(_ sender: Any)
    {
        self.present(FinishedVC(), animated: true, completion: nil)
    }
    
    
    
    @IBAction func actExitPressed(_ sender: Any)
    {
        self.performSegue(withIdentifier: GlobalHelper.sharedInstance.segueToFirstScreen, sender: self)
    }
}






















