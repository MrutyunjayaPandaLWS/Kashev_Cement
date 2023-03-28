//
//  HR_MyRedemptionDetailsVM.swift
//  HR_Johnson
//
//  Created by ArokiaIT on 2/24/22.
//


import UIKit

class HR_MyRedemptionDetailsVM{
    
    weak var VC: HRD_MyRedemptionDetailsVC?
    var requestAPIs = RestAPI_Requests()
    var loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyId") ?? ""
  
    var myredemptionArray = [ObjCatalogueList01]()
    
    func redemptionDetailsApi(customerId: String){
        self.VC?.startLoading()
        let parameters = [
            "ActionType": 263,
            "ActorId": "\(customerId)",
            "ObjCatalogueDetails": [
                "RedemptionRefno": "\(self.VC?.redemptionRefNo ?? "")"
            ]
        ] as [String: Any]
        print(parameters)
        self.requestAPIs.myredemptionDetails(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.myredemptionArray = result?.objCatalogueList ?? []
                        print(self.myredemptionArray.count, "Redemption Status Count")
                        if self.myredemptionArray.count != 0 {
                            self.VC?.myRedemptionDetailsTableView.isHidden = false
                            self.VC?.noDataFound.isHidden = true
                            self.VC?.myRedemptionDetailsTableView.reloadData()
                        }else{
                            self.VC?.myRedemptionDetailsTableView.isHidden = true
                            self.VC?.noDataFound.isHidden = false
                        }
                    }
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                    }
                    
                }else{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        self.VC?.noDataFound.isHidden = false
                    }
                }
            }else{
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                    self.VC?.noDataFound.isHidden = false
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
