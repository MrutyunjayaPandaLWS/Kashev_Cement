//
//  KC_MyCartVM.swift
//  KeshavCement
//
//  Created by ADMIN on 23/02/2023.
//

import Foundation
import UIKit
import LanguageManager_iOS
class KC_MyCartVM{
//:  popUpAlertDelegate {
//    func popupAlertDidTap(_ vc: HR_PopUpVC) {}
    
    weak var VC: KC_MyCartVC?
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
                            self.VC?.myCartListTableView.isHidden = false
                            self.VC?.subview.isHidden = false
                            self.VC?.noDataFoundLbl.isHidden = true
                            self.VC?.myCartListTableView.reloadData()
                        }else{
                            self.VC?.myCartListTableView.isHidden = true
                            self.VC?.subview.isHidden = true
                            self.VC?.noDataFoundLbl.isHidden = false
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
    
    func updateCartListApi(parameter: JSON){
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        self.requestAPIs.updateCartApi(parameters: parameter) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        
                        if result?.returnMessage ?? "-1" == "1"{
                            
                                if self.VC?.customerTypeId ?? "" == "3" && self.VC?.partyLoyaltyId != "" || self.VC?.customerTypeId ?? "" == "4" && self.VC?.partyLoyaltyId != ""{
                                        self.getMycartList(PartyLoyaltyID: self.loyaltyId, LoyaltyID: self.VC!.partyLoyaltyId)
                                }else if self.VC?.customerTypeId ?? "" == "3" && self.VC?.partyLoyaltyId == "" || self.VC?.customerTypeId ?? "" == "4" && self.VC?.partyLoyaltyId == ""{
                                    self.getMycartList(PartyLoyaltyID: "", LoyaltyID: self.loyaltyId)
                                }else{
                                    self.getMycartList(PartyLoyaltyID: "", LoyaltyID: self.loyaltyId)
                                }
                        }else{
                             
                            self.VC!.view.makeToast("somethingwentWrong".localiz(), duration: 2.0, position: .bottom)
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
    
    func productRemoveApi(parameter: JSON){
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        self.requestAPIs.updateCartApi(parameters: parameter) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        if result?.returnMessage ?? "-1" == "1"{
                            DispatchQueue.main.async {
                                self.VC!.view.makeToast("ProducthasbeenRemovedfromCart".localiz(), duration: 2.0, position: .bottom)
                                if self.VC?.customerTypeId ?? "" == "3" && self.VC?.partyLoyaltyId != "" || self.VC?.customerTypeId ?? "" == "4" && self.VC?.partyLoyaltyId != ""{
                                    
                                        self.getMycartList(PartyLoyaltyID: self.loyaltyId, LoyaltyID: self.VC!.partyLoyaltyId)
                                     
                                    
                                }else if self.VC?.customerTypeId ?? "" == "3" && self.VC?.partyLoyaltyId == "" || self.VC?.customerTypeId ?? "" == "4" && self.VC?.partyLoyaltyId == ""{
                                    self.getMycartList(PartyLoyaltyID: "", LoyaltyID: self.loyaltyId)
                                }else{
                                    self.getMycartList(PartyLoyaltyID: "", LoyaltyID: self.loyaltyId)
                                }
                            }
                        }else{
                            DispatchQueue.main.async {
                             
                                self.VC!.view.makeToast("somethingwentWrong".localiz(), duration: 2.0, position: .bottom)
                            }
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
    
        
}
