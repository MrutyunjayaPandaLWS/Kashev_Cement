//
//  KC_NewEnrollementVC.swift
//  KeshavCement
//
//  Created by ADMIN on 13/01/2023.
//

import UIKit

class KC_NewEnrollementVC: BaseViewController, SelectedDataDelegate, DateSelectedDelegate, UITextFieldDelegate {
    func didTapHelpTopic(_ vc: KC_DropDownVC) {}
    func didTapWorkLevel(_ vc: KC_DropDownVC) {}
   func didTapMappedUserName(_ vc: KC_DropDownVC) {}
    func didTapProductName(_ vc: KC_DropDownVC){}
    func didTapUserType(_ vc: KC_DropDownVC) {}
    
    func acceptDate(_ vc: KC_DOBVC) {
//        if vc.isComeFrom == "DOB"{
//            self.dobLbl.text = vc.selectedDate
//            self.selectedDOB = vc.selectedDate
//
//        }else{
//            self.dateOfAnniversaryLbl.text = vc.selectedDate
//            self.selectedAnniversary = vc.selectedDate
//        }
    }
    
    func declineDate(_ vc: KC_DOBVC) {}
    
    func didTapCustomerType(_ vc: KC_DropDownVC) {
        self.selectCustomerTypeLbl.text = vc.selectedCustomerType
        self.selectedCustomerTypeName = vc.selectedCustomerType
        
        if self.selectedCustomerTypeName == "Engineer"{
            self.selectedCustomerTypeId = 1
        }else if self.selectedCustomerTypeName == "Mason"{
            self.selectedCustomerTypeId = 2
        }else if self.selectedCustomerTypeName == "Sub Dealer"{
            self.selectedCustomerTypeId = 4
        }
    }
    
    func didTapState(_ vc: KC_DropDownVC) {
        self.selectStateLbl.text = vc.selectedStateName
        self.selectedStateName = vc.selectedStateName
        self.selectedStateId = vc.selectedStateId
    }
    
    func didTapDistrict(_ vc: KC_DropDownVC) {
        self.selectDistrictLBl.text = vc.selectedDistrictName
        self.selectedDistrictName = vc.selectedDistrictName
        self.selectedDistrictId = vc.selectedDistrictId
    }
    
    func didTapTaluk(_ vc: KC_DropDownVC) {
        self.selectTaluk.text = vc.selectedTalukName
        self.selectedTalukName = vc.selectedTalukName
        self.selectedTalukId = vc.selectedTalukId
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
    
    @IBOutlet weak var submitButton: UIButton!
    
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
    var VM = KC_NewEnrollmentVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.mobileTF.delegate = self
        self.pincodeTF.delegate = self
        self.mobileTF.keyboardType = .numberPad
        self.pincodeTF.keyboardType = .numberPad
        NotificationCenter.default.addObserver(self, selector: #selector(navigateToPrevious), name: Notification.Name.navigateToPrevious, object: nil)
    }
    
    @objc func navigateToPrevious(){
        self.navigationController?.popViewController(animated: true)
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
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_DropDownVC") as! KC_DropDownVC
        vc.itsFrom = "DISTRICT"
        vc.delegate = self
        vc.selectedStateId = self.selectedStateId
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    @IBAction func selectTalukBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_DropDownVC") as! KC_DropDownVC
        vc.itsFrom = "TALUK"
        vc.delegate = self
        vc.selectedDistrictId = self.selectedDistrictId
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
                
                    "ActionType": "0",
                    "HierarchyMapDetails": [
                        "CustomerUserID": "\(self.userID)"
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
                        "TalukId": "\(self.selectedTalukId)"
                    ],
                    "ObjCustomerOfficalInfo": [
                        "CompanyName": "\(self.firmNameTF.text ?? "")"
                    ]
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
