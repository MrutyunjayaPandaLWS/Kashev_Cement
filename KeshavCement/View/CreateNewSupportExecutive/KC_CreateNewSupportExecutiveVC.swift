//
//  KC_CreateNewSupportExecutiveVC.swift
//  KeshavCement
//
//  Created by ADMIN on 13/01/2023.
//

import UIKit
import LanguageManager_iOS

class KC_CreateNewSupportExecutiveVC: BaseViewController, UITextFieldDelegate {

    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var passwordLbl: UILabel!
    @IBOutlet weak var mobileLbl: UILabel!
    @IBOutlet weak var headerText: UILabel!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    
    var VM = KC_SubmitNewExecutiveVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mobileTF.delegate = self
        self.mobileTF.keyboardType = .asciiCapable
        self.VM.VC = self
        self.submitBtn.setTitle("Submit".localiz(), for: .normal)
        self.nameLbl.text = "Name".localiz()
        self.mobileLbl.text = "MobileNumber".localiz()
        self.passwordLbl.text = "Password".localiz()
        
        self.nameTF.attributedPlaceholder = NSAttributedString(
            string: "Entername".localiz(),
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        self.nameTF.textColor = .white

        self.passwordTF.attributedPlaceholder = NSAttributedString(
            string: "Enterpassword".localiz(),
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        self.passwordTF.textColor = .white
        self.mobileTF.attributedPlaceholder = NSAttributedString(
            string: "Entermobilenumber".localiz(),
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        self.mobileTF.textColor = .white
        
        NotificationCenter.default.addObserver(self, selector: #selector(navigateToPrevious), name: Notification.Name.navigateToSupport, object: nil)
        
    }
    
    @objc func navigateToPrevious(){
        self.navigationController?.popViewController(animated: true)
        
    }
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func submitButton(_ sender: Any) {
        
        if self.nameTF.text?.count == 0{
            self.view.makeToast("Entername".localiz(), duration: 2.0, position: .bottom)
        }else if self.mobileTF.text?.count == 0{
            self.view.makeToast("Entermobilenumber".localiz(), duration: 2.0, position: .bottom)
        }else if self.mobileTF.text?.count != 10{
            self.view.makeToast("Entervalidmobilenumber".localiz(), duration: 2.0, position: .bottom)
        }else if self.passwordTF.text?.count == 0{
            self.view.makeToast("Enterpassword".localiz(), duration: 2.0, position: .bottom)
        }else{
            self.createNewSupport()
        }
    }
    
    func createNewSupport(){
        
        let parameter = [
            "ActionType": "0",
            "HierarchyMapDetails": [
                "CustomerUserID": "\(self.userID)"
            ],
            "ObjCustomer": [
                "CustomerMobile": "\(self.mobileTF.text ?? "")",
                "CustomerTypeID": "5",
                "FirstName": "\(self.nameTF.text ?? "")",
                "IsActive": "1",
                "MerchantId": "1",
                "RegistrationSource": "3",
                "Password": "\(self.passwordTF.text ?? "")"
            ]
        ] as [String: Any]
        print(parameter)
        self.VM.createNewExecutiveApi(parameter: parameter)
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      let aSet = NSCharacterSet(charactersIn:"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz").inverted
      let compSepByCharInSet = string.components(separatedBy: aSet)
      let numberFiltered = compSepByCharInSet.joined(separator: "")

      if string == numberFiltered {
          let currentText = self.mobileTF.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= 10
      } else {
        return false
      }
    }

}
