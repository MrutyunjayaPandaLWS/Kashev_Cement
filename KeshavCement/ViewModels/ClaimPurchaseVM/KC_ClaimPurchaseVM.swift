//
//  KC_ClaimPurchaseVM.swift
//  KeshavCement
//
//  Created by ADMIN on 20/02/2023.
//

import Foundation
import UIKit

class KC_ClaimPurchaseVM{
    
    weak var VC: KC_ClaimPurchaseVC?
    var requestAPIs = RestAPI_Requests()
    
    
    func claimPurchaseSubmissionApi(parameter: JSON){
        
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        
        self.requestAPIs.claimPurchaseSubmissionApi(parameters: parameter) { (result, error) in
            
            if result == nil{
                
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
            }else{
                if error == nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        print(result?.returnMessage ?? "", "Claim Purchase submission")
                        if result?.returnMessage ?? "" == "1"{
                            self.VC!.swipeButton.reset()
                            self.VC!.swipeButton.backgroundColor = .white
                            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_ForgetPwdSuccessVC") as! KC_ForgetPwdSuccessVC
                            vc.itsComeFrom = "CLAIMPURCHASE"
                            vc.modalTransitionStyle = .coverVertical
                            vc.modalPresentationStyle = .overFullScreen
                            self.VC!.present(vc, animated: true)
                            self.VC!.swipeButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                        }else{
                            self.VC!.view.makeToast("Claim submission failed!", duration: 2.0, position: .bottom)
                            self.VC!.swipeButton.reset()
                            self.VC!.swipeButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
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
