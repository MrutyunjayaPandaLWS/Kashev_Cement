//
//  QS_redeemQuantity_VM.swift
//  Quba Safalta
//
//  Created by Arokia-M3 on 24/03/21.
//

import UIKit
//import LanguageManager_iOS

class QS_redeemQuantity_VM{
    weak var VC: QS_redeemQuantity_VC?
    var loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyId") ?? ""
    var userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    var requestAPIs = RestAPI_Requests()
    var pointsArray = [ObjCatalogueFixedPoints1]()
    var filteredpointsArray = [ObjCatalogueFixedPoints1]()
    
    
    func myVouchersAPI(userID: String, productCode: String){
        self.VC?.startLoading()
        let parameters = [
            "ActionType":"6",
            "ActorId":"\(userID)",
            "ObjCatalogueDetails":
                [
                    "CatalogueType":"4",
                    "MerchantId":"1"
                ]
        ] as [String : Any]
        print(parameters)
        self.requestAPIs.evoucherListApi(parameters: parameters) { result, error in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.pointsArray = result?.objCatalogueFixedPoints ?? []
                        for product in self.pointsArray{
                            if product.productCode == productCode{
                                self.filteredpointsArray.append(product)
                            }
                        }
                        self.VC!.pointsTableView.reloadData()
                        self.VC!.stopLoading()
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
