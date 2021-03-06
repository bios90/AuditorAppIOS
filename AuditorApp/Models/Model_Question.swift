//
//  Model_Question.swift
//  AuditorApp
//
//  Created by Филипп Бесядовский on 26.06.2018.
//  Copyright © 2018 dimFcompany. All rights reserved.
//

import UIKit

class Model_Question: Audit_Element
{
    var questionRandomID : String!
    var questionType : Int!
    var weight : Int!
    
    var answerVariants : [String] = []
    var plusMinus : [Int] = []
    
    var auditButtons : [myBtnTogg] = []
    
    var addedImages : [UIImage] = []
    
    var photoView : myAuditView!
    var commentView : myAuditView!
    
    var commentStr : String!
    
    var isFatal : Int!
}
