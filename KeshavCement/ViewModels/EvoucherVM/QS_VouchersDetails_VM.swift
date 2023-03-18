//
//  QS_VouchersDetails_VM.swift
//  HR_Johnson
//
//  Created by ADMIN on 10/05/2022.
//

import UIKit
//import LanguageManager_iOS

class QS_VouchersDetails_VM{
    
    weak var VC:EgiftVoucherDetailsVC?
    var requestAPIs = RestAPI_Requests()
    var count = 0
    var redemptionRefId = 0
    var timer = Timer()
    var OTPforVerification = ""
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
                        "redemptionid": 1,
                        "redemptiontypeid": 4,
                        "noofquantity": 1,
                        "status": 0,
                        "vendorid": VendorId,
                        "vendorname": VendorName
                    ]
                ],
                "receiveremail": ReceiverEmail,
                "ReceiverName": ReceiverName,
                "ReceiverMobile": ReceiverMobile,
                "SourceMode": "3"
        ] as [String:Any]
        print(parameterJSON)

        self.requestAPIs.voucherSubmission_Post_API(parameters: parameterJSON) { (result, error) in
            if error == nil {
                if result != nil{
                    DispatchQueue.main.async {
                        print(result?.returnMessage ?? "")
                        let message = result?.returnMessage ?? ""

                        if message.count != 0 {
                            let separatedmessage = message.split(separator: "-")
                            if separatedmessage[2] == "0"{
                                let alertController = UIAlertController(title: "Oops", message: "You don’t have sufficient point balance to redeem the voucher", preferredStyle: .alert)
                                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                                       UIAlertAction in
                                    self.VC!.navigationController?.popViewController(animated: true)
                                   }
                                   alertController.addAction(okAction)
                                self.VC!.present(alertController, animated: true, completion: nil)
                            }else if separatedmessage[2] == "00"{
                                let alertController = UIAlertController(title: "Oops", message: "member is deActivated", preferredStyle: .alert)
                                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                                       UIAlertAction in
                                    self.VC!.navigationController?.popViewController(animated: true)
                                   }
                                   alertController.addAction(okAction)
                                self.VC!.present(alertController, animated: true, completion: nil)
                            }else if separatedmessage[2] == "000"{
                                let alertController = UIAlertController(title: "Oops", message: "Unfortunately_your_redemption_has_not_been_completed", preferredStyle: .alert)
                                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                                       UIAlertAction in
                                    self.VC!.navigationController?.popViewController(animated: true)
                                   }
                                   alertController.addAction(okAction)
                                self.VC!.present(alertController, animated: true, completion: nil)
                            }else{
                                DispatchQueue.main.async{
                                    self.VC?.successPopupView.isHidden = false
//                                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
//                                    vc!.delegate = self
//                                    vc!.titleInfo = ""
//                                    vc!.isComeFrom = "VoucherSuccess"
//                                    vc!.descriptionInfo = "Thank_you_for_redeeming. The_E-voucher_will_sent_email_id_shortly"
//                                    vc!.modalPresentationStyle = .overFullScreen
//                                    vc!.modalTransitionStyle = .crossDissolve
//                                    self.VC?.present(vc!, animated: true, completion: nil)
                                }

                            }
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
