//
//  KC_NewEnrollmentVM.swift
//  KeshavCement
//
//  Created by ADMIN on 18/02/2023.
//
import UIKit
import LanguageManager_iOS
class KC_NewEnrollmentVM{
    
    weak var VC: KC_NewEnrollementVC?
    var requestAPIs = RestAPI_Requests()
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
                DispatchQueue.main.async{
                    
                    if str ?? "" == "0"{
                        self.VC?.customerTypeLbl.isHidden = false; self.VC?.customerTypePriority.isHidden = false; self.VC?.customerTypeView.isHidden = false; self.VC?.fullNameLbl.isHidden = false; self.VC?.fullNamePriority.isHidden = false; self.VC?.fullNameView.isHidden = false; self.VC?.firmNameLbl.isHidden = false; self.VC?.firmNamePriority.isHidden = false; self.VC?.firmView.isHidden = false; self.VC?.emailLbl.isHidden = false; self.VC?.emailView.isHidden = false; self.VC?.addressLbl.isHidden = false; self.VC?.addressPriority.isHidden = false; self.VC?.addressView.isHidden = false; self.VC?.pincodeLbl.isHidden = false; self.VC?.pincodePriority.isHidden = false; self.VC?.pinCodeView.isHidden = false; self.VC?.stateLbl.isHidden = false; self.VC?.statePriority.isHidden = false; self.VC?.stateView.isHidden = false; self.VC?.districtLbl.isHidden = false; self.VC?.districtPriority.isHidden = false; self.VC?.districtView.isHidden = false; self.VC?.talukLbl.isHidden = false; self.VC?.talukPriority.isHidden = true; self.VC?.talukView.isHidden = false; self.VC?.cityTitleLbl.isHidden = false; self.VC?.cityView.isHidden = false; self.VC?.dobTitleLbl.isHidden = false; self.VC?.dobPriority.isHidden = false; self.VC?.dobView.isHidden = false; self.VC?.dateOfAnniversaryLbls.isHidden = false; self.VC?.anniversaryView.isHidden = false; self.VC?.submitButton.isHidden = false
                        self.VC?.mobileTF.isEnabled = false
                        self.VC?.scrollViewHeightConstarint.constant = 1167
                    }else{
                        self.VC?.scrollViewHeightConstarint.constant = 1167
                        self.VC?.mobileTF.isEnabled = true
                        self.VC?.mobileTF.text = ""
                        self.VC?.view.makeToast("Themobilenumberalreadyexists".localiz(), duration: 2.0, position: .center)
                        self.VC?.customerTypeLbl.isHidden = true; self.VC?.customerTypePriority.isHidden = true; self.VC?.customerTypeView.isHidden = true; self.VC?.fullNameLbl.isHidden = true; self.VC?.fullNamePriority.isHidden = true; self.VC?.fullNameView.isHidden = true; self.VC?.firmNameLbl.isHidden = true; self.VC?.firmNamePriority.isHidden = true; self.VC?.firmView.isHidden = true; self.VC?.emailLbl.isHidden = true; self.VC?.emailView.isHidden = true; self.VC?.addressLbl.isHidden = true; self.VC?.addressPriority.isHidden = true; self.VC?.addressView.isHidden = true; self.VC?.pincodeLbl.isHidden = true; self.VC?.pincodePriority.isHidden = true; self.VC?.pinCodeView.isHidden = true; self.VC?.stateLbl.isHidden = true; self.VC?.statePriority.isHidden = true; self.VC?.stateView.isHidden = true; self.VC?.districtLbl.isHidden = true; self.VC?.districtPriority.isHidden = true; self.VC?.districtView.isHidden = true; self.VC?.talukLbl.isHidden = true; self.VC?.talukPriority.isHidden = true; self.VC?.talukView.isHidden = true; self.VC?.cityTitleLbl.isHidden = true; self.VC?.cityView.isHidden = true; self.VC?.dobTitleLbl.isHidden = true; self.VC?.dobPriority.isHidden = true; self.VC?.dobView.isHidden = true; self.VC?.dateOfAnniversaryLbls.isHidden = true; self.VC?.anniversaryView.isHidden = true; self.VC?.submitButton.isHidden = true
                    }
                   
                    
                        self.VC?.stopLoading()
                    
                        
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
                                self.VC!.view.makeToast("EnrollmentFailed".localiz(), duration: 3.0, position: .bottom)
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

