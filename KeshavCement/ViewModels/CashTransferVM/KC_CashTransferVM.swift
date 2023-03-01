//
//  KC_CashTransferVM.swift
//  KeshavCement
//
//  Created by ADMIN on 27/02/2023.
//

import Foundation

class KC_CashTransferVM{
    
    weak var VC: KC_CashTransferVC?
    var requestAPIs = RestAPI_Requests()
    
    var cashTransferListArray = [ObjCatalogueList31]()
    
    
    func cashTransferListApi(parameter: JSON){
        
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        
        self.requestAPIs.cashTransferListApi(parameters: parameter) { (result, error) in
            
            if result == nil{
                
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
            }else{
                if error == nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        let enrollmenteLists = result?.objCatalogueList ?? []
                        
                        if enrollmenteLists.isEmpty == false{
                            self.cashTransferListArray += enrollmenteLists
                            self.VC?.noofelements = self.cashTransferListArray.count
                            print(self.cashTransferListArray.count, "cashTransferListArray Count")
                            self.VC?.stopLoading()
                            if self.cashTransferListArray.count != 0 {
                                self.VC?.cashTransferTableView.isHidden = false
                                self.VC?.noDataFoundLbl.isHidden = true
                                self.VC?.cashTransferTableView.reloadData()
                            }else{
                                self.VC?.cashTransferTableView.isHidden = true
                                self.VC?.noDataFoundLbl.isHidden = false
                                self.VC?.noDataFoundLbl.textColor = .white
                            }
                        }else{
                            if self.VC!.startIndex > 1{
                                self.VC?.startIndex = 1
                                self.VC?.noofelements = 9
                            }else{
                                self.VC?.cashTransferTableView.isHidden = true
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
