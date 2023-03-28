//
//  KC_DropDownVM.swift
//  KeshavCement
//
//  Created by ADMIN on 15/02/2023.
//

import Foundation


class KC_DropDownVM{
    
    weak var VC: KC_DropDownVC?
    var requestAPIs = RestAPI_Requests()
    var customerTypeArray = [LstAttributesDetails]()
    var stateListArray = [StateList]()
    var districtListArray = [LstDistrict]()
    var talukListArray = [LstTaluk]()
    var mappedListArray = [LstCustParentChildMapping2]()
    var mappedListFilterArray = [LstCustParentChildMapping2]()
        
    var cashDetailsListArray = [LstCashTransfer]()
    var cashDetailsFilterListArray = [LstCashTransfer]()
    
    var claimProductListArray = [LstAttributesDetails12]()
    var workLevelListArray = [LstAttributesDetails]()
    var queryTopicListArray = [ObjHelpTopicList]()
    var cityListArray = [CityList]()
    var cityArray = [CityList]()
    
    func citylisting(parameters:JSON){
        self.VC?.startLoading()
        print(parameters)
        self.requestAPIs.city_Post_API(parameters: parameters) { (result, error) in
            if error == nil {
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        self.cityArray = result?.cityList ?? []
                        print(self.cityArray.count, "City Count")
                        self.cityListArray = self.cityArray
                        if self.cityListArray.count != 0 {
                            self.VC?.dropDownTableView.isHidden = false
                            self.VC?.noDataFoundLbl.isHidden = true
                            if self.cityListArray.count <= 20{
                                self.VC!.tableViewHeightConstraint.constant = CGFloat(self.cityListArray.count * 40)
                            }else{
                                self.VC!.tableViewHeightConstraint.constant = CGFloat(500)
                            }
                            self.VC?.dropDownTableView.reloadData()
                        }else{
                            self.VC?.dropDownTableView.isHidden = true
                            self.VC?.noDataFoundLbl.isHidden = false
                        }

                    }
                }else{
                    print("NO RESPONSE")
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                    }
                }
            }else{
                print("ERROR_ \(error)")
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }

            }

        }
    }
    func queryTopicListAPI(parameter: JSON){
        
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }

        self.requestAPIs.queryTopicListApi(parameters: parameter) { (result, error) in
            if result == nil{
                
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
            }else{
                if error == nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        self.queryTopicListArray = result?.objHelpTopicList ?? []
                        if self.queryTopicListArray.count != 0 {
                            self.VC?.dropDownTableView.isHidden = false
                            self.VC?.noDataFoundLbl.isHidden = true
                            if self.queryTopicListArray.count <= 20{
                                self.VC!.tableViewHeightConstraint.constant = CGFloat(self.queryTopicListArray.count * 40)
                            }else{
                                self.VC!.tableViewHeightConstraint.constant = CGFloat(500)
                            }
                            self.VC?.dropDownTableView.reloadData()
                        }else{
                            self.VC?.dropDownTableView.isHidden = true
                            self.VC?.noDataFoundLbl.isHidden = false
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
                            self.VC?.dropDownTableView.isHidden = false
                            self.VC?.noDataFoundLbl.isHidden = true
                            if self.customerTypeArray.count <= 20{
                                self.VC!.tableViewHeightConstraint.constant = CGFloat(self.customerTypeArray.count * 40)
                            }else{
                                self.VC!.tableViewHeightConstraint.constant = CGFloat(500)
                            }
                            self.VC?.dropDownTableView.reloadData()
                        }else{
                            self.VC?.dropDownTableView.isHidden = true
                            self.VC?.noDataFoundLbl.isHidden = false
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
    
    func stateListApi(parameter: JSON){
        
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        
        self.requestAPIs.state_Post_API(parameters: parameter) { (result, error) in
            
            if result == nil{
                
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
            }else{
                if error == nil{
                    DispatchQueue.main.async {
                        self.stateListArray = result?.stateList ?? []
                        print(self.stateListArray.count, "stateListArray Count")
                        
                        self.VC?.stopLoading()
                        if self.stateListArray.count != 0 {
                            self.VC?.dropDownTableView.isHidden = false
                            self.VC?.noDataFoundLbl.isHidden = true
                            if self.stateListArray.count <= 20{
                                self.VC!.tableViewHeightConstraint.constant = CGFloat(self.stateListArray.count * 40)
                            }else{
                                self.VC!.tableViewHeightConstraint.constant = CGFloat(500)
                            }
                            self.VC?.dropDownTableView.reloadData()
                        }else{
                            self.VC?.dropDownTableView.isHidden = true
                            self.VC?.noDataFoundLbl.isHidden = false
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
    
    
    func districtListApi(parameter: JSON){
        
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        
        self.requestAPIs.district_Post_API(parameters: parameter) { (result, error) in
            
            if result == nil{
                
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
            }else{
                if error == nil{
                    DispatchQueue.main.async {
                        self.districtListArray = result?.lstDistrict ?? []
                        print(self.districtListArray.count, "districtListArray Count")
                        
                        self.VC?.stopLoading()
                        if self.districtListArray.count != 0 {
                            self.VC?.dropDownTableView.isHidden = false
                            self.VC?.noDataFoundLbl.isHidden = true
                            if self.districtListArray.count <= 20{
                                self.VC!.tableViewHeightConstraint.constant = CGFloat(self.districtListArray.count * 40)
                            }else{
                                self.VC!.tableViewHeightConstraint.constant = CGFloat(500)
                            }
                            self.VC?.dropDownTableView.reloadData()
                        }else{
                            self.VC?.dropDownTableView.isHidden = true
                            self.VC?.noDataFoundLbl.isHidden = false
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
    
    func talukListApi(parameter: JSON){
        
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        
        self.requestAPIs.taluk_Post_API(parameters: parameter) { (result, error) in
            
            if result == nil{
                
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
            }else{
                if error == nil{
                    DispatchQueue.main.async {
                        self.talukListArray = result?.lstTaluk ?? []
                        print(self.talukListArray.count, "Taluk Count")
                        self.VC?.stopLoading()
                        
                        if self.talukListArray.count != 0 {
                            self.VC?.dropDownTableView.isHidden = false
                            self.VC?.noDataFoundLbl.isHidden = true
                            if self.talukListArray.count <= 20{
                                self.VC!.tableViewHeightConstraint.constant = CGFloat(self.talukListArray.count * 40)
                            }else{
                                self.VC!.tableViewHeightConstraint.constant = CGFloat(500)
                            }
                            self.VC?.dropDownTableView.reloadData()
                        }else{
                            self.VC?.dropDownTableView.isHidden = true
                            self.VC?.noDataFoundLbl.isHidden = false
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
    
    func cashDetailsListApi(parameter: JSON){
        
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        
        self.requestAPIs.cashSubmissionPointsListApi(parameters: parameter) { (result, error) in
            
            if result == nil{
                
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
            }else{
                if error == nil{
                    DispatchQueue.main.async {
                        self.cashDetailsListArray = result?.lstCashTransfer ?? []
                        self.cashDetailsFilterListArray = self.cashDetailsListArray
                        print(self.cashDetailsListArray.count, "cashDetailsListArray Count")
                      
                        self.VC?.stopLoading()
                        if self.cashDetailsListArray.count != 0 {
                            self.VC?.dropDownTableView.isHidden = false
                            self.VC?.noDataFoundLbl.isHidden = true
                            if self.cashDetailsListArray.count <= 20{
                                self.VC!.tableViewHeightConstraint.constant = CGFloat(self.cashDetailsListArray.count * 40)
                            }else{
                                self.VC!.tableViewHeightConstraint.constant = CGFloat(500)
                            }
                            self.VC?.dropDownTableView.reloadData()
                        }else{
                            self.VC?.dropDownTableView.isHidden = true
                            self.VC?.noDataFoundLbl.isHidden = false
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
    
    func mappedUserTypeListApi(parameter: JSON){
        
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        
        self.requestAPIs.mappedDealerandSubdealerListApi(parameters: parameter) { (result, error) in
            
            if result == nil{
                
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
            }else{
                if error == nil{
                    DispatchQueue.main.async {
                        self.mappedListArray = result?.lstCustParentChildMapping ?? []
                        self.mappedListFilterArray = self.mappedListArray
                        print(self.mappedListArray.count, "Mapped Dealer list Count")
                      
                        self.VC?.stopLoading()
                        if self.mappedListArray.count != 0 {
                            self.VC?.dropDownTableView.isHidden = false
                            self.VC?.noDataFoundLbl.isHidden = true
                            if self.mappedListArray.count <= 20{
                                self.VC!.tableViewHeightConstraint.constant = CGFloat(self.mappedListArray.count * 40)
                            }else{
                                self.VC!.tableViewHeightConstraint.constant = CGFloat(500)
                            }
                            self.VC?.dropDownTableView.reloadData()
                        }else{
                            self.VC?.dropDownTableView.isHidden = true
                            self.VC?.noDataFoundLbl.isHidden = false
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
    
    func claimProductListApi(parameter: JSON){
        
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        
        self.requestAPIs.claimProductListApi(parameters: parameter) { (result, error) in
            
            if result == nil{
                
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
            }else{
                if error == nil{
                    DispatchQueue.main.async {
                        self.claimProductListArray = result?.lstAttributesDetails ?? []
                        print(self.claimProductListArray.count, "Mapped Dealer list Count")
                        
                        self.VC?.stopLoading()
                        if self.claimProductListArray.count != 0 {
                            self.VC?.dropDownTableView.isHidden = false
                            self.VC?.noDataFoundLbl.isHidden = true
                            if self.claimProductListArray.count <= 20{
                                self.VC!.tableViewHeightConstraint.constant = CGFloat(self.claimProductListArray.count * 40)
                            }else{
                                self.VC!.tableViewHeightConstraint.constant = CGFloat(500)
                            }
                            self.VC?.dropDownTableView.reloadData()
                        }else{
                            self.VC?.dropDownTableView.isHidden = true
                            self.VC?.noDataFoundLbl.isHidden = false
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
    
    func workLevelListApi(parameter: JSON){
        
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        
        self.requestAPIs.getWorkLevelApi(parameters: parameter) { (result, error) in
            
            if result == nil{
                
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
            }else{
                if error == nil{
          
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        self.workLevelListArray = result?.lstAttributesDetails ?? []
                        print(self.workLevelListArray.count, "Mapped Dealer list Count")
                      if self.workLevelListArray.count != 0 {
                            self.VC?.dropDownTableView.isHidden = false
                            self.VC?.noDataFoundLbl.isHidden = true
                          if self.workLevelListArray.count <= 20{
                              self.VC!.tableViewHeightConstraint.constant = CGFloat(self.workLevelListArray.count * 40)
                          }else{
                              self.VC!.tableViewHeightConstraint.constant = CGFloat(500)
                          }
                          self.VC?.dropDownTableView.reloadData()
                        
                      }else if self.workLevelListArray.count == 0 {
                            self.VC?.dropDownTableView.isHidden = true
                            self.VC?.noDataFoundLbl.isHidden = false
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
