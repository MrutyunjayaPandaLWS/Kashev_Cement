//
//  KC_LoginVC.swift
//  KeshavCement
//
//  Created by Arokia-M3 on 28/12/22.
//

import UIKit
import Toast_Swift
class KC_LoginVC: BaseViewController, UITextFieldDelegate{

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
    
    @IBOutlet weak var registerStackView: UIStackView!
    @IBOutlet weak var subView: UIView!
    
    @IBOutlet weak var activateStatckView: UIView!
    
    @IBOutlet weak var filterTableViewHeightContraint: NSLayoutConstraint!
    
    @IBOutlet weak var commonImage: UIImageView!
    
    @IBOutlet weak var supportImage: UIImageView!
    var categoryTitle = ""
    var categoryId = -1
    var filterTopicArray = ["Select","Engineer", "Mason", "Dealer", "Subdealer", "Support Executive"]
    
    var VM = KC_LoginVM()
    
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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.filterLbl.text = "\(self.categoryTitle)"
        self.tokendata()
        self.customerTypeApi()
    }

    @IBAction func filterDropDownBtn(_ sender: Any) {
        if self.subView.isHidden == false{
            self.subView.isHidden = true
        }else{
            self.subView.isHidden = false
        }
    }
    @IBAction func loginBtn(_ sender: Any) {
        
        if self.mobileTF.text?.count == 0 {
            self.view.makeToast("Enter mobile number / membership Id", duration: 2.0, position: .bottom)
        }else if self.mobileTF.text!.count > 10{
            self.view.makeToast("Enter valid mobile number / membership Id", duration: 2.0, position: .bottom)
        }else if self.passwordTF.text?.count == 0 {
            self.view.makeToast("Enter password", duration: 2.0, position: .bottom)
        }else if self.categoryId == -1 {
            self.view.makeToast("Select customer type", duration: 2.0, position: .bottom)
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
    }
    
    @IBAction func activateNowBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_ActivateAccountVC") as! KC_ActivateAccountVC
        vc.categoryId = self.categoryId
        vc.customerTypValue = self.filterLbl.text ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func userNameEditingDidEnd(_ sender: Any) {
        
        if self.mobileTF.text?.count == 0 {
            self.view.makeToast("Enter mobile number / membership Id", duration: 2.0, position: .bottom)
        }else if self.mobileTF.text!.count > 10{
            self.view.makeToast("Enter valid mobile number / membership Id", duration: 2.0, position: .bottom)
        }else if self.categoryId == -1 {
            self.view.makeToast("Select customer type", duration: 2.0, position: .bottom)
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
