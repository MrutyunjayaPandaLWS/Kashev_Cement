//
//  KC_RegisterVC.swift
//  KeshavCement
//
//  Created by Arokia-M3 on 29/12/22.
//

import UIKit
import DPOTPView
import LanguageManager_iOS

class KC_RegisterVC:  BaseViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var activateNowLbl: UILabel!
    @IBOutlet weak var otpLbl: UILabel!
    @IBOutlet weak var mobileNumberLbl: UILabel!
    @IBOutlet weak var infoLbl: UILabel!
    @IBOutlet weak var signUpLbl: UILabel!
    @IBOutlet weak var filterLbl: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var mobileNumberTF: UITextField!
    @IBOutlet weak var otpView: DPOTPView!
    @IBOutlet weak var otpTimerLbl: UILabel!
    
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var filterTableView: UITableView!
    
    @IBOutlet weak var generateOTPBtn: UIButton!
    
    @IBOutlet weak var resendOtpBtn: UIButton!
    @IBOutlet weak var otpMobilenoLbl: UILabel!
    @IBOutlet weak var otpInfoLbl: UILabel!
    @IBOutlet weak var registerBtnStackView: UIStackView!
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var topSpaceGenerateOTPBtn: NSLayoutConstraint!
    
    @IBOutlet weak var alreadHaveLb: UILabel!
    @IBOutlet weak var activateInfo: UILabel!
    @IBOutlet weak var activateBtn: UIButton!
  //  var filterTopicArray = ["Select","Engineer", "Mason", "Dealer", "Subdealer", "Support Executive"]
    var txtOTPView: DPOTPView!
    var enteredValue = ""
    var selectedTopic = ""
    var enteredMobile = ""
    var categoryId = -1
    var categoryTitle = ""
    var receivedOTP = ""
    
    var VM = KC_RegisterVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customerTypeApi()
        self.VM.timer.invalidate()
        self.filterLbl.text = self.categoryTitle
        self.VM.VC = self
        self.mobileNumberTF.text = self.enteredMobile
        self.filterTableView.delegate = self
        self.filterTableView.dataSource = self
        self.mobileNumberTF.delegate = self
        self.filterView.isHidden = true
        
        self.otpInfoLbl.isHidden = true
        self.otpMobilenoLbl.isHidden = true
        self.resendOtpBtn.isHidden = true
        self.otpLbl.isHidden = true
        self.otpView.isHidden = true
        self.topSpaceGenerateOTPBtn.constant = 20
        self.otpTimerLbl.isHidden = true
        
        otpView.dpOTPViewDelegate = self
        otpView.fontTextField = UIFont.systemFont(ofSize: 25)
        otpView.textEdgeInsets = UIEdgeInsets(top: 0, left: -1, bottom: 0, right: 0)
        otpView.editingTextEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        if self.mobileNumberTF.text!.count != 10{
            self.otpView.text = ""
        }
        mainView.clipsToBounds = false
        mainView.layer.cornerRadius = 36
        mainView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        
        self.activateNowLbl.text = "ActivateNow".localiz()
        self.otpLbl.text = "OTP".localiz()
        self.mobileNumberLbl.text = "MobileNumber".localiz()
        self.infoLbl.text = "Pleaseregister".localiz()
        self.signUpLbl.text = "SignUp".localiz()
        self.generateOTPBtn.setTitle("GenerateOTP".localiz(), for: .normal)
        self.activateInfo.text = "StillNotAccount".localiz()
        self.alreadHaveLb.text = "Alreadyhaveanaccount".localiz()
        self.loginBtn.setTitle("Login".localiz(), for: .normal)
        self.resendOtpBtn.setTitle("ResendOTP".localiz(), for: .normal)
        
        
        
    }


    @IBAction func filterViewActionBtn(_ sender: Any) {
        if self.filterView.isHidden == false{
            self.filterView.isHidden = true
        }else{
            self.filterView.isHidden = false
        }
        
    }
    
    @IBAction func generateOTPActionBtn(_ sender: Any) {
        if self.generateOTPBtn.currentTitle == "GenerateOTP".localiz(){
        if self.mobileNumberTF.text?.count == 0 {
            self.view.makeToast("Entermobilenumber".localiz(), duration: 2.0, position: .bottom)
        }else if self.mobileNumberTF.text?.count != 10 {
            self.view.makeToast("Entervalidmobilenumber".localiz(), duration: 2.0, position: .bottom)
        }else if self.categoryId == -1{
            self.view.makeToast("Selectcustomertype".localiz(), duration: 2.0, position: .bottom)
        }else{
            let mobilenumber = self.mobileNumberTF.text ?? ""
            
            let getLastFour = String(mobilenumber.suffix(4))
            print(getLastFour)
            self.otpInfoLbl.text = getLastFour
            
            let parameter = [
                "ActionType":"65",
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
            }else if self.receivedOTP != self.enteredValue{
                self.view.makeToast("EntercorrectOTP".localiz(), duration: 2.0, position: .bottom)
            }else{
                self.VM.timer.invalidate()
                if self.categoryId == 1 || self.categoryId == 2{
                    let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_RegistrationReferralCodeVC") as! KC_RegistrationReferralCodeVC
                    vc.referralCode = "Check"
                    vc.enteredMobile = self.mobileNumberTF.text ?? ""
                    vc.customerTypeName = self.filterLbl.text ?? ""
                    print(self.filterLbl.text ?? "", "asdfkasdhlfahksdflahlksdfhklads")
                    self.navigationController?.pushViewController(vc, animated: true)
                }else{
                    let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_SignUpVC") as! KC_SignUpVC
                    vc.enteredMobile = self.mobileNumberTF.text ?? ""
                    vc.customerTypeName = self.filterLbl.text ?? ""
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
            }

        }

    }
    
    @IBAction func resendOTPBtn(_ sender: Any) {
        
        if self.mobileNumberTF.text?.count == 0 {
            self.view.makeToast("Entermobilenumber".localiz(), duration: 2.0, position: .bottom)
        }else if self.mobileNumberTF.text?.count != 10 {
            self.view.makeToast("Entervalidmobilenumber".localiz(), duration: 2.0, position: .bottom)
        }else{
            self.generateOTPApi()
        }
//        self.filterView.isHidden = true
//        self.generateOTPBtn.setTitle("Generate OTP", for: .normal)
//        self.otpInfoLbl.isHidden = true
//        self.otpMobilenoLbl.isHidden = true
//        self.resendOtpBtn.isHidden = true
//        self.otpLbl.isHidden = true
//        self.otpView.isHidden = true
//        self.topSpaceGenerateOTPBtn.constant = 20
    }
    
    @IBAction func activateNowBtn(_ sender: Any) {
        self.VM.timer.invalidate()
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_ActivateAccountVC") as! KC_ActivateAccountVC
        vc.customerTypValue = self.filterLbl.text ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func backToLogin(_ sender: Any) {
        self.VM.timer.invalidate()
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func userNameEditingDidEnd(_ sender: Any) {
        
//        if self.mobileNumberTF.text?.count == 0 {
//            self.view.makeToast("Enter mobile number", duration: 2.0, position: .bottom)
//        }else if self.mobileNumberTF.text?.count != 10 {
//            self.view.makeToast("Enter valid mobile number", duration: 2.0, position: .bottom)
//        }else if self.categoryId == -1{
//            self.view.makeToast("Select customer type", duration: 2.0, position: .bottom)
//        }else{
//            let mobilenumber = self.mobileNumberTF.text ?? ""
//            
//            let getLastFour = String(mobilenumber.suffix(4))
//            print(getLastFour)
//            self.otpInfoLbl.text = getLastFour
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
//        }
    }
    
    func customerTypeApi(){
        
        let parameter = [
            "ActionType":"33"
        ] as [String: Any]
        print(parameter)
        self.VM.customerTypeListApi(parameter: parameter)
        
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
    
}
extension KC_RegisterVC:  DPOTPViewDelegate, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VM.customerTypeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "KC_RegisterFilterTVC", for: indexPath) as! KC_RegisterFilterTVC
        cell.titleLbl.text = self.VM.customerTypeArray[indexPath.row].attributeValue ?? ""
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.filterLbl.text = self.VM.customerTypeArray[indexPath.row].attributeValue ?? ""
        self.filterView.isHidden = true
        self.selectedTopic = self.VM.customerTypeArray[indexPath.row].attributeValue ?? ""
        self.categoryId = self.VM.customerTypeArray[indexPath.row].attributeId ?? -1
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
