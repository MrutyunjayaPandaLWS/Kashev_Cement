//
//  KC_MyProfileVM.swift
//  KeshavCement
//
//  Created by ADMIN on 17/02/2023.
//


import UIKit
import LanguageManager_iOS
class KC_MyProfileVM{
    
    weak var VC: KC_MyProfileVC?
    var requestAPIs = RestAPI_Requests()
    
    func myProfileImageListing(parameter: JSON){
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        self.requestAPIs.myProfile(parameters: parameter) { (result, error) in
            
            if result == nil{
                DispatchQueue.main.async {
                    self.VC?.startLoading()
                }
            }else{
                if error == nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        let response = result?.lstCustomerJson ?? []
                        
                        if response.count != 0 {
                            self.VC?.customerTypeTF.text = response[0].customerType ?? ""
                            self.VC?.fullNameTF.text = response[0].firstName ?? ""
                          
                            self.VC?.mobileNumberTF.text = response[0].mobile ?? ""
                           
                            self.VC?.emailTF.text = response[0].email ?? ""
                            self.VC?.addressTextView.text = response[0].address1 ?? ""
                            self.VC?.pincodeTF.text = response[0].zip ?? ""
                            self.VC?.stateTF.text = response[0].stateName ?? ""
                            self.VC?.districtTF.text = response[0].districtName ?? ""
                            self.VC?.talukTF.text = response[0].talukName ?? ""
                            self.VC?.addressId = "\(response[0].addressId ?? -1)"
                            self.VC?.customerId = "\(response[0].customerId ?? -1)"
                            self.VC?.districtId = "\(response[0].districtId ?? -1)"
                            self.VC?.stateId = "\(response[0].stateId ?? -1)"
                            self.VC?.cityID = "\(response[0].cityId ?? -1)"
                            self.VC?.talukId = "\(response[0].talukId ?? -1)"
                            self.VC?.cityTF.text = "\(response[0].cityName ?? "")"
                            let dateOfBirth = (response[0].jdob)?.split(separator: " ")
                            let aniv = (response[0].anniversary)?.split(separator: " ")
                            self.VC?.dobTF.text = "\(dateOfBirth?[0] ?? "")"
                            self.VC?.selectedDOB = "\(self.VC?.convertDateFormater("\(dateOfBirth?[0] ?? "")", fromDate: "dd/mm/yyyy", toDate: "yyyy-mm-dd") ?? "")"//"\(dateOfBirth?[0] ?? "")"
                            self.VC?.dateOfAnniverseryTF.text = "\(aniv?[0] ?? "")"
                            
                            let customerImage = String(response[0].profilePicture ?? "").dropFirst(1)
                            self.VC!.profileImage.kf.setImage(with: URL(string: PROMO_IMG1 + "\(customerImage)"), placeholder: UIImage(named: "ic_default_img"))
                            
                          
                        }
                        let response2 = result?.lstCustomerOfficalInfoJson ?? []
                        
                        if response2.count != 0 {
                            self.VC?.firmTF.text = response2[0].companyName ?? ""
                        }
                      
                        
                      
                        
                        if self.VC?.customerTypeId == "1" || self.VC?.customerTypeId == "2"{
                            let response2 = result?.lstCustomerIdentityInfo ?? []
                            if response2.count != 0 {
                                self.VC?.aadharNumberTF.text = response2[0].identityNo ?? ""
                            }
                            
                        }else{
                            let response1 = result?.lstCustomerOfficalInfoJson ?? []
                            if response1.count != 0 {
                                    self.VC?.aadharNumberTF.text = response1[0].gstNumber ?? ""
                                }
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
    
    
    func myProfileImageUploadApI(parameter: JSON){
        
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        self.requestAPIs.profileImageUpload_API(parameters: parameter) { (result, error) in
            
            if result == nil{
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
            }else{
                if error == nil{
                    
                    print(result?.returnMessage ?? "", "Profile Image Upload")
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        if result?.returnMessage ?? "" == "1"{
                            self.VC!.view.makeToast("Profileimageuploadedsuccessfully".localiz(), duration: 2.0, position: .bottom)
                        }else{
                            self.VC!.view.makeToast("SomethingwentwrongTryagainLater!".localiz(), duration: 2.0, position: .bottom)
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
    
    func myProfileDetailsUpdateApi(parameter: JSON){
        
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        self.requestAPIs.profileUpdateApi(parameters: parameter) { (result, error) in
            
            if result == nil{
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
            }else{
                if error == nil{
                    
                    print(result?.returnMessage ?? "", "Profile Image Upload")
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        if String(result?.returnMessage ?? "").prefix(1) == "1"{
                            self.VC!.view.makeToast("Profileuploadedsuccessfully!".localiz(), duration: 2.0, position: .bottom)
                        }else{
                            self.VC!.view.makeToast("SomethingwentwrongTryagainLater!".localiz(), duration: 2.0, position: .bottom)
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
