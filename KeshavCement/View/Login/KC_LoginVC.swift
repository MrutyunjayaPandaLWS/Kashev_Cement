//
//  KC_LoginVC.swift
//  KeshavCement
//
//  Created by Arokia-M3 on 28/12/22.
//

import UIKit
import Toast_Swift
import LanguageManager_iOS
class KC_LoginVC: BaseViewController, UITextFieldDelegate, CheckBoxSelectDelegate{
    func accept(_ vc: HR_TermsandCondtionVC) {
        self.termsandConditionBtn.setImage(UIImage(named: "black-check-box-with-white-check 1"), for: .normal)
        self.status = 1
    }
    
    func decline(_ vc: HR_TermsandCondtionVC) {
        self.termsandConditionBtn.setImage(UIImage(named: "check-box-empty"), for: .normal)
        self.status = 0
    }
    @IBOutlet weak var activateNowBtn: UIButton!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var loginInfoLbl: UILabel!
    @IBOutlet weak var loginLbl: UILabel!
    @IBOutlet weak var filterLbl: UILabel!
    
    @IBOutlet weak var filterTableView: UITableView!
    @IBOutlet weak var mobileNoLbl: UILabel!
    
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var passwordLbl: UILabel!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var forgotPasswordBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var donthaveAcc: UILabel!
    
    @IBOutlet weak var registerBtn: UIButton!
    
    @IBOutlet weak var stillNotActiveLbl: UILabel!
    
    @IBOutlet weak var activateNowLbl: UILabel!
    
    @IBOutlet weak var tandCTC: UIButton!
    @IBOutlet weak var registerStackView: UIStackView!
    @IBOutlet weak var subView: UIView!
    
    @IBOutlet weak var activateStatckView: UIView!
    
    @IBOutlet weak var termsandConditionBtn: UIButton!
    
    @IBOutlet weak var commonImage: UIImageView!
    
    @IBOutlet weak var eyeButton: UIButton!
    @IBOutlet weak var supportImage: UIImageView!
    var categoryTitle = ""
    var categoryId = -1
    var filterTopicArray = ["Select","Engineer", "Mason", "Dealer", "Subdealer", "Support Executive"]
    var boolResult:Bool = false
    var VM = KC_LoginVM()
    var status = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.subView.isHidden = true
        mainView.clipsToBounds = false
        mainView.layer.cornerRadius = 36
        mainView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        self.filterTableView.delegate = self
        self.filterTableView.dataSource = self
        self.filterTableView.reloadData()
        self.supportImage.isHidden = true
        self.mobileTF.delegate = self
        self.selectionSetUp()
        self.eyeButton.setImage(UIImage(named: "hidden"), for: .normal)
        self.termsandConditionBtn.setImage(UIImage(named: "check-box-empty"), for: .normal)
        self.status = 0
        
        self.loginLbl.text = "Login".localiz()
        self.loginInfoLbl.text = "Please_log_in".localiz()
        self.mobileNoLbl.text = "MobileNoID".localiz()
        self.mobileTF.placeholder = "MobileNoID".localiz()
        self.passwordLbl.text = "Password".localiz()
        self.passwordTF.placeholder = "Enterpassword".localiz()
        self.tandCTC.setTitle("IacceptTerms&C".localiz(), for: .normal)
        self.loginBtn.setTitle("Login".localiz(), for: .normal)
        self.forgotPasswordBtn.setTitle("Forgot".localiz(), for: .normal)
        self.donthaveAcc.text = "DonHaveanacc".localiz()
        self.registerBtn.setTitle("Register".localiz(), for: .normal)
        self.stillNotActiveLbl.text = "StillNotAccount".localiz()
        self.activateNowLbl.text = "ActivateNow".localiz()
         
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.filterLbl.text = "\(self.categoryTitle)"
        self.tokendata()
        self.customerTypeApi()
        if self.categoryTitle == "Engineer"{
            self.categoryId = 1
        }else if self.categoryTitle == "Mason"{
            self.categoryId = 2
        }else if self.categoryTitle == "Dealer"{
            self.categoryId = 3
        }else if self.categoryTitle == "Sub Dealer"{
            self.categoryId = 4
        }else{
            self.categoryId = 5
        }
    }
    
    @IBAction func passwordSecureButton(_ sender: Any) {
        if passwordTF.isSecureTextEntry {
            passwordTF.isSecureTextEntry = false
            self.eyeButton.setImage(UIImage(named: "view"), for: .normal)
         
        } else {
            passwordTF.isSecureTextEntry = true
            self.eyeButton.setImage(UIImage(named: "hidden"), for: .normal)
          
        }
        
    }

    @IBAction func termsandCondBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_TermsandCondtionVC") as! HR_TermsandCondtionVC
        vc.delegate = self
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
        
    }
    @IBAction func filterDropDownBtn(_ sender: Any) {
        if self.subView.isHidden == false{
            self.subView.isHidden = true
        }else{
            self.subView.isHidden = false
           // self.filterTableViewHeightContraint.constant = CGFloat(25 * 5)
        }
    }
    @IBAction func loginBtn(_ sender: Any) {
        
        if self.mobileTF.text?.count == 0 {
            self.view.makeToast("EntermembershipId".localiz(), duration: 2.0, position: .bottom)
            self.passwordTF.text = ""
        }else if self.passwordTF.text?.count == 0 {
            self.view.makeToast("Enterpassword".localiz(), duration: 2.0, position: .bottom)
        }else if self.categoryId == -1 {
            self.view.makeToast("Selectcustomertype".localiz(), duration: 2.0, position: .bottom)
        }else if self.status != 1 {
            self.view.makeToast("AcceptTermsandconditions".localiz(), duration: 2.0, position: .bottom)
        }else{
            let parameter = [
                "Password": "\(self.passwordTF.text ?? "")",
                    "UserName": "\(self.mobileTF.text ?? "")",
                    "UserActionType": "GetPasswordDetails",
                    "Browser": "iOS",
                    "LoggedDeviceName": "iOS",
                    "PushID": "vfd87vuifu",
                    "UserType": "Customer"
            ] as [String: Any]
            print(parameter)
            self.VM.loginSubmissionApi(parameter: parameter)
        }
        
    }
    @IBAction func forgetPwd(_ sender: Any) {
        
        
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_ForgetPasswordVC") as! KC_ForgetPasswordVC
        vc.categoryId = self.categoryId
        vc.enteredMobileNumber = self.mobileTF.text ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func registerButton(_ sender: Any) {
        
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_RegisterVC") as! KC_RegisterVC
            vc.enteredMobile = self.mobileTF.text ?? ""
            vc.categoryId = self.categoryId
            vc.categoryTitle = self.categoryTitle
            self.navigationController?.pushViewController(vc, animated: true)
//        }else{
//            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_SignUpVC") as! KC_SignUpVC
//            vc.itsFrom = "LoginVC"
//            vc.enteredMobile = self.mobileTF.text ?? ""
//            vc.customerTypeName = self.categoryTitle
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
        
    }
    @IBAction func passwordTFEditingDidEnd(_ sender: Any) {
        if self.mobileTF.text?.count == 0 {
            self.view.makeToast("EntermembershipId".localiz(), duration: 2.0, position: .bottom)
            self.passwordTF.text = ""
        }
    }
    
    @IBAction func activateNowBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_ActivateAccountVC") as! KC_ActivateAccountVC
        vc.categoryId = self.categoryId
        vc.customerTypValue = self.filterLbl.text ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func userNameEditingDidEnd(_ sender: Any) {
        
        if self.mobileTF.text?.count == 0 {
            self.view.makeToast("EntermembershipId".localiz(), duration: 2.0, position: .bottom)
            self.passwordTF.text = ""
        }else if self.categoryId == -1 {
            self.view.makeToast("Selectcustomertype".localiz(), duration: 2.0, position: .bottom)
        }else{
            let parameter = [
                "ActionType":"65",
                "ActorId": self.categoryId,
                "Location":[
                    "UserName":"\(self.mobileTF.text ?? "")"
                ]
            ] as [String: Any]
            print(parameter)
            self.VM.verifyMobileNumberAPI(paramters: parameter)
        }
    }
    
    
    
    
    func customerTypeApi(){
        
        let parameter = [
            "ActionType":"33"
        ] as [String: Any]
        print(parameter)
        self.VM.customerTypeListApi(parameter: parameter)
        
    }
    func selectionSetUp(){
        if self.categoryTitle == "Support Executive"{
            self.forgotPasswordBtn.isHidden = true
            self.registerStackView.isHidden = true
            self.activateStatckView.isHidden = true
            self.supportImage.isHidden = false
            self.commonImage.isHidden = true
        }else{
            self.forgotPasswordBtn.isHidden = false
            self.registerStackView.isHidden = false
            self.activateStatckView.isHidden = false
            self.supportImage.isHidden = true
            self.commonImage.isHidden = false
        }
    }
    func tokendata(){
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
        }else{
            let parameters : Data = "username=\(username)&password=\(password)&grant_type=password".data(using: .utf8)!

        let url = URL(string: tokenURL)!
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        do {
            request.httpBody = parameters
        } catch let error {
            print(error.localizedDescription)
        }
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
       
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

            guard error == nil else {
                return
            }
            guard let data = data else {
                return
            }
            do{
                let parseddata = try JSONDecoder().decode(TokenModels.self, from: data)
                    print(parseddata.access_token ?? "")
                    UserDefaults.standard.setValue(parseddata.access_token ?? "", forKey: "TOKEN")
                 }catch let parsingError {
                print("Error", parsingError)
            }
        })
        task.resume()
    }
    }
}
extension KC_LoginVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VM.customerTypeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "KC_LoginTVC", for: indexPath) as! KC_LoginTVC
        cell.titleLbl.text = self.VM.customerTypeArray[indexPath.row].attributeValue ?? ""
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.filterLbl.text = self.VM.customerTypeArray[indexPath.row].attributeValue ?? ""
        self.categoryTitle = self.VM.customerTypeArray[indexPath.row].attributeValue ?? ""
        self.categoryId = self.VM.customerTypeArray[indexPath.row].attributeId ?? -1
        self.mobileTF.text = ""
        self.passwordTF.text = ""
        self.subView.isHidden = true
        self.selectionSetUp()
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 10
        let currentString: NSString = (self.mobileTF.text ?? "") as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    }
