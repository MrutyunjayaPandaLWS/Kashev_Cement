//
//  KC_MappedCustomerListVM.swift
//  KeshavCement
//
//  Created by ADMIN on 25/02/2023.
//

import Foundation

class KC_MappedCustomerListVM{
    
    weak var VC: KC_MappedCustomerListVC?
    var requestAPIs = RestAPI_Requests()
    
    var mappedCustomerListArray = [LstCustParentChildMapping3]()
    func mappedCustomerListApi(parameter: JSON){
        
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        
        self.requestAPIs.mappedCustomerListApi(parameters: parameter) { (result, error) in
            
            if result == nil{
                
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
            }else{
                if error == nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        let enrollmenteLists = result?.lstCustParentChildMapping ?? []
                        
                        if enrollmenteLists.isEmpty == false{
                            self.mappedCustomerListArray += enrollmenteLists
                            self.VC?.noofelements = self.mappedCustomerListArray.count
                            print(self.mappedCustomerListArray.count, "mappedCustomerListArray Count")
                            self.VC?.stopLoading()
                            if self.mappedCustomerListArray.count != 0 {
                                self.VC?.enrollmentListTableView.isHidden = false
                                self.VC?.noDataFoundLbl.isHidden = true
                                self.VC?.enrollmentListTableView.reloadData()
                            }else{
                                self.VC?.enrollmentListTableView.isHidden = true
                                self.VC?.noDataFoundLbl.isHidden = false
                                self.VC?.noDataFoundLbl.textColor = .white
                            }
                        }else{
                            if self.VC!.startIndex > 1{
                                self.VC?.startIndex = 1
                                self.VC?.noofelements = 9
                            }else{
                                self.VC?.enrollmentListTableView.isHidden = true
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
