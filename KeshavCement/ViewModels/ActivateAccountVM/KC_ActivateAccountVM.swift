//
//  KC_ActivateAccountVM.swift
//  KeshavCement
//
//  Created by ADMIN on 01/03/2023.
//

import LanguageManager_iOS
import UIKit
class KC_ActivateAccountVM{
    
    weak var VC: KC_ActivateAccountVC?
    var requestAPIs = RestAPI_Requests()
    var count = 0
    var timer = Timer()
    func myAccountDetailsApi(parameters: JSON){
        self.VC?.startLoading()
        self.requestAPIs.getAccountDetailsForActivateApi(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        let response = result?.lstCustomerJson ?? []
                        
                        if response.count != 0{
                            if response[0].customerId ?? 0 == 0{
                                DispatchQueue.main.async{
                                    self.VC!.view.makeToast("NotmappedToAnyDealer".localiz(), duration: 2.0, position: .bottom)
                                }
                            }else{
                                if response[0].isActive ?? -1 == 1{
                                    self.VC!.filterView.isHidden = true
                                    self.VC!.generateOTPBtn.setTitle("GenerateOTP".localiz(), for: .normal)
                                    self.VC!.otpInfoLbl.isHidden = true
                                    self.VC!.otpMobilenoLbl.isHidden = true
                                    self.VC!.resendOtpBtn.isHidden = true
                                    self.VC!.otpLbl.isHidden = true
                                    self.VC!.otpView.isHidden = true
                                    self.VC!.topSpaceGenerateOTPBtn.constant = 20
                                    self.VC!.otpTimerLbl.isHidden = true
                                    self.VC!.mobileNumberTF.text = ""
                                    self.VC!.otpView.text = ""
                                    self.VC!.view.makeToast("Thiscustomerisalreadyactivated".localiz(), duration: 2.0, position: .bottom)
                                }else{
                                    let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_ActivateAccountSubmissionVC") as! KC_ActivateAccountSubmissionVC
                                    vc.enteredMobileNumber = self.VC?.mobileNumberTF.text ?? ""
                                    self.VC?.navigationController?.pushViewController(vc, animated: true)
                                }
                            }}else{
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
                        self.VC?.generateOTPBtn.setTitle("Submit".localiz(), for: .normal)
                        self.VC?.otpInfoLbl.isHidden = false
                        self.VC?.otpMobilenoLbl.isHidden = false
                        self.VC?.resendOtpBtn.isHidden = false
                        self.VC?.otpLbl.isHidden = false
                        self.VC?.otpView.isHidden = false
                        self.VC?.otpTimerLbl.isHidden = false
                        self.VC?.topSpaceGenerateOTPBtn.constant = 122
                       
                        self.VC?.generateOTPApi()
                    }
                }else if str ?? "" == "3"{
                    DispatchQueue.main.async{
                        self.VC?.stopLoading()
                        self.VC?.view.makeToast("Invaildcustomertype".localiz(), duration: 2.0, position: .bottom)
                        self.VC?.generateOTPBtn.setTitle("GenerateOTP".localiz(), for: .normal)
                        self.VC?.mobileNumberTF.text = ""
                    }
                }else if str ?? "" != "1"{
                    DispatchQueue.main.async{
                        self.VC?.stopLoading()
                        self.VC?.view.makeToast("Mobilenumberdoesntexists".localiz(), duration: 2.0, position: .bottom)
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
            self.VC?.resendOtpBtn.isHidden = true
            
        }else{
            self.VC?.resendOtpBtn.isHidden = false
            self.timer.invalidate()
        }
    }
    
    
}

