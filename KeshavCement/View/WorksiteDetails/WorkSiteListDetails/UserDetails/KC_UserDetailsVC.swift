//
//  KC_UserDetailsVC.swift
//  KeshavCement
//
//  Created by ADMIN on 09/01/2023.
//

import UIKit
import LanguageManager_iOS
class KC_UserDetailsVC: BaseViewController, UITextFieldDelegate{
    

    @IBOutlet weak var ownerDetailsLbl: UILabel!
    @IBOutlet weak var ownerNameLbl: UILabel!
    @IBOutlet weak var ownerNameTF: UITextField!
    @IBOutlet weak var ownerMobileNumberLbl: UILabel!
    @IBOutlet weak var ownerMobileTF: UITextField!
    @IBOutlet weak var ownerResidentialDetailsLbl: UILabel!
    @IBOutlet weak var ownerResidentialTextView: UITextView!
    @IBOutlet weak var engineerDetailsLbl: UILabel!
    @IBOutlet weak var engineerNameLbl: UILabel!
    @IBOutlet weak var engineerNameTF: UITextField!
    @IBOutlet weak var engineerNumbLbl: UILabel!
    @IBOutlet weak var engineerNumberTF: UITextField!
    
    @IBOutlet weak var engineerDetailVIew: UIView!
    @IBOutlet weak var nextBtn: UIButton!
    
    var ownerName = ""
    var ownerMobile = ""
    var ownerResidentialDetails = ""
    var engineerName = ""
    var engineerNumber = ""
    
    var strdata1 = ""
    var currentLatitude = ""
    var currentLongitude = ""
    var siteName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ownerMobileTF.delegate = self
        self.engineerNumberTF.delegate = self
        self.ownerMobileTF.keyboardType = .asciiCapableNumberPad
        self.engineerNumberTF.keyboardType = .asciiCapableNumberPad
        print(self.currentLatitude, "User Details List")
        
        if self.customerTypeId == "1"{
            self.engineerDetailVIew.isHidden = true
        }else{
            self.engineerDetailVIew.isHidden = false
        }
        self.ownerDetailsLbl.text = "OwnerDetails".localiz()
        self.ownerNameLbl.text = "OwnerName".localiz()
        self.ownerNameTF.placeholder = "Enterownername".localiz()
        self.ownerMobileNumberLbl.text = "OwnerMobileNumber".localiz()
        self.ownerMobileTF.placeholder = "Enterownermobilenumber".localiz()
        self.ownerResidentialDetailsLbl.text = "OwnerAddess".localiz()
        self.engineerDetailsLbl.text = "EngineerDetails".localiz()
        self.engineerNameLbl.text = "EngineerName".localiz()
        self.engineerNameTF.placeholder = "Enterengineername".localiz()
        self.engineerNumbLbl.text = "EngineerMobileNumber".localiz()
        self.engineerNumberTF.placeholder = "Enterengineermobilenumber".localiz()
        self.nextBtn.setTitle("Next".localiz(), for: .normal)
        
        
    }
    

    @IBAction func nextButton(_ sender: Any) {
        if self.customerTypeId == "1"{
            if self.ownerNameTF.text!.count == 0{
                self.view.makeToast("Enterownername".localiz(), duration: 2.0, position: .bottom)
            }else if self.ownerNameTF.text!.count > 15{
                self.ownerNameTF.text = ""
                self.view.makeToast("ownernameshouldbe15digits".localiz(), duration: 2.0, position: .bottom)
            }else if self.ownerMobileTF.text!.count == 0{
                self.view.makeToast("Enterownermobilenumber".localiz(), duration: 2.0, position: .bottom)
            }else if self.ownerMobileTF.text!.count != 10{
                self.view.makeToast("Entervalidownermobilenumber".localiz(), duration: 2.0, position: .bottom)
            }else if self.ownerResidentialTextView.text!.count == 0{
                self.view.makeToast("Enterownerresidentialdetails".localiz(), duration: 2.0, position: .bottom)
            }else{
                self.ownerName = self.ownerNameTF.text ?? ""
                self.ownerMobile = self.ownerMobileTF.text ?? ""
                self.ownerResidentialDetails = self.ownerResidentialTextView.text ?? ""
                self.engineerName = self.engineerNameTF.text ?? ""
                self.engineerNumber = self.engineerNumberTF.text ?? ""
            
                NotificationCenter.default.post(name: .navigateToWorkDetails, object: self)
            }
            
        }else{
            if self.ownerNameTF.text!.count == 0{
                self.view.makeToast("Enterownername".localiz(), duration: 2.0, position: .bottom)
            }else if self.ownerNameTF.text!.count > 15{
                self.ownerNameTF.text = ""
                self.view.makeToast("ownernameshouldbe15digits".localiz(), duration: 2.0, position: .bottom)
            }else if self.ownerMobileTF.text!.count == 0{
                self.view.makeToast("Enterownermobilenumber".localiz(), duration: 2.0, position: .bottom)
            }else if self.ownerMobileTF.text!.count != 10{
                self.view.makeToast("Entervalidownermobilenumber".localiz(), duration: 2.0, position: .bottom)
            }else if self.ownerResidentialTextView.text!.count == 0{
                self.view.makeToast("Enterownerresidentialdetails".localiz(), duration: 2.0, position: .bottom)
            }else if self.engineerNameTF.text!.count == 0{
                self.view.makeToast("Enterengineername".localiz(), duration: 2.0, position: .bottom)
            }else if self.engineerNumberTF.text!.count == 0{
                self.view.makeToast("Enterengineermobilenumber".localiz(), duration: 2.0, position: .bottom)
            }else if self.engineerNumberTF.text!.count != 10{
                self.view.makeToast("Entervalidengineermobilenumber".localiz(), duration: 2.0, position: .bottom)
            }else{
                self.ownerName = self.ownerNameTF.text ?? ""
                self.ownerMobile = self.ownerMobileTF.text ?? ""
                self.ownerResidentialDetails = self.ownerResidentialTextView.text ?? ""
                self.engineerName = self.engineerNameTF.text ?? ""
                self.engineerNumber = self.engineerNumberTF.text ?? ""
            
                NotificationCenter.default.post(name: .navigateToWorkDetails, object: self)
            }
        }
        
       
        
       
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 10
        if textField == ownerMobileTF{
            let currentString: NSString = (self.ownerMobileTF.text ?? "") as NSString
            let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }else if textField == engineerNumberTF{
            let currentString: NSString = (self.engineerNumberTF.text ?? "") as NSString
            let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        return true
    }
}
