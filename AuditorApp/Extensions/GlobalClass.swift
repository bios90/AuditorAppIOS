//
//  GlobalClass.swift
//  AuditorApp
//
//  Created by Филипп Бесядовский on 30.06.2018.
//  Copyright © 2018 dimFcompany. All rights reserved.
//

import UIKit

class GlobalClass: NSObject
{
    var shablonToBegin : Model_Shablon!
    static let sharedInstance = GlobalClass()
    var shablonInWork : Model_Shablon!
    var currentBeginAuditVC : beginAuVC!
    var shablonTomMakeOtchet : Model_Shablon!
}
