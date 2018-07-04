import UIKit
import SignaturePad

class myPodpisDialogVC: UIViewController
{
    var podpis : Model_Podpis!
    let gh = GlobalHelper.sharedInstance
    
    func customInit()
    {
        self.modalPresentationStyle = .overCurrentContext
        
        view.backgroundColor = UIColor.clear
    
        let darkView = UIView()
        darkView.backgroundColor = UIColor.black
        darkView.alpha = 0.8
        darkView.frame = view.bounds
        darkView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        view.addSubview(darkView)
        

        let dialogView = myAuditView()
        view.insertSubview(dialogView, at: 1)
        
        dialogView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dialogView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        dialogView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9, constant: 0).isActive = true
        dialogView.heightAnchor.constraint(equalToConstant: 260).isActive = true
        dialogView.layoutIfNeeded()
        
        let viewForSignPad = myAuditView()
        dialogView.addSubview(viewForSignPad)
        
        viewForSignPad.topAnchor.constraint(equalTo: dialogView.topAnchor, constant: 8).isActive = true
        viewForSignPad.leftAnchor.constraint(equalTo: dialogView.leftAnchor, constant: 8).isActive = true
        viewForSignPad.widthAnchor.constraint(equalTo: dialogView.widthAnchor, multiplier: 1, constant: -16).isActive = true
        viewForSignPad.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        let sigPad = SignaturePad()
        sigPad.translatesAutoresizingMaskIntoConstraints = false
        viewForSignPad.addSubview(sigPad)
        
        sigPad.centerXAnchor.constraint(equalTo: viewForSignPad.centerXAnchor).isActive = true
        sigPad.centerYAnchor.constraint(equalTo: viewForSignPad.centerYAnchor).isActive = true
        sigPad.widthAnchor.constraint(equalTo: viewForSignPad.widthAnchor, multiplier: 1, constant: -8).isActive = true
        sigPad.heightAnchor.constraint(equalTo: viewForSignPad.heightAnchor, multiplier: 1, constant: -8).isActive = true
        sigPad.layoutIfNeeded()
        
        let okButton = redButton()
        dialogView.addSubview(okButton)
        
        okButton.widthAnchor.constraint(equalTo: viewForSignPad.widthAnchor, multiplier: 0.5, constant: -12).isActive=true
        okButton.widthAnchor.constraint(equalToConstant: 36).isActive=true
        okButton.topAnchor.constraint(equalTo: viewForSignPad.bottomAnchor, constant: 12).isActive = true
        okButton.rightAnchor.constraint(equalTo: dialogView.rightAnchor, constant: -8).isActive = true
        okButton.layoutIfNeeded()
        
        let cancelButton = transButton()
        dialogView.addSubview(cancelButton)
        
        cancelButton.widthAnchor.constraint(equalTo: viewForSignPad.widthAnchor, multiplier: 0.5, constant: -12).isActive=true
        cancelButton.widthAnchor.constraint(equalToConstant: 36).isActive=true
        cancelButton.topAnchor.constraint(equalTo: viewForSignPad.bottomAnchor, constant: 12).isActive = true
        cancelButton.leftAnchor.constraint(equalTo: dialogView.leftAnchor, constant: 8).isActive = true
        cancelButton.layoutIfNeeded()
        
        okButton.click =
            {
                let signImage = sigPad.getSignature()!
                
                let imgToSigh = self.podpis.auditView.viewWithTag(self.gh.tagMyAuditView)!.viewWithTag(self.gh.tagAnyMyImageView)! as! UIImageView
                imgToSigh.image = nil
                imgToSigh.image = signImage
                self.podpis.addSign = signImage
                self.dismiss(animated: true, completion: nil)
            }
        
        cancelButton.click =
            {
                self.dismiss(animated: true, completion: nil)
            }
    }
    
    
    


    
    init(podpis : Model_Podpis)
    {
        super.init(nibName: nil, bundle: nil)
        self.podpis = podpis
        customInit()
    }
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        customInit()
    }
}
