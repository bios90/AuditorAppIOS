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
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        GlobalHelper.sharedInstance.setFont(viewArray: [btnDownload,btnSkachannie,btnFinished,btnExit], size: 18)
        GlobalHelper.sharedInstance.setTextColor(viewArray: [btnDownload,btnSkachannie,btnFinished,btnExit], col: GlobalHelper.sharedInstance.myBejColor)
        
        GlobalHelper.sharedInstance.makeLittleCorners(viewArray: [btnDownloadView,btnSkacannieView,btnFinishedView], radius: 10)
        
        GlobalHelper.sharedInstance.addShadow(viewArray: [btnDownloadView,btnSkacannieView,btnFinishedView,btnExitView])

   
    }

    @IBAction func actDownloadPressed(_ sender: Any)
    {
        self.performSegue(withIdentifier: GlobalHelper.sharedInstance.segueToDownloadAudits, sender: self)
    }
    @IBAction func actSkachanniePressed(_ sender: Any)
    {
        self.performSegue(withIdentifier: GlobalHelper.sharedInstance.segueToSkachannie, sender: self)
    }
    @IBAction func actFinishedPressed(_ sender: Any)
    {
        
    }
    @IBAction func actExitPressed(_ sender: Any)
    {
        self.performSegue(withIdentifier: GlobalHelper.sharedInstance.segueToFirstScreen, sender: self)
    }
}






















