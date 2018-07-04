//
//  DownloadAuditCell.swift
//  AuditorApp
//
//  Created by Филипп Бесядовский on 25.06.2018.
//  Copyright © 2018 dimFcompany. All rights reserved.
//

import UIKit

protocol btnDownloadDelegate
{
    func btnPressed(shablon : Model_Shablon)
}

class DownloadAuditCell: UITableViewCell {
    
    

    @IBOutlet weak var lblAuditName: UILabel!
    @IBOutlet weak var lblAuditAuthor: UILabel!
    @IBOutlet weak var lblAuditPlace: UILabel!
    
    @IBOutlet weak var viewDownLoadBtn: UIView!
    @IBOutlet weak var viewLogoImg: UIView!
    @IBOutlet weak var viewText: UIView!
    
    @IBOutlet weak var imgAuditLogo: UIImageView!
    @IBOutlet weak var viewRoot: UIView!
    @IBOutlet weak var customRootView: UIView!
    @IBOutlet weak var btnDownloadAudit: UIButton!
    
    var downloadDelegate : btnDownloadDelegate?
    var shablon : Model_Shablon?
    
    override func awakeFromNib()
    {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func actDownLoadPressed(_ sender: Any)
    {
        downloadDelegate?.btnPressed(shablon: shablon!)
    }
    

}
