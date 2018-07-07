//
//  Model_Shablon.swift
//  AuditorApp
//
//  Created by Филипп Бесядовский on 25.06.2018.
//  Copyright © 2018 dimFcompany. All rights reserved.
//

import UIKit

class Model_Shablon: NSObject
{
    var fbId : String!
    var name : String!
    var password : String!
    var author : String!
    var place : String!
    var logoUrl : String?
    
    var localImageName : String?
    
    var image : UIImage!
    
    var allCategs : [Model_Categ] = []
    
    var beginTime : String!
    
    func recountScrollSize()
    {
        for categ in allCategs
        {
            var height : CGFloat = 0
            let scroll = categ.categScroll!
            
            for element in categ.allElementsSorted
            {
                if element.auditView != nil
                {
                    element.auditView.layoutIfNeeded()
                    print("open element")
                    height += element.auditView!.frame.size.height+4
                }
            }
            scroll.contentSize.height = height + 4
        }
    }
    
}
