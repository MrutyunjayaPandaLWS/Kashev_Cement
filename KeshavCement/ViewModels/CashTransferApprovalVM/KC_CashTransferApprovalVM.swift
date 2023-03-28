//
//  KC_CashTransferApprovalVM.swift
//  KeshavCement
//
//  Created by ADMIN on 24/03/2023.
//

import Foundation
import UIKit

class KC_CashTransferApprovalVM{
    
    weak var VC: KC_CashTranferApprovalVC?
    var requestAPIs = RestAPI_Requests()
    var count = 0
    var redemptionRefId = 0
    var timer = Timer()
    var OTPforVerification = ""
    
    var cashTransferApprovalListingArray = [LstCustomerCashTransferedDetails]()
    
    
    func cashTransferApprovalHistoryApi(parameter: JSON){
        
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        
        self.requestAPIs.cashTransferListsApi(parameters: parameter) { (result, error) in
            
            if result == nil{
                
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
            }else{
                if error == nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        let enrollmenteLists = result?.lstCustomerCashTransferedDetails ?? []
                        
                        if enrollmenteLists.isEmpty == false{
                            
                          //  self.cashTransferApprovalListingArray.removeAll()
//
                            self.cashTransferApprovalListingArray += enrollmenteLists
                           
                            print(self.cashTransferApprovalListingArray.count, "mappedCustomerListArray Count")
                            self.VC!.noofelements = self.cashTransferApprovalListingArray.count
                            print(self.VC!.noofelements, "No Of Elements")
                            if self.cashTransferApprovalListingArray.count != 0 {
                                self.VC!.cashTransferApprovalTableView.isHidden = false
                                self.VC!.noDataFoundLbl.isHidden = true
                            }else{
                                self.VC!.cashTransferApprovalTableView.isHidden = true
                                self.VC!.noDataFoundLbl.isHidden = false
                            }
//                            for data in self.pendingClaimListArray{
//                                let pendingClaimList = PendingClaimPurcase(context: Persistanceservice.context)
//                                pendingClaimList.locationName = data.locationName ?? ""
//                                pendingClaimList.memberName = data.memberName ?? ""
//                                pendingClaimList.memberType = data.memberType ?? ""
//                                pendingClaimList.productName = data.prodName ?? ""
//                                pendingClaimList.quantity = "\(Int(data.quantity!))"
//                                pendingClaimList.transactionDate = data.tranDate ?? ""
//                                pendingClaimList.temperId = "\(data.ltyTranTempID ?? 0)"
//                                pendingClaimList.productImage = data.productImage
//                                pendingClaimList.productCode = data.prodCode
//                                pendingClaimList.invoiceNo = data.invoiceNo ?? "-"
//                                Persistanceservice.saveContext()
//                                self.VC!.fetchCartDetails()
//                            }
                            
                            self.VC?.cashTransferApprovalTableView.reloadData()
                            self.VC?.stopLoading()
                            
                        }else{
                            if self.VC!.startIndex > 1{
                                self.VC?.startIndex = 1
                                self.VC?.noofelements = 9
                            }else{
                                self.VC?.cashTransferApprovalTableView.isHidden = true
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
    
    func cashTransferApproveorRejectionSubmissionApi(parameter: JSON){
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        self.requestAPIs.cashTransferApproveOrRejectionSubmissionApi(parameters: parameter) { (result, error) in
            if result == nil{
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
            }else{
                if error == nil{
                    DispatchQueue.main.async {
                        print(error)
                        self.VC?.stopLoading()
                        print(result?.returnValue ?? -1 , "Return Value For ascaoiefjsaklfjdsaf")
                        if result?.returnValue ?? -1 > 0 {
                            self.VC?.otpPopUpView.isHidden = true
                            self.VC?.successPopupView.isHidden = false
                        }else{
                            self.timer.invalidate()
                            self.VC?.otpPopUpView.isHidden = true
                            self.VC?.successPopupView.isHidden = true
                            self.VC?.view.makeToast("Something went wrong! Try again later", duration: 2.0, position: .bottom)
                          //  self.VC!.navigationController?.popViewController(animated: true)
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
                            //self.VC!.generateOTPApi()
                            
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
                            self.VC!.view.makeToast("Insufficient quantity !!", duration: 3.0, position: .bottom)
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
                                self.VC!.successMessageLbl.text = "Your claim has been approved"
                            }else{
                                self.VC!.successMessageLbl.text = "Your claim has been rejected"
                            }
                            
                            self.VC!.successPopupView.isHidden = false
                            self.VC!.otpPopUpView.isHidden = true
                        }else{
                            self.VC!.view.makeToast("Submission failed!!", duration: 2.0, position: .bottom)
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
