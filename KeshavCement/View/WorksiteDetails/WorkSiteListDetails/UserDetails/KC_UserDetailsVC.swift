//
//  KC_UserDetailsVC.swift
//  KeshavCement
//
//  Created by ADMIN on 09/01/2023.
//

import UIKit

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
        
    }
    

    @IBAction func nextButton(_ sender: Any) {
        if self.ownerNameTF.text!.count == 0{
            self.view.makeToast("Enter owner name", duration: 2.0, position: .bottom)
        }else if self.ownerMobileTF.text!.count == 0{
            self.view.makeToast("Enter owner mobile number", duration: 2.0, position: .bottom)
        }else if self.ownerMobileTF.text!.count != 10{
            self.view.makeToast("Enter valid owner mobile number", duration: 2.0, position: .bottom)
        }else if self.ownerResidentialTextView.text!.count == 0{
            self.view.makeToast("Enter owner residential details", duration: 2.0, position: .bottom)
        }else if self.engineerNameTF.text!.count == 0{
            self.view.makeToast("Enter engineer name", duration: 2.0, position: .bottom)
        }else if self.engineerNumberTF.text!.count == 0{
            self.view.makeToast("Enter engineer mobile number", duration: 2.0, position: .bottom)
        }else if self.engineerNumberTF.text!.count != 10{
            self.view.makeToast("Enter valid engineer mobile number", duration: 2.0, position: .bottom)
        }else{
            self.ownerName = self.ownerNameTF.text ?? ""
            self.ownerMobile = self.ownerMobileTF.text ?? ""
            self.ownerResidentialDetails = self.ownerResidentialTextView.text ?? ""
            self.engineerName = self.engineerNameTF.text ?? ""
            self.engineerNumber = self.engineerNumberTF.text ?? ""
        
            NotificationCenter.default.post(name: .navigateToWorkDetails, object: self)
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
