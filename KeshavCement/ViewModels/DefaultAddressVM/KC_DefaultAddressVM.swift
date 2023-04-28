//
//  KC_DefaultAddressVM.swift
//  KeshavCement
//
//  Created by ADMIN on 24/02/2023.
//

import Foundation

import UIKit
import LanguageManager_iOS
class KC_DefaultAddressVM{
    
    weak var VC: KC_OrderConfirmationVC?
    var requestAPIs = RestAPI_Requests()
    var loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyId") ?? ""
    var userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    
    var myCartListArray = [CatalogueSaveCartDetailListResponse]()
    var sumOfProductsCount = 0
    var parameters : JSON?
    
    func getMycartList(PartyLoyaltyID: String, LoyaltyID: String){
        self.VC?.startLoading()
        let parameters = [
            "ActionType": "2",
            "LoyaltyID": LoyaltyID,
             "Domain": "KESHAV_CEMENT",
            "PartyLoyaltyID": PartyLoyaltyID
        ] as [String : Any]
        print(parameters)
        self.requestAPIs.productMyCartListApi(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        self.myCartListArray = result?.catalogueSaveCartDetailListResponse ?? []
                        self.sumOfProductsCount = Int(result?.catalogueSaveCartDetailListResponse?[0].sumOfTotalPointsRequired ?? 0)
                        print(self.myCartListArray.count, "My cart Count")
                        if self.myCartListArray.count != 0{
                            if self.myCartListArray.count <= 2{
                                self.VC?.tableViewHeightConstarint.constant = CGFloat(280)
                            }else{
                                self.VC?.tableViewHeightConstarint.constant = CGFloat(self.myCartListArray.count * 140)
                            }
                            self.VC?.orderConfirmationTableView.isHidden = false
                           
//                            self.VC?.noDataFoundLbl.isHidden = true
                            self.VC?.orderConfirmationTableView.reloadData()
                        }else{
                            self.VC?.orderConfirmationTableView.isHidden = true
//                            self.VC?.noDataFoundLbl.isHidden = false
                        }
                        
                    }

                }else{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                    }
                }
            }else{
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
            }
        }
    }
    func myAccountDetailsApi(){
        self.VC?.startLoading()
        let parameters = [
            "ActionType": "6",
            "CustomerId": "\(userID)"
        ]  as [String : Any]
        print(parameters)
        
        self.requestAPIs.myProfile(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        
                        let customerDetails = result?.lstCustomerJson ?? []
                        
                        if customerDetails.count != 0{
                            if customerDetails[0].customerId ?? 0 == 0{
                                DispatchQueue.main.async{
                                    self.VC!.view.makeToast("currentlyContactAdministrator".localiz(), duration: 2.0, position: .bottom)
                                }
                            }else{
                            self.VC?.addressTextView.text = "\(result?.lstCustomerJson?[0].address1 ?? "-"),\n\(result?.lstCustomerJson?[0].districtName ?? "-"),\n\(result?.lstCustomerJson?[0].stateName ?? "-"),\n \("India -")\(result?.lstCustomerJson?[0].zip ?? "-")\n\("PH")- \(result?.lstCustomerJson?[0].mobile ?? "-")\n\("Email")- \(result?.lstCustomerJson?[0].email ?? "-")"
                            self.VC?.stateID = result?.lstCustomerJson?[0].stateId ?? -1
                            self.VC?.mobile = result?.lstCustomerJson?[0].mobile ?? ""
                            self.VC?.address1 = result?.lstCustomerJson?[0].address1 ?? "-"
                            self.VC?.stateName = result?.lstCustomerJson?[0].stateName ?? "-"
                            self.VC?.districtID = result?.lstCustomerJson?[0].districtId ?? -1
                                self.VC?.districtName = result?.lstCustomerJson?[0].districtName ?? ""
                            self.VC?.cityID = result?.lstCustomerJson?[0].cityId ?? -1
                            self.VC?.cityName = result?.lstCustomerJson?[0].cityName ?? "-"
                            self.VC?.pincode = result?.lstCustomerJson?[0].zip ?? ""
                            self.VC?.countryID = result?.lstCustomerJson?[0].countryId ?? -1
                            self.VC?.countryName = result?.lstCustomerJson?[0].countryName ?? "-"
                            self.VC?.customerNameLbl.text = result?.lstCustomerJson?[0].firstName ?? "-"
                            self.VC?.emailID = result?.lstCustomerJson?[0].email ?? "-"
                           // self.VC?.redeemButton.isHidden = false
                            }}else{
                          //  self.VC?.redeemButton.isHidden = true
                        }
                    }
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                    }
                }else{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                    }
                }
            }else{
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
            }
        }
    }
 }

