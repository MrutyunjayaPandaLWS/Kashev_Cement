//
//  KC_EditAddressVC.swift
//  KeshavCement
//
//  Created by ADMIN on 07/01/2023.
//

import UIKit
protocol SendUpdatedAddressDelegate {
    func updatedAddressDetails(_ vc: KC_EditAddressVC)
}
class KC_EditAddressVC: BaseViewController, SelectedDataDelegate, UITextFieldDelegate {
    func didTapHelpTopic(_ vc: KC_DropDownVC) {}
    func didTapAmount(_ vc: KC_DropDownVC){}
    func didTapCityName(_ vc: KC_DropDownVC) {
           self.selectedCityName = vc.selectedCityName
           self.selectedCityId = vc.selectedCityId
           self.cityLbl.text = vc.selectedCityName
       }
    func didTapWorkLevel(_ vc: KC_DropDownVC) {}
    func didTapMappedUserName(_ vc: KC_DropDownVC) {}
    func didTapProductName(_ vc: KC_DropDownVC){}
    func didTapUserType(_ vc: KC_DropDownVC) {}
    func didTapCustomerType(_ vc: KC_DropDownVC) {}
    func didTapState(_ vc: KC_DropDownVC) {
        self.selectedStatelb.text = vc.selectedStateName
        self.selectedState = vc.selectedStateName
        self.selectedStateID = vc.selectedStateId
        self.selectedDistrictId = -1
        self.selectedCityId = -1
        self.districtLbl.text = "Select District"
        self.cityLbl.text = "Select City"
    }
    func didTapDistrict(_ vc: KC_DropDownVC) {
        self.selectedDistrictLbl.text = vc.selectedDistrictName
        self.selectedDistrictName = vc.selectedDistrictName
        self.selectedDistrictId = vc.selectedDistrictId
        self.selectedCityId = -1
        self.cityLbl.text = "Select City"
    }
    func didTapTaluk(_ vc: KC_DropDownVC) {}
    
    
    @IBOutlet weak var fullNameTF: UITextField!
    
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var selectedDistrictLbl: UILabel!
    @IBOutlet weak var selectedStatelb: UILabel!
    @IBOutlet weak var stateLbl: UILabel!
    @IBOutlet weak var pincodeTF: UITextField!

    @IBOutlet weak var flatHouseNameTF: UITextField!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var districtLbl: UILabel!
    @IBOutlet weak var pincodeLbl: UILabel!
    @IBOutlet weak var flathouseNameLbl: UILabel!
    @IBOutlet weak var mobileNumberLbl: UILabel!
    @IBOutlet weak var fullNameLbl: UILabel!
    @IBOutlet weak var cartCountLbl: UILabel!
    @IBOutlet weak var cartView: UIView!
    @IBOutlet weak var editAddressLbl: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    var delegate: SendUpdatedAddressDelegate!
    
    var selectedname = ""
    var selectedemail = ""
    var selectedmobile = ""
    var selectedState = ""
    var selectedStateID = 0
    var selectedCity = ""
    var selectedCityID = 0
    var selectedaddress = ""
    var selectedpincode = ""
    var selectedCountryId = 15
    var selectedCountry = ""
    
    var address1 = ""
    
    var selectedDistrictName = ""
    var selectedDistrictId = -1
    
    var selectedCityName = ""
    var selectedCityId = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        headerView.layer.masksToBounds = false
        headerView.layer.shadowRadius = 2
        headerView.layer.shadowOpacity = 0.2
        headerView.layer.shadowColor = UIColor.gray.cgColor
        headerView.layer.shadowOffset = CGSize(width: 0 , height:2)
        
        
//        self.flatHouseTextView.backgroundColor = UIColor.white
        
        //or self.tv_comments.backgroundColor = UIColor.clear
        //self.tv_comments.layer.backgroundColor = UIColor.white

//        self.flatHouseTextView.layer.shadowRadius = 2
//        self.flatHouseTextView.layer.shadowColor = UIColor.gray.cgColor
//        self.flatHouseTextView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
//        self.flatHouseTextView.layer.shadowOpacity = 0.4
//        self.flatHouseTextView.textColor = UIColor.lightGray
//        self.flatHouseTextView.layer.masksToBounds = false
        
        self.pincodeTF.delegate = self
        self.mobileTF.delegate = self
        self.fullNameTF.isEnabled = false
        self.mobileTF.isEnabled = false
        self.fullNameTF.text = selectedname
        self.mobileTF.text = selectedmobile
        self.flatHouseNameTF.text = selectedaddress
        
        if selectedState != "" {
            self.selectedStatelb.text = selectedState
        }else{
            self.selectedStatelb.text = "Select State"
        }
       
        if selectedDistrictName != ""{
            self.selectedDistrictLbl.text = self.selectedDistrictName
        }else{
            self.selectedDistrictLbl.text = "Select District"
        }
        
        self.pincodeTF.text = selectedpincode
    }

    @IBAction func backBTN(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func cartVCbtn(_ sender: Any) {
        
    }
    
    
    @IBAction func stateBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_DropDownVC") as! KC_DropDownVC
        vc.itsFrom = "STATE"
        vc.delegate = self
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    
    @IBAction func cityButton(_ sender: Any) {
        if self.selectedStateID == 0 || self.selectedStateID == -1{
            self.view.makeToast("Select State", duration: 2.0, position: .bottom)
        }else{
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_DropDownVC") as! KC_DropDownVC
            vc.itsFrom = "CITY"
            vc.delegate = self
            vc.selectedStateId = self.selectedStateID
            vc.modalTransitionStyle = .coverVertical
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }
    }
    
    
    @IBAction func selectedDistrictBtn(_ sender: Any) {
        if self.selectedStateID == 0 || self.selectedStateID == -1{
            self.view.makeToast("Select State", duration: 2.0, position: .bottom)
        }else{
            
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_DropDownVC") as! KC_DropDownVC
            vc.itsFrom = "DISTRICT"
            vc.delegate = self
            vc.selectedStateId = self.selectedStateID
            vc.modalTransitionStyle = .coverVertical
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }
    }
    @IBAction func saveBtn(_ sender: Any) {
        //Api Call
         if fullNameTF.text?.count == 0{
             self.view.makeToast("Enter full name", duration: 2.0, position: .bottom)
         }else if mobileTF.text?.count == 0 {
             self.view.makeToast("Enter mobile number", duration: 2.0, position: .bottom)
         }else if mobileTF.text?.count != 10 {
             self.view.makeToast("Enter valid mobile number", duration: 2.0, position: .bottom)
         }else if flatHouseNameTF.text?.count == 0{
             self.view.makeToast("Enter flat house address", duration: 2.0, position: .bottom)
             
         }else if selectedStatelb.text == "Select state"{
             self.view.makeToast("Select state", duration: 2.0, position: .bottom)
         }else if selectedStatelb.text == "Select district"{
             self.view.makeToast("Select district", duration: 2.0, position: .bottom)
         }else if pincodeTF.text?.count == 0{
             self.view.makeToast("Enter pin", duration: 2.0, position: .bottom)
         }else if pincodeTF.text?.count != 6{
             self.view.makeToast("Enter valid pin", duration: 2.0, position: .bottom)
         }else{
             self.view.makeToast("Shipping Address Updated", duration: 2.0, position: .bottom)
             self.selectedname = self.fullNameTF.text!
             self.selectedmobile = self.mobileTF.text!
             self.selectedaddress = self.flatHouseNameTF.text!
             self.selectedState = self.selectedStatelb.text!
             self.selectedDistrictName = self.selectedDistrictLbl.text!
             self.selectedpincode = self.pincodeTF.text!
             self.delegate.updatedAddressDetails(self)
             self.navigationController?.popViewController(animated: true)
         }
     
        
     }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 10
        let otpLength = 6
        if textField == mobileTF{
            let currentString: NSString = (mobileTF.text ?? "") as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }else if textField == pincodeTF{
            let currentString: NSString = (pincodeTF.text ?? "") as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= otpLength
        }
        return true
    }
    func isValidPhone(testStr:String) -> Bool {
        let phoneRegEx = "^[6-9]\\d{9}$"
        let phoneNumber = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        return phoneNumber.evaluate(with: testStr)
    }
}
