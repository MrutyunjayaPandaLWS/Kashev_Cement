//
//  KC_PendingClaimListVm.swift
//  KeshavCement
//
//  Created by ADMIN on 27/02/2023.
//

import UIKit
import LanguageManager_iOS
class KC_PendingClaimListVM{
    
    weak var VC: KC_PendingClaimVC?
    var requestAPIs = RestAPI_Requests()
    var count = 0
    var redemptionRefId = 0
    var timer = Timer()
    var OTPforVerification = ""
    
    var pendingClaimListArray = [LstTransactionApprovalDetails2]()
    func pendinClaimListRequest(parameter: JSON){
        
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        
        self.requestAPIs.pendingClaimListApi(parameters: parameter) { (result, error) in
            
            if result == nil{
                
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
            }else{
                if error == nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        let enrollmenteLists = result?.lstTransactionApprovalDetails ?? []
                        
                        if enrollmenteLists.isEmpty == false{
                            
                            self.pendingClaimListArray.removeAll()
//
                            self.pendingClaimListArray += enrollmenteLists
                           
                            print(self.pendingClaimListArray.count, "mappedCustomerListArray Count")
                            self.VC!.noofelements = self.pendingClaimListArray.count + self.VC!.claimPurchaseListArray.count
                            print(self.VC!.noofelements, "No Of Elements")
                            for data in self.pendingClaimListArray{
                                let pendingClaimList = PendingClaimPurcase(context: Persistanceservice.context)
                                pendingClaimList.locationName = data.locationName ?? ""
                                pendingClaimList.memberName = data.memberName ?? ""
                                pendingClaimList.memberType = data.memberType ?? ""
                                pendingClaimList.productName = data.prodName ?? ""
                                pendingClaimList.quantity = "\(Int(data.quantity!))"
                                pendingClaimList.transactionDate = data.tranDate ?? ""
                                pendingClaimList.temperId = "\(data.ltyTranTempID ?? 0)"
                                pendingClaimList.productImage = data.productImage
                                pendingClaimList.productCode = data.prodCode
                                pendingClaimList.invoiceNo = data.invoiceNo ?? "-"
                                Persistanceservice.saveContext()
                                self.VC!.fetchCartDetails()
                            }
                            
                            self.VC?.stopLoading()
                            
                        }else{
                            if self.VC!.startIndex > 1{
                                self.VC?.startIndex = 1
                                self.VC?.noofelements = 9
                            }else{
                                self.VC?.pendingClaimTableView.isHidden = true
                                self.VC?.noDataFoundLbl.isHidden = false
                                self.VC?.noDataFoundLbl.textColor = .white
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
                            self.VC!.successPopupView.isHidden = true
                            self.VC!.otpPopUpView.isHidden = true
//                            self.VC!.qtyTF.text = "0"
//                            self.VC?.quantity = 0
//                            self.VC?.count = 0
//                            self.VC?.selectTypeLbl.text = "Select Type"
//                            self.VC?.searchTF.placeholder = "Search"
//                            self.VC?.searchTF.text = ""
//                            self.VC?.pleaseSelectProductLbl.text = "Please select product"
//                            self.VC?.mappedUserId = -1
//                            self.VC?.selectedProductId = -1
////                            self.VC!.successPopUpView.isHidden = true
//                            self.VC!.otpPopUpView.isHidden = true
                            self.VC!.view.makeToast("Insufficientquantity".localiz(), duration: 3.0, position: .bottom)
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
    
    func pendingClaimSubmission(parameter: JSON){
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        self.requestAPIs.pendingClaimSubmissionApi(parameters: parameter) { (result, error) in
            
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC!.stopLoading()
                        print(result?.returnMessage ?? "", "Response")
                        if result?.returnMessage ?? "-1" == "1"{
                            if self.VC!.approvedStatus == "1"{
                                self.VC!.successMessageLbl.text = "Yourclaimhasbeenapproved".localiz()
                            }else{
                                self.VC!.successMessageLbl.text = "Yourclaimhasbeenrejected".localiz()
                            }
                            
                            self.VC!.successPopupView.isHidden = false
                            self.VC!.otpPopUpView.isHidden = true
                        }else{
                            self.VC!.view.makeToast("Submissionfailed".localiz(), duration: 2.0, position: .bottom)
                        }
                    }
                }else{
                    DispatchQueue.main.async {
                        print(result)
                        self.VC!.stopLoading()
                    }
                }
            }else{
                DispatchQueue.main.async {
                    print(error)
                    self.VC!.stopLoading()
                }
            }
        }
        
    }
    
 }
