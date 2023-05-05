//
//  KC_ClaimHistoryVM.swift
//  KeshavCement
//
//  Created by ADMIN on 28/02/2023.
//

import Foundation
import UIKit

class KC_ClaimHistoryVM{
    
    weak var VC: KC_ClaimHistoryVC?
    var requestAPIs = RestAPI_Requests()
    var count = 0
    var redemptionRefId = 0
    var timer = Timer()
    var OTPforVerification = ""

    var claimHistoryListArray = [CustomerBasicInfoListJson8]()
    
    func claimHistoryListApi(parameter: JSON){
        
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }

        self.requestAPIs.claimHistoryListApi(parameters: parameter) { (result, error) in
            if result == nil{
                
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
            }else{
                if error == nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        let enrollmenteLists = result?.customerBasicInfoListJson ?? []
                        
                        if enrollmenteLists.isEmpty == false{
                            self.claimHistoryListArray += enrollmenteLists
                            self.VC?.noofelements = self.claimHistoryListArray.count
                            print(self.claimHistoryListArray.count, "mappedCustomerListArray Count")
                            self.VC?.stopLoading()
                            if self.claimHistoryListArray.count != 0 {
                                self.VC?.claimHistoryTableView.isHidden = false
                                self.VC?.noDataFoundLbl.isHidden = true
                                self.VC?.claimHistoryTableView.reloadData()
                            }else{
                                self.VC?.claimHistoryTableView.isHidden = true
                                self.VC?.noDataFoundLbl.isHidden = false
                                self.VC?.filterButtonView.isHidden = true
                                self.VC?.noDataFoundLbl.textColor = .white
                            }
                        }else{
                            if self.VC!.startIndex > 1{
                                self.VC?.startIndex = 1
                                self.VC?.noofelements = 9
                            }else{
                                self.VC?.claimHistoryTableView.isHidden = true
                                self.VC?.noDataFoundLbl.isHidden = false
                                self.VC?.filterButtonView.isHidden = true
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
