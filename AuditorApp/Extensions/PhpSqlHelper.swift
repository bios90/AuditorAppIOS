import UIKit
import Alamofire
import SwiftyJSON

class PhpSqlHelper: NSObject
{
    let gh = GlobalHelper.sharedInstance
    
    
    func checkIfUploaded(localId: String, completion: @escaping (_ alreadyUploaded : Bool) -> ())
    {
        print("Begin check for upload!")
        SessionManager.default.startRequestsImmediately = true
        var parameters : Parameters!
        parameters  =
            [
                gh.uLocal_Id : localId
            ]
        
        print(parameters)
        
        Alamofire.request(self.gh.GET_OTHCET_BY_ID, method: .post, parameters: parameters).responseString
            { (response) in
                print("Result from check if exists is \(response.result.value!)")
                let str = response.result.value!
                print(str)
                let exists = NSString(string:str).boolValue
                completion(exists)
            }

    }
    
    
    func getAllRestaraunts(completion: @escaping (_ restaraunts : [Model_Restaraunt]) -> ())
    {
        var allRestaraunts : [Model_Restaraunt] = []
        
        Alamofire.request(self.gh.GET_ALL_RESTARAUNTS_URL,method: .get)
            .responseJSON
            {
                (response:DataResponse<Any>) in
                if let value = response.result.value
                {
                    print(value)
                    let json = JSON(value)
                    for object in json.array!
                    {
                        let name = object["Name"].stringValue
                        let adress = object["Adress"].stringValue
                        let id = object["Id"].intValue
                        
                        let restaraunt = Model_Restaraunt()
                        restaraunt.id = id
                        restaraunt.name = name
                        restaraunt.adress = adress
                        
                        allRestaraunts.append(restaraunt)
                    }
                    completion(allRestaraunts)
                }
            }
        
       
        
        
        
        
    }
}

class RequestChain
{
    typealias CompletionHandler = (_ success:Bool, _ errorResult:ErrorResult?) -> Void
    
    struct ErrorResult
    {
        let request:DataRequest?
        let error:Error?
    }
    
    fileprivate var requests:[DataRequest] = []
    
    init(requests:[DataRequest])
    {
        self.requests = requests
    }
    
    func start(_ completionHandler:@escaping CompletionHandler)
    {
        if let request = requests.first
        {
            request.response(completionHandler:
                { (response:DefaultDataResponse) in
                if let error = response.error
                {
                    completionHandler(false, ErrorResult(request: request, error: error))
                    return
                }
                
                print("//////finished one of chain///////////")
                print(response)
                self.requests.removeFirst()
                self.start(completionHandler)
            })
            request.resume()
        }
        else
        {
            completionHandler(true, nil)
            return
        }
        
    }
}
