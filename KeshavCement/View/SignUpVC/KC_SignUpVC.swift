//
//  SignUpVC.swift
//  KeshavCement
//
//  Created by ADMIN on 02/01/2023.
//

import UIKit
import LanguageManager_iOS

class KC_SignUpVC: BaseViewController, SelectedDataDelegate, DateSelectedDelegate, UITextFieldDelegate {
    func didTapCityName(_ vc: KC_DropDownVC) {
        self.selectedCityName = vc.selectedCityName
        self.selectedCityId = vc.selectedCityId
        self.cityLbl.text = vc.selectedCityName
    }
    func acceptDate(_ vc: KC_DOBVC) {
        if vc.isComeFrom == "DOB"{
            self.dobLbl.text = vc.selectedDate
            self.selectedDOB = vc.selectedDate
            
        }else if vc.isComeFrom == "ANNIVERSARY"{
            print(dobLbl.text)
            print(vc.selectedDate)
            if self.dobLbl.text ?? "" >= vc.selectedDate{
                vc.selectedDate = ""
                self.view.makeToast("AnniversaryDateofbirth".localiz(), duration: 2.0, position: .bottom)
            }else{
                self.dateOfAnniversaryLbl.text = vc.selectedDate
                self.selectedAnniversary = vc.selectedDate
            }
        }
    }
    
    
    func didTapCustomerType(_ vc: KC_DropDownVC) {
        self.customerTypeLbl.text = vc.selectedCustomerType
        self.selectedCustomerTypeId = vc.selectedCustomerTypeId
        self.selectedCustomerTypeName = vc.selectedCustomerType
        //        Sub dealer/ dealer - GST show and none mandatory
        //
        //        Engineer, Manson - Adhaar card, is not manditory
        if self.selectedCustomerTypeId == 1 || self.selectedCustomerTypeId == 2{
            self.aadharNumberLbl.text = "AadharNumber".localiz()
            self.aadharNumberTF.placeholder = "Enteraadharnumber".localiz()
            self.aadharNumberTF.keyboardType = .asciiCapableNumberPad
        }else if self.selectedCustomerTypeId == 3 || self.selectedCustomerTypeId == 4{
            self.aadharNumberLbl.text = "GSTNumber".localiz()
            self.aadharNumberTF.placeholder = "EnterGSTnumber".localiz()
            self.aadharNumberTF.keyboardType = .default
        }
    }
    
    func didTapState(_ vc: KC_DropDownVC) {
        self.selectStateLbl.text = vc.selectedStateName
        self.selectedStateName = vc.selectedStateName
        self.selectedStateId = vc.selectedStateId
        self.selectedDistrictId = -1
        self.selectedCityId = -1
        self.selectedTalukId = -1
        self.selectDistrictLbl.text = "SelectDistrict".localiz()
        self.selectTalukLbl.text = "SelectTaluk".localiz()
        self.cityLbl.text = "SelectCity".localiz()
    }
    
    func didTapDistrict(_ vc: KC_DropDownVC) {
        
        self.selectDistrictLbl.text = vc.selectedDistrictName
        self.selectedDistrictName = vc.selectedDistrictName
        self.selectedDistrictId = vc.selectedDistrictId
        self.selectedCityId = -1
        self.selectedTalukId = -1
        self.selectTalukLbl.text = "SelectTaluk".localiz()
        self.cityLbl.text = "SelectCity".localiz()
    }
    
    func didTapTaluk(_ vc: KC_DropDownVC) {
        self.selectTalukLbl.text = vc.selectedTalukName
        self.selectedTalukName = vc.selectedTalukName
        self.selectedTalukId = vc.selectedTalukId
        self.selectedCityId = -1
        self.cityLbl.text = "SelectCity".localiz()
    }
    

    @IBOutlet weak var customerTypeButton: UIButton!
    @IBOutlet weak var signUp: UILabel!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var backToLoginBtn: UIButton!
    @IBOutlet weak var signUpInfo: UILabel!
    @IBOutlet weak var customerTopicLbl: UILabel!
    @IBOutlet weak var customerTypeLbl: UILabel!
//    @IBOutlet weak var memberIDLbl: UILabel!
//    @IBOutlet weak var memberTF: UITextField!
    @IBOutlet weak var fullNameLbl: UILabel!
    @IBOutlet weak var fullNameTF: UITextField!
    @IBOutlet weak var firmLbl: UILabel!
    @IBOutlet weak var firmNameTF: UITextField!
    @IBOutlet weak var mobileLbl: UILabel!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var aadharNumberLbl: UILabel!
    @IBOutlet weak var aadharNumberTF: UITextField!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var pincodeLbl: UILabel!
    @IBOutlet weak var pincodeTF: UITextField!
    @IBOutlet weak var stateLbl: UILabel!
    @IBOutlet weak var selectStateLbl: UILabel!
    @IBOutlet weak var districtLbl: UILabel!
    @IBOutlet weak var selectDistrictLbl: UILabel!
    @IBOutlet weak var talukLbl: UILabel!
    @IBOutlet weak var selectTalukLbl: UILabel!
    
    @IBOutlet weak var cityTitle: UILabel!
    @IBOutlet weak var dobLbl: UILabel!
    @IBOutlet weak var dateOfAnniversaryLbl: UILabel!
   
    @IBOutlet weak var cityLbl: UILabel!
    
    @IBOutlet weak var doaTitleLbl: UILabel!
    @IBOutlet weak var dateOfBirthLbl: UILabel!
    var referralCode = ""
    var selectedCustomerTypeName = ""
    var selectedCustomerTypeId = -1
    var selectedStateId = -1
    var selectedStateName = ""
    var selectedDistrictName = ""
    var selectedDistrictId = -1
    var selectedTalukName = ""
    var selectedTalukId = -1
    
    var selectedCityName = ""
    var selectedCityId = -1
    
    var selectedDOB = ""
    var selectedAnniversary = ""
    var gstNumber = ""
    var aadharcarNumber = ""
    
    var enteredMobile = ""
    var customerTypeName = ""
    
    var itsFrom = ""
    var VM = KC_SignUpVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
       
        
        if self.customerTypeName == "Engineer"{
            self.selectedCustomerTypeId = 1
            self.aadharNumberTF.keyboardType = .asciiCapableNumberPad
        }else if self.customerTypeName == "Mason"{
            self.selectedCustomerTypeId = 2
            self.aadharNumberTF.keyboardType = .asciiCapableNumberPad
        }else if self.customerTypeName == "Dealer"{
            self.selectedCustomerTypeId = 3
            self.aadharNumberTF.keyboardType = .default
        }else{
            self.selectedCustomerTypeId = 4
            self.aadharNumberTF.keyboardType = .default
        }
        self.aadharNumberTF.autocapitalizationType = .allCharacters
        
        self.mobileTF.delegate = self
        self.pincodeTF.delegate = self
        self.mobileTF.keyboardType = .numberPad
        self.pincodeTF.keyboardType = .numberPad
        
        NotificationCenter.default.addObserver(self, selector: #selector(navigateToLogin), name: Notification.Name.navigateToLogin, object: nil)
        
      
        self.customerTypeLbl.text = self.customerTypeName
        print(self.customerTypeName, "aksdfjklasdfjfkldsjklfljkdfssdfklj")
        self.mobileTF.text = self.enteredMobile
        self.mobileTF.isUserInteractionEnabled = false
        
        self.signUp.text = "SignUp".localiz()
        self.signUpInfo.text = "plzFillRegister".localiz()
        self.customerTopicLbl.text = "CustomerType".localiz()
//        self.customerTypeLbl.text = "SelectCustomerType".localiz()
        self.fullNameLbl.text = "FullName".localiz()
        self.fullNameTF.placeholder = "Enterfullname".localiz()
        self.firmLbl.text = "FirmName".localiz();
        self.firmNameTF.placeholder = "Enterfirmname".localiz()
        self.mobileLbl.text = "MobileNumber".localiz()
        self.mobileTF.placeholder = "Entermobilenumber".localiz()
        if self.customerTypeName == "Engineer" || self.customerTypeName == "Mason"{
            self.aadharNumberLbl.text = "AadharNumber".localiz()
            self.aadharNumberTF.placeholder = "Enteraadharnumber".localiz()
        }else{
            self.aadharNumberLbl.text = "GSTNumber".localiz()
            self.aadharNumberTF.placeholder = "EnterGSTnumber".localiz()
        }
        self.emailLbl.text = "Email".localiz()
        self.emailTF.placeholder = "Enteremail".localiz()
        self.addressLbl.text = "Address".localiz()
        self.addressTF.placeholder = "EnterAddress".localiz()
        self.pincodeLbl.text = "Pincode".localiz()
        self.pincodeTF.placeholder = "EnterPincode".localiz()
        self.stateLbl.text = "State".localiz()
        self.selectStateLbl.text = "SelectState".localiz()
        self.districtLbl.text = "District".localiz()
        self.selectDistrictLbl.text = "SelectDistrict".localiz()
        self.talukLbl.text = "Taluk".localiz()
        self.selectTalukLbl.text = "SelectTaluk".localiz()
        self.cityLbl.text = "SelectCity".localiz()
        self.cityTitle.text = "City".localiz()
        self.dateOfBirthLbl.text = "DateofBirth".localiz()
        self.dobLbl.text = "SelectDOB".localiz()
        self.doaTitleLbl.text = "DateofAnniversary".localiz()
        self.dateOfAnniversaryLbl.text = "SelectAnniversary".localiz()
        self.backToLoginBtn.setTitle("Backtologin".localiz(), for: .normal)
        self.submitBtn.setTitle("Submit".localiz(), for: .normal)
        
    }
    
    @objc func navigateToLogin(){
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: KC_LoginVC.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }

    @IBAction func backToLogin(_ sender: Any) {
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: KC_LoginVC.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }
    @IBAction func emailValidationDidEnd(_ sender: Any) {
        if self.emailTF.text!.count != 0{
            if !isValidEmail(self.emailTF.text ?? "") {
                self.emailTF.text = ""
                self.view.makeToast("Entervalidemail".localiz(), duration: 2.0, position: .bottom)
        }
    }
    }
    
    @IBAction func selectStateBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_DropDownVC") as! KC_DropDownVC
        vc.itsFrom = "STATE"
        vc.delegate = self
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    
    @IBAction func customerTypeBtn(_ sender: Any) {
//        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_DropDownVC") as! KC_DropDownVC
//        vc.itsFrom = "CUSTOMERTYPE"
//        vc.delegate = self
//        vc.modalTransitionStyle = .coverVertical
//        vc.modalPresentationStyle = .overFullScreen
//        self.present(vc, animated: true)
    }
    
    @IBAction func selectDistrictBtn(_ sender: Any) {
        if self.selectedStateId == -1{
            self.view.makeToast("SelectState".localiz(), duration: 2.0, position: .bottom)
        }else{
            
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_DropDownVC") as! KC_DropDownVC
            vc.itsFrom = "DISTRICT"
            vc.delegate = self
            vc.selectedStateId = self.selectedStateId
            vc.modalTransitionStyle = .coverVertical
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }
    }
    
    @IBAction func selectTalukBtn(_ sender: Any) {
        if self.selectedDistrictId == -1{
            self.view.makeToast("SelectDistrict".localiz(), duration: 2.0, position: .bottom)
        }else{
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_DropDownVC") as! KC_DropDownVC
            vc.itsFrom = "TALUK"
            vc.delegate = self
            vc.selectedDistrictId = self.selectedDistrictId
            vc.modalTransitionStyle = .coverVertical
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }
    }
    
    @IBAction func dobButton(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_DOBVC") as! KC_DOBVC
        vc.isComeFrom = "DOB"
        vc.delegate = self
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    
    @IBAction func cityButton(_ sender: Any) {
        if self.selectedStateId == -1{
            self.view.makeToast("SelectState".localiz(), duration: 2.0, position: .bottom)
        }else{
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_DropDownVC") as! KC_DropDownVC
            vc.itsFrom = "CITY"
            vc.delegate = self
            vc.selectedStateId = self.selectedStateId
            vc.modalTransitionStyle = .coverVertical
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }
    }
    @IBAction func dateOfAnniversaryButton(_ sender: Any) {
        if self.dobLbl.text!.count == 0{
            self.view.makeToast("Pleasedateofbirth".localiz(), duration: 2.0, position: .bottom)
        }else{
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_DOBVC") as! KC_DOBVC
            vc.isComeFrom = "ANNIVERSARY"
            vc.delegate = self
            vc.receivedDate = self.dobLbl.text ?? ""
            vc.modalTransitionStyle = .coverVertical
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
            
        }
        
    }
    
    @IBAction func AadharNumberEditingDidEnd(_ sender: Any) {
        if self.selectedCustomerTypeId == 1 || self.selectedCustomerTypeId == 2{
            if self.aadharNumberTF.text!.count != 12{
                self.view.makeToast("Aadhar12digits".localiz(), duration: 2.0, position: .bottom)
                self.aadharNumberTF.text = ""
            }else{
                self.aadharcarNumber = self.aadharNumberTF.text ?? ""
            }
        }else if self.selectedCustomerTypeId == 3 || self.selectedCustomerTypeId == 4{
        
            if self.aadharNumberTF.text!.count != 15{
                self.view.makeToast("Gstnumberdigits".localiz(), duration: 2.0, position: .bottom)
                self.aadharNumberTF.text = ""
            }else{
                self.gstNumber = self.aadharNumberTF.text ?? ""
            }
        }
    }
  
    
    @IBAction func submitBtn(_ sender: Any) {
        
        if self.selectedCustomerTypeId == -1{
            self.view.makeToast("SelectCustomerType".localiz(), duration: 2.0, position: .bottom)
        }else if self.fullNameTF.text?.count == 0{
            self.view.makeToast("Enterfullname".localiz(), duration: 2.0, position: .bottom)
        }else if self.firmNameTF.text?.count == 0{
            self.view.makeToast("Enterfirmname".localiz(), duration: 2.0, position: .bottom)
        }else if self.mobileTF.text?.count == 0{
            self.view.makeToast("Entermobilenumber".localiz(), duration: 2.0, position: .bottom)
        }else if self.addressTF.text?.count == 0{
            self.view.makeToast("EnterAddress".localiz(), duration: 2.0, position: .bottom)
        }else if self.pincodeTF.text?.count == 0{
            self.view.makeToast("EnterPincode".localiz(), duration: 2.0, position: .bottom)
        }else if self.selectedStateId == -1{
            self.view.makeToast("SelectState".localiz(), duration: 2.0, position: .bottom)
        }else if self.selectedDistrictId == -1{
            self.view.makeToast("SelectDistrict".localiz(), duration: 2.0, position: .bottom)
        }else if self.selectedDOB == ""{
            self.view.makeToast("SelectDOB".localiz(), duration: 2.0, position: .bottom)
        }
//        else if self.selectedTalukId == -1{
//            self.view.makeToast("SelectTaluk".localiz(), duration: 2.0, position: .bottom)
//        }
        else{
            let parameter = [
                
                    "actiontype": "0",
                    "lstidentityinfo": [
                        [
                            "identityid": "2",
                            "identityno": "\(self.aadharcarNumber)",
                            "identitytype": "2"
                        ]
                    ],
                    "objcustomer": [
                        "address": "\(self.addressTF.text ?? "")",
                        "customeremail": "\(self.emailTF.text ?? "")",
                        "CustomerMobile": "\(self.mobileTF.text ?? "")",
                        "CustomerCityId": "\(self.selectedCityId)",
                        "CustomerStateId": "\(self.selectedStateId)",
                        "CustomerTypeID": "\(self.selectedCustomerTypeId)",
                        "CustomerZip": "\(self.pincodeTF.text ?? "")",
                        "DistrictId": "\(self.selectedDistrictId)",
                        "FirstName": "\(self.fullNameTF.text ?? "")",
                        "IsActive": "1",
                        "MerchantId": "1",
                        "ReferrerCode": self.referralCode,
                        "RegistrationSource": "3",
                        "TalukId": "\(self.selectedTalukId)",
                        "Anniversary": "\(self.selectedAnniversary)",
                        "DOB": "\(self.selectedDOB)"
                    ],
                    "ObjCustomerOfficalInfo": [
                        "CompanyName": "\(self.firmNameTF.text ?? "" )",
                        "OfficialGSTNumber": "\(self.gstNumber)"
                    ]
                
                
//                "ActionType": "0",
//                "ObjCustomer": [
//                    "FirstName": "\(self.fullNameTF.text ?? "")",
//                    "CustomerMobile": "\(self.mobileTF.text ?? "")",
//                    "CustomerEmail": "\(self.emailTF.text ?? "")",
//                    "CustomerStateId": "\(self.selectedStateId )",
//                    "DistrictId": "\(self.selectedDistrictId)",
//                    "TalukId": "\(self.selectedTalukId)",
//                    "RegistrationSource": "3",
//                    "CustomerZip": "\(self.pincodeTF.text ?? "")",
//                    "Address": "\(self.addressTF.text ?? "")",
//                    "MerchantId": "1",
//                    "ReferrerCode": self.referralCode,
//                    "IsActive": "1",
//                    "CustomerTypeID": "\(self.selectedCustomerTypeId)",
//                    "Anniversary": "\(self.selectedAnniversary)",
//                    "DOB": "\(self.selectedDOB)"
//                ],
//                "ObjCustomerOfficalInfo": [
//                    "CompanyName": "\(self.firmNameTF.text ?? "" )", //Firm Name
//                    "SAPCode": "\(self.memberTF.text ?? "")" //Member ID
//                ],
//                "lstIdentityInfo": [
//                    "IdentityID": "2",
//                    "IdentityType": "4",
//                    "IdentityNo":"\(self.aadharNumberTF.text ?? "")",
//                ]
            ] as [String: Any]
            print(parameter)
            self.VM.registrationSubmission(parameter: parameter)
        }
        
    }
    
    
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
      let compSepByCharInSet = string.components(separatedBy: aSet)
      let numberFiltered = compSepByCharInSet.joined(separator: "")
      if string == numberFiltered {
          if textField == mobileTF{
              let currentText = mobileTF.text ?? ""
              guard let stringRange = Range(range, in: currentText) else { return false }
              let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
              return updatedText.count <= 10
          }else if textField == pincodeTF {
              let currentText = pincodeTF.text ?? ""
              guard let stringRange = Range(range, in: currentText) else { return false }
              let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
              return updatedText.count <= 6
          }
      
      } else {
        return false
      }
        return false
    }
}
