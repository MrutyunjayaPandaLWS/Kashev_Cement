//
//  KC_ProductCatalgoueDetailsVM.swift
//  KeshavCement
//
//  Created by ADMIN on 23/02/2023.
//

import Foundation
import UIKit
class KC_ProductCatalgoueDetailsVM{
//:  popUpAlertDelegate {
//    func popupAlertDidTap(_ vc: HR_PopUpVC) {}
    
    weak var VC: KC_ProductCatalogueDetailsVC?
    var requestAPIs = RestAPI_Requests()
    var loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyId") ?? ""
    var userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    
    var categoryListArray = [ObjCatalogueCategoryListJson]()
    var productCategoryList = [ObjCatalogueCategoryListJson]()
    var brandArray = [ObjCatalogueList]()
    var catalgoueListArray = [ObjCatalogueList]()
    var filteredArray = [ObjCatalogueList]()
    var myCartListArray = [CatalogueSaveCartDetailListResponse]()
    var sumOfProductsCount = 0
    var plannerListArray = [ObjCatalogueList1]()
    var productCategoryListArray = [ProductCateogryModels]()
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
                        self.VC?.cartCount.text = "\(self.myCartListArray.count)"

                        if self.VC?.customerTypeId ?? "" == "3" && self.VC?.partyLoyaltyId != "" || self.VC?.customerTypeId ?? "" == "4" && self.VC?.partyLoyaltyId != ""{
                            
                                self.redemptionPlannerList(PartyLoyaltyID: self.VC!.partyLoyaltyId)
                            
                        }else if self.VC?.customerTypeId ?? "" == "3" && self.VC?.partyLoyaltyId == "" || self.VC?.customerTypeId ?? "" == "4" && self.VC?.partyLoyaltyId == ""{
                            self.redemptionPlannerList(PartyLoyaltyID: "")
                        }else{
                            self.redemptionPlannerList(PartyLoyaltyID: "")
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

    func redemptionPlannerList(PartyLoyaltyID: String){
        self.VC?.startLoading()
        let parameters = [
            "ActionType": "6",
            "ActorId": self.userID,
             "StartIndex": 1,
             "PageSize": 10,
             "PartyLoyaltyID": PartyLoyaltyID
        ] as [String : Any]
        print(parameters)
        self.requestAPIs.productPlannerListApi(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async{
                        self.VC?.stopLoading()
                        self.plannerListArray = result?.objCatalogueList ?? []
                        print(self.plannerListArray.count, "Planner List Count")
                        
                        if self.VC?.is_Reedemable == 1{
                            self.VC?.cartButtonView.isHidden = false
                            self.VC?.subView.isHidden = false
                          
                        }else{
                            self.VC?.cartButtonView.isHidden = true
                            self.VC?.subView.isHidden = false
                        }
                        let filterArray = self.myCartListArray.filter{$0.catalogueId == self.VC!.catalogueId}
                        
                        if filterArray.count > 0 {
                            self.VC!.addedToCart.isHidden = false
                            self.VC!.addedToCart.isUserInteractionEnabled = false
                            self.VC!.addToCart.isHidden = true
                            self.VC!.addToPlanner.isHidden = true
                            self.VC!.addedToPlannerBTN.isHidden = true
                        }else{
                            print(self.VC!.productPts)
                            print(self.VC!.pointBalance)
                            if Int(self.VC!.productPts) ?? 0 <= Int(self.VC!.pointBalance) ?? 0{
                                self.VC!.addedToCart.isHidden = true
                                self.VC!.addToCart.isHidden = false
                                self.VC!.addToPlanner.isHidden = true
                                self.VC!.addedToPlannerBTN.isHidden = true
                            }else{
                                let filterArray1 = self.plannerListArray.filter{$0.catalogueId == self.VC!.catalogueId}
                                if filterArray1.count > 0 {
                                    self.VC?.addedToPlannerBTN.isHidden = false
                                    self.VC!.addedToPlannerBTN.isUserInteractionEnabled = false
                                    self.VC?.addToPlanner.isHidden = true
                                    self.VC?.addToCart.isHidden = true
                                    self.VC?.addedToCart.isHidden = true
                                }else{
                                    self.VC?.addedToCart.isHidden = true
                                    self.VC?.addToPlanner.isHidden = false
                                    self.VC?.addToCart.isHidden = true
                                    self.VC?.addedToPlannerBTN.isHidden = true
                                }
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
    
    func addToCartApi(PartyLoyaltyID: String, LoyaltyID: String){
        self.VC?.startLoading()
        let parameters = [
                "ActionType": "1",
                "ActorId": "\(userID)",
                "CatalogueSaveCartDetailListRequest": [
                    [
                        "CatalogueId": "\(self.VC?.catalogueId ?? 0)",
                        "DeliveryType": "1",
                        "NoOfQuantity": "1"
                    ]
                ],
                "LoyaltyID": LoyaltyID,
                "MerchantId": "1",
                "PartyLoyaltyID": PartyLoyaltyID
        ] as [String :Any]
        print(parameters)
        self.requestAPIs.productAddToCartApi(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        print(result?.returnValue ?? "", "ReturnValue")
                        if result?.returnValue == 1{
                            let alert = UIAlertController(title: "", message: "Added To Cart", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.VC?.present(alert, animated: true, completion: nil)
                            self.VC?.addedToCart.isHidden = false
                            self.VC?.addToCart.isHidden = true
                            self.VC?.addToPlanner.isHidden = true
                            self.VC?.addedToPlannerBTN.isHidden = true
                            if self.VC?.customerTypeId ?? "" == "3" && self.VC?.partyLoyaltyId != "" || self.VC?.customerTypeId ?? "" == "4" && self.VC?.partyLoyaltyId != ""{
                                    self.getMycartList(PartyLoyaltyID: self.loyaltyId, LoyaltyID: self.VC!.partyLoyaltyId)
                            }else if self.VC?.customerTypeId ?? "" == "3" && self.VC?.partyLoyaltyId == "" || self.VC?.customerTypeId ?? "" == "4" && self.VC?.partyLoyaltyId == ""{
                                self.getMycartList(PartyLoyaltyID: "", LoyaltyID: self.loyaltyId)
                            }else{
                                self.getMycartList(PartyLoyaltyID: "", LoyaltyID: self.loyaltyId)
                            }
                            return
                        }else{
                            //PopUp Message
                            DispatchQueue.main.async{
                                self.VC?.addedToCart.isHidden = true
                                self.VC?.addToCart.isHidden = false
                                self.VC?.addToPlanner.isHidden = true
                                self.VC?.addedToPlannerBTN.isHidden = true
                                self.VC!.view.makeToast("Insufficient Point Balance", duration: 2.0, position: .bottom)
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
    
    func addedToPlanner(PartyLoyaltyID: String){
        self.VC?.startLoading()
        let parameters = [
            "ActionType": 0,
            "PartyLoyaltyID": PartyLoyaltyID,
              "ActorId": "\(userID)",
              "ObjCatalogueDetails": [
                  "CatalogueId": self.VC!.plannerProductId
              ]
        ] as [String :Any]
        print(parameters)
        self.requestAPIs.productAddToPlannerApi(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        print(result?.returnValue ?? "", "Add To Planner Return Value")
                        if result?.returnValue ?? 0 >= 1{
                           DispatchQueue.main.async{
                               let alert = UIAlertController(title: "", message: "Product is added into the Planner", preferredStyle: UIAlertController.Style.alert)
                               alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                               self.VC?.present(alert, animated: true, completion: nil)
                            }
                        }else{
                            DispatchQueue.main.async{
                                let alert = UIAlertController(title: "", message: "You can't add this products into your planner List", preferredStyle: UIAlertController.Style.alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                self.VC?.present(alert, animated: true, completion: nil)
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
