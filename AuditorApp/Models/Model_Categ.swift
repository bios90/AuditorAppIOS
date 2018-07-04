//
//  Model_Categ.swift
//  AuditorApp
//
//  Created by Филипп Бесядовский on 26.06.2018.
//  Copyright © 2018 dimFcompany. All rights reserved.
//

import UIKit

class Model_Categ: NSObject
{
    var name : String!
    var categPosition : Int!
    var fbId : String!
    var shabName : String!
    
    var allElementsInCateg : [Audit_Element] = []
    var allElementsSorted : [Audit_Element] = []
    
    var questions : [Model_Question] = []
    var adresses : [Model_Adress] = []
    var checkBoxes : [Model_CheckBox] = []
    var dates : [Model_Date] = []
    var infos : [Model_Info] = []
    var medias : [Model_Media] = []
    var podpises : [Model_Podpis] = []
    var questVars : [Model_QuestVar] = []
    var seekers : [Model_Seeker] = []
    var textsLarge : [Model_TextLarge] = []
    var textsOneLine : [Model_TextOneLine] = []
    var toggles : [Model_Toggle]  = []
    var timers : [Model_Timer] = []
    
    func sumAllElements()
    {
        self.allElementsInCateg += (self.questions as [Audit_Element])
        self.allElementsInCateg += (self.adresses as [Audit_Element])
        self.allElementsInCateg += (self.checkBoxes as [Audit_Element])
        self.allElementsInCateg += (self.dates as [Audit_Element])
        self.allElementsInCateg += (self.infos as [Audit_Element])
        self.allElementsInCateg += (self.medias as [Audit_Element])
        self.allElementsInCateg += (self.podpises as [Audit_Element])
        self.allElementsInCateg += (self.questVars as [Audit_Element])
        self.allElementsInCateg += (self.seekers as [Audit_Element])
        self.allElementsInCateg += (self.textsLarge as [Audit_Element])
        self.allElementsInCateg += (self.textsOneLine as [Audit_Element])
        self.allElementsInCateg += (self.toggles as [Audit_Element])
        self.allElementsInCateg += (self.timers as [Audit_Element])
    }
    
    func sortElements()
    {
        for a in 0..<allElementsInCateg.count
        {
            self.allElementsSorted.append(Audit_Element())
        }
        
        for element in allElementsInCateg
        {
            let a = element.positionInLa!
            
            self.allElementsSorted.remove(at: a)
            self.allElementsSorted.insert(element, at: a)
        }
    }
    
    
    
    
    
    
    
    
    
}
