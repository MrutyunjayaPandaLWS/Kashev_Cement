//
//  KC_RegisterVM.swift
//  KeshavCement
//
//  Created by ADMIN on 14/02/2023.
//

import Foundation
import LanguageManager_iOS
class KC_RegisterVM {
    
    weak var VC: KC_RegisterVC?
    var requestAPIs = RestAPI_Requests()
    var customerTypeArray = [LstAttributesDetails]()
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
                if str ?? "" == "0"{
                    DispatchQueue.main.async{
                        self.VC?.stopLoading()
                        self.VC?.generateOTPBtn.setTitle("Submit".localiz(), for: .normal)
                        self.VC?.otpInfoLbl.isHidden = false
                        self.VC?.otpMobilenoLbl.isHidden = false
                        self.VC?.resendOtpBtn.isHidden = false
                        self.VC?.otpLbl.isHidden = false
                        self.VC?.otpView.isHidden = false
                        self.VC?.otpTimerLbl.isHidden = false
                        self.VC?.topSpaceGenerateOTPBtn.constant = 120
                        self.VC?.generateOTPApi()
                    }
                }else if str ?? "" == "3"{
                    DispatchQueue.main.async{
                        self.VC?.stopLoading()
                        self.VC?.view.makeToast("Invaildcustomertype".localiz(), duration: 2.0, position: .bottom)
                        self.VC?.generateOTPBtn.setTitle("GenerateOTP".localiz(), for: .normal)
                        self.VC?.mobileNumberTF.text = ""
                    }
                }else if str ?? "" == "1"{
                    DispatchQueue.main.async{
                        self.VC?.stopLoading()
                        self.VC?.view.makeToast("Thismemberisalreadyexists".localiz(), duration: 2.0, position: .bottom)
                        self.VC?.generateOTPBtn.setTitle("GenerateOTP".localiz(), for: .normal)
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
    
   
    
    func customerTypeListApi(parameter: JSON){
        
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        
        self.requestAPIs.getCustomerTypeListApi(parameters: parameter) { (result, error) in
            
            if result == nil{
                
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
            }else{
                if error == nil{
                    DispatchQueue.main.async {
                        self.customerTypeArray = result?.lstAttributesDetails ?? []
                        print(self.customerTypeArray.count, "Attributes Count")
                        self.VC?.stopLoading()
                        if self.customerTypeArray.count != 0 {
                            self.VC?.filterTableView.isHidden = false
                            self.VC?.filterTableView.reloadData()
                        }else{
                            self.VC?.filterTableView.isHidden = true
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
//                        self.VC?.receivedOTP = result?.returnMessage ?? ""
                        print(result?.returnMessage ?? "", "-OTP")
//                        self.VC?.receivedOTP = "123456"
                        let response = result?.returnMessage ?? ""
                        self.VC?.receivedOTP = response
                       
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
            self.VC?.resendOtpBtn.isHidden = true
            
        }else{
            self.VC?.resendOtpBtn.isHidden = false
            self.timer.invalidate()
        }
    }
    
    
    
    func serverOTP(mobileNumber : String, otpNumber : String) {
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        let parameters = [
                "ActionType":"Get Encrypted OTP",
                "MobileNo": mobileNumber,
                "OTP": otpNumber,
                "UserName":""
        ] as [String: Any]
        print(parameters)
        self.requestAPIs.serverOTP_API(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                    let response = result?.returnMessage ?? ""
                        print(response, "- OTP")
                        if response > "0"{
                            self.VC?.submitToRegistorData()
                        }else{
                            DispatchQueue.main.async{
                                self.VC?.view.makeToast("Invalid OTP".localiz(), duration: 2.0, position: .bottom)
                            }
                        }
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
