//
//  KC_ReferandEarnVM.swift
//  KeshavCement
//
//  Created by ADMIN on 01/03/2023.
//

import Foundation
import UIKit
import LanguageManager_iOS

class KC_ReferandEarnVM{
    
    weak var VC: KC_ReferandEarnVC?
    var requestAPIs = RestAPI_Requests()

    
    
    
    func referandEarnSubmission(parameter: JSON){

        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        self.requestAPIs.referralCodeSubmissionApi(parameters: parameter) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        print(result?.returnMessage ?? "1", "ReturnMessage")
                        if result?.returnMessage ?? "0" == "1"{
                            self.VC!.nameTF.text = ""
                            self.VC!.mobileTF.text = ""
                            self.VC!.view.makeToast("Successfullyreferralcodesenttoyourfriend".localiz(),duration: 2.0, position: .bottom)
                        }else  if result?.returnMessage ?? "0" == "2~Mobile number already Referred"{
                            self.VC!.view.makeToast("Thismobilenumberalreadyreferred".localiz(),duration: 2.0, position: .bottom)
                        }else{
                            self.VC!.view.makeToast("SomethingwentwrongTryagainLater.".localiz(),duration: 2.0, position: .bottom)
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



