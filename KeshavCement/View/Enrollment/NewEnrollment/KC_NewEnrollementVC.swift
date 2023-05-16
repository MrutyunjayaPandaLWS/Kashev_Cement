//
//  KC_NewEnrollementVC.swift
//  KeshavCement
//
//  Created by ADMIN on 13/01/2023.
//

import UIKit
import LanguageManager_iOS

class KC_NewEnrollementVC: BaseViewController, SelectedDataDelegate, DateSelectedDelegate, UITextFieldDelegate {
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
                self.view.makeToast("AnniversarydateshouldbemorethenaDateofbirth".localiz(), duration: 2.0, position: .bottom)
            }else{
                self.dateOfAnniversaryLbl.text = vc.selectedDate
                self.selectedAnniversary = vc.selectedDate
            }
        }
    }
    
    func didTapCustomerType(_ vc: KC_DropDownVC) {
        self.selectCustomerTypeLbl.text = vc.selectedCustomerType
        self.selectedCustomerTypeName = vc.selectedCustomerType
        
        if self.selectedCustomerTypeName == "Engineer"{
            self.selectedCustomerTypeId = 1
        }else if self.selectedCustomerTypeName == "Mason"{
            self.selectedCustomerTypeId = 2
        }else if self.selectedCustomerTypeName == "Sub Dealer"{
            self.selectedCustomerTypeId = 4
        }else if self.selectedCustomerTypeName == "Dealer"{
            self.selectedCustomerTypeId = 3
        }else{
            self.selectedCustomerTypeId = 5
        }
    }
    
    func didTapState(_ vc: KC_DropDownVC) {
        self.selectStateLbl.text = vc.selectedStateName
        self.selectedStateName = vc.selectedStateName
        self.selectedStateId = vc.selectedStateId
        self.selectedDistrictId = -1
        self.selectedCityId = -1
        self.selectedTalukId = -1
        self.selectDistrictLBl.text = "SelectDistrict".localiz()
        self.selectTaluk.text = "SelectTaluk".localiz()
        self.cityLbl.text = "SelectCity".localiz()
    }
    
    func didTapDistrict(_ vc: KC_DropDownVC) {
        self.selectDistrictLBl.text = vc.selectedDistrictName
        self.selectedDistrictName = vc.selectedDistrictName
        self.selectedDistrictId = vc.selectedDistrictId
        self.selectedCityId = -1
        self.selectedTalukId = -1
        self.selectTaluk.text = "SelectTaluk".localiz()
        self.cityLbl.text = "SelectCity".localiz()

    }
    
    func didTapTaluk(_ vc: KC_DropDownVC) {
        self.selectTaluk.text = vc.selectedTalukName
        self.selectedTalukName = vc.selectedTalukName
        self.selectedTalukId = vc.selectedTalukId
        self.selectedCityId = -1
        self.cityLbl.text = "SelectCity".localiz()

    }
    
    @IBOutlet weak var talukLbl: UILabel!
    @IBOutlet weak var selectTaluk: UILabel!
    @IBOutlet weak var selectDistrictLBl: UILabel!
    @IBOutlet weak var districtLbl: UILabel!
    @IBOutlet weak var selectStateLbl: UILabel!
    @IBOutlet weak var stateLbl: UILabel!
    @IBOutlet weak var pincodeTF: UITextField!
    @IBOutlet weak var pincodeLbl: UILabel!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var mobileNumberLbl: UILabel!
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var firmNameTF: UITextField!
    @IBOutlet weak var firmNameLbl: UILabel!
    @IBOutlet weak var fullNameTF: UITextField!
    @IBOutlet weak var fullNameLbl: UILabel!
    @IBOutlet weak var selectCustomerTypeLbl: UILabel!
    @IBOutlet weak var customerTypeLbl: UILabel!
    @IBOutlet weak var headerTextLbl: UILabel!
    
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var dobLbl: UILabel!
    @IBOutlet weak var dateOfAnniversaryLbl: UILabel!
    
    @IBOutlet weak var customerTypeView: UIView!
    @IBOutlet weak var customerTypePriority: UILabel!
    
    @IBOutlet weak var fullNamePriority: UILabel!
    @IBOutlet weak var fullNameView: UIView!
    
    @IBOutlet weak var firmNamePriority: UILabel!
    @IBOutlet weak var firmView: UIView!
    
    @IBOutlet weak var emailView: UIView!
    
    @IBOutlet weak var addressPriority: UILabel!
    @IBOutlet weak var addressView: UIView!
    
    @IBOutlet weak var pincodePriority: UILabel!
    @IBOutlet weak var pinCodeView: UIView!
    
    @IBOutlet weak var statePriority: UILabel!
    @IBOutlet weak var stateView: UIView!
    
    @IBOutlet weak var districtPriority: UILabel!
    @IBOutlet weak var districtView: UIView!
    
    @IBOutlet weak var talukPriority: UILabel!
    @IBOutlet weak var talukView: UIView!
    
    @IBOutlet weak var cityTitleLbl: UILabel!
    @IBOutlet weak var cityView: UIView!
    
    @IBOutlet weak var dobTitleLbl: UILabel!
    @IBOutlet weak var dobPriority: UILabel!
    @IBOutlet weak var dobView: UIView!
    
    @IBOutlet weak var dateOfAnniversaryLbls: UILabel!
    
    @IBOutlet weak var anniversaryView: UIView!
    
    @IBOutlet weak var scrollViewHeightConstarint: NSLayoutConstraint!
    
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
    var VM = KC_NewEnrollmentVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.mobileTF.delegate = self
        self.pincodeTF.delegate = self
        self.mobileTF.keyboardType = .numberPad
        self.pincodeTF.keyboardType = .numberPad
        NotificationCenter.default.addObserver(self, selector: #selector(navigateToPrevious), name: Notification.Name.navigateToPrevious, object: nil)
        
        self.customerTypeLbl.isHidden = true; self.customerTypePriority.isHidden = true; self.customerTypeView.isHidden = true; self.fullNameLbl.isHidden = true; self.fullNamePriority.isHidden = true; self.fullNameView.isHidden = true; self.firmNameLbl.isHidden = true; self.firmNamePriority.isHidden = true; self.firmView.isHidden = true; self.emailLbl.isHidden = true; self.emailView.isHidden = true; self.addressLbl.isHidden = true; self.addressPriority.isHidden = true; self.addressView.isHidden = true; self.pincodeLbl.isHidden = true; self.pincodePriority.isHidden = true; self.pinCodeView.isHidden = true; self.stateLbl.isHidden = true; self.statePriority.isHidden = true; self.stateView.isHidden = true; self.districtLbl.isHidden = true; self.districtPriority.isHidden = true; self.districtView.isHidden = true; self.talukLbl.isHidden = true; self.talukPriority.isHidden = true; self.talukView.isHidden = true; self.cityTitleLbl.isHidden = true; self.cityView.isHidden = true; self.dobTitleLbl.isHidden = true; self.dobPriority.isHidden = true; self.dobView.isHidden = true; self.dateOfAnniversaryLbls.isHidden = true; self.anniversaryView.isHidden = true; self.submitButton.isHidden = true
            self.scrollViewHeightConstarint.constant = 1160
        
    }
    
    @objc func navigateToPrevious(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func emailValidationDidEnd(_ sender: Any) {
        if self.emailTF.text!.count != 0{
            if !isValidEmail(self.emailTF.text ?? "") {
                self.emailTF.text = ""
                self.view.makeToast("Entervalidemail".localiz(), duration: 2.0, position: .bottom)
            }
        }
    }
    @IBAction func backBTn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectCustomerTypeBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_DropDownVC") as! KC_DropDownVC
        if self.customerTypeId == "3"{
            vc.itsFrom = "CUSTOMERTYPE3"
        }else if self.customerTypeId == "4"{
            vc.itsFrom = "CUSTOMERTYPE4"
        }else if self.customerTypeId == "5"{
            vc.itsFrom = "CUSTOMERTYPE3"
        }
        
        vc.delegate = self
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    
    @IBAction func selectStateBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_DropDownVC") as! KC_DropDownVC
        vc.itsFrom = "STATE"
        vc.delegate = self
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
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
    
    @IBAction func dobButton(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_DOBVC") as! KC_DOBVC
        vc.isComeFrom = "DOB"
        vc.delegate = self
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    
    @IBAction func dateOfAnniversaryButton(_ sender: Any) {
        if self.dobLbl.text!.count == 0{
            self.view.makeToast("Pleaseselectdateofbirth".localiz(), duration: 2.0, position: .bottom)
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
    
    @IBAction func submitBtn(_ sender: Any) {
        
        if self.selectedCustomerTypeId == -1{
            self.view.makeToast("Selectcustomertype".localiz(), duration: 2.0, position: .bottom)
        }else if self.fullNameTF.text?.count == 0{
            self.view.makeToast("Enterfullname".localiz(), duration: 2.0, position: .bottom)
        }else if self.firmNameTF.text?.count == 0{
            self.view.makeToast("Enterfirmname".localiz(), duration: 2.0, position: .bottom)
        }else if self.mobileTF.text?.count == 0{
            self.view.makeToast("Entermobilenumber".localiz(), duration: 2.0, position: .bottom)
        }else if self.addressTF.text?.count == 0{
            self.view.makeToast("Enteraddress".localiz(), duration: 2.0, position: .bottom)
        }else if self.pincodeTF.text?.count == 0{
            self.view.makeToast("Enterpincode".localiz(), duration: 2.0, position: .bottom)
        }else if self.selectedStateId == -1{
            self.view.makeToast("SelectState".localiz(), duration: 2.0, position: .bottom)
        }else if self.selectedDistrictId == -1{
            self.view.makeToast("SelectDistrict".localiz(), duration: 2.0, position: .bottom)
        }else if self.selectedDOB == ""{
            self.view.makeToast("SelectDOB".localiz(), duration: 2.0, position: .bottom)
        }
//        else if self.selectedTalukId == -1{
//            self.view.makeToast("Select Taluk", duration: 2.0, position: .bottom)
//        }
        else{
            
            if self.customerTypeId == "5"{
                self.newCustomerSubmissionApi(customerID: UserDefaults.standard.string(forKey: "mappedCustomerId") ?? "")
                
            }else{
                self.newCustomerSubmissionApi(customerID: self.userID)
            }
        }
    }
        
        func newCustomerSubmissionApi(customerID: String){
            let parameter = [
                
                    "ActionType": "0",
                    "HierarchyMapDetails": [
                        "CustomerUserID": customerID
                    ],
                    "ObjCustomer": [
                        "Address": "\(self.addressTF.text ?? "")",
                        "CustomerEmail": "\(self.emailTF.text ?? "")",
                        "CustomerMobile": "\(self.mobileTF.text ?? "")",
                        "CustomerStateId": "\(self.selectedStateId)",
                        "CustomerTypeID": "\(self.selectedCustomerTypeId)",
                        "CustomerZip": "\(self.pincodeTF.text ?? "")",
                        "DistrictId": "\(self.selectedDistrictId)",
                        "FirstName": "\(self.firmNameTF.text ?? "")",
                        "IsActive": "1",
                        "MerchantId": "1",
                        "RegistrationSource": "3",
                        "TalukId": "\(self.selectedTalukId)",
                        "Anniversary": "\(self.selectedAnniversary)",
                        "DOB": "\(self.selectedDOB)"
                    ],
                    "ObjCustomerOfficalInfo": [
                        "CompanyName": "\(self.firmNameTF.text ?? "")"
                    ]
            ] as [String: Any]
            print(parameter)
            self.VM.registrationSubmission(parameter: parameter)
        }
    
    @IBAction func mobileEditingDidEnd(_ sender: Any) {
        if self.mobileTF.text?.count == 0 {
            self.view.makeToast("Entermobilenumber".localiz(), duration: 2.0, position: .bottom)
        }else if self.mobileTF.text?.count != 10 {
            self.view.makeToast("Entervalidmobilenumber".localiz(), duration: 2.0, position: .bottom)
        }else{
            let parameter = [
                "ActionType":"70",
                "ActorId": self.userID,
                "Location":[
                    "UserName":"\(self.mobileTF.text ?? "")"
                ]
            ] as [String: Any]
            print(parameter)
            self.VM.verifyMobileNumberAPI(paramters: parameter)
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
