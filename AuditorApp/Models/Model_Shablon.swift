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
    
    
    
}
