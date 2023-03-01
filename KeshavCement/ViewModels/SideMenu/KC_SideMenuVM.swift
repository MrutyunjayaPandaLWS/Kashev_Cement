//
//  KC_SideMenuVM.swift
//  KeshavCement
//
//  Created by ADMIN on 17/02/2023.
//

import Foundation
import Kingfisher
class KC_SideMenuVM{

    weak var VC:KC_SideMenuVC?
    var requestAPIs = RestAPI_Requests()
    
    func dashboardApi(parameter: JSON){
        
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        
        self.requestAPIs.dashboard_API(parameters: parameter) { (result, error) in
            if error == nil{
                if result != nil{
                DispatchQueue.main.async {
                   let dashboardDetails = result?.objCustomerDashboardList ?? []
                    if dashboardDetails.count != 0 {
                        
                       
                        self.VC?.ptsBalanceLbl.text = "\(result?.objCustomerDashboardList?[0].redeemablePointsBalance ?? 0)"
                    }
                    
                    let customerFeedbakcJSON = result?.lstCustomerFeedBackJsonApi ?? []
                    if customerFeedbakcJSON.count != 0 {
                        
                        let imageurl = "\(result?.lstCustomerFeedBackJsonApi?[0].customerImage ?? "")".dropFirst(1)
                        let imageData = imageurl.split(separator: "~")
                        if imageData.count >= 2 {
                            print(imageData[1],"jdsnjkdn")
                            let totalImgURL = PROMO_IMG1 + (imageData[1])
                            print(totalImgURL, "Total Image URL")
                            self.VC?.profileImage.kf.setImage(with: URL(string: totalImgURL),placeholder: UIImage(named: "ic_default_img"))
                        }else{
                            let totalImgURL = PROMO_IMG1 + imageurl
                            print(totalImgURL, "Total Image URL")
                            self.VC?.profileImage.kf.setImage(with: URL(string: totalImgURL),placeholder: UIImage(named: "ic_default_img"))
                        }
                            UserDefaults.standard.synchronize()
                        self.VC?.customerTypeIds = result?.lstCustomerFeedBackJsonApi?[0].customerTypeId ?? -1
                        self.VC?.categoryLbl.text = result?.lstCustomerFeedBackJsonApi?[0].customerType ?? ""
                        self.VC?.customerType = result?.lstCustomerFeedBackJsonApi?[0].customerType ?? ""
                         self.VC?.userNameLbl.text = result?.lstCustomerFeedBackJsonApi?[0].firstName ?? ""
                        self.VC?.memberShipIdLbl.text = result?.lstCustomerFeedBackJsonApi?[0].loyaltyId ?? ""
                        
//                        @IBOutlet weak var memberShipIdLbl: UILabel!
//                        @IBOutlet weak var pointBalanceTitle: UILabel!
//                        @IBOutlet weak var pointBalanceLbl: UILabel!
//                        @IBOutlet weak var earnPts: UILabel!
//                        @IBOutlet weak var whenPurchaseLbl: UILabel!
//                        @IBOutlet weak var claimPurchaseLbl: UILabel!
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


