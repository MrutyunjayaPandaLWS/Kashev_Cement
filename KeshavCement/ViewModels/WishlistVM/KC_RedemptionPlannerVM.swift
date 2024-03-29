//
//  KC_RedemptionPlannerVM.swift
//  KeshavCement
//
//  Created by ADMIN on 24/02/2023.
//

import UIKit
import LanguageManager_iOS
class KC_RedemptionPlannerVM {
    
    weak var VC: HR_RedemptionPlannerVC?
    var requestAPIs = RestAPI_Requests()
    var loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyId") ?? ""
    var userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    var plannerListArray = [ObjCatalogueList1]()
    var myCartListArray = [CatalogueSaveCartDetailListResponse]()
   var value = 0
    var sumOfProductsCount = 0
  
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
                        if self.myCartListArray.count != 0 {
                          //  self.VC?.cartCount.text = "\(self.myCartListArray.count)"
                            let myCartValues:Int = Int(self.myCartListArray[0].sumOfTotalPointsRequired ?? 0)
                            print(myCartValues, "Totatadgsafasdfs")
                            self.VC?.totalCartValue = myCartValues
                            print(self.VC?.totalCartValue, "MY Cart Values")
                        }else{
                          //  self.VC?.cartCount.text = "0"
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
    

    //"\(self.VC?.mappedUserId ?? 0)",
    func redemptionPlannerList(PartyLoyaltyID: String, ActorId: String){
        self.VC?.startLoading()
        let parameters = [
            "ActionType": "6",
            "ActorId": ActorId,
             "StartIndex": 1,
             "PageSize": 10,
             "PartyLoyaltyID": PartyLoyaltyID
        ] as [String : Any]
        print(parameters)
        self.requestAPIs.productPlannerListApi(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        self.plannerListArray = result?.objCatalogueList ?? []
                        print(self.plannerListArray.count, "Planner List Count")
                        if self.plannerListArray.count != 0 {
                            self.VC?.redemptionPlannerTableView.isHidden = false
                            self.VC?.addToPlanner.isHidden = true
                            self.VC?.redemptionPlannerTableView.reloadData()
                        }else{
                            self.VC?.addToPlanner.isHidden = false
                            self.VC?.view.makeToast("NoDataFound".localiz(), duration: 3.0, position: .bottom)
                            self.VC?.redemptionPlannerTableView.isHidden = true
                        }

                    }
                }else{
                    DispatchQueue.main.async {
                        self.VC?.view.makeToast("NoDataFound".localiz(), duration: 3.0, position: .bottom)
                        self.VC?.stopLoading()
                    }
                }
            }else{
                DispatchQueue.main.async {
                    self.VC?.view.makeToast("NoDataFound".localiz(), duration: 3.0, position: .bottom)
                    self.VC?.stopLoading()
                }
            }
        }
    }
//https://keshavliveserv.loyltwo3ks.com/Mobile/GetPlannerAddedOrNot
    //{"ActionType":17,"ActorId":"16","RedemptionPlannerId":156,"PartyLoyaltyID":"D00002"}
    //["PartyLoyaltyID": "E00001", "ActionType": "17", "ActorId": "10", "RedemptionPlannerId": "150"]
    func removeRedemptionPlanner(redemptionPlannerId: Int, PartyLoyaltyID: String, ActorID: String){
        self.VC?.startLoading()
        let parameters = [
            "ActionType":"17",
            "ActorId": ActorID,
            "RedemptionPlannerId": "\(self.VC?.removeProductId ?? 0)",
            "PartyLoyaltyID": PartyLoyaltyID
        ] as [String : Any]
        print(parameters)
        self.requestAPIs.plannerRemoveApi(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        let response = result?.returnValue ?? 0
                        print(response, "RemoveProduct")
                        if response == 1{
                            if self.VC?.customerTypeId ?? "" == "3" && self.VC?.partyLoyaltyId != "" || self.VC?.customerTypeId ?? "" == "4" && self.VC?.partyLoyaltyId != ""{
                                //self.VM.redemptionPlannerList(PartyLoyaltyID: self.partyLoyaltyId, ActorId: "\(self.mappedUserId)")
                                self.redemptionPlannerList(PartyLoyaltyID: self.loyaltyId, ActorId: "\(self.VC?.mappedUserId ?? 0)")
                            }else if self.VC?.customerTypeId ?? "" == "3" && self.VC?.partyLoyaltyId == "" || self.VC?.customerTypeId ?? "" == "4" && self.VC?.partyLoyaltyId == ""{
                                self.redemptionPlannerList(PartyLoyaltyID: "", ActorId: self.userID)
                            }else{
                                self.redemptionPlannerList(PartyLoyaltyID: "", ActorId: self.userID)
                            }
                          
                            self.VC?.redemptionPlannerTableView.reloadData()
                        }else{
                            DispatchQueue.main.async{
                                self.VC!.view.makeToast("Producthasbeenremovedsuccessfully!".localiz(), duration: 2.0, position: .bottom)
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


    //Add to Cart Api
    
    func addToCartApi(redemptionPlannerId:Int, PartyLoyaltyID: String, LoyaltyID: String){
        self.VC?.startLoading()
        let parameters = [
                "ActionType": "1",
                "ActorId": "\(userID)",
                "CatalogueSaveCartDetailListRequest": [
                    [
                        "CatalogueId": "\(self.VC?.selectedCatalogueID ?? 0)",
                        "DeliveryType": "1",
                        "NoOfQuantity": "1"
                    ]
                ],
                "LoyaltyID": LoyaltyID,
                "MerchantId": "1",
                "PartyLoyaltyID":PartyLoyaltyID
        ] as [String :Any]
        print(parameters)
        self.requestAPIs.productAddToCartApi(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        print(result?.returnValue ?? "", "ReturnValue")
                        if result?.returnValue == 1{
                            //self.cartCountApi()
                            if self.VC?.customerTypeId ?? "" == "3" && self.VC?.partyLoyaltyId != "" || self.VC?.customerTypeId ?? "" == "4" && self.VC?.partyLoyaltyId != ""{
                                    self.getMycartList(PartyLoyaltyID: self.VC!.loyaltyId, LoyaltyID: self.VC!.partyLoyaltyId)
                                self.removeRedemptionPlanner(redemptionPlannerId: redemptionPlannerId, PartyLoyaltyID: self.VC!.partyLoyaltyId, ActorID: "\(self.VC?.mappedUserId)")
                                
                            }else if self.VC?.customerTypeId ?? "" == "3" && self.VC?.partyLoyaltyId == "" || self.VC?.customerTypeId ?? "" == "4" && self.VC?.partyLoyaltyId == ""{
                                self.getMycartList(PartyLoyaltyID: "", LoyaltyID: self.VC!.loyaltyId)
                                self.removeRedemptionPlanner(redemptionPlannerId: redemptionPlannerId, PartyLoyaltyID: "", ActorID: "\(self.VC?.mappedUserId)")
                            }else{
                                self.getMycartList(PartyLoyaltyID: "", LoyaltyID: self.VC!.loyaltyId)
                                self.removeRedemptionPlanner(redemptionPlannerId: redemptionPlannerId, PartyLoyaltyID: "", ActorID: self.userID)
                                
                            }
                            
                           
                         //   self.redemptionPlannerList()
                           // NotificationCenter.default.post(name: .cartCount, object: nil)
                            let alert = UIAlertController(title: "", message: "AddedToCart".localiz(), preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "OK".localiz(), style: .default, handler:{ (UIAlertAction) in
                                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_MyCartVC") as! KC_MyCartVC
                                self.VC?.navigationController?.pushViewController(vc, animated: true)

                            }))
                            self.VC?.present(alert, animated: true, completion: nil)
                            return
                        }else{
                            //PopUp Message
                            DispatchQueue.main.async{
                                self.VC!.view.makeToast("AddToCartFailedsometime".localiz(), duration: 2.0, position: .bottom)
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

