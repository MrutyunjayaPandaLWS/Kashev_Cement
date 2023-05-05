//
//  KC_ActivateAccountSubmissionVC.swift
//  KeshavCement
//
//  Created by ADMIN on 01/03/2023.
//

import UIKit
import LanguageManager_iOS

class KC_ActivateAccountSubmissionVC: BaseViewController, SelectedDataDelegate, DateSelectedDelegate, UITextFieldDelegate {
    func didTapCityName(_ vc: KC_DropDownVC) {
           self.selectedCityName = vc.selectedCityName
           self.selectedCityId = vc.selectedCityId
           self.cityLbl.text = vc.selectedCityName
       }
    func acceptDate(_ vc: KC_DOBVC) {
        if vc.isComeFrom == "DOB"{
            self.dobLbl.text = vc.selectedDate
            self.selectedDOB = vc.selectedDate
            
        }else{
            self.dateOfAnniversaryLbl.text = vc.selectedDate
            self.selectedAnniversary = vc.selectedDate
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
        }else if self.selectedCustomerTypeId == 3 || self.selectedCustomerTypeId == 4{
            self.aadharNumberLbl.text = "GSTNumber".localiz()
            self.aadharNumberTF.placeholder = "EnterGSTnumber".localiz()
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
    

    @IBOutlet weak var signUp: UILabel!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var backToLoginBtn: UIButton!
    @IBOutlet weak var signUpInfo: UILabel!
    @IBOutlet weak var customerTopicLbl: UILabel!
    @IBOutlet weak var customerTypeLbl: UILabel!
    @IBOutlet weak var memberIDLbl: UILabel!
    @IBOutlet weak var memberTF: UITextField!
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
    
    @IBOutlet weak var dobLbl: UILabel!
    @IBOutlet weak var dateOfAnniversaryLbl: UILabel!
   
    @IBOutlet weak var cityLbl: UILabel!
    
    var receiverName = ""
    var address = ""
    var stateID = -1
    var stateName = ""
    var districtID = -1
    var districtName = ""
    var cityID = -1
    var cityName = ""
    var pincode = ""
    var emailID = ""
    var address1 = ""
    var countryID = -1
    var countryName = ""
    var redemptionDate = ""
    var totalPoints = 0
    var mobile = ""
    var addressId = ""
    
    var customerId = ""
    
    var referralCode = ""
    var selectedCustomerTypeName = ""
    var selectedCustomerTypeId = -1
    var selectedStateId = -1
    var selectedStateName = ""
    var selectedDistrictName = ""
    var selectedDistrictId = -1
    var selectedTalukName = ""
    var selectedTalukId = -1
    
    var selectedDOB = ""
    var selectedAnniversary = ""
    var enteredMobileNumber = ""
    
    var selectedCityName = ""
    var selectedCityId = -1
    
    var VM = KC_ActivateAccountSubmissionVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.mobileTF.delegate = self
        self.pincodeTF.delegate = self
        self.mobileTF.keyboardType = .numberPad
        self.pincodeTF.keyboardType = .numberPad
        NotificationCenter.default.addObserver(self, selector: #selector(navigateToLogin), name: Notification.Name.navigateToLogin, object: nil)
        self.getAccountDetailsApi()
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
    
    @IBAction func selectStateBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_DropDownVC") as! KC_DropDownVC
        vc.itsFrom = "STATE"
        vc.delegate = self
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    
    @IBAction func customerTypeBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_DropDownVC") as! KC_DropDownVC
        vc.itsFrom = "CUSTOMERTYPE"
        vc.delegate = self
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    
    @IBAction func selectDistrictBtn(_ sender: Any) {
        if self.selectedStateId == -1{
            self.view.makeToast("Select State", duration: 2.0, position: .bottom)
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
            self.view.makeToast("Select District", duration: 2.0, position: .bottom)
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
    
    @IBAction func cityButton(_ sender: Any) {
        if self.selectedStateId == -1{
            self.view.makeToast("Select State", duration: 2.0, position: .bottom)
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
    
    
    
    @IBAction func dobButton(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_DOBVC") as! KC_DOBVC
        vc.isComeFrom = "DOB"
        vc.delegate = self
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    
    @IBAction func dateOfAnniversaryButton(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_DOBVC") as! KC_DOBVC
        vc.isComeFrom = "Anniversary"
        vc.delegate = self
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    @IBAction func submitBtn(_ sender: Any) {
        
        if self.selectedCustomerTypeId == -1{
            self.view.makeToast("Select customer type", duration: 2.0, position: .bottom)
        }else if self.fullNameTF.text?.count == 0{
            self.view.makeToast("Enter full name", duration: 2.0, position: .bottom)
        }else if self.firmNameTF.text?.count == 0{
            self.view.makeToast("Enter firm name", duration: 2.0, position: .bottom)
        }else if self.mobileTF.text?.count == 0{
            self.view.makeToast("Enter mobile number", duration: 2.0, position: .bottom)
        }else if self.emailTF.text?.count != 0 {
            if !isValidEmail(self.emailTF.text ?? "") {
                self.view.makeToast("Enter valid email", duration: 2.0, position: .bottom)
            }
        }else if self.addressTF.text?.count == 0{
            self.view.makeToast("Enter address", duration: 2.0, position: .bottom)
        }else if self.pincodeTF.text?.count == 0{
            self.view.makeToast("Enter pincode", duration: 2.0, position: .bottom)
        }else if self.selectedStateId == -1{
            self.view.makeToast("Select State", duration: 2.0, position: .bottom)
        }else if self.selectedDistrictId == -1{
            self.view.makeToast("Select District", duration: 2.0, position: .bottom)
        }else if self.selectedTalukId == -1{
            self.view.makeToast("Select Taluk", duration: 2.0, position: .bottom)
        }else{
            let parameter = [
                    "ActionType": "262",
                    "ActorId": "\(self.customerId)",
                    "ObjCustomerJson": [
                        "Address1": "\(self.addressTF.text ?? "")",
                        "StateId": "\(self.selectedStateId)",
                        "CustomerId": "\(self.customerId)",
                        "FirstName": "\(self.fullNameTF.text ?? "")",
                        "Mobile": "\(self.mobileTF.text ?? "")",
                        "Zip": "\(self.pincodeTF.text ?? "")",
                        "DistrictId": "\(self.selectedDistrictId)",
                        "TalukId": "\(self.selectedTalukId)",
                        "Email": "\(self.emailTF.text ?? "")",
                        "RELATED_PROJECT_TYPE":"KESHAV_CEMENT",
                        "AddressId":"\(self.addressId)"
                    ],
                    "ObjCustomerOfficalInfo": [
                        "CompanyName": "\(self.firmNameTF.text ?? "") ",
                        "SapNo": "\(self.memberTF.text ?? "")", //MEMBER id
                        "GSTNumber": "\(self.aadharNumberTF.text ?? "")" //FOR ADDHAR AND GST
                    ]
                
            ] as [String: Any]
            print(parameter)
           self.VM.activateAccountSubmission(parameter: parameter)
        }
        
    }
    
    func getAccountDetailsApi(){
        let parameter = [
            "ActionType": "6",
            "MerchantID": "1",
            "MobileNumber": "\(self.enteredMobileNumber)"
        ] as [String:Any]
        print(parameter)
        self.VM.myAccountDetailsApi(parameters: parameter)
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
