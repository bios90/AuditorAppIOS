import UIKit
import Alamofire
import FirebaseAuth

class UploadOthcetClass: NSObject
{
    let gc = GlobalClass.sharedInstance
    let gh = GlobalHelper.sharedInstance
    var parameters : Parameters = [:]
    var otchet : Model_Otchet!
    var logoUrl : String = "Default"
    
    var finVoid : ((String) -> Void)?
    
    func upload( finishedVoid: @escaping (_ answer:String)->())
    {
        otchet = gc.otchetToUpload!
        
        getAllInfo()
        finVoid = finishedVoid
    }
    
    func getAllInfo()
    {
        let shabFbId = otchet.fbId!
        
        GlobalHelper.sharedInstance.dbShablonRef.child(shabFbId).observeSingleEvent(of: .value)
        {
            (snapshot) in
            
            if snapshot.hasChild(FBNames.shIn.SHABLON_LOGO_URL)
            {
                let logo = snapshot.childSnapshot(forPath: FBNames.shIn.SHABLON_LOGO_URL).value as! String
                self.logoUrl = logo
            }
            
//            self.continueUpload()
            self.uploadPdfFile()
        }
    }
    
    
    func uploadPdfFile()
    {
        let fileName = otchet.pdfFileName!
        let fm = FileManager.default
        let docDir = fm.urls(for: .documentDirectory, in: .userDomainMask).first!
        let dataPath = docDir.appendingPathComponent("Otchets")
        let url = URL(fileURLWithPath: dataPath.path).appendingPathComponent("\(fileName).pdf")
        
        SessionManager.default.startRequestsImmediately = true
        
        do
        {
            let pdfData = try Data(contentsOf:url)
            let data : Data = pdfData
            
            print("///////////////Date of Beginnnnnnnnnnn")
            print(NSDate().timeIntervalSince1970 * 1000)
            
            Alamofire.upload(multipartFormData:
                {
                    (multipartFormData) in
                    multipartFormData.append(data as Data , withName: "bill", fileName: "\(fileName).pdf", mimeType: "application/pdf")
            },
                             to: self.gh.URL_TO_UPLOAD_OTHCETS,
                             encodingCompletion:
                {
                    encodingResult in
                    switch encodingResult
                    {
                    case .success(let upload, _, _):
                        
                        upload.uploadProgress
                            {
                                progress in
                                print("///////////\(progress.fractionCompleted)")
                                if(progress.fractionCompleted == 1.0)
                                {
                                    self.uploadToMysql()
//                                    self.upload3()
                                }
                        }
                    case .failure(let encodingError):
                        self.finVoid?("error")
                        print(encodingError)
                    }
            })
        }
        catch
        {
            self.finVoid?("error")
            print("exception in upload otchet class!")
        }
    }
    
    
    func uploadToMysql()
    {
        print("entered upload to MYSQL")
        SessionManager.default.startRequestsImmediately = false
        var requests : [DataRequest]  = []
        
        parameters[gh.uFbId] = otchet.fbId!
        parameters[gh.uLocal_Id] = otchet.Id!
        parameters[gh.uName] = otchet.name!
        parameters[gh.uUser_Id] = gh.currentUser()[2]
        parameters[gh.uRestarauntId] = otchet.restarauntId!
        parameters[gh.uPercent] = otchet.percent!
        parameters[gh.uLogoUrl] = logoUrl
        parameters[gh.uDate] = (gh.dateToInt(date: otchet.date) * 1000)
        print(parameters)
        
        let otchetAddReq = Alamofire.request(self.gh.INSERT_OTCHET_URL, method: .post, parameters: parameters)
        requests.append(otchetAddReq)
        
        for i in 0..<self.otchet.categNames.count
        {
            let params : Parameters =
                [
                    self.gh.uLocal_Id : self.otchet.Id!,
                    self.gh.uName : self.otchet.categNames[i],
                    self.gh.uPercent : self.otchet.catagPercents[i]
                ]
            
            let req = Alamofire.request(self.gh.INSERT_CATEG_URL, method: .post, parameters: params)
            
            requests.append(req)
        }
        
        let chain = RequestChain(requests: requests)
        chain.start
            { (done, error) in
                if error != nil
                {
                    print(error)
                    self.finVoid?("error")
                    return
                }
                self.finVoid?("success")
        }
    }
//    
//    func continueUpload()
//    {
//        parameters[gh.uFbId] = otchet.fbId!
//        parameters[gh.uLocal_Id] = otchet.Id!
//        parameters[gh.uName] = otchet.name!
//        parameters[gh.uUser_Id] = gh.currentUser()[2]
//        parameters[gh.uRestarauntId] = otchet.restarauntId!
//        parameters[gh.uPercent] = otchet.percent!
//        parameters[gh.uLogoUrl] = logoUrl
//        parameters[gh.uDate] = (gh.dateToInt(date: otchet.date) * 1000)
//        
//        Alamofire.request(self.gh.INSERT_OTCHET_URL, method: .post, parameters: parameters)
//        
//        print(parameters)
//        
//
//        let fileName = otchet.pdfFileName!
//        let fm = FileManager.default
//        let docDir = fm.urls(for: .documentDirectory, in: .userDomainMask).first!
//        let dataPath = docDir.appendingPathComponent("Otchets")
//        let url = URL(fileURLWithPath: dataPath.path).appendingPathComponent("\(fileName).pdf")
//        
//
//        
//       
//        
//        
//        do
//        {
//            let pdfData = try Data(contentsOf:url)
//            let data : Data = pdfData
//            
//            print("///////////////Date of Beginnnnnnnnnnn")
//            print(NSDate().timeIntervalSince1970 * 1000)
//            
//            Alamofire.upload(multipartFormData:
//                {
//                    (multipartFormData) in
//                    multipartFormData.append(data as Data , withName: "bill", fileName: "\(fileName).pdf", mimeType: "application/pdf")
//                },
//                to: self.gh.URL_TO_UPLOAD_OTHCETS,
//                encodingCompletion:
//                {
//                    encodingResult in
//                    switch encodingResult
//                    {
//                    case .success(let upload, _, _):
// 
//                    upload.uploadProgress
//                        {
//                        progress in
//                        print("///////////\(progress.fractionCompleted)")
//                            if(progress.fractionCompleted == 1.0)
//                            {
////                                self.upload3()
//                            }
//                        }
//                        case .failure(let encodingError):
//                        print(encodingError)
//                    }
//            })
//
//            
//        }
//            catch
//            {
//                print("exception in upload otchet class!")
//            }
//    }
//            
//    
//            

//            Alamofire.upload(multipartFormData:
//                {
//                    (multipartFormData) in
//                    multipartFormData.append(data as Data , withName: "bill", fileName: "\(fileName).pdf", mimeType: "application/pdf")
//            },to: self.gh.URL_TO_UPLOAD_OTHCETS).uploadProgress
//                {
//                progress in // main queue by default
//                print("Upload Progress: \(progress.fractionCompleted)");
//                }
            
            
            
            
            
            
            
//            Alamofire.upload(multipartFormData:
//                {
//                    (multipartFormData) in
//                    multipartFormData.append(data as Data , withName: "bill", fileName: "\(fileName).pdf", mimeType: "application/pdf")
//                },
//                to: self.gh.URL_TO_UPLOAD_OTHCETS,
//                encodingCompletion:
//                {
//                (resulllllt) in
//                print("got endcompletion will")
//                print("///////////////Date of Finishhhhhhhhhhhghghhghghg")
//                print(NSDate().timeIntervalSince1970 * 1000)
//                self.upload3()
//                });
    
//            let pdfReq = Alamofire.upload(multipartFormData:
//            { (multipartFormData) in
//                 multipartFormData.append(data as Data , withName: "bill", fileName: "\(fileName).pdf", mimeType: "application/pdf")
//            }, to: self.gh.URL_TO_UPLOAD_OTHCETS,encodingCompletion)
//            {
//                (resullllt) in
//                SessionManager.default.startRequestsImmediately = false
//
//                var requests : [DataRequest]  = []
//
//                for i in 0..<self.otchet.categNames.count
//                {
//                    let params : Parameters =
//                        [
//                            self.gh.uLocal_Id : self.otchet.Id!,
//                            self.gh.uName : self.otchet.categNames[i],
//                            self.gh.uPercent : self.otchet.catagPercents[i]
//                    ]
//
//                    let req = Alamofire.request(self.gh.INSERT_CATEG_URL, method: .post, parameters: params)
//
//                    requests.append(req)
//                }
//
//                let chain = RequestChain(requests: requests)
//                chain.start
//                    { (done, error) in
//                        if error != nil
//                        {
//                            print(error)
//                            return
//                        }
//                        self.finVoid?()
//                }
//            }
//            let pdfReq = Alamofire.upload(multipartFormData:
//                {
//                    multipartFormData in
//                    multipartFormData.append(data as Data , withName: "bill", fileName: "\(fileName).pdf", mimeType: "application/pdf")
//                },to:self.gh.URL_TO_UPLOAD_OTHCETS)
//                {
//                    (result) in
//                print(result)
//
//                SessionManager.default.startRequestsImmediately = false
//
//                var requests : [DataRequest]  = []
//
//                for i in 0..<self.otchet.categNames.count
//                {
//                    let params : Parameters =
//                        [
//                            self.gh.uLocal_Id : self.otchet.Id!,
//                            self.gh.uName : self.otchet.categNames[i],
//                            self.gh.uPercent : self.otchet.catagPercents[i]
//                        ]
//
//                    let req = Alamofire.request(self.gh.INSERT_CATEG_URL, method: .post, parameters: params)
//
//                    requests.append(req)
//                }
//
//                let chain = RequestChain(requests: requests)
//                chain.start
//                    { (done, error) in
//                        if error != nil
//                        {
//                            print(error)
//                            return
//                        }
//                        self.finVoid?()
//                }
//            }
//            }
            
            

    
    
//    func upload3()
//    {
//        print("entered upload 3")
//        SessionManager.default.startRequestsImmediately = false
//
//        var requests : [DataRequest]  = []
//
//        for i in 0..<self.otchet.categNames.count
//        {
//            let params : Parameters =
//                [
//                    self.gh.uLocal_Id : self.otchet.Id!,
//                    self.gh.uName : self.otchet.categNames[i],
//                    self.gh.uPercent : self.otchet.catagPercents[i]
//            ]
//
//            let req = Alamofire.request(self.gh.INSERT_CATEG_URL, method: .post, parameters: params)
//
//            requests.append(req)
//        }
//
//        let chain = RequestChain(requests: requests)
//        chain.start
//            { (done, error) in
//                if error != nil
//                {
//                    print(error)
//                    return
//                }
//                self.finVoid?()
//        }
//    }
    
}


