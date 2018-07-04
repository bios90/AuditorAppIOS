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
        
        tbvAllAudits.delegate = self
        tbvAllAudits.dataSource = self
        tbvAllAudits.separatorColor = UIColor.clear
        tbvAllAudits.allowsSelection = false
        
        
        GlobalHelper.sharedInstance.setFont(viewArray: [lblAllAudits], size: 18)
        GlobalHelper.sharedInstance.setTextColor(viewArray: [lblAllAudits], col: GlobalHelper.sharedInstance.myBejColor)
        
        GlobalHelper.sharedInstance.addShadow(viewArray: [lblAllAudits])
        
        loadShablons()
        print(self.listOfAllShablons.count)
        
        
    }
        

    
    func loadShablons()
    {
        Dialog.shIn.show(message: "Загрузка", view: view)
        
        GlobalHelper.sharedInstance.dbShablonRef.observe(DataEventType.value)
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
            self.tbvAllAudits.reloadData()
        }
        
        
        Dialog.shIn.hide(afterTime: 1)
        
        

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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let shablon = listOfAllShablons[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "downAuditCell", for: indexPath) as! DownloadAuditCell
        
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
        
        cell.downloadDelegate = self
        
        return cell
    }
    
    
    @IBAction func actBackPressed(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
