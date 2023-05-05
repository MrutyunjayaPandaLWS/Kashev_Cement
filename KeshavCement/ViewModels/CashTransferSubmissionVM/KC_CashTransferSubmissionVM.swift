//
//  KC_CashTransferSubmissionVM.swift
//  KeshavCement
//
//  Created by ADMIN on 27/02/2023.
//

import UIKit
import LanguageManager_iOS
class KC_CashTransferSubmissionVM{
    
    weak var VC: KC_CashTranferPopUpVC?
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
    func myAccountDetailsApi(){
        self.VC?.startLoading()
        let parameters = [
            "ActionType": "6",
            "CustomerId": "\(self.VC!.userID)"
        ]  as [String : Any]
        print(parameters)
        
        self.requestAPIs.myProfile(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        
                        let customerDetails = result?.lstCustomerJson ?? []
                        
                        if customerDetails.count != 0{
                            if customerDetails[0].customerId ?? 0 == 0{
                                DispatchQueue.main.async{
                                    self.VC!.view.makeToast("Currentlycontactadministrator".localiz(), duration: 2.0, position: .bottom)
                                }
                            }else{
//                            self.VC?.addressTextView.text = "\(result?.lstCustomerJson?[0].address1 ?? "-"),\n\(result?.lstCustomerJson?[0].districtName ?? "-"),\n\(result?.lstCustomerJson?[0].stateName ?? "-"),\n \("India -")\(result?.lstCustomerJson?[0].zip ?? "-")\n\("PH")- \(result?.lstCustomerJson?[0].mobile ?? "-")\n\("Email")- \(result?.lstCustomerJson?[0].email ?? "-")"
                            self.VC?.stateID = result?.lstCustomerJson?[0].stateId ?? -1
                            self.VC?.mobile = result?.lstCustomerJson?[0].mobile ?? ""
                            self.VC?.address1 = result?.lstCustomerJson?[0].address1 ?? "-"
                            self.VC?.stateName = result?.lstCustomerJson?[0].stateName ?? "-"
                            self.VC?.districtID = result?.lstCustomerJson?[0].districtId ?? -1
                                self.VC?.districtName = result?.lstCustomerJson?[0].districtName ?? ""
                            self.VC?.cityID = result?.lstCustomerJson?[0].cityId ?? -1
                            self.VC?.cityName = result?.lstCustomerJson?[0].cityName ?? "-"
                            self.VC?.pincode = result?.lstCustomerJson?[0].zip ?? ""
                            self.VC?.countryID = result?.lstCustomerJson?[0].countryId ?? -1
                            self.VC?.countryName = result?.lstCustomerJson?[0].countryName ?? "-"
                            self.VC?.customerName = result?.lstCustomerJson?[0].firstName ?? "-"
                            self.VC?.emailId = result?.lstCustomerJson?[0].email ?? "-"
                                
                                print(self.VC?.stateID)
                                print(self.VC?.mobile)
                                print(self.VC?.address1)
                                print(self.VC?.stateName)
                                print(self.VC?.cityID)
                                print(self.VC?.cityName)
                                print(self.VC?.pincode)
                                print(self.VC?.customerName)
                                print(self.VC?.emailId)
                                
                                
                           // self.VC?.redeemButton.isHidden = false
                            }}else{
                          //  self.VC?.redeemButton.isHidden = true
                        }
                    }
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
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
    func cashSubmissionApi(parameter: JSON){
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        self.requestAPIs.cashTransferSubmissionApi(parameters: parameter) { (result, error) in
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
                                self.timer.invalidate()
                                self.VC!.cashTransferView.isHidden = true
                                self.VC!.cashTransferOtpView.isHidden = true
                                self.VC!.cashTransferSuccessPopUp.isHidden = false
                            }
                        }else{
                            self.VC!.cashTransferView.isHidden = true
                            self.VC!.cashTransferOtpView.isHidden = true
                            self.VC!.cashTransferSuccessPopUp.isHidden = true
                            self.VC!.dismiss(animated: true)
                            self.VC!.view.makeToast("SomethingwentwrongTryagainLater!".localiz(), duration: 2.0, position: .bottom)
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
    
    }
