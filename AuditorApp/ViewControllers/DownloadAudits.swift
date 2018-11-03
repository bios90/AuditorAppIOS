import UIKit
import Firebase
import FirebaseDatabase

class DownloadAudits: UIViewController, UITableViewDelegate , UITableViewDataSource
{
    @IBOutlet weak var lblAllAudits: UILabel!
    @IBOutlet weak var tbvAllAudits: UITableView!
    
    var listOfAllShablons = [Model_Shablon]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tbvAllAudits.backgroundColor = UIColor.clear
        
        //lblAllAudits.isHidden = true
        
//
//        let headerRed = UIView()
//        headerRed.translatesAutoresizingMaskIntoConstraints = false
//        headerRed.backgroundColor = gh.myRed
//        view.addSubview(headerRed)
//
//        headerRed.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
//        headerRed.heightAnchor.constraint(equalToConstant: 38).isActive = true
//        headerRed.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//        headerRed.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        headerRed.layoutIfNeeded()
//
        
        
        
        tbvAllAudits.delegate = self
        tbvAllAudits.dataSource = self
        tbvAllAudits.separatorColor = UIColor.clear
        tbvAllAudits.allowsSelection = false
        
        
        //GlobalHelper.sharedInstance.setFont(viewArray: [lblAllAudits], size: 18)
        //GlobalHelper.sharedInstance.setTextColor(viewArray: [lblAllAudits], col: GlobalHelper.sharedInstance.myBejColor)
        
        //GlobalHelper.sharedInstance.addShadow(viewArray: [lblAllAudits])
        
        loadShablons()
        print(self.listOfAllShablons.count)
        
        lblAllAudits.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        lblAllAudits.backgroundColor = UIColor.clear
        
        let status = UIView()
        view.insertSubview(status, at: 1)
        status.backgroundColor = gh.myRed
        status.translatesAutoresizingMaskIntoConstraints = false
        
        status.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        status.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        status.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        status.bottomAnchor.constraint(equalTo: lblAllAudits.bottomAnchor).isActive = true
        status.layoutIfNeeded()
        
        tbvAllAudits.backgroundColor = UIColor.clear
        tbvAllAudits.translatesAutoresizingMaskIntoConstraints = false
        
        tbvAllAudits.topAnchor.constraint(equalTo: status.bottomAnchor).isActive = true
        tbvAllAudits.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tbvAllAudits.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tbvAllAudits.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tbvAllAudits.layoutIfNeeded()
        
        
        
        lblAllAudits.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(lblAllAudits)
        lblAllAudits.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1, constant : -78).isActive = true
        lblAllAudits.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        lblAllAudits.heightAnchor.constraint(equalToConstant: 36).isActive = true
        lblAllAudits.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lblAllAudits.layoutIfNeeded()
        
        
        
        let backButtom = myBackArrowButton()
        view.addSubview(backButtom)
        
        backButtom.widthAnchor.constraint(equalToConstant: 36).isActive = true
        backButtom.heightAnchor.constraint(equalToConstant: 36).isActive = true
        backButtom.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        backButtom.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backButtom.layoutIfNeeded()
        
        
        backButtom.click =
            {
                self.dismiss(animated: true, completion: nil)
            }
        
        
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
        

    
    func loadShablons()
    {
        Dialog.shIn.show(message: "Загрузка", view: view)
        //GlobalHelper.sharedInstance.dbShablonRef.observe(DataEventType.value)
            gh.dbShablonRef.observeSingleEvent(of: .value)
        { (snapshot) in
            print(snapshot.childrenCount)
            
            for child in snapshot.children //.allObjects as? [DataSnapshot]
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
            Dialog.shIn.hide(afterTime: 0.2)
            self.tbvAllAudits.reloadData()
        }
        
        
        

        
        

//        GlobalHelper.sharedInstance.dbShablonRef.observe(of: DataEventType.value)
//        { (snapshot) in
//            var shablon = Model_Shablon()
//
//            if let allData = snapshot.value as? [String : AnyObject]
//            {
//                let name = allData[FBNames.shIn.SHABLON_NAME] as! String
//                let pass = allData[FBNames.shIn.SHABLON_PASSWORD] as! String
//                let place = allData[FBNames.shIn.SHABLON_PLACE] as! String
//                let author = allData[FBNames.shIn.SHABLON_AUTHOR] as! String
//                let logourl = allData[FBNames.shIn.SHABLON_LOGO_URL] as! String
//                let fbId = snapshot.key
//
//                shablon.fbId = fbId
//                shablon.name = name
//                shablon.place = place
//                shablon.author = author
//                shablon.password = pass
//                shablon.logoUrl = logourl
//
//                print(shablon.author)
//
//                self.listOfAllShablons.append(shablon)
//
//                print(self.listOfAllShablons.count)
//            }
//        }
        
        
//        GlobalHelper.sharedInstance.dbRootRef.observeSingleEvent(of: .value)
//        { (snapshot) in
//
//            for child in snapshot.children
//            {
//                var shablon = Model_Shablon()
//
//                let childSnap = child as! DataSnapshot
//                let fbId = childSnap.key
//
//                print(childSnap)
//
//                let name = childSnap
//                if let dictionary = childSnap.value as? [String:AnyObject]
//                {
//
////                    let name = dictionary[FBNames.shIn.SHABLON_NAME] as! String
////                    let pass = dictionary[FBNames.shIn.SHABLON_PASSWORD] as! String
////                    let author = dictionary[FBNames.shIn.SHABLON_AUTHOR] as! String
////                    let place = dictionary[FBNames.shIn.SHABLON_PLACE] as! String
////                    let logoUrl = dictionary[FBNames.shIn.SHABLON_LOGO_URL] as! String
////
////                    shablon.name = name
////                    shablon.fbId = fbId
////                    shablon.password = pass
////                    shablon.author = author
////                    shablon.place = place
////                    shablon.logoUrl = logoUrl
//
////                    self.listOfAllShablons.append(shablon)
////                    print(self.listOfAllShablons.count,shablon.name)
//                }
//
//            }
//        }
        
//        GlobalHelper.sharedInstance.dbShablonRef.observe(DataEventType.childAdded)
//        { (snapshot) in
//            var shablon = Model_Shablon()
//
//            if let allData = snapshot.value as? [String : AnyObject]
//            {
//                let name = allData[FBNames.shIn.SHABLON_NAME] as! String
//                let pass = allData[FBNames.shIn.SHABLON_PASSWORD] as! String
//                let place = allData[FBNames.shIn.SHABLON_PLACE] as! String
//                let author = allData[FBNames.shIn.SHABLON_AUTHOR] as! String
//                let logourl = allData[FBNames.shIn.SHABLON_LOGO_URL] as! String
//                let fbId = snapshot.key
//
//                shablon.fbId = fbId
//                shablon.name = name
//                shablon.place = place
//                shablon.author = author
//                shablon.password = pass
//                shablon.logoUrl = logourl
//
//                print(shablon.author)
//
//                self.listOfAllShablons.append(shablon)
//                print(self.listOfAllShablons.count)
//
//                DispatchQueue.main.async
//                    {
//                        GlobalHelper.sharedInstance.showToast(message: shablon.name, view: self.view)
//                    }
//            }
//        }
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        print(self.listOfAllShablons.count ,"rerubt from CountFucnction!!!!")
        return self.listOfAllShablons.count
    }
    
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
//    {
//        let shablon = listOfAllShablons[indexPath.row]
//
//        let cell = DownloadAuditCell()
//
//        return cell
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let shablon = listOfAllShablons[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "downAuditCell", for: indexPath) as! DownloadAuditCell
        //let cell = DownloadAuditCell()

        cell.shablon = shablon

        cell.viewRoot.backgroundColor = UIColor.clear
        cell.backgroundColor = UIColor.clear
        cell.viewLogoImg.backgroundColor = UIColor.clear
        cell.viewDownLoadBtn.backgroundColor = UIColor.clear


        cell.lblAuditName.text = shablon.name!
        cell.lblAuditPlace.text = String ("Место : \(shablon.place!)")
        cell.lblAuditAuthor.text = String("Автор : \(shablon.author!)")

        GlobalHelper.sharedInstance.addShadow(viewArray: [cell.btnDownloadAudit,cell.customRootView,cell.imgAuditLogo])

        GlobalHelper.sharedInstance.makeLittleCorners(viewArray: [cell.customRootView], radius: 6)
        GlobalHelper.sharedInstance.makeLittleCorners(viewArray: [cell.imgAuditLogo], radius: 4)

        if(shablon.logoUrl != nil)
        {
            ImgHelper.shIn.loadImageFromURL(urlStr: shablon.logoUrl!, imgView: cell.imgAuditLogo)
        }
        else
        {
            cell.imgAuditLogo.image = UIImage(named: "defSrc")
        }

        //cell.downloadDelegate = self

        return cell
    }
    
    
    @IBAction func actBackPressed(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
