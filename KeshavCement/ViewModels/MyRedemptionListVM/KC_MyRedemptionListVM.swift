//
//  KC_MyRedemptionListVM.swift
//  KeshavCement
//
//  Created by ADMIN on 25/02/2023.
//

import UIKit
import LanguageManager_iOS

class KC_MyRedemptionListVM {
    
    weak var VC: KC_MyRedemptionVC?
    var requestAPIs = RestAPI_Requests()
    var loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyId") ?? ""
    var userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    var myredemptionListArray = [ObjCatalogueRedemReqList]()
   
    
    func myRedemptionListApi(parameter: JSON){
        DispatchQueue.main.async {
          //  self.myredemptionListArray.removeAll()
            self.VC!.startLoading()
        }
       
        self.requestAPIs.myRedemptionListApi(parameters: parameter) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        
                        let redemptionListArray = result?.objCatalogueRedemReqList ?? []
                        if redemptionListArray.isEmpty == false{
                            self.myredemptionListArray += redemptionListArray
                            self.VC?.noofelements = self.myredemptionListArray.count
                            if self.myredemptionListArray.count != 0{
                                self.VC!.myRedemptionTV.isHidden = false
                                self.VC!.myRedemptionTV.reloadData()
                            }else{
                                self.VC!.startIndex = 1
                                self.VC?.myRedemptionTV.isHidden = true
                                self.VC!.view.makeToast("NoDataFound".localiz(), duration: 3.0, position: .bottom)
                            }
                            
                        }else{
                            if self.VC!.startIndex > 1{
                                self.VC!.startIndex = 1
                                self.VC!.noofelements = 9
                            }else{
                                self.VC!.startIndex = 1
                                self.VC!.myRedemptionTV.isHidden = true
                                self.VC!.view.makeToast("NoDataFound".localiz(), duration: 3.0, position: .bottom)
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
