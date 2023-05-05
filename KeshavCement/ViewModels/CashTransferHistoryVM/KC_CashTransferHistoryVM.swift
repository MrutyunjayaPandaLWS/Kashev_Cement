//
//  KC_CashTransferHistoryVM.swift
//  KeshavCement
//
//  Created by ADMIN on 25/03/2023.
//

import UIKit

class KC_CashTransferHistoryVM{
    
    weak var VC: KC_CashTranferHistoryVC?
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

//
                            self.cashTransferApprovalListingArray += enrollmenteLists
                           
                            print(self.cashTransferApprovalListingArray.count, "mappedCustomerListArray Count")
                            self.VC!.noofelements = self.cashTransferApprovalListingArray.count
                            print(self.VC!.noofelements, "No Of Elements")
                            if self.cashTransferApprovalListingArray.count != 0 {
                                self.VC!.cashHistoryTableView.isHidden = false
                                self.VC!.noDataFoundLbl.isHidden = true
                                self.VC!.filterButtonView.isHidden = false
                            }else{
                                self.VC!.cashHistoryTableView.isHidden = true
                                self.VC!.noDataFoundLbl.isHidden = false
                                self.VC!.filterButtonView.isHidden = true
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
                            
                            self.VC?.cashHistoryTableView.reloadData()
                            self.VC?.stopLoading()
                            
                        }else{
                            if self.VC!.startIndex > 1{
                                self.VC?.startIndex = 1
                                self.VC?.noofelements = 9
                            }else{
                                self.VC?.cashHistoryTableView.isHidden = true
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
    
 }

