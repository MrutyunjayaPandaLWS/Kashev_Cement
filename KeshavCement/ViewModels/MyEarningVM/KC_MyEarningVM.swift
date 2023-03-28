//
//  KC_MyEarningVM.swift
//  KeshavCement
//
//  Created by ADMIN on 01/03/2023.
//

import Foundation
import UIKit

class KC_MyEarningVM{
    
    weak var VC: KC_MyEarningVC?
    var requestAPIs = RestAPI_Requests()
    var count = 0
    var redemptionRefId = 0
    var timer = Timer()
    var OTPforVerification = ""

    var myEarningListArray = [LstRewardTransJsonDetails]()
    
    func myEarningListApi(parameter: JSON){
        
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }

        self.requestAPIs.myEarningListApi(parameters: parameter) { (result, error) in
            if result == nil{
                
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
            }else{
                if error == nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                       // self.myEarningListArray = result?.lstRewardTransJsonDetails ?? []

//                        if self.myEarningListArray.count != 0{
//                            self.VC!.myEarningTV.isHidden = false
//                            self.VC!.myEarningTV.reloadData()
//                        }else{
//                            self.VC!.myEarningTV.isHidden = true
//                           // self.VC!.view.makeToast("No data found !!", duration: 2.0, position: .bottom)
//                        }
                        let enrollmenteLists = result?.lstRewardTransJsonDetails ?? []

                        if enrollmenteLists.isEmpty == false{
                            self.myEarningListArray += enrollmenteLists
                            self.VC?.noofelements = self.myEarningListArray.count
                            print(self.myEarningListArray.count, "mappedCustomerListArray Count")
                            self.VC?.stopLoading()
                            if self.myEarningListArray.count != 0 {
                                self.VC?.myEarningTV.isHidden = false
                                self.VC?.noDataFoundLbl.isHidden = true
                                self.VC?.myEarningTV.reloadData()
                            }else{
                                self.VC?.myEarningTV.isHidden = true
                                self.VC?.noDataFoundLbl.isHidden = false
                                self.VC?.noDataFoundLbl.textColor = .white
                            }
                        }else{
                            if self.VC!.startIndex > 1{
                                self.VC?.startIndex = 1
                                self.VC?.noofelements = 9
                            }else{
                                self.VC?.myEarningTV.isHidden = true
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

