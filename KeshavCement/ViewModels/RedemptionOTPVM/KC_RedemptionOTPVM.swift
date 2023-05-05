//
//  KC_RedemptionOTPVM.swift
//  KeshavCement
//
//  Created by ADMIN on 24/02/2023.
//

import LanguageManager_iOS
import UIKit
class KC_RedemptionOTPVM{
    
    weak var VC: KC_EvoucherPopUpVC?
    var requestAPIs = RestAPI_Requests()
    var myCartListArray = [CatalogueSaveCartDetailListResponse]()
    var sumOfProductsCount = 0
    var parameters : JSON?
    var count = 0
    var redemptionRefId = 0
    var timer = Timer()
    var OTPforVerification = ""
    var newproductArray: [[String:Any]] = []
    var sendSMArray: [[String:Any]] = []
    
    func checkUserStatusApi(parameter: JSON){
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        self.requestAPIs.userStatusApi(parameters: parameter) { (result, error) in
            if result == nil{
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                   
                }
            }else{
                if error == nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        if result?.isActive! == true{
                            if self.VC?.customerTypeId ?? "" == "3" && self.VC?.partyLoyaltyId != "" || self.VC?.customerTypeId ?? "" == "4" && self.VC?.partyLoyaltyId != ""{
                               
                                self.getMycartList(PartyLoyaltyID: self.VC!.loyaltyID, LoyaltyID: self.VC!.partyLoyaltyId)
                            }else if self.VC?.customerTypeId ?? "" == "3" && self.VC?.partyLoyaltyId == "" || self.VC?.customerTypeId ?? "" == "4" && self.VC?.partyLoyaltyId == ""{
                                self.getMycartList(PartyLoyaltyID: "", LoyaltyID: self.VC!.loyaltyId)
                            }else{
                                    self.getMycartList(PartyLoyaltyID: "", LoyaltyID: self.VC!.loyaltyId)
                                }
                            if self.VC!.partyLoyaltyId == ""{
                                self.VC?.generateOTPApi(loyaltyId: self.VC!.loyaltyID)
                            }else{
                                self.VC?.generateOTPApi(loyaltyId: self.VC!.partyLoyaltyId)
                            }
                            
                        }else{
                            self.VC!.view.makeToast("Userisnactive".localiz(), duration: 2.0, position: .bottom)
                        }
                       
                    }
                }else{
                    DispatchQueue.main.async {
                        print(error)
                        self.VC?.stopLoading()
                    }
                }
            }
        }
    }
    
    func getMycartList(PartyLoyaltyID: String, LoyaltyID: String){
        self.VC?.startLoading()
        let parameters = [
            "ActionType": "2",
            "LoyaltyID": LoyaltyID,
             "Domain": "KESHAV_CEMENT",
            "PartyLoyaltyID": PartyLoyaltyID
        ] as [String : Any]
        print(parameters)
        self.requestAPIs.productMyCartListApi(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        self.myCartListArray = result?.catalogueSaveCartDetailListResponse ?? []
                        self.newproductArray.removeAll()
                        self.sendSMArray.removeAll()
                        let yesterday = "\(Calendar.current.date(byAdding: .day, value: 0, to: Date())!)"
                        let today = yesterday.split(separator: " ")
                        let desiredDateFormat = self.VC!.convertDateFormater("\(today[0])", fromDate: "yyyy-MM-dd", toDate: "yyyy-MM-dd")
                       print("\(desiredDateFormat)")
                        for item in self.myCartListArray {
                            let createdDate = String(item.createdDate ?? "").split(separator: " ")
                            
                            let singleImageDict:[String:Any] = [
                                    "CatalogueId": item.catalogueId ?? 0,
                                    "DeliveryType": "In Store",
                                    "HasPartialPayment": false,
                                    "NoOfPointsDebit": "\(item.pointsRequired ?? 0)",
                                    "NoOfQuantity": item.noOfQuantity ?? 0,
                                    "PointsRequired": "\(item.pointsRequired ?? 0)",
                                    "ProductCode": "\(item.productCode ?? "")",
                                    "ProductImage": "\(item.productImage ?? "")",
                                    "ProductName": "\(item.productName ?? "")",
                                    "RedemptionDate": "\(desiredDateFormat)",
                                    "RedemptionId": item.redemptionId ?? 0,
                                    "RedemptionTypeId": 1,
                                    "Status": item.status ?? 0,
                                    "CatogoryId": item.categoryID ?? 0,
                                    "CustomerCartId": item.customerCartId ?? 0,
                                    "TermsCondition": "\(item.termsCondition ?? "")",
                                    "TotalCash": item.totalCash ?? 0,
                                    "VendorId": item.vendorId ?? 0
                                ]
                                print(singleImageDict)
                                self.newproductArray.append(singleImageDict)
                                
                                let smsArray:[String:Any] = [
                                    "CatalogueId": item.catalogueId ?? 0,
                                    "DeliveryType": "In Store",
                                    "HasPartialPayment": false,
                                    "NoOfPointsDebit": "\(item.pointsRequired ?? 0)",
                                    "NoOfQuantity": item.noOfQuantity ?? 0,
                                    "PointsRequired": "\(item.pointsRequired ?? 0)",
                                    "ProductCode": "\(item.productCode ?? "")",
                                    "ProductImage": "\(item.productImage ?? "")",
                                    "ProductName": "\(item.productName ?? "")",
                                    "RedemptionDate": "\(desiredDateFormat)",
                                    "RedemptionId": item.redemptionId ?? 0,
                                    "RedemptionRefno": "\(self.redemptionRefId)",
                                    "RedemptionTypeId": 1,
                                    "Status": item.status ?? 0,
                                    "TermsCondition": "\(item.termsCondition ?? "")",
                                    "TotalCash": item.totalCash ?? 0,
                                    "VendorId": item.vendorId ?? 0
                                    ]
                                print(smsArray, "SMS Array")
                                print(self.redemptionRefId, "Refer ID")
                                self.sendSMArray.append(smsArray)
                            
                            
                        }
                        
                        
                }

                }else{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                    }
                }
            }else{
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
            }
        }
    }
    
    func redemptionSubmissionApi(parameter: JSON){
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        self.requestAPIs.redemptionSubmissionApi(parameters: parameter) { (result, error) in
            if result == nil{
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                  
                }
            }else{
                if error == nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        print(result?.returnMessage ?? "", "Redemption Submission")
                        print(result?.returnValue ?? "", "ReturnValue")
                        let message = result?.returnMessage ?? ""
                        print(message)
                        
                        let seperateMessage = message.split(separator: "-")
                        print(seperateMessage.count, "Akjdslafjasjefjklsdaljkfsdljfljdaf")
                        if seperateMessage.count > 1 {
                            print(seperateMessage[0])
                            print(seperateMessage[1])
                            print(seperateMessage[2])
                            if seperateMessage[1] >= "1" {
                                print("Success")
                                self.redemptionRefId = Int(result?.returnMessage ?? "") ?? 0

                                
                                if self.VC?.customerTypeId ?? "" == "3" && self.VC?.partyLoyaltyId != "" || self.VC?.customerTypeId ?? "" == "4" && self.VC?.partyLoyaltyId != ""{
                                   
                                    self.getMycartList(PartyLoyaltyID: self.VC!.loyaltyID, LoyaltyID: self.VC!.partyLoyaltyId)
                                }else if self.VC?.customerTypeId ?? "" == "3" && self.VC?.partyLoyaltyId == "" || self.VC?.customerTypeId ?? "" == "4" && self.VC?.partyLoyaltyId == ""{
                                    self.getMycartList(PartyLoyaltyID: "", LoyaltyID: self.VC!.loyaltyID)
                                }else{
                                        self.getMycartList(PartyLoyaltyID: "", LoyaltyID: self.VC!.loyaltyID)
                                    }
                                if self.VC?.contractorName != ""{
                                    self.VC?.removeDreamGift()
                                }
                                
                                if self.VC?.partyLoyaltyId == ""{
                                    self.VC!.sendSuccessMessage(loyaltyId: self.VC!.loyaltyID)
                                }else{
                                    self.VC!.sendSuccessMessage(loyaltyId: self.VC!.partyLoyaltyId)
                                }
                            }
                        }else{
                            DispatchQueue.main.async {
                                print(error)
                                self.VC?.stopLoading()
                                if self.VC?.itsComeFrom == "REDEMPTIONSUBMISSION"{
                                    self.VC?.popUpTitleText.text = "Failed".localiz()
                                    self.VC?.popUpInfoText.text = "SomethingwentwrongTryagainLater!".localiz()
                                    self.VC!.successPopUpView.isHidden = false
                                }
                            }
                        }
                       
                    }
                }else{
                    DispatchQueue.main.async {
                        print(error)
                        self.VC?.stopLoading()
                    }
                }
            }
        }
    }
    
    func sendSMSApi(parameter: JSON){
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
     
            let url = URL(string: sendSMSToUserURL)!
            let session = URLSession.shared
            var request = URLRequest(url: url)
            request.httpMethod = "POST"

            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameter, options: .prettyPrinted)
            } catch let error {
                print(error.localizedDescription)
            }
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("Bearer \(UserDefaults.standard.string(forKey: "TOKEN") ?? "")", forHTTPHeaderField: "Authorization")

            let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

                guard error == nil else {
                    return
                }
                guard let data = data else {
                    return
                }
                do{
                    let str = String(decoding: data, as: UTF8.self) as String?
                     print(str, "- response")
                    if str ?? "" == "true"{
                        DispatchQueue.main.async {
                            self.VC?.stopLoading()
                            self.VC!.successPopUpView.isHidden = false
//                            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_ForgetPwdSuccessVC") as! KC_ForgetPwdSuccessVC
//                            vc.itsComeFrom = "REDEMPTIONSUBMISSION"
//                            vc.modalTransitionStyle = .coverVertical
//                            vc.modalPresentationStyle = .overFullScreen
//                            self.VC!.present(vc, animated: true)
                            }
                    }else{
                        DispatchQueue.main.async{
                            self.VC?.stopLoading()
                            self.VC!.view.makeToast("RedemptionFailed!".localiz(), duration: 2.0, position: .bottom)
                        }
                    }
                     }catch{
                         DispatchQueue.main.async{
                             self.VC?.stopLoading()
                             print("parsing Error")
                         }
                }
            })
            task.resume()
        }
    func getOTPApi(parameter: JSON){
        DispatchQueue.main.async {
            self.count = 60
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
            self.VC?.startLoading()
        }
        
        self.requestAPIs.otp_Post_API(parameters: parameter) { (result, error) in
            
            if result == nil{
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
            }else{
                if error == nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        self.VC?.receivedOTP = result?.returnMessage ?? ""
                        print(result?.returnMessage ?? "", "-OTP")
                        self.VC?.receivedOTP = "123456"
                       
                    }
                }else{
                    DispatchQueue.main.async {
                        print(error)
                        self.VC?.stopLoading()
                    }
                }
            }
        }
    }
    
    @objc func update() {
        if(count > 1) {
            count = count - 1
            self.VC?.otpValueLbl.text = "Seconds Remaining : 0:\(count - 1)"
            self.VC?.resendOTPBtn.isHidden = true
            
        }else{
            self.VC?.resendOTPBtn.isHidden = false
            self.timer.invalidate()
        }
    }
    

    func removeDreamGift(parameters: JSON, completion: @escaping (RemoveGiftModels?) -> ()){
           DispatchQueue.main.async {
                 self.VC?.startLoading()
   //              self.VC?.loaderView.isHidden = false
   //              self.VC?.playAnimation()
            }
           self.requestAPIs.removeDreamGifts(parameters: parameters) { (result, error) in
               if error == nil{
                   if result != nil {
                       DispatchQueue.main.async {
                           completion(result)
                           //self.VC?.loaderView.isHidden = true
                           self.VC?.stopLoading()
                       }
                   } else {
                       print("No Response")
                       DispatchQueue.main.async {
                          // self.VC?.loaderView.isHidden = true
                           self.VC?.stopLoading()
                       }
                   }
               }else{
                   print("ERROR_Login \(error)")
                   DispatchQueue.main.async {
                      // self.VC?.loaderView.isHidden = true
                       self.VC?.stopLoading()
                   }

           }
       }
       
       }
    
    
}
