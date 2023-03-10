//
//  WorkSiteDetailsVM.swift
//  KeshavCement
//
//  Created by ADMIN on 22/02/2023.
//

import Foundation
import UIKit

class WorkSiteDetailsVM{
    
    weak var VC: KC_WorkDetailsVC?
    var requestAPIs = RestAPI_Requests()
    
    
    func workSiteDetailsSubmission(parameter: JSON){
        
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        
        self.requestAPIs.saveWorkDetailsApi(parameters: parameter) { (result, error) in

            if result == nil{

                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
            }else{
                if error == nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        print(result?.returnValue ?? -1, "Worksite Details  submission")
                        if result?.returnValue ?? -1 == 1{
                            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_ForgetPwdSuccessVC") as! KC_ForgetPwdSuccessVC
                            vc.itsComeFrom = "SAVEWORKSITEINFO"
                            vc.modalTransitionStyle = .coverVertical
                            vc.modalPresentationStyle = .overFullScreen
                            self.VC!.present(vc, animated: true)
                        }else{
                            self.VC!.view.makeToast("Submission failed", duration: 2.0, position: .bottom)
                          
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
