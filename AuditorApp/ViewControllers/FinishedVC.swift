import UIKit
import PDFReader

class FinishedVC: UIViewController
{
    let gh = GlobalHelper.sharedInstance
    let gc = GlobalClass.sharedInstance
    var listOfOthcets : [Model_Otchet] = []
    var lastView : UIView!
    var listOfOtchets : [Model_Otchet] = []
    
    var scroll : UIScrollView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let sql = MySqlite()
        listOfOtchets = sql.getOtchets()
        
        viewPrepare()
        prepareOtchets()
        
        print(view.frame.size.width)
        
        
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
        titleLabel.text = "Список завершенных аудитов"
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
    
    func prepareOtchets()
    {
        var scrollHeight : CGFloat = 0
        
        for otchet in listOfOtchets
        {
            let cell = otchetCell()
            
            print(listOfOtchets.count)
            
            cell.lblTitle.text = otchet.name
            cell.lblTitle.layoutIfNeeded()

            cell.lblDate.text = "Дата : \(dateToStr(date: otchet.date!))"
            cell.lblDate.layoutIfNeeded()

            cell.lblPercent.text = "Набранные баллы : \(otchet.percent!)%"
            cell.lblPercent.layoutIfNeeded()

            var image : UIImage

            if otchet.logoFileName != nil
            {
                let fileName = "\(otchet.logoFileName!).jpg"
                let fm = FileManager.default
                let docDir = fm.urls(for: .documentDirectory, in: .userDomainMask).first!
                let logoPath = docDir.appendingPathComponent("LocalShablonLogos")
                let imageURL = URL(fileURLWithPath: logoPath.path).appendingPathComponent(fileName)

                image = UIImage(contentsOfFile: imageURL.path)!
            }
            else
            {
                image = UIImage(named: "defSrc")!
            }

            cell.logoView.image = image
            
            scroll.addSubview(cell)
            cell.widthAnchor.constraint(equalTo: scroll.widthAnchor, multiplier: 1, constant: -8).isActive = true
            cell.heightAnchor.constraint(equalToConstant: 122).isActive = true
            cell.centerXAnchor.constraint(equalTo: scroll.centerXAnchor).isActive = true
            
            if lastView == nil
            {
                cell.topAnchor.constraint(equalTo: scroll.topAnchor, constant: 4).isActive = true
            }
            else
            {
                cell.topAnchor.constraint(equalTo: lastView.bottomAnchor, constant: 4).isActive = true
            }
            
            

            let fileName = "\(otchet.pdfFileName!).pdf"
            let fm = FileManager.default
            let docDir = fm.urls(for: .documentDirectory, in: .userDomainMask).first!
            let dataPath = docDir.appendingPathComponent("Otchets")
            let pdfUrl = URL(fileURLWithPath: dataPath.path).appendingPathComponent(fileName)


            
            cell.cellClick =
                {
                    let fileName = otchet.pdfFileName!
                    
                    let fm = FileManager.default
                    let docDir = fm.urls(for: .documentDirectory, in: .userDomainMask).first!
                    
                    let dataPath = docDir.appendingPathComponent("Otchets")
                    
                    let url = URL(fileURLWithPath: dataPath.path).appendingPathComponent("\(fileName).pdf")
                    let document = PDFDocument(url: url)!
                    
                    let myBackButton = UIBarButtonItem(title: "Назад", style: .done, target: self, action: #selector(self.goBackTapped))
                    let readerController = PDFViewController.createNew(with: document, title: otchet.name, actionButtonImage: nil, actionStyle: .activitySheet, backButton: myBackButton, isThumbnailsEnabled: false, startPageIndex: 0)
                    let targetNavigationController = UINavigationController(rootViewController: readerController)
                    self.present(targetNavigationController, animated: true, completion: nil)
                }
            
            
            cell.share =
                {
                    print("share clicked!!")
//                    let activityVC = UIActivityViewController(activityItems: [pdfUrl], applicationActivities: nil)
//                    activityVC.popoverPresentationController?.sourceView = self.view
//
//                    self.present(activityVC , animated: true, completion: nil)
                    if(!self.gh.isConnectedToNetwork())
                    {
                        self.gh.showToast(message: "Нет соединения с сетью", view: self.view)
                        return
                    }
                    
                    var phpHelper : PhpSqlHelper!
                    phpHelper = PhpSqlHelper()
                    
                    phpHelper.checkIfUploaded(localId: otchet.Id!, completion:
                        {
                        (exists) in
                        if exists
                        {
                            let activityVC = UIActivityViewController(activityItems: [pdfUrl], applicationActivities: nil)
                            activityVC.popoverPresentationController?.sourceView = self.view
                            phpHelper = nil
                            self.present(activityVC , animated: true, completion: nil)
                        }
                        else
                        {
                            self.gc.otchetToUpload = otchet
                            phpHelper = nil
                            self.present(UploadDialogVC(), animated: true, completion: nil)
                        }
                    })
                    
                }
            
            
            cell.delete =
                {
                    let index = self.listOfOtchets.index(of: otchet)
                    self.listOfOtchets.remove(at: index!)

                    for view in self.scroll.subviews
                    {
                        view.removeFromSuperview()
                    }
                    
                    self.lastView = nil
                    
                    let sql = MySqlite()
                    sql.deleteOthcet(id: otchet.Id)
                    self.prepareOtchets()
                }
            
            scrollHeight += 122 + 4
            
            lastView = cell
        }
    
        scroll.contentSize.height = scrollHeight
    }
    
    
    @objc func goBackTapped()
    {
        let v = UIApplication.topViewController()
        v?.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
    
    
    
    


}
