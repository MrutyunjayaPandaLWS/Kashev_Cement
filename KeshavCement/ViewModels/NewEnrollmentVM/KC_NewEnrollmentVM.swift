//
//  KC_NewEnrollmentVM.swift
//  KeshavCement
//
//  Created by ADMIN on 18/02/2023.
//

import Foundation

import UIKit
class KC_NewEnrollmentVM{
    
    weak var VC: KC_NewEnrollementVC?
    var requestAPIs = RestAPI_Requests()
    
    func registrationSubmission(parameter: JSON){
        
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        self.requestAPIs.registrationSubmissionApi(parameters: parameter) { (result, error) in
            
            if result == nil{
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
            }else{
                if error == nil{
                    
                    let response = String(result?.returnMessage ?? "").split(separator: "~")
                    print(result?.returnMessage ?? "", "Registration Response")
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                       
                        if response.count != 0 {
                            if response[0] == "1"{
                                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_SignUpSuccessPopVC") as! KC_SignUpSuccessPopVC
                                vc.itsFrom = "ENROLLMENT"
                                vc.modalTransitionStyle = .coverVertical
                                vc.modalPresentationStyle = .overFullScreen
                                self.VC!.present(vc, animated: true)
                            }else{
                                self.VC!.view.makeToast("Enrollment Failed", duration: 3.0, position: .bottom)
                                self.VC!.navigationController?.popViewController(animated: true)
                            }
                        }
                    }
                }else{
                    DispatchQueue.main.async {
                        print(error)
                        print(result)
                        self.VC?.stopLoading()
                    }
                }
            }
        }
    }
}

