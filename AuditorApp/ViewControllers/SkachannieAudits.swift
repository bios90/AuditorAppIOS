import UIKit

class SkachannieAudits: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var lblTitle: UILabel!
    
    var listOfSkachannihShablonov : [Model_Shablon] = []
    var mySql : MySqlite!
    var lastAddedView : UIView?
    
    //var gh : GlobalHelper!
    let gh = GlobalHelper.sharedInstance
    let gc = GlobalClass.sharedInstance
    //___________________var last????//////
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //gh = GlobalHelper.sharedInstance
        
        gh.setFont(viewArray: [lblTitle], size: GlobalHelper.sharedInstance.sizeTitle)
        
        mySql = MySqlite()
        listOfSkachannihShablonov = mySql.getAllSkachannie()
        print(listOfSkachannihShablonov.count)
    
        displayShablonCell()
    }
    
    func displayShablonCell()
    {
        for shablon in listOfSkachannihShablonov
        {
            print("Tryi 11")
            let cellClass = SkachannieCell()
            let newView = cellClass.instanceFromNib()
            addSubviewWithPosition(nibView: newView, shablon: shablon)
        }
    }

   
    func addSubviewWithPosition(nibView : SkachannieCell, shablon : Model_Shablon)
    {

        scrollView.addSubview(nibView)

        nibView.translatesAutoresizingMaskIntoConstraints = false
        if lastAddedView != nil
        {
            nibView.topAnchor.constraint(equalTo: (lastAddedView?.bottomAnchor)!).isActive = true
        }
        else
        {
            nibView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        }
        nibView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        nibView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        nibView.heightAnchor.constraint(equalToConstant: 148).isActive = true
        
        gh.addShadow(viewArray: [nibView.cellRootView,nibView.imgLogo])
        gh.makeLittleCorners(viewArray: [nibView.cellRootView,nibView.rootImageView,nibView.rootButtonsView,nibView.imgLogo], radius: 6)
        gh.setFont(viewArray: [nibView.lblTitle], size: gh.sizeTitle)
        gh.setFont(viewArray: [nibView.lblAuthor,nibView.lblPlace], size: gh.sizeMiddleMinus1)
        
        nibView.lblTitle.text = shablon.name
        nibView.lblPlace.text = "Место : \(shablon.place!)"
        nibView.lblAuthor.text = "Автор : \(shablon.author!)"
        
        if shablon.localImageName != nil
        {
            do
            {
                let fileName = "\(shablon.localImageName!).jpg"
                let fm = FileManager.default
                let docDir = fm.urls(for: .documentDirectory, in: .userDomainMask).first!
                let logoPath = docDir.appendingPathComponent("LocalShablonLogos")
                let imageURL = URL(fileURLWithPath: logoPath.path).appendingPathComponent(fileName)
                let image    = UIImage(contentsOfFile: imageURL.path)
                nibView.imgLogo.image = image
            }
            catch
            {
                
            }
        }
        
        nibView.onClickCallback =
            {
                let fullShablon = MySqlite().getFullShablon(notFullShablon: shablon)
                self.gc.shablonToBegin = fullShablon
                self.performSegue(withIdentifier: self.gh.segueToBeginAudit, sender: nil)
            }
        
        lastAddedView = nibView
    }
    
  
}
