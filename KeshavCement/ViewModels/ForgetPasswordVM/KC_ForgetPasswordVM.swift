//
//  KC_ForgetPasswordVM.swift
//  KeshavCement
//
//  Created by ADMIN on 17/02/2023.
//

import Foundation

import UIKit
class KC_ForgetPasswordVM{
    
    weak var VC: KC_ForgetPasswordVC?
    var requestAPIs = RestAPI_Requests()
    var count = 0
    var timer = Timer()
    
    

    
    func verifyMobileNumberAPI(paramters: JSON){
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        let url = URL(string: checkUserExistencyURL)!
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: paramters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(UserDefaults.standard.string(forKey: "TOKEN") ?? "")", forHTTPHeaderField: "Authorization")

        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

            guard error == nil else {
                return
            }
            guard let data = data else {
                return
            }
            do{
                let str = String(decoding: data, as: UTF8.self) as String?
                 print(str, "- Mobile Number Exists")
                if str ?? "" == "1"{
                    DispatchQueue.main.async{
                        self.VC?.stopLoading()
                        self.VC?.generateOTPBtn.setTitle("Submit", for: .normal)
                        self.VC?.otpInfoLbl.isHidden = false
                        self.VC?.otpInfoLbl2.isHidden = false
                        self.VC?.resendOTPBtn.isHidden = false
                        self.VC?.otpLbl.isHidden = false
                        self.VC?.otpView.isHidden = false
                        self.VC?.otpTimerLbl.isHidden = false
                        self.VC?.generateOTPButtonTopConstraint.constant = 122
                       
                        self.VC?.generateOTPApi()
                    }
                }else if str ?? "" == "2"{
                    DispatchQueue.main.async{
                        self.VC?.stopLoading()
                        self.VC?.view.makeToast("Your account has been deactivated..", duration: 2.0, position: .bottom)
                        self.VC?.generateOTPBtn.setTitle("Generate OTP", for: .normal)
                        self.VC?.mobileNumberTF.text = ""
                    }
                }else if str ?? "" == "3"{
                    DispatchQueue.main.async{
                        self.VC?.stopLoading()
                        self.VC?.view.makeToast("Invaild customer type", duration: 2.0, position: .bottom)
                        self.VC?.generateOTPBtn.setTitle("Generate OTP", for: .normal)
                        self.VC?.mobileNumberTF.text = ""
                    }
                }else if str ?? "" != "1"{
                    DispatchQueue.main.async{
                        self.VC?.stopLoading()
                        self.VC?.view.makeToast("Mobile number doesn't exists", duration: 2.0, position: .bottom)
                        self.VC?.generateOTPBtn.setTitle("Generate OTP", for: .normal)
                    }
                }
                 }catch{
                     DispatchQueue.main.async{
                         self.VC?.stopLoading()
                         print("parsing Error")
                     }
            }
        })
        task.resume()
    }
    func getOTPApi(parameter: JSON){
        DispatchQueue.main.async {
            self.count = 60
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
            self.VC?.startLoading()
        }
        
        self.requestAPIs.otp_Post_API(parameters: parameter) { (result, error) in
            
            if result == nil{
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
            }else{
                if error == nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        self.VC?.receivedOTP = result?.returnMessage ?? ""
                        print(result?.returnMessage ?? "", "-OTP")
                        self.VC?.receivedOTP = "123456"
                       
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
    
    @objc func update() {
        if(count > 1) {
            count = count - 1
            self.VC?.otpTimerLbl.text = "Seconds Remaining : 0:\(count - 1)"
            self.VC?.resendOTPBtn.isHidden = true
            
        }else{
            self.VC?.resendOTPBtn.isHidden = false
            self.timer.invalidate()
        }
    }
    
    func loginSubmissionApi(parameter: JSON){
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        self.requestAPIs.login_API(parameters: parameter) { (result, error) in
            
            if result == nil{
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
            }else{
                if error == nil{
                    let loginResponse = result?.userList ?? []
                    
                    print(loginResponse.count)
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        if loginResponse.count != 0{
//
//                            if loginResponse[0].result ?? -1 != 1{
//                                self.VC!.view.makeToast("Your account is verification pending! Kindly contact your administrator.", duration: 2.0, position: .bottom)
//                            }
                            if loginResponse[0].isDelete ?? -1 == 1 || loginResponse[0].isUserActive ?? -1 == 0 && loginResponse[0].verifiedStatus ?? -1 == 3{
                                self.VC!.view.makeToast("Your account is verification pending! Kindly contact your administrator.", duration: 2.0, position: .bottom)
                            }else if loginResponse[0].isUserActive ?? -1 == 1 && loginResponse[0].verifiedStatus ?? -1 == 0 || loginResponse[0].isUserActive ?? -1 == 0 && loginResponse[0].verifiedStatus ?? -1 == 0{
                                self.VC!.view.makeToast("Your account is not activated! Kindly activate your account.", duration: 2.0, position: .bottom)
                            }else if loginResponse[0].isUserActive ?? -1 == 0 && loginResponse[0].verifiedStatus ?? -1 == 1 || loginResponse[0].isUserActive ?? -1 == 0 && loginResponse[0].verifiedStatus ?? -1 == 4{
                                self.VC!.view.makeToast("Your account has been deactivated! Kindly contact your administrator.", duration: 2.0, position: .bottom)
                            }else if loginResponse[0].verifiedStatus ?? -1 == 2 {
                                self.VC!.view.makeToast("Your account verification is failed!, Kindly contact your administrator.", duration: 2.0, position: .bottom)
                            }else{
                                if loginResponse[0].result ?? -1 == 1 || loginResponse[0].isUserActive ?? -1 == 1 && loginResponse[0].verifiedStatus ?? -1 == 1 && loginResponse[0].result ?? -1 == 1 || loginResponse[0].isUserActive ?? -1 == 1 && loginResponse[0].verifiedStatus ?? -1 == 1{
                                    UserDefaults.standard.setValue(loginResponse[0].userId ?? -1, forKey: "UserID")
                                    UserDefaults.standard.setValue(true, forKey: "IsloggedIn?")
                                    UserDefaults.standard.set(true, forKey: "UpdatePassword")
                                    UserDefaults.standard.synchronize()
                                    DispatchQueue.main.async {
                                        //                                        NotificationCenter.default.post(name: .navigateToChangePassword, object: nil)
                                        if #available(iOS 13.0, *) {
                                            let sceneDelegate = self.VC!.view.window!.windowScene!.delegate as! SceneDelegate
                                            sceneDelegate.setHomeAsRootViewController()
                                        } else {
                                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                            appDelegate.setHomeAsRootViewController()
                                        }
                                    }
                                }
                            }
//
                        }else{
                            self.VC!.view.makeToast("Something went wrong. Try again later!", duration: 2.0, position: .bottom)
                        }
                    
                    }
                }else{
                    print(error)
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                    }
                }
            }
        }
    }
}
