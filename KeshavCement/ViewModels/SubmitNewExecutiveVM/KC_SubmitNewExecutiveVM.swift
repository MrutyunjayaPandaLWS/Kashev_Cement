//
//  KC_SubmitNewExecutiveVM.swift
//  KeshavCement
//
//  Created by ADMIN on 28/02/2023.
//

import Foundation
import UIKit

class KC_SubmitNewExecutiveVM{
    
    weak var VC: KC_CreateNewSupportExecutiveVC?
    var requestAPIs = RestAPI_Requests()

    
    
    
    func createNewExecutiveApi(parameter: JSON){
        
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        self.requestAPIs.newExecutiveSubmissionApi(parameters: parameter) { (result, error) in
            
            if result == nil{
                
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
            }else{
                if error == nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        print(result?.returnMessage ?? "", "Claim Purchase submission")
                        let response = String(result?.returnMessage ?? "").split(separator: "~")
                        if response.count != 0{
                            if response[0] == "1"{
                                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_ForgetPwdSuccessVC") as! KC_ForgetPwdSuccessVC
                                vc.itsComeFrom = "SUPPORTEXECUTIVE"
                                vc.modalTransitionStyle = .coverVertical
                                vc.modalPresentationStyle = .overFullScreen
                                self.VC!.present(vc, animated: true)
                            }else{
                                
                            }
                        }else{
                            self.VC!.view.makeToast("Something went wrong! Try again later...")
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


