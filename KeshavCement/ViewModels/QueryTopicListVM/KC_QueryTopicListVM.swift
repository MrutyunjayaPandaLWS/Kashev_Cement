//
//  KC_QueryTopicListVM.swift
//  KeshavCement
//
//  Created by ADMIN on 01/03/2023.
//

import Foundation
import UIKit

class KC_QueryTopicListVM{
    
    weak var VC: KC_SelectTopicQueryVC?
    var requestAPIs = RestAPI_Requests()
    var count = 0
    var redemptionRefId = 0
    var timer = Timer()
    var OTPforVerification = ""

    var queryTopicListArray = [ObjHelpTopicList]()
    
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
                            
                            self.VC?.queryCategoryListTableView.isHidden = false
                            self.VC?.queryCategoryListTableView.reloadData()
                        }else{
                            self.VC?.queryCategoryListTableView.isHidden = true
                            self.VC?.view.makeToast("No data found !!", duration: 2.0, position: .bottom)
                        }
                        
//                        let enrollmenteLists = result?.customerBasicInfoListJson ?? []
//
//                        if enrollmenteLists.isEmpty == false{
//                            self.claimHistoryListArray += enrollmenteLists
//                            self.VC?.noofelements = self.claimHistoryListArray.count
//                            print(self.claimHistoryListArray.count, "mappedCustomerListArray Count")
//                            self.VC?.stopLoading()
//                            if self.claimHistoryListArray.count != 0 {
//                                self.VC?.claimHistoryTableView.isHidden = false
//                                self.VC?.noDataFoundLbl.isHidden = true
//                                self.VC?.claimHistoryTableView.reloadData()
//                            }else{
//                                self.VC?.claimHistoryTableView.isHidden = true
//                                self.VC?.noDataFoundLbl.isHidden = false
//                                self.VC?.noDataFoundLbl.textColor = .white
//                            }
//                        }else{
//                            if self.VC!.startIndex > 1{
//                                self.VC?.startIndex = 1
//                                self.VC?.noofelements = 9
//                            }else{
//                                self.VC?.claimHistoryTableView.isHidden = true
//                                self.VC?.noDataFoundLbl.isHidden = false
//                                self.VC?.noDataFoundLbl.textColor = .white
//                            }
//                        }
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

