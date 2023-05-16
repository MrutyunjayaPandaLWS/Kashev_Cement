//
//  KC_NewQuerySubmissionVM.swift
//  KeshavCement
//
//  Created by ADMIN on 01/03/2023.
//

import UIKit
import LanguageManager_iOS
class KC_NewQuerySubmissionVM{
    
    weak var VC: KC_AddLodgeQueryVC?
    var requestAPIs = RestAPI_Requests()

   
    func submitHelptopic(parameters:JSON){
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        
        self.requestAPIs.newQuerySubmissionApi(parameters: parameters) { (result, error) in
            if error == nil {
                if result != nil{
                    DispatchQueue.main.async {
                        let response = result?.returnMessage ?? "-1~failed~QE13"
                        let responsearray = response.split(separator: "~")
                        if responsearray[0] == "-1"{
                            DispatchQueue.main.async{
                                self.VC?.stopLoading()
                                self.VC?.view.makeToast("Supportticketsubmissionfailed!!".localiz(),duration: 2.0,position: .bottom)
                            }
                        }else{
                            self.VC?.stopLoading()
                            self.VC?.view.makeToast("Supporttickethasbeensubmittedsuccessfully!!".localiz(),duration: 2.0,position: .bottom)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                                self.VC?.stopLoading()
//                                for controller in self.VC?.navigationController!.viewControllers as Array {
//                                    if controller.isKind(of: KC_LodgeQueryVC.self) {
//                                        self.VC?.navigationController!.popToViewController(controller, animated: true)
//                                        break
//                                    }
//                                }
                            }
                            
                        }
                    
                    }
                }else{
                    print("NO RESPONSE")
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                    }
                }
            }else{
                print("ERROR_ \(error)")
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
                
            }
        }
    }
}
