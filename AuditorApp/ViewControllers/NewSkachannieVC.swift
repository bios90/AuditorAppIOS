import UIKit

class NewSkachannieVC: UIViewController
{
    let gh = GlobalHelper.sharedInstance
    let gc = GlobalClass.sharedInstance
    var scrollView : UIScrollView!
    var listOfSkachannihShablonov : [Model_Shablon] = []
    var mySql : MySqlite!
    var lastAddedView : UIView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        mySql = MySqlite()
        listOfSkachannihShablonov = mySql.getAllSkachannie()
        prepareView()
        prepareScroll()


    }
    
    func prepareView()
    {
        let bgImgV = UIImageView()
        bgImgV.translatesAutoresizingMaskIntoConstraints = false
        bgImgV.image = UIImage(named: "backgroundBG")
        view.addSubview(bgImgV)
        
        bgImgV.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        bgImgV.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        bgImgV.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bgImgV.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        bgImgV.layoutIfNeeded()
        
        
        let statusView = UIView()
        statusView.translatesAutoresizingMaskIntoConstraints = false
        statusView.backgroundColor = gh.myRed
        self.view.addSubview(statusView)
        
        statusView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        statusView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        statusView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        statusView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        statusView.layoutIfNeeded()
        
        let headerRed = UIView()
        headerRed.translatesAutoresizingMaskIntoConstraints = false
        headerRed.backgroundColor = gh.myRed
        view.addSubview(headerRed)
        
        headerRed.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        headerRed.heightAnchor.constraint(equalToConstant: 38).isActive = true
        headerRed.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        headerRed.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        headerRed.layoutIfNeeded()
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.text = "Список скачанных шаблонов"
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.white
        headerRed.addSubview(titleLabel)
        
        titleLabel.widthAnchor.constraint(equalTo: headerRed.widthAnchor, multiplier: 1, constant: -96).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 38).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: headerRed.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: headerRed.topAnchor).isActive = true
        titleLabel.layoutIfNeeded()
        
        
        
        
        let backButton = myBackArrowButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        headerRed.addSubview(backButton)
        
        backButton.widthAnchor.constraint(equalToConstant: 38).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 38).isActive = true
        backButton.leftAnchor.constraint(equalTo: headerRed.leftAnchor).isActive = true
        backButton.centerYAnchor.constraint(equalTo: headerRed.centerYAnchor).isActive = true
        backButton.layoutIfNeeded()
        
        backButton.click =
            {
                self.dismiss(animated: true, completion: nil)
        }
        
        
        
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        scrollView.topAnchor.constraint(equalTo: headerRed.bottomAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.layoutIfNeeded()
    }

    func prepareScroll()
    {
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
                    
                    self.gc.shablonToBegin = fullShablon
                    self.present(beginAuVC(), animated: true, completion: nil)
                    
//                    if self.gc.auditorName == nil
//                    {
//                        self.present(AuditorNameVC(shablon: fullShablon), animated: true, completion: nil)
//                    }
//                    else
//                    {
//                        self.gc.shablonToBegin = fullShablon
//                        self.performSegue(withIdentifier: self.gh.segueToBeginAudit, sender: nil)
//                    }
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
            
            
            cell.lblTitle.numberOfLines = 2
            cell.lblTitle.layoutIfNeeded()
            
//            cell.bottomAnchor.constraint(equalTo: cell.lblAuthor.bottomAnchor, constant: 4).isActive = true
            cell.layoutIfNeeded()
            



            if cell.lblTitle.frame.size.height > 54
            {
                let cons = cell.lblTitle.constraints.filter
                {
                    $0.firstAttribute == NSLayoutAttribute.height
                }
                NSLayoutConstraint.deactivate(cons)

                cell.lblTitle.heightAnchor.constraint(equalToConstant: 54)
            }
        }
        
        countHeight()
    }
    
    
    func countHeight()
    {
        var height : CGFloat = 0
        
        for view in scrollView.subviews
        {
            view.layoutIfNeeded()
            let vh = view.frame.size.height
            height+=vh + 4
        }
        
        scrollView.contentSize.height = height
    }

    
    
    
    
    
    
    
    
    
    
    
    
}
