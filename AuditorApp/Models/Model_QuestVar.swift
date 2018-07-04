//
//  Model_QuestVar.swift
//  AuditorApp
//
//  Created by Филипп Бесядовский on 26.06.2018.
//  Copyright © 2018 dimFcompany. All rights reserved.
//

import UIKit

class Model_QuestVar: Audit_Element
{
    var questVarRandomID : String!
    var answers : [String] = []
    var weights : [Int] = []
    
    var auditToggButtons : [myBtnTogg] = []
}
