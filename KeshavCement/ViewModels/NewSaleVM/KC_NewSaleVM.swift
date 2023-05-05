//
//  KC_NewSaleVM.swift
//  KeshavCement
//
//  Created by ADMIN on 27/02/2023.
//


import UIKit
import LanguageManager_iOS

class KC_NewSaleVM{
    
    weak var VC: KC_NewSaleVC?
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
                        self.VC?.receivedOTP = "123456"
                        print(result?.returnMessage ?? "", "-OTP")
                        self.VC?.successPopUpView.isHidden = true
                        self.VC?.otpPopUpView.isHidden = false
                       
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
    
    
    func checkPointBalanceApi(parameter: JSON){
        
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        
        self.requestAPIs.checkQuantityApi(parameters: parameter) { (result, error) in
            
            if result == nil{
                
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
            }else{
                if error == nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        print(result?.pointsBalance ?? 0, "point Balance")
                        if result?.pointsBalance ?? 0 > 0{
                            self.timer.invalidate()
                            self.VC!.generateOTPApi()
                            
                        }else{
                            self.VC!.qtyTF.text = "0"
                            self.VC?.quantity = 0
                            self.VC?.count = 0
                            self.VC?.selectTypeLbl.text = "SelectType".localiz()
                            self.VC?.searchTF.placeholder = "Search".localiz()
                            self.VC?.searchTF.text = ""
                            self.VC?.pleaseSelectProductLbl.text = "Pleaseselectproduct".localiz()
                            self.VC?.mappedUserId = -1
                            self.VC?.selectedProductId = -1
                            self.VC!.successPopUpView.isHidden = true
                            self.VC!.otpPopUpView.isHidden = true
                            self.VC!.view.makeToast("Insufficientquantity!!".localiz(), duration: 3.0, position: .bottom)
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
    
    func claimPurchaseSubmissionApi(parameter: JSON){
        
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        
        self.requestAPIs.claimPurchaseSubmissionApi(parameters: parameter) { (result, error) in
            
            if result == nil{
                
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
            }else{
                if error == nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        print(result?.returnMessage ?? "", "Claim Purchase submission")
                        if result?.returnMessage ?? "" == "1"{
                            self.VC!.successPopUpView.isHidden = false
                            if self.VC!.itsFrom == "SendOTP"{
                                self.VC!.popUpInfoLbl.text = "Claimissuccessfullycompleted.".localiz()
                            }
                            self.VC!.otpPopUpView.isHidden = true
                            
                        }else if result?.returnMessage ?? "" == "2"{
                            self.VC!.successPopUpView.isHidden = true
                            self.VC!.otpPopUpView.isHidden = true
                            self.VC!.view.makeToast("Insufficientquantity!!".localiz(), duration: 2.0, position: .bottom)
                            
                        }else{
                            self.VC!.successPopUpView.isHidden = true
                            self.VC!.otpPopUpView.isHidden = true
                            self.VC!.view.makeToast("Claimsubmissionfailed!!".localiz(), duration: 2.0, position: .bottom)
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

