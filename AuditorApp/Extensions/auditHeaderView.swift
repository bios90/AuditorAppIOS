import UIKit

class auditHeaderView: UIView
{
    let gh = GlobalHelper.sharedInstance
    var type : Int!
    var btnSkrepka : UIButton!
    var imgObyaz : UIImageView!
    
    var click : (() -> Void)?
    
    func customInit()
    {
        tag = gh.tagHeader
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        
        let typeImage = createTypeImage()
        addSubview(typeImage)
        
        typeImage.widthAnchor.constraint(equalToConstant: 36).isActive = true
        typeImage.heightAnchor.constraint(equalToConstant: 36).isActive = true
        typeImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 4).isActive = true
        typeImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 4).isActive = true
        
        imgObyaz = myObyazImage()
        addSubview(imgObyaz)
        
        imgObyaz.widthAnchor.constraint(equalToConstant: 36).isActive = true
        imgObyaz.heightAnchor.constraint(equalToConstant: 36).isActive = true
        imgObyaz.leftAnchor.constraint(equalTo: typeImage.rightAnchor, constant: 4).isActive = true
        imgObyaz.topAnchor.constraint(equalTo: self.topAnchor, constant: 4).isActive = true
        
        btnSkrepka = mySkrepkaButton()
        addSubview(btnSkrepka)
        
        btnSkrepka.widthAnchor.constraint(equalToConstant: 36).isActive = true
        btnSkrepka.heightAnchor.constraint(equalToConstant: 36).isActive = true
        btnSkrepka.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -4).isActive = true
        btnSkrepka.topAnchor.constraint(equalTo: self.topAnchor, constant: 4).isActive = true
        btnSkrepka.layoutIfNeeded()
        
        btnSkrepka.addTarget(self, action: #selector(self.skrepkaClick), for: .touchUpInside)
    }
    
    @objc func skrepkaClick()
    {
        click?()
    }
    
    init(typeInt : Int)
    {
        super.init(frame: CGRect(x: 8, y: 8, width: 8, height: 8))
        type = typeInt
        customInit()
    }
    
    func createTypeImage() -> UIImageView
    {
        let img : UIImageView = UIImageView()
        let myRed = gh.myRed
        img.backgroundColor = myRed
        img.layer.cornerRadius = 18
        img.translatesAutoresizingMaskIntoConstraints = false
        
        switch type
        {
        case gh.typeQuestion:
            img.image = UIImage(named: "ic_question_bej")!
        case gh.typeAdress:
            img.image = UIImage(named: "ic_adress_bej")!
        case gh.typeCheckBox:
            img.image = UIImage(named: "ic_checkbox_bej")!
        case gh.typeDate:
            img.image = UIImage(named: "ic_date_bej")!
        case gh.typeInfo:
            img.image = UIImage(named: "ic_info_bej")!
        case gh.typeMedia:
            img.image = UIImage(named: "ic_media_bej")!
        case gh.typePodpis:
            img.image = UIImage(named: "ic_podpis_bej")!
        case gh.typeQuestVar:
            img.image = UIImage(named: "ic_questvar_bej")!
        case gh.typeSeeker:
            img.image = UIImage(named: "ic_seeker_bej")!
        case gh.typeTextLaerge:
            img.image = UIImage(named: "ic_textlarge_bej")!
        case gh.typeTextOneLine:
            img.image = UIImage(named: "ic_onelinetext_bej")!
        case gh.typeToggle:
            img.image = UIImage(named: "ic_toggle")!
        case gh.typeTimer:
            img.image = UIImage(named: "ic_timer_bej")
        default:
            break
        }
        
        return img
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        customInit()
    }
    
}
