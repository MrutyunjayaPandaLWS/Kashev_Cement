//
//  HR_RedemptionPlannerDetailsVM.swift
//  HR_Johnson
//
//  Created by ArokiaIT on 3/1/22.
//

import UIKit

class HR_RedemptionPlannerDetailsVM{
    
    weak var VC: HR_RedemptionPlannerDetailsVC?
    var requestAPIs = RestAPI_Requests()
    var loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyId") ?? ""
    var userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    var plannerListArray = [ObjCatalogueList1]()
    var myCartListArray = [CatalogueSaveCartDetailListResponse]()

    
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
                        self.myCartListArray = result?.catalogueSaveCartDetailListResponse ?? []
                        if self.myCartListArray.count != 0 {
                         //   self.VC?.cartCount.text = "\(self.myCartListArray.count)"
                            let myCartValues:Int = Int(self.myCartListArray[0].sumOfTotalPointsRequired ?? 0)
                            print(myCartValues, "Totatadgsafasdfs")
                            self.VC?.totalCartValue = myCartValues
                            print(self.VC?.totalCartValue, "MY Cart Values")
                        }else{
                            //self.VC?.cartCount.text = "0"
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
    
    
    func removeRedemptionPlanner1(redemptionPlannerId:Int, PartyLoyaltyID: String){
        self.VC?.startLoading()
        let parameters = [
            "ActionType":"17",
            "ActorId":"\(userID)",
            "RedemptionPlannerId": "\(self.VC?.redemptionPlannerId ?? 0)",
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
                            self.VC!.view.makeToast("Product is removed from the List", duration: 2.0, position: .bottom)
                            
                            if self.VC?.customerTypeId ?? "" == "3" && self.VC?.partyLoyaltyId != "" || self.VC?.customerTypeId ?? "" == "4" && self.VC?.partyLoyaltyId != ""{
                                self.redemptionPlannerList(PartyLoyaltyID: self.VC!.partyLoyaltyId)
                            }else if self.VC?.customerTypeId ?? "" == "3" && self.VC?.partyLoyaltyId == "" || self.VC?.customerTypeId ?? "" == "4" && self.VC?.partyLoyaltyId == ""{
                                self.redemptionPlannerList(PartyLoyaltyID: "")
                            }   else{
                                self.redemptionPlannerList(PartyLoyaltyID: "")
                            }
                        // self.VC?.redemptionPlannerTableView.reloadData()
                        }else{
                            DispatchQueue.main.async{
                                self.VC!.view.makeToast("Redemption Failed", duration: 2.0, position: .bottom)
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
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        self.plannerListArray = result?.objCatalogueList ?? []
                        print(self.plannerListArray.count, "Planner List Count")
//                        if self.plannerListArray.count != 0 {
//                            self.VC?.redemptionPlannerTableView.isHidden = false
//                            self.VC?.addToPlanner.isHidden = true
//                            self.VC?.redemptionPlannerTableView.reloadData()
//                        }else{
//                            self.VC?.addToPlanner.isHidden = false
//                            self.VC?.redemptionPlannerTableView.isHidden = true
//                        }

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
                        print(result?.returnValue ?? "", "ReturnValue")
                        if result?.returnValue == 1{
                            //self.cartCountApi()
                           // self.getMycartList()
                            if self.VC?.customerTypeId ?? "" == "3" && self.VC?.partyLoyaltyId != "" || self.VC?.customerTypeId ?? "" == "4" && self.VC?.partyLoyaltyId != ""{
                                
                                    self.getMycartList(PartyLoyaltyID: self.loyaltyId, LoyaltyID: self.VC!.partyLoyaltyId)
                                    self.removeRedemptionPlanner1(redemptionPlannerId: redemptionPlannerId, PartyLoyaltyID: self.VC!.partyLoyaltyId)
                                    self.redemptionPlannerList(PartyLoyaltyID: self.VC!.partyLoyaltyId)
                                     
                            }else if self.VC?.customerTypeId ?? "" == "3" && self.VC?.partyLoyaltyId == "" || self.VC?.customerTypeId ?? "" == "4" && self.VC?.partyLoyaltyId == ""{
                                self.getMycartList(PartyLoyaltyID: "", LoyaltyID: self.VC!.loyaltyId)
                                self.removeRedemptionPlanner1(redemptionPlannerId: redemptionPlannerId, PartyLoyaltyID: "")
                                self.redemptionPlannerList(PartyLoyaltyID: "")
                            }else{
                                self.getMycartList(PartyLoyaltyID: "", LoyaltyID: self.VC!.loyaltyId)
                                self.removeRedemptionPlanner1(redemptionPlannerId: redemptionPlannerId, PartyLoyaltyID: "")
                                self.redemptionPlannerList(PartyLoyaltyID: "")
                                
                            }
                            

                            
                            
                         
                           // NotificationCenter.default.post(name: .cartCount, object: nil)
                            let alert = UIAlertController(title: "", message: "Added To Cart", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler:{ (UIAlertAction) in
                                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_MyCartVC") as! KC_MyCartVC
                                self.VC?.navigationController?.pushViewController(vc, animated: true)

                            }))
                            self.VC?.present(alert, animated: true, completion: nil)
                            return
                        }else{
                            //PopUp Message
                            DispatchQueue.main.async{
                                self.VC!.view.makeToast("Insufficient Point Balance", duration: 2.0, position: .bottom)
                            }
                        }
                        DispatchQueue.main.async {
                            self.VC?.stopLoading()
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
//    func cartCountApi(){
//        self.VC?.startLoading()
//        let parameters = [
//            "ActionType":"1",
//            "LoyaltyID":"\(loyaltyId)"
//        ] as [String : Any]
//        print(parameters)
//        self.requestAPIs.cartCountApi(parameters: parameters) { (result, error) in
//            if error == nil{
//                if result != nil{
//                    DispatchQueue.main.async{
////                        self.VC?.cartCount.text = "\(result?.totalCartCatalogue ?? 0)"
//                        }
//                    DispatchQueue.main.async{
//                        self.VC?.stopLoading()
//                    }
//                }else{
//                    DispatchQueue.main.async{
//                        self.VC?.stopLoading()
//                    }
//                }
//            }else{
//                DispatchQueue.main.async{
//                    self.VC?.stopLoading()
//                }
//            }
//        }
//    }
    
}
