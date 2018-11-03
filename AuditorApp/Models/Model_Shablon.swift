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
    
    var obyazNum : Int = 0
    
    var weightSum : Int = 0
    var weightGet : Int = 0
    var weightPercent : Int = 0
    
    var failed = false;
    
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
