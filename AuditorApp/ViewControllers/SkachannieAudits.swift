import UIKit

class SkachannieAudits: UIViewController {

//    @IBOutlet weak var scrollView: UIScrollView!
//    @IBOutlet weak var lblTitle: UILabel!
    var scrollView:UIScrollView!
    var lblTitle : UILabel!
    
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
        
        //gh.setFont(viewArray: [lblTitle], size: GlobalHelper.sharedInstance.sizeTitle)
        
        mySql = MySqlite()
        listOfSkachannihShablonov = mySql.getAllSkachannie()
        print(listOfSkachannihShablonov.count)
    
        //displayShablonCell()
        
        lblTitle = UILabel()
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        lblTitle.backgroundColor = UIColor.clear
        self.view.addSubview(lblTitle)
        
        lblTitle.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        lblTitle.heightAnchor.constraint(equalToConstant: 36).isActive = true
        lblTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        lblTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lblTitle.layoutIfNeeded()
        
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scrollView)
        
        scrollView.topAnchor.constraint(equalTo: lblTitle.bottomAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        scrollView.layoutIfNeeded()
        
        
        let backBbutton = myBackArrowButton()
        view.addSubview(backBbutton)
        
        backBbutton.widthAnchor.constraint(equalToConstant: 36).isActive = true
        backBbutton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        backBbutton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backBbutton.centerYAnchor.constraint(equalTo: lblTitle.centerYAnchor).isActive = true
        backBbutton.layoutIfNeeded()
        
        backBbutton.click =
            {
                self.dismiss(animated: true, completion: nil)
            }
        
        
        lblTitle.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        
        
        let status = UIView()
        view.insertSubview(status, at: 1)
        status.backgroundColor = gh.myRed
        status.translatesAutoresizingMaskIntoConstraints = false
        
        status.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        status.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        status.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        status.bottomAnchor.constraint(equalTo: lblTitle.bottomAnchor).isActive = true
        status.layoutIfNeeded()
        
        
        prepareScroll()
        
        
        let statusView = UIView()
        statusView.translatesAutoresizingMaskIntoConstraints = false
        statusView.backgroundColor = gh.myRed
        self.view.addSubview(statusView)
        
        statusView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        statusView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        statusView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        statusView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        statusView.layoutIfNeeded()
        
    }
    
    func displayShablonCell()
    {
        for shablon in listOfSkachannihShablonov
        {
            print("Tryi 11")
            let cellClass = SkachannieCell()
            //let newView = cellClass.instanceFromNib()
            let newView = mySkachannieCell()
            //addSubviewWithPosition(cellView: newView, shablon: shablon)
        }
    }

   
    
    func prepareScroll()
    {
        var scrollHeight : CGFloat = 0
        
        for shablon in listOfSkachannihShablonov
        {
            let cell = mySkachannieCell()
            
            scrollView.addSubview(cell)
            
            cell.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1, constant: -8).isActive = true
            cell.heightAnchor.constraint(equalToConstant: 122).isActive = true
            cell.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
            
            if lastAddedView != nil
            {
                cell.topAnchor.constraint(equalTo: lastAddedView!.bottomAnchor, constant: 4).isActive = true
            }
            else
            {
                cell.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 4).isActive = true
            }
            
            lastAddedView = cell
            
            cell.lblTitle.text = shablon.name!
            cell.lblPlace.text = "Место : \(shablon.place!)"
            cell.lblAuthor.text = "Автор : \(shablon.author!)"
            
            if shablon.localImageName != nil
            {
                let fileName = "\(shablon.localImageName!).jpg"
                let fm = FileManager.default
                let docDir = fm.urls(for: .documentDirectory, in: .userDomainMask).first!
                let logoPath = docDir.appendingPathComponent("LocalShablonLogos")
                let imageURL = URL(fileURLWithPath: logoPath.path).appendingPathComponent(fileName)
                let image    = UIImage(contentsOfFile: imageURL.path)
                
                cell.logoView.image = image
            }
            else
            {
                cell.logoView.image = UIImage(named: "defSrc")
            }
            
            
            
            cell.begin =
                {
                    let fullShablon = MySqlite().getFullShablon(notFullShablon: shablon)
                    
                    if self.gc.auditorName == nil
                    {
                        self.present(AuditorNameVC(shablon: fullShablon), animated: true, completion: nil)
                    }
                    else
                    {
                        self.gc.shablonToBegin = fullShablon
                        self.performSegue(withIdentifier: self.gh.segueToBeginAudit, sender: nil)
                    }
                }
            
            
            
            cell.delete =
                {
                    let index = self.listOfSkachannihShablonov.index(of: shablon)!
                    self.listOfSkachannihShablonov.remove(at: index)
                    
                    for v in self.scrollView.subviews
                    {
                        v.removeFromSuperview()
                    }
                    
                    self.lastAddedView = nil
                    
                    let sql = MySqlite()
                    sql.deleteShablon(shab: shablon)
                    self.prepareScroll()
                }
            
            
            cell.lblTitle.layoutIfNeeded()
            cell.lblTitle.numberOfLines = 2
            print(cell.lblTitle.frame.size.height,"title heighttttt")
            
            if cell.lblTitle.frame.size.height > 54
            {
                let cons = lblTitle.constraints.filter
                {
                    $0.firstAttribute == NSLayoutAttribute.height
                }
                NSLayoutConstraint.deactivate(cons)
                
                lblTitle.heightAnchor.constraint(equalToConstant: 54)
            }
            
            scrollHeight += 126
        }
        
        scrollView.contentSize.height = scrollHeight + 4
        
    }
    
    
    
    func addSubviewWithPosition(cellView : SkachannieCell, shablon : Model_Shablon)
    {

        scrollView.addSubview(cellView)

        cellView.translatesAutoresizingMaskIntoConstraints = false
        if lastAddedView != nil
        {
            cellView.topAnchor.constraint(equalTo: (lastAddedView?.bottomAnchor)!).isActive = true
        }
        else
        {
            cellView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        }
        cellView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        cellView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        cellView.heightAnchor.constraint(equalToConstant: 148).isActive = true
        
        gh.addShadow(viewArray: [cellView.cellRootView,cellView.imgLogo])
        gh.makeLittleCorners(viewArray: [cellView.cellRootView,cellView.rootImageView,cellView.rootButtonsView,cellView.imgLogo], radius: 6)
        gh.setFont(viewArray: [cellView.lblTitle], size: gh.sizeTitle)
        gh.setFont(viewArray: [cellView.lblAuthor,cellView.lblPlace], size: gh.sizeMiddleMinus1)
        
        cellView.lblTitle.text = shablon.name
        cellView.lblPlace.text = "Место : \(shablon.place!)"
        cellView.lblAuthor.text = "Автор : \(shablon.author!)"
        
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
                cellView.imgLogo.image = image
            }
            catch
            {
                
            }
        }
        
        cellView.onClickCallback =
            {
                let fullShablon = MySqlite().getFullShablon(notFullShablon: shablon)
                self.gc.shablonToBegin = fullShablon
                self.performSegue(withIdentifier: self.gh.segueToBeginAudit, sender: nil)
            }
        
        lastAddedView = cellView
    }
    
  
}
