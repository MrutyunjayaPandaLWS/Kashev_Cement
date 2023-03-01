//
//  KC_EnrollmentVM.swift
//  KeshavCement
//
//  Created by ADMIN on 18/02/2023.
//

import Foundation

class KC_EnrollmentVM{
    
    weak var VC: KC_EnrollmentListVC?
    var requestAPIs = RestAPI_Requests()
    
    var enrollmentListArray = [LstCustParentChildMapping1]()
    func enrollmentListApi(parameter: JSON){
        
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        
        self.requestAPIs.enrollmentApi(parameters: parameter) { (result, error) in
            
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
                            self.enrollmentListArray += enrollmenteLists
                            self.VC?.noofelements = self.enrollmentListArray.count
                            print(self.enrollmentListArray.count, "Attributes Count")
                            self.VC?.stopLoading()
                            if self.enrollmentListArray.count != 0 {
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
