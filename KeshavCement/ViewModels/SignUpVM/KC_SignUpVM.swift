//
//  KC_SignUpVM.swift
//  KeshavCement
//
//  Created by ADMIN on 15/02/2023.
//


import UIKit
import LanguageManager_iOS
class KC_SignUpVM{
    
    weak var VC: KC_SignUpVC?
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
                                vc.modalTransitionStyle = .coverVertical
                                vc.modalPresentationStyle = .overFullScreen
                                self.VC!.present(vc, animated: true)
                            }else{
                                self.VC!.view.makeToast("RegistrationFailed!!".localiz(), duration: 3.0, position: .bottom)
                                for controller in self.VC!.navigationController!.viewControllers as Array {
                                    if controller.isKind(of: KC_RegisterVC.self) {
                                        self.VC!.navigationController!.popToViewController(controller, animated: true)
                                        break
                                    }
                                }
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
