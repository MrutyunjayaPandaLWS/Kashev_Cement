//
//  KC_ActivateAccountVC.swift
//  KeshavCement
//
//  Created by ADMIN on 02/01/2023.
//

import UIKit
import DPOTPView
class KC_ActivateAccountVC: BaseViewController, UITextFieldDelegate {
  

    @IBOutlet weak var filterLbl: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var mobileNumberTF: UITextField!
    @IBOutlet weak var otpView: DPOTPView!
    @IBOutlet weak var otpTimerLbl: UILabel!
    
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var filterTableView: UITableView!
    
    @IBOutlet weak var otpLbl: UILabel!
    @IBOutlet weak var generateOTPBtn: UIButton!
    
    @IBOutlet weak var resendOtpBtn: UIButton!
    @IBOutlet weak var otpMobilenoLbl: UILabel!
    @IBOutlet weak var otpInfoLbl: UILabel!
    @IBOutlet weak var registerBtnStackView: UIStackView!
    
    @IBOutlet weak var topSpaceGenerateOTPBtn: NSLayoutConstraint!
    
    var filterTopicArray = ["Select","Engineer", "Mason", "Dealer", "Subdealer", "Support Executive"]
    var txtOTPView: DPOTPView!
    var enteredValue = ""
    var categoryId = -1
    var receivedOTP = ""
    var VM = KC_ActivateAccountVM()
    var customerTypValue = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.filterLbl.text = self.customerTypValue
        self.filterTableView.delegate = self
        self.filterTableView.dataSource = self
        self.mobileNumberTF.delegate = self
        self.filterView.isHidden = true
        self.generateOTPBtn.setTitle("Generate OTP", for: .normal)
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
    }


    @IBAction func filterViewActionBtn(_ sender: Any) {
        if self.filterView.isHidden == false{
            self.filterView.isHidden = true
        }else{
            self.filterView.isHidden = false
        }
    }
    
    @IBAction func userNameEditingDidEnd(_ sender: Any) {
//       if self.mobileNumberTF.text?.count == 0 {
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
//            self.otpMobilenoLbl.text = getLastFour
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
            
        //}
    }
    
    
    @IBAction func generateOTPActionBtn(_ sender: Any) {
        
        if self.generateOTPBtn.currentTitle == "Generate OTP"{
            if self.mobileNumberTF.text?.count == 0 {
                 self.view.makeToast("Enter mobile number/ member ID", duration: 2.0, position: .bottom)
             }
             else if self.mobileNumberTF.text?.count != 10 {
                 self.view.makeToast("Enter valid mobile number", duration: 2.0, position: .bottom)
             }
            else{
                let mobilenumber = self.mobileNumberTF.text ?? ""
                
                let getLastFour = String(mobilenumber.suffix(4))
                print(getLastFour)
                self.otpMobilenoLbl.text = getLastFour
                
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
        }else if self.generateOTPBtn.currentTitle == "Submit"{
            print(self.enteredValue, "- Entered Value")
            if self.enteredValue.count == 0 {
                self.view.makeToast("Enter OTP", duration: 2.0, position: .bottom)
            }else if self.enteredValue.count != 6{
                self.view.makeToast("Enter valid OTP", duration: 2.0, position: .bottom)
            }else if self.receivedOTP != self.enteredValue{
                self.view.makeToast("Enter correct OTP", duration: 2.0, position: .bottom)
            }else{
                self.VM.timer.invalidate()
                self.getAccountDetailsApi()
               
               
            }

        }

    }
    
    @IBAction func resendOTPBtn(_ sender: Any) {
        if self.mobileNumberTF.text?.count == 0 {
            self.view.makeToast("Enter mobile number", duration: 2.0, position: .bottom)
        }else if self.mobileNumberTF.text?.count != 10 {
            self.view.makeToast("Enter valid mobile number", duration: 2.0, position: .bottom)
        }else{
            self.generateOTPApi()
        }
    }
    @IBAction func backToLogin(_ sender: Any) {
       // self.navigationController?.popViewController(animated: true)
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: KC_LoginVC.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }
    
    func generateOTPApi(){
        let parameter = [
            "UserName": "",
            "UserId": -1,
            "MobileNo": "\(self.mobileNumberTF.text ?? "")",
            "OTPType": "Enrollment",
            "MerchantUserName": "KeshavCementDemo"
        ] as [String: Any]
        print(parameter)
        self.VM.getOTPApi(parameter: parameter)
    }
    func getAccountDetailsApi(){
        let parameter = [
            "ActionType": "6",
            "MerchantID": "1",
            "MobileNumber": "\(self.mobileNumberTF.text ?? "")"
        ] as [String:Any]
        print(parameter)
        self.VM.myAccountDetailsApi(parameters: parameter)
    }
}
extension KC_ActivateAccountVC:  DPOTPViewDelegate, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filterTopicArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "KC_ActivateTVC", for: indexPath) as! KC_ActivateTVC
        cell.titleLbl.text = self.filterTopicArray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.filterLbl.text = self.filterTopicArray[indexPath.row]
        self.filterView.isHidden = true
    }
    
    func dpOTPViewAddText(_ text: String, at position: Int) {
        print("addText:- " + text + " at:- \(position)" )
        self.enteredValue = "\(text)"
    }
    
    func dpOTPViewRemoveText(_ text: String, at position: Int) {
        print("removeText:- " + text + " at:- \(position)" )
        self.enteredValue = ""
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
