import UIKit
import Firebase

class DownloadVC: UIViewController
{

    var listOfAllShablons : [Model_Shablon] = []
    var listOfViewsInLayout : [UIView] = []
    
    var scroll : UIScrollView!
    
    var lastAddedView : UIView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        viewPrepare()
        loadShablons()
        
        
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
    
    func viewPrepare()
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
        view.addSubview(statusView)
        
        statusView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        statusView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        statusView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        statusView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
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
        titleLabel.text = "Список доступных аудитов"
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
        
        
        
        scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scroll)
        
        scroll.topAnchor.constraint(equalTo: headerRed.bottomAnchor).isActive = true
        scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scroll.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scroll.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scroll.layoutIfNeeded()
    }
    
    
    func prepareAll()
    {
        var scrollHeight : CGFloat = 0
        
        for shab in listOfAllShablons
        {
            let cell = downloadCell()
            
            
            cell.lblTitle.text = shab.name
            cell.lblTitle.setNeedsLayout()
            cell.lblTitle.layoutIfNeeded()
            cell.lblTitle.sizeToFit()

            
            cell.lblAuthor.text = "Автор : \(shab.author!)"
            cell.lblAuthor.setNeedsLayout()
            cell.lblAuthor.layoutIfNeeded()
            cell.lblAuthor.sizeToFit()
            
            cell.lblPlace.text = "Место: \(shab.place!)"
            cell.lblPlace.setNeedsLayout()
            cell.lblPlace.layoutIfNeeded()
            cell.lblPlace.sizeToFit()
            
            var image : UIImage
            
            if(shab.logoUrl != nil)
            {
                ImgHelper.shIn.loadImageFromURL(urlStr: shab.logoUrl!, imgView: cell.logoView)
            }
            else
            {
                cell.logoView.image = UIImage(named: "defSrc")
            }
            cell.logoView.layoutIfNeeded()

            
            scroll.addSubview(cell)
            cell.widthAnchor.constraint(equalTo: scroll.widthAnchor, multiplier: 1, constant: -8).isActive = true
            cell.heightAnchor.constraint(equalToConstant: 122).isActive = true
            cell.centerXAnchor.constraint(equalTo: scroll.centerXAnchor).isActive = true
            
            
            
            if lastAddedView == nil
            {
                cell.topAnchor.constraint(equalTo: scroll.topAnchor, constant: 4).isActive = true
            }
            else
            {
                cell.topAnchor.constraint(equalTo: lastAddedView.bottomAnchor, constant: 4).isActive = true
            }
            
            scrollHeight += 122 + 4
            
            
            cell.download =
                {
                    print(shab.password!)
                    self.present(PassRequest(shablon: shab), animated:  true, completion: nil)
                    //self.downloadAudit(fbId: shab.fbId!)
                }
            
            cell.lblTitle.setNeedsLayout()
            cell.lblTitle.layoutIfNeeded()
            cell.lblTitle.sizeToFit()

            let titleHeight = cell.lblTitle.frame.size.height
            let authorHeight = cell.lblAuthor.frame.size.height
            let placeHeight = cell.lblPlace.frame.size.height
            
            let sum = titleHeight + authorHeight + placeHeight
            
            print("sum is \(sum)")
            
            
            if sum > 106
            {
                print("sum is more than 106")
                let photoViewCons = cell.constraints.filter
                {
                    $0.firstAttribute == NSLayoutAttribute.height
                }
                NSLayoutConstraint.deactivate(photoViewCons)
                
                cell.bottomAnchor.constraint(equalTo: cell.lblPlace.bottomAnchor, constant: 8).isActive = true
                
            }
            
            lastAddedView = cell
            self.listOfViewsInLayout.append(cell)
        }
        
        recountScroll()
    }
    
    
//    @objc func goBackTapped()
//    {
//        let v = UIApplication.topViewController()
//        v?.dismiss(animated: true, completion: nil)
//    }
    
    
    
    
    
    
    
    func loadShablons()
    {
        Dialog.shIn.show(message: "Загрузка", view: view)
        gh.dbShablonRef.observeSingleEvent(of: .value)
        { (snapshot) in
            print(snapshot.childrenCount)
            
            for child in snapshot.children
            {
                let childSnap = child as! DataSnapshot
                let shablon = Model_Shablon()
                
                let fbId = childSnap.key
                let name = childSnap.childSnapshot(forPath: FBNames.shIn.SHABLON_NAME).value as! String
                let pass = childSnap.childSnapshot(forPath: FBNames.shIn.SHABLON_PASSWORD).value as! String
                let place = childSnap.childSnapshot(forPath: FBNames.shIn.SHABLON_PLACE).value as! String
                let author = childSnap.childSnapshot(forPath: FBNames.shIn.SHABLON_AUTHOR).value as! String
                
                if childSnap.hasChild(FBNames.shIn.SHABLON_LOGO_URL)
                {
                    let logoUrl = childSnap.childSnapshot(forPath: FBNames.shIn.SHABLON_LOGO_URL).value as! String
                    shablon.logoUrl = logoUrl
                }
                
                shablon.fbId = fbId
                shablon.name = name
                shablon.place = place
                shablon.author = author
                shablon.password = pass
                
                self.listOfAllShablons.append(shablon)
                
                
            }
            self.prepareAll()
            Dialog.shIn.hide(afterTime: 0.2)

        }
    }
    
    func recountScroll()
    {
        var height : CGFloat = 0
        for v in listOfViewsInLayout
        {
            v.layoutIfNeeded()
            let vHeight = v.frame.size.height
            height += vHeight+4
        }
        
        scroll.contentSize.height = height + 4
    }
        
}
