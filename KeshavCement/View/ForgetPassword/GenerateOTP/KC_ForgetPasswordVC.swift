//
//  KC_ForgetPasswordVC.swift
//  KeshavCement
//
//  Created by ADMIN on 02/01/2023.
//

import UIKit
import DPOTPView
import LanguageManager_iOS
class KC_ForgetPasswordVC: BaseViewController, DPOTPViewDelegate,UITextFieldDelegate{
   
    
    
    @IBOutlet weak var generateOTPButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var generateOTPBtn: UIButton!
    @IBOutlet weak var mobileNumberTF: UITextField!
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var otpLbl: UILabel!
    @IBOutlet weak var otpTimerLbl: UILabel!
    
    @IBOutlet weak var otpView: DPOTPView!
    
    @IBOutlet weak var otpInfoLbl2: UILabel!
    
    @IBOutlet weak var resendOTPBtn: UIButton!
    
    @IBOutlet weak var forgotPwdLbl: UILabel!
    @IBOutlet weak var forgotPwdTitle: UILabel!
    @IBOutlet weak var pleaseSetPwdLbl: UILabel!
    @IBOutlet weak var mobileNoLbl: UILabel!
    
    @IBOutlet weak var otpInfoLbl: UILabel!
    
    
    
    var VM = KC_ForgetPasswordVM()
    
    var enteredValue = ""
    var receivedOTP = ""
    var categoryId = -1
    var enteredMobileNumber = ""
    var newPassword = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
    
        self.generateOTPButtonTopConstraint.constant = 50
        self.otpView.isHidden = true
        self.otpLbl.isHidden = true
        self.otpTimerLbl.isHidden = true
        self.otpInfoLbl.isHidden = true
        self.otpInfoLbl2.isHidden = true
        self.resendOTPBtn.isHidden = true
        
        mainView.clipsToBounds = false
        mainView.layer.cornerRadius = 36
        mainView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        otpView.dpOTPViewDelegate = self
        otpView.fontTextField = UIFont.systemFont(ofSize: 25)
        otpView.textEdgeInsets = UIEdgeInsets(top: 0, left: -1, bottom: 0, right: 0)
        otpView.editingTextEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        self.generateOTPBtn.setTitle("GenerateOTP".localiz(), for: .normal)
        self.forgotPwdLbl.text = "ForgotPassword".localiz()
        self.forgotPwdTitle.text = "ForgotPassword".localiz()
        self.pleaseSetPwdLbl.text = "Pleasesetthenewpassword".localiz()
        self.mobileNoLbl.text = "MobileNumber".localiz()
        self.mobileNumberTF.placeholder = "Entermobilenumber".localiz()
        self.otpLbl.text = "OTP".localiz()
        self.otpInfoLbl.text = "OTPwillreciev".localiz()
        self.resendOTPBtn.setTitle("ResendOTP".localiz(), for: .normal)
        
        self.mobileNumberTF.delegate = self
        self.mobileNumberTF.keyboardType = .numberPad
    }
    
    @IBAction func userNameEditingDidEnd(_ sender: Any) {
        
//        if self.mobileNumberTF.text?.count == 0 {
//            self.view.makeToast("Enter mobile number/ member ID", duration: 2.0, position: .bottom)
//        }
//        else if self.mobileNumberTF.text?.count != 10 {
//            self.view.makeToast("Enter valid mobile number", duration: 2.0, position: .bottom)
//        }
//        else{
//            let mobilenumber = self.mobileNumberTF.text ?? ""
//
//            let getLastFour = String(mobilenumber.suffix(4))
//            print(getLastFour)
//            self.otpInfoLbl2.text = getLastFour
//
//            let parameter = [
//                "ActionType":"65",
//                "ActorId": self.categoryId,
//                "Location":[
//                    "UserName":"\(self.mobileNumberTF.text ?? "")"
//                ]
//            ] as [String: Any]
//            print(parameter)
//            self.VM.verifyMobileNumberAPI(paramters: parameter)
//
//        }
    }
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func resendButton(_ sender: Any) {
        if self.mobileNumberTF.text?.count == 0 {
            self.view.makeToast("Entermobilenumber".localiz(), duration: 2.0, position: .bottom)
        }else{
            self.generateOTPApi()
        }
    }
    
    @IBAction func generateOTPButton(_ sender: Any) {
            
        if self.generateOTPBtn.currentTitle == "GenerateOTP".localiz(){
                if self.mobileNumberTF.text?.count == 0 {
                    self.view.makeToast("EntermemberID".localiz(), duration: 2.0, position: .bottom)
                }else if (self.mobileNumberTF.text?.count ?? 0) < 10{
                    self.view.makeToast("EnterValidmobilenumber".localiz(), duration: 2.0, position: .bottom)
                }
               
                else{
                    let mobilenumber = self.mobileNumberTF.text ?? ""
                    
                    let getLastFour = String(mobilenumber.suffix(4))
                    print(getLastFour)
                    self.otpInfoLbl2.text = getLastFour
                    
                    let parameter = [
                        "ActionType":"61",
                        "ActorId": self.categoryId,
                        "Location":[
                            "UserName":"\(self.mobileNumberTF.text ?? "")"
                        ]
                    ] as [String: Any]
                    print(parameter)
                    self.VM.verifyMobileNumberAPI(paramters: parameter)
                    
                }
        }else if self.generateOTPBtn.currentTitle == "Submit".localiz(){
                print(self.enteredValue, "- Entered Value")
                if self.enteredValue.count == 0 {
                    self.view.makeToast("EnterOTP".localiz(), duration: 2.0, position: .bottom)
                }else if self.enteredValue.count != 6{
                    self.view.makeToast("EntervalidOTP".localiz(), duration: 2.0, position: .bottom)
                }
//            else if self.receivedOTP != self.enteredValue{
//                    self.view.makeToast("EntercorrectOTP".localiz(), duration: 2.0, position: .bottom)
//                }
            else{
                    self.VM.timer.invalidate()
                    self.VM.serverOTP(mobileNumber: self.mobileNumberTF.text ?? "", otpNumber: enteredValue)
                   
                }

            }

        }
    
    
    
    
    func submitAPI(){
        let parameter = [
            "Password": "123456",
            "UserName": "\(self.mobileNumberTF.text ?? "")",
                "UserActionType": "GetPasswordDetails",
                "Browser": "iOS",
                "LoggedDeviceName": "iOS",
                "PushID": "vfd87vuifu",
                "UserType": "Customer"
        ] as [String: Any]
        print(parameter)
        self.VM.loginSubmissionApi(parameter: parameter)
    }

    
    
    func generateOTPApi(){
        let parameter = [
            "UserName": "",
            "UserId": -1,
            "MobileNo": "\(self.mobileNumberTF.text ?? "")",
            "OTPType": "Enrollment",
            "MerchantUserName": MerchantUserName
        ] as [String: Any]
        print(parameter)
        self.VM.getOTPApi(parameter: parameter)
    }
    
    
    
    func dpOTPViewAddText(_ text: String, at position: Int) {
        print("addText:- " + text + " at:- \(position)" )
        self.enteredValue = "\(text)"
    }
    
    func dpOTPViewRemoveText(_ text: String, at position: Int) {
        print("removeText:- " + text + " at:- \(position)" )
        self.enteredValue = "\(text)"
    }
    
    func dpOTPViewChangePositionAt(_ position: Int) {
        print("at:-\(position)")
    }
    func dpOTPViewBecomeFirstResponder() {
        
    }
    func dpOTPViewResignFirstResponder() {
        
    }
    func isValidPhone(testStr:String) -> Bool {
        let phoneRegEx = "^[6-9]\\d{9}$"
        let phoneNumber = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        return phoneNumber.evaluate(with: testStr)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
      let compSepByCharInSet = string.components(separatedBy: aSet)
      let numberFiltered = compSepByCharInSet.joined(separator: "")

      if string == numberFiltered {
          let currentText = self.mobileNumberTF.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= 10
      } else {
        return false
      }
    }
}
