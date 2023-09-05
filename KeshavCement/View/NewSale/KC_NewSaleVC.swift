//
//  KC_NewSaleVC.swift
//  KeshavCement
//
//  Created by ADMIN on 14/01/2023.
//

import UIKit
import DPOTPView
import LanguageManager_iOS
class KC_NewSaleVC: BaseViewController, SelectedDataDelegate, DPOTPViewDelegate{
    func didTapCustomerType(_ vc: KC_DropDownVC) {
        self.selectTypeLbl.text = vc.selectedCustomerType
        self.selectedUserTypeName = vc.selectedCustomerType
        self.selectedUserTypeId = vc.selectedUserTypeId
        print(self.selectedUserTypeId)
        self.searchTF.placeholder = "Search".localiz()
        self.searchTF.text = ""
        self.pleaseSelectProductLbl.text = "Pleaseselectproduct".localiz()
        self.mappedUserId = -1
        self.selectedProductId = -1
    }
    func didTapMappedUserName(_ vc: KC_DropDownVC) {
        self.searchTF.text = vc.mappedUsername
        self.mappedName = vc.mappedUsername
        self.mappedUserId = vc.mappedUserId
        self.mappedUserMobile = vc.mappedMobileNumber
        self.mappedLoyaltyId = vc.mappedLoyaltyId
        let getLastFour = String(mappedUserMobile.suffix(4))
        print(getLastFour)
        self.mobileNumberLbl.text = getLastFour
        
        self.pleaseSelectProductLbl.text = "Pleaseselectproduct".localiz()
        self.selectedProductId = -1
    }
    func didTapProductName(_ vc: KC_DropDownVC){
        self.pleaseSelectProductLbl.text = vc.selectedProductName
        self.selectedProductName = vc.selectedProductName
        self.selectedProductId = vc.selectedProductId
        self.selectedProductCode = vc.selectedProductCode
        
    }
    
    @IBOutlet weak var successPopUpView: UIView!
    
    @IBOutlet weak var headerText: UILabel!
   
    @IBOutlet weak var qtyTF: UITextField!
    @IBOutlet weak var selectTypeLbl: UILabel!
    @IBOutlet weak var customerTypeLb: UILabel!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var popUpInfoLbl: UILabel!
    @IBOutlet weak var searchTF: UITextField!
    
    @IBOutlet weak var selectProductLbl: UILabel!
    
    @IBOutlet weak var pleaseSelectProductLbl: UILabel!
    
    @IBOutlet weak var sendOTP: UIButton!
    
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var saveandProceedBtn: UIButton!
    
    @IBOutlet weak var otpPopUpView: UIView!
    
    @IBOutlet weak var redeemBtn: UIButton!
    @IBOutlet weak var resendOTPBtn: UIButton!
    @IBOutlet weak var otpView: DPOTPView!
    @IBOutlet weak var otpValueLbl: UILabel!

    
    @IBOutlet weak var mobileNumberLbl: UILabel!
    
    var selectedUserTypeName = ""
    var selectedUserTypeId = -1
    var selectedProductCode = ""
    
    var mappedLoyaltyId = ""
    var mappedName = ""
    var mappedUserId = -1
    var mappedUserMobile = ""
    var selectedProductName = ""
    var selectedProductId = -1
    var enteredValue = ""
    var quantity = 0
    var count = 0
    var receivedOTP = ""
    var loyaltyID = UserDefaults.standard.string(forKey: "LoyaltyId") ?? ""
    var mobilenumber = UserDefaults.standard.string(forKey: "CustomerMobileNumber") ?? ""
    let emailID = UserDefaults.standard.string(forKey: "CustomerEmail") ?? ""
    let firstname = UserDefaults.standard.string(forKey: "FirstName") ?? ""
    let merchantUserName = UserDefaults.standard.string(forKey: "MerchantEmail") ?? ""
    var merchanMobile = UserDefaults.standard.string(forKey: "MerchantMobile") ?? ""
    var pointBalance = UserDefaults.standard.string(forKey: "RedeemablePointBalance") ?? ""
    var itsFrom = "SendOTP"
    
    
    
    var VM = KC_NewSaleVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        mainView.clipsToBounds = false
        self.successPopUpView.isHidden = true
        self.otpPopUpView.isHidden = true
        mainView.layer.cornerRadius = 36
        mainView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        self.searchTF.attributedPlaceholder = NSAttributedString(string: "SearchName".localiz(), attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        otpView.dpOTPViewDelegate = self
        otpView.fontTextField = UIFont.systemFont(ofSize: 25)
        otpView.textEdgeInsets = UIEdgeInsets(top: 0, left: -1, bottom: 0, right: 0)
        otpView.editingTextEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        self.qtyTF.keyboardType = .asciiCapableNumberPad
        if self.customerTypeId == "5"{
            self.headerText.text = "Claim".localiz()
        }
    }
    

    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func closeOTPViewButton(_ sender: Any) {
        self.VM.timer.invalidate()
        self.otpPopUpView.isHidden = true
        self.successPopUpView.isHidden = true
    }
    
    @IBAction func selectCutomerTypeBtn(_ sender: Any) {
        print(mappedCustomerType, "saldf;dkafjls;jkl;fadsjklafsjlkdfasdsfjlak")
        if self.mappedCustomerType == "Dealer" && self.customerTypeId == "5"{
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_DropDownVC") as! KC_DropDownVC
            vc.itsFrom = "CUSTOMERTYPE3"
            vc.delegate = self
            vc.customerType = self.customerType
            vc.modalTransitionStyle = .coverVertical
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }else if self.mappedCustomerType == "Sub Dealer" && self.customerTypeId == "5"{
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_DropDownVC") as! KC_DropDownVC
            vc.itsFrom = "CUSTOMERTYPE4"
            vc.delegate = self
            vc.customerType = self.customerType
            vc.modalTransitionStyle = .coverVertical
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }else{
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_DropDownVC") as! KC_DropDownVC
            if self.customerTypeId == "3" {
                vc.itsFrom = "CUSTOMERTYPE3"
            }else if self.customerTypeId == "5"{
                vc.itsFrom = "CUSTOMERTYPE4"
            }else if self.customerTypeId == "4"{
                vc.itsFrom = "CUSTOMERTYPE4"
            }else{
                vc.itsFrom = "CUSTOMERTYPE4"
            }
            vc.delegate = self
            vc.modalTransitionStyle = .coverVertical
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }
    }
    
    @IBAction func selectProductBtn(_ sender: Any) {
        if self.mappedUserId == -1{
            self.view.makeToast("Pleasemappeduser".localiz(), duration: 2.0, position: .bottom)
        }else{
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_DropDownVC") as! KC_DropDownVC
            vc.itsFrom = "CLAIMPRODUCTLIST"
            vc.delegate = self
            vc.modalTransitionStyle = .coverVertical
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }
    }
    @IBOutlet weak var enterQtyLbl: UILabel!
    
    @IBAction func minusBtn(_ sender: Any) {
        if self.selectedUserTypeId == -1{
            self.view.makeToast("Pleaseselectusertype".localiz(), duration: 2.0, position: .bottom)
        }else if self.mappedUserId == -1{
            self.view.makeToast("Pleaseselectmappeduser".localiz(), duration: 2.0, position: .bottom)
        }else if self.selectedProductId == -1{
            self.view.makeToast("Pleaseselectproduct".localiz(), duration: 2.0, position: .bottom)
        }else{
            self.count -= 1
            self.quantity = self.count
            if self.count != 0{
                self.qtyTF.text = "\(self.quantity)"
            }else{
                self.count = 1
                self.quantity = self.count
            }
        }
    }
    
    @IBAction func addBtn(_ sender: Any) {
        if self.selectedUserTypeId == -1{
            self.view.makeToast("Pleaseselectusertype".localiz(), duration: 2.0, position: .bottom)
        }else if self.mappedUserId == -1{
            self.view.makeToast("Pleasemappeduser".localiz(), duration: 2.0, position: .bottom)
        }else if self.selectedProductId == -1{
            self.view.makeToast("Pleaseselectproduct".localiz(), duration: 2.0, position: .bottom)
        }else{
            self.count += 1
            self.quantity = self.count
            self.qtyTF.text = "\(self.quantity)"
        }
        
    }
    @IBAction func filterByNameBtn(_ sender: Any) {
        if self.selectedUserTypeId == -1{
            self.view.makeToast("Pleaseselectusertype".localiz(), duration: 2.0, position: .bottom)
        }else{
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_DropDownVC") as! KC_DropDownVC
            vc.itsFrom = "MAPPEDUSERS"
            vc.delegate = self
            vc.selectedUserTypeId = self.selectedUserTypeId
            vc.modalTransitionStyle = .coverVertical
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }
    }
    
    @IBAction func enterQTYEditingDidEnd(_ sender: Any) {
        
        
        self.quantity = Int(self.qtyTF.text ?? "") ?? 0
        if self.selectedUserTypeId == -1{
            self.qtyTF.text = "0"
            self.view.makeToast("Pleaseselectusertype".localiz(), duration: 2.0, position: .bottom)
          
        }else if self.mappedUserId == -1{
            self.qtyTF.text = "0"
            self.view.makeToast("Pleasemappeduser".localiz(), duration: 2.0, position: .bottom)
       
        }else if self.selectedProductId == -1{
            self.qtyTF.text = "0"
            self.view.makeToast("Pleaseselectproduct".localiz(), duration: 2.0, position: .bottom)
          
        }else if self.quantity == 0{
            self.view.makeToast("Qunantityshouldnt0".localiz(), duration: 2.0, position: .bottom)
            self.count = 1
            self.quantity = 1
            self.qtyTF.text = "\(self.count)"
        }else{
             self.count = Int(self.qtyTF.text ?? "") ?? 0
            self.quantity = self.count
        }
        
        
    }
    
    @IBAction func okBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func resendOTPBtn(_ sender: Any) {
        if self.selectedUserTypeId == -1{
            self.view.makeToast("Pleaseselectusertype".localiz(), duration: 2.0, position: .bottom)
            
        }else if self.mappedUserId == -1{
            self.view.makeToast("Pleasemappeduser".localiz(), duration: 2.0, position: .bottom)
            
        }else if self.selectedProductId == -1{
            self.view.makeToast("Pleaseselectproduct".localiz(), duration: 2.0, position: .bottom)
            
        }else if self.quantity == 0{
            self.view.makeToast("Quantityshoulntbe0".localiz(), duration: 2.0, position: .bottom)
            
        }else{
            self.VM.timer.invalidate()
            self.generateOTPApi()
        }
    }
    @IBAction func sendOTPButton(_ sender: Any) {
        if self.selectedUserTypeId == -1{
            self.view.makeToast("Pleaseselectusertype".localiz(), duration: 2.0, position: .bottom)
            
        }else if self.mappedUserId == -1{
            self.view.makeToast("Pleaseselectmappeduser".localiz(), duration: 2.0, position: .bottom)
            
        }else if self.selectedProductId == -1{
            self.view.makeToast("Pleaseselectproduct".localiz(), duration: 2.0, position: .bottom)
            
        }else if self.quantity == 0{
            self.view.makeToast("Quantityshoulntbe0".localiz(), duration: 2.0, position: .bottom)
            
        }else{
            self.itsFrom = "SendOTP"
            self.validatePointBalanceApi()
            
        }
    }
    @IBAction func otpSubmitBtn(_ sender: Any) {
        print(self.enteredValue, "- Entered Value")
        if self.enteredValue.count == 0 {
            self.view.makeToast("EnterOTP".localiz(), duration: 2.0, position: .bottom)
        }else if self.enteredValue.count != 6{
            self.view.makeToast("EntervalidOTP".localiz(), duration: 2.0, position: .bottom)
        }
//        else if self.receivedOTP != self.enteredValue{
//            self.view.makeToast("EntercorrectOTP".localiz(), duration: 2.0, position: .bottom)
//        }
        else{
            self.VM.serverOTP(mobileNumber: self.mappedUserMobile, otpNumber: enteredValue)
        }
        
        
     
    }
    @IBAction func saveandProceedBtn(_ sender: Any) {
        if self.selectedUserTypeId == -1{
            self.view.makeToast("Pleaseselectusertype".localiz(), duration: 2.0, position: .bottom)
          
        }else if self.mappedUserId == -1{
            self.view.makeToast("Pleaseselectmappeduser".localiz(), duration: 2.0, position: .bottom)
          
        }else if self.selectedProductId == -1{
            self.view.makeToast("Pleaseselectproduct".localiz(), duration: 2.0, position: .bottom)
          
        }else if self.quantity == 0{
            self.view.makeToast("Quantityshoulntbe0".localiz(), duration: 2.0, position: .bottom)
          
        }else{
            let yesterday = "\(Calendar.current.date(byAdding: .day, value: 0, to: Date())!)"
            let today = yesterday.split(separator: " ")
            let desiredDateFormat = self.convertDateFormater("\(today[0])", fromDate: "yyyy-MM-dd", toDate: "yyyy-MM-dd")
           print("\(desiredDateFormat)")
            self.itsFrom = "SaveProceed"
            
            if self.customerTypeId == "5"{
                let parameter = [
                    "ActorId": self.mappedUserId,
                    "ProductSaveDetailList": [
                        [
                            "ProductCode": self.selectedProductCode,
                            "Quantity": self.quantity
                        ]
                    ],
                    "RitailerId": UserDefaults.standard.string(forKey: "mappedCustomerId") ?? "",
                    "SourceDevice": 1,
                    "TranDate": "\(desiredDateFormat)",
                    "Approval_Status": "-1"
                ] as [String: Any]
                print(parameter)
                self.VM.claimPurchaseSubmissionApi(parameter: parameter)
            }else{
                let parameter = [
                    "ActorId": self.mappedUserId,
                    "ProductSaveDetailList": [
                        [
                            "ProductCode": self.selectedProductCode,
                            "Quantity": self.quantity
                        ]
                    ],
                    "RitailerId": self.userID,
                    "SourceDevice": 1,
                    "TranDate": "\(desiredDateFormat)",
                    "Approval_Status": "-1"
                ] as [String: Any]
                print(parameter)
                self.VM.claimPurchaseSubmissionApi(parameter: parameter)
            }
            
        }
        
    }
    
    func validatePointBalanceApi(){
        if self.customerTypeId == "5"{
            let parameter = [
                "ActorId": UserDefaults.standard.string(forKey: "mappedCustomerId") ?? "",
                "ProductSaveDetailList": [
                    [
                        "ProductCode": self.selectedProductCode,
                        "Quantity": self.quantity
                    ]
                ],
                "RitailerId": UserDefaults.standard.string(forKey: "mappedCustomerId") ?? "",
                "Approval_Status": "5"
            ] as [String: Any]
            print(parameter)
            self.VM.checkPointBalanceApi(parameter: parameter)
        }else{
            let parameter = [
                "ActorId":  self.userID,
                "ProductSaveDetailList": [
                    [
                        "ProductCode": self.selectedProductCode,
                        "Quantity": self.quantity
                    ]
                ],
                "RitailerId":  self.userID,
                "Approval_Status": "5"
            ] as [String: Any]
            print(parameter)
            self.VM.checkPointBalanceApi(parameter: parameter)
        }
        
       
        
        
    }
    
    func claimSubmissionWithOTP(){
        let yesterday = "\(Calendar.current.date(byAdding: .day, value: 0, to: Date())!)"
        let today = yesterday.split(separator: " ")
        let desiredDateFormat = self.convertDateFormater("\(today[0])", fromDate: "yyyy-MM-dd", toDate: "yyyy-MM-dd")
       print("\(desiredDateFormat)")
        
        
        
        if self.customerTypeId == "5"{
            let parameter = [
                "ActorId": self.mappedUserId,
                "ProductSaveDetailList": [
                    [
                        "ProductCode": self.selectedProductCode,
                        "Quantity": self.quantity
                    ]
                ],
                "RitailerId": self.userID,
                "SourceDevice": 1,
                "TranDate": "\(desiredDateFormat)",
                "Approval_Status": "1"
            ] as [String: Any]
            print(parameter)
            self.VM.claimPurchaseSubmissionApi(parameter: parameter)
        }else{
            let parameter = [
                "ActorId": self.mappedUserId,
                "ProductSaveDetailList": [
                    [
                        "ProductCode": self.selectedProductCode,
                        "Quantity": self.quantity
                    ]
                ],
                "RitailerId": self.userID,
                "SourceDevice": 1,
                "TranDate": "\(desiredDateFormat)",
                "Approval_Status": "1"
            ] as [String: Any]
            print(parameter)
            self.VM.claimPurchaseSubmissionApi(parameter: parameter)
        }
    }
    
    func generateOTPApi(){
        let parameter = [
//            "MerchantUserName": "KeshavCementDemo",
//            "MobileNo": self.mappedUserMobile,
//            "UserId": self.mappedUserId,
//            "UserName": self.mappedName,
//            "Name": self.mappedName
            "MerchantUserName": MerchantUserName,
              "MobileNo": self.mappedUserMobile,
              "OTPType": "OTPForRewardCardsENCashAuthorization",
              "UserId": self.mappedUserId,
              "UserName": self.mappedName,
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
   
}
