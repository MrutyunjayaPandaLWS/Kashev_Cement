//
//  MyPurchaseClaimListVM.swift
//  KeshavCement
//
//  Created by ADMIN on 21/02/2023.
//

import Foundation


class MyPurchaseClaimListVM{
    
    weak var VC: KC_MyPurchaseClaimVC?
    var requestAPIs = RestAPI_Requests()
    
    var myPurchaseListArray = [CustomerBasicInfoListJson]()
    
    
    func myPurchaseClaimListApi(parameter: JSON){
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        
        self.requestAPIs.myClaimPurchaseListApi(parameters: parameter) { (result, error) in
            
            if result == nil{
                DispatchQueue.main.async {
                    self.myPurchaseListArray.removeAll()
                    self.VC?.purchaseClaimTableView.isHidden = true
                    self.VC?.noDataFoundLbl.isHidden = false
                    self.VC?.noDataFoundLbl.textColor = .white
                    self.VC?.stopLoading()
                }
            }else{
                if error == nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        let myPurchaseListsArray = result?.customerBasicInfoListJson ?? []
                        print(myPurchaseListsArray.count, "asdfljasdklfjadslfjkladsfsajlfljkdsfasljdf")
                        if myPurchaseListsArray.isEmpty == false{
                            self.myPurchaseListArray += myPurchaseListsArray
                            self.VC?.noofelements = self.myPurchaseListArray.count
                            print(self.myPurchaseListArray.count, "Attributes Count")
                            self.VC?.stopLoading()
                            if self.myPurchaseListArray.count != 0 {
                                self.VC?.purchaseClaimTableView.isHidden = false
                                self.VC?.noDataFoundLbl.isHidden = true
                                self.VC?.purchaseClaimTableView.reloadData()
                            }else{
                                self.VC?.purchaseClaimTableView.isHidden = true
                                self.VC?.noDataFoundLbl.isHidden = false
                                self.VC?.noDataFoundLbl.textColor = .white
                            }
                        }else{
                            if self.VC!.startIndex > 1{
                                self.VC?.startIndex = 1
                                self.VC?.noofelements = 9
                            }else{
                                self.VC?.purchaseClaimTableView.isHidden = true
                                self.VC?.noDataFoundLbl.isHidden = false
                                self.VC?.noDataFoundLbl.textColor = .white
                            }
                        }
                    }
                }else{
                    DispatchQueue.main.async {
                        print(error)
                        self.VC?.purchaseClaimTableView.isHidden = true
                        self.VC?.noDataFoundLbl.isHidden = false
                        self.VC?.noDataFoundLbl.textColor = .white
                        self.VC?.stopLoading()
                    }
                }
            }
        }
        
    }
    
 }
