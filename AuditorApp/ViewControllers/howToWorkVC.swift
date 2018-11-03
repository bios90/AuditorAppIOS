import UIKit
import WebKit

class howToWorkVC: UIViewController {

    let gh = GlobalHelper.sharedInstance
    let fm = FileManager.default
    var webView : WKWebView!
    
    func customInit()
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
        
        
        let header = pdfHeader()
        self.view.addSubview(header)
        
        header.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1).isActive = true
        header.heightAnchor.constraint(equalToConstant: 44).isActive = true
        header.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        header.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        header.titleView.adjustsFontSizeToFitWidth = true
        
        
        header.backClick =
            {
//                self.dismiss(animated: false, completion: nil)
                self.present(NewMainMenu(), animated: true, completion: nil)
                
//                self.dismiss(animated: true, completion: {
//
//                })
            }
        
        webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(webView)
        webView.backgroundColor = gh.myBejColor
        
        webView.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 0).isActive = true
        webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        webView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        webView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        webView.layoutIfNeeded()
        
        do{
            let pdfURL = Bundle.main.url(forResource: "howToWork", withExtension: "pdf")
            let data = try Data(contentsOf: pdfURL!)
            webView.load(data, mimeType: "application/pdf", characterEncodingName:"", baseURL: (pdfURL?.deletingLastPathComponent())!)
        }
        catch
        {
            
        }
    }
    
    init()
    {
        super.init(nibName: nil, bundle: nil)
        customInit()
    }
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        customInit()
    }

}
