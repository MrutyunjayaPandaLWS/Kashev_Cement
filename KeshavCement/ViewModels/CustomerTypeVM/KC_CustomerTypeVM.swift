//
//  KC_CustomerTypeVM.swift
//  KeshavCement
//
//  Created by ADMIN on 09/02/2023.
//

import Foundation

class KC_CustomerTypeVM {
    
    weak var VC: KC_WelcomeVC?
    var requestAPIs = RestAPI_Requests()
    var customerTypeArray = [LstAttributesDetails]()
    
    func customerTypeListApi(parameter: JSON){
        
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        
        self.requestAPIs.getCustomerTypeListApi(parameters: parameter) { (result, error) in
            
            if result == nil{
                
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
            }else{
                if error == nil{
                    DispatchQueue.main.async {
                        self.customerTypeArray = result?.lstAttributesDetails ?? []
                        print(self.customerTypeArray.count, "Attributes Count")
                        self.VC?.stopLoading()
                        if self.customerTypeArray.count != 0 {
                            self.VC?.noDataFoundLbl.isHidden = true
                            self.VC?.customerTypeTableView.isHidden = false
                            self.VC?.customerTypeTableView.reloadData()
                        }else{
                            self.VC?.noDataFoundLbl.isHidden = false
                            self.VC?.customerTypeTableView.isHidden = true
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

