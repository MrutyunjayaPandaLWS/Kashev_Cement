//
//  KC_ActivateAccountSubmissionVM.swift
//  KeshavCement
//
//  Created by ADMIN on 01/03/2023.
//



import UIKit
import LanguageManager_iOS
class KC_ActivateAccountSubmissionVM{
    
    weak var VC: KC_ActivateAccountSubmissionVC?
    var requestAPIs = RestAPI_Requests()
    
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
                                    self.VC!.view.makeToast("Currentlycontactadministrator".localiz(), duration: 2.0, position: .bottom)
                                }
                            }else{
//                            self.VC?.addressTextView.text = "\(result?.lstCustomerJson?[0].address1 ?? "-"),\n\(result?.lstCustomerJson?[0].districtName ?? "-"),\n\(result?.lstCustomerJson?[0].stateName ?? "-"),\n \("India -")\(result?.lstCustomerJson?[0].zip ?? "-")\n\("PH")- \(result?.lstCustomerJson?[0].mobile ?? "-")\n\("Email")- \(result?.lstCustomerJson?[0].email ?? "-")"
//                            self.VC?.stateID = result?.lstCustomerJson?[0].stateId ?? -1
//                            self.VC?.mobile = result?.lstCustomerJson?[0].mobile ?? ""
//                            self.VC?.address1 = result?.lstCustomerJson?[0].address1 ?? "-"
//                            self.VC?.stateName = result?.lstCustomerJson?[0].stateName ?? "-"
//                            self.VC?.districtID = result?.lstCustomerJson?[0].districtId ?? -1
//                                self.VC?.districtName = result?.lstCustomerJson?[0].districtName ?? ""
//                            self.VC?.cityID = result?.lstCustomerJson?[0].cityId ?? -1
//                            self.VC?.cityName = result?.lstCustomerJson?[0].cityName ?? "-"
//                            self.VC?.pincode = result?.lstCustomerJson?[0].zip ?? ""
//                            self.VC?.countryID = result?.lstCustomerJson?[0].countryId ?? -1
//                            self.VC?.countryName = result?.lstCustomerJson?[0].countryName ?? "-"
//                        //    self.VC?.customerNameLbl.text = result?.lstCustomerJson?[0].firstName ?? "-"
//                            self.VC?.emailID = result?.lstCustomerJson?[0].email ?? "-"
                                self.VC?.selectedCustomerTypeId = response[0].customerTypeId ?? -1
                                self.VC?.customerTypeLbl.text = response[0].customerType ?? ""
                                self.VC?.fullNameTF.text = response[0].firstName ?? ""
                                self.VC?.firmNameTF.text = response[0].firstName ?? ""
                                self.VC?.mobileTF.text = response[0].mobile ?? ""
                                self.VC?.aadharNumberTF.text = response[0].aadharNumber ?? ""
                                self.VC?.emailTF.text = response[0].email ?? ""
                                self.VC?.addressTF.text = response[0].address1 ?? ""
                                self.VC?.pincodeTF.text = response[0].zip ?? ""
                                self.VC?.selectStateLbl.text = response[0].stateName ?? ""
                                self.VC?.selectDistrictLbl.text = response[0].districtName ?? ""
                                self.VC?.selectTalukLbl.text = response[0].talukName ?? ""
                                self.VC?.addressId = "\(response[0].addressId ?? -1)"
                                self.VC?.customerId = "\(response[0].customerId ?? -1)"
                                self.VC?.selectedDistrictId = response[0].districtId ?? -1
                                self.VC?.selectedStateId = response[0].stateId ?? -1
                                self.VC?.selectedTalukId = response[0].talukId ?? -1
                                
                                
//                                let customerImage = String(response[0].profilePicture ?? "").dropFirst(1)
//                                self.VC!.profileImage.kf.setImage(with: URL(string: PROMO_IMG1 + "\(customerImage)"), placeholder: UIImage(named: "ic_default_img"))
                                
                                
                           // self.VC?.redeemButton.isHidden = false
                            }}else{
                          //  self.VC?.redeemButton.isHidden = true
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
    
    func activateAccountSubmission(parameter: JSON){

        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        self.requestAPIs.activateAccountSubmissionApi(parameters: parameter) { (result, error) in

            if result == nil{
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
            }else{
                if error == nil{

                    let response = String(result?.returnMessage ?? "").split(separator: "~")
                    print(result?.returnMessage ?? "", "Activate Response")
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()

                        if response.count != 0 {
                            if response[0] == "1"{
                                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_SignUpSuccessPopVC") as! KC_SignUpSuccessPopVC
                                vc.modalTransitionStyle = .coverVertical
                                vc.modalPresentationStyle = .overFullScreen
                                self.VC!.present(vc, animated: true)
                            }else{
                                self.VC!.view.makeToast("Accountactivateisfailed".localiz(), duration: 3.0, position: .bottom)
                                for controller in self.VC!.navigationController!.viewControllers as Array {
                                    if controller.isKind(of: KC_ActivateAccountVC.self) {
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
