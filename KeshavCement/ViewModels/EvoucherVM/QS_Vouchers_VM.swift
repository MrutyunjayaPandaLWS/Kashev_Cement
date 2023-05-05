//
//  QS_Vouchers_VM.swift
//  Quba Safalta
//
//  Created by Arokia-M3 on 11/03/21.
//

import UIKit
import LanguageManager_iOS

class QS_Vouchers_VM{
    
    weak var VC:QS_MyVouchers_VC?
    var requestAPIs = RestAPI_Requests()
    var count = 0
    var redemptionRefId = 0
    var timer = Timer()
    var OTPforVerification = ""
    var myvouchersArray = [ObjCatalogueList2]()
    
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
                        self.VC?.otpPopUpView.isHidden = false
                        self.VC?.successPopupView.isHidden = true
                       
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

    
    func myVouchersAPI(userID:String){
        self.myvouchersArray.removeAll()
        DispatchQueue.main.async {
            self.VC!.startLoading()
        }
        var parametersJSON = [
            "ActionType":"6",
            "ActorId":"\(userID)",
            "ObjCatalogueDetails":
                [
                    "CatalogueType":"4",
                    "MerchantId":"1"
                ]
        ] as [String:Any]
        
        print(parametersJSON)
        self.requestAPIs.evoucherListApi(parameters: parametersJSON) { (result, error) in
            if error == nil{
                    self.myvouchersArray = (result?.objCatalogueList)!
                DispatchQueue.main.async {
                    self.VC!.myVouchersTableview.reloadData()
                    self.VC!.stopLoading()
                }
            }else{
                print(error)
                DispatchQueue.main.async {
                    self.VC!.stopLoading()
                }
                
            }
        }
    }
    func voucherSubmission(ReceiverMobile:String,ActorId:String,CountryID:Int,MerchantId:Int,CatalogueId:Int,DeliveryType:String,pointsrequired:String,ProductCode:String,ProductImage:String,ProductName:String,NoOfQuantity:String,VendorId:Int,VendorName:String,ReceiverEmail:String,ReceiverName:String){
        
        self.VC?.startLoading()
        let parameterJSON = [
            "ActionType": "51",
            "ActorId": ActorId,
            "CountryID": CountryID,
            "MerchantId": MerchantId,
            "ObjCatalogueList": [
                [
                    "CatalogueId": CatalogueId,
                    "CountryCurrencyCode": "",
                    "DeliveryType": DeliveryType,
                    "HasPartialPayment": false,
                    "NoOfPointsDebit": pointsrequired,
                    "PointsRequired": pointsrequired,
                    "ProductCode": ProductCode,
                    "ProductImage": ProductImage,
                    "ProductName": ProductName,
                    "RedemptionId": 0,
                    "RedemptionTypeId": 4,
                    "NoOfQuantity": NoOfQuantity,
                    "Status": 0,
                    "VendorId": VendorId,
                    "VendorName": VendorName
                ]
            ],
            "ReceiverEmail": ReceiverEmail,
            "ReceiverName": ReceiverName,
            "ReceiverMobile": ReceiverMobile,
            "SourceMode": "5"
        ] as [String:Any]
        print(parameterJSON)
        self.requestAPIs.voucherSubmission_Post_API(parameters: parameterJSON) { (result, error) in
            if error == nil {
                if result != nil{
                    DispatchQueue.main.async {
                        print(result?.returnMessage ?? "")
                        let message = result?.returnMessage ?? ""
                        let separatedmessage = message.split(separator: "-")
                        if separatedmessage[1] == "0"{
                            let alertController = UIAlertController(title: "Oops".localiz(), message: "Youdonsufficientvoucher".localiz(), preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "OK".localiz(), style: UIAlertAction.Style.default) {
                                   UIAlertAction in
                                self.VC!.navigationController?.popViewController(animated: true)
                               }
                               alertController.addAction(okAction)
                            self.VC!.present(alertController, animated: true, completion: nil)
                        }else if separatedmessage[1] == "00"{
                            let alertController = UIAlertController(title: "Oops".localiz(), message: "MemberisdeActivated".localiz(), preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "OK".localiz(), style: UIAlertAction.Style.default) {
                                   UIAlertAction in
                                self.VC!.navigationController?.popViewController(animated: true)
                               }
                               alertController.addAction(okAction)
                            self.VC!.present(alertController, animated: true, completion: nil)
                        }else if separatedmessage[1] == "000"{
                            let alertController = UIAlertController(title: "Oops".localiz(), message: "Unfortunately_your_redemption_has_not_been_completed".localiz(), preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "OK".localiz(), style: UIAlertAction.Style.default) {
                                   UIAlertAction in
                                self.VC!.navigationController?.popViewController(animated: true)
                               }
                               alertController.addAction(okAction)
                            self.VC!.present(alertController, animated: true, completion: nil)
                        }else{
//                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "QS_SuccessTransfer_VC") as? QS_SuccessTransfer_VC
//                            vc?.isComeFrom = "VoucherSuccess"
//                            vc!.modalPresentationStyle = .overCurrentContext
//                            vc!.modalTransitionStyle = .crossDissolve
//                            self.VC?.present(vc!, animated: true, completion: nil)
                            self.VC?.successPopupView.isHidden = false
                            
                        }
                        
                        self.VC?.stopLoading()
                    }
                }else{
                    print("NO RESPONSE")
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                    }
                }
            }else{
                print("ERROR_GOODPACK \(error)")
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
                



            }
        }
    }
    
}
