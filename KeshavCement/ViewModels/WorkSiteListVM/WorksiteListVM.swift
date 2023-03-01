//
//  WorksiteListVM.swift
//  KeshavCement
//
//  Created by ADMIN on 21/02/2023.
//

import Foundation

class WorksiteListVM{
    
    weak var VC: KC_WorksiteDetailsVC?
    var requestAPIs = RestAPI_Requests()
    
    var workSiteListArray = [LstWorkSiteInfo]()
    
    
    func worksiteListApi(parameter: JSON){
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        
        self.requestAPIs.getWorkSiteListApi(parameters: parameter) { (result, error) in
            
            if result == nil{
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
            }else{
                if error == nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        let workSiteListArray1 = result?.lstWorkSiteInfo ?? []
                        
                        if workSiteListArray1.isEmpty == false{
                            self.workSiteListArray += workSiteListArray1
                            self.VC?.noofelements = self.workSiteListArray.count
                            print(self.workSiteListArray.count, "Attributes Count")
                            self.VC?.stopLoading()
                            if self.workSiteListArray.count != 0 {
                                self.VC?.worksiteDetailsTableView.isHidden = false
                                self.VC?.noDataFoundLbl.isHidden = true
                                self.VC?.worksiteDetailsTableView.reloadData()
                            }else{
                                self.VC?.worksiteDetailsTableView.isHidden = true
                                self.VC?.noDataFoundLbl.isHidden = false
                                self.VC?.noDataFoundLbl.textColor = .white
                            }
                        }else{
                            if self.VC!.startIndex > 1{
                                self.VC?.startIndex = 1
                                self.VC?.noofelements = 9
                            }else{
                                self.VC?.worksiteDetailsTableView.isHidden = true
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
