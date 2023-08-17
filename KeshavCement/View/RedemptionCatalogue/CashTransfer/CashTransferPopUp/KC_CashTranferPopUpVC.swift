//
//  KC_CashTranferPopUpVC.swift
//  KeshavCement
//
//  Created by ADMIN on 09/01/2023.
//

import UIKit
import DPOTPView
import LanguageManager_iOS
class KC_CashTranferPopUpVC: BaseViewController, DPOTPViewDelegate, SelectedDataDelegate{
  
    func didTapMappedUserName(_ vc: KC_DropDownVC) {
        self.nameTF.text = vc.mappedUsername
        self.mappedName = vc.mappedUsername
        self.mappedUserId = vc.mappedUserId
    }
    func didTapUserType(_ vc: KC_DropDownVC) {
        self.selectTypeLbl.text = vc.selectedUserTypeName
        self.selectedUserTypeName = vc.selectedUserTypeName
        self.selectedUserTypeId = vc.selectedUserTypeId
        
    }

    @IBOutlet weak var cashTransferSuccessPopUp: UIView!
    @IBOutlet weak var cashTransferView: UIView!
    @IBOutlet weak var cashTransferOtpView: UIView!
    @IBOutlet weak var redeemBtn: UIButton!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var selectTypeLbl: UILabel!
    @IBOutlet weak var userTypeLbl: UILabel!
    @IBOutlet weak var infoLbl: UILabel!
    @IBOutlet weak var mainTitleLbl: UILabel!
    
    @IBOutlet weak var resendOTPBtn: UIButton!
    @IBOutlet weak var otpView: DPOTPView!
    @IBOutlet weak var otpValueLbl: UILabel!
    @IBOutlet weak var mobileNumberLbl: UILabel!
    var itsComeFrom = ""
    var titleLbl = ""
    var infoMessageLbl = ""
    var redeemBtnTitle = ""
    var enteredValue = ""
    var receivedOTP = ""
    
    var stateID = 0
    var cityID = 0
    var cityName = ""
    var stateName = ""
    var countryID = -1
    var countryName = ""
    var pincode = ""
    var address1 = ""
    var customerName = ""
    var mobile = ""
    var emailId = ""
    var OTPforVerification = ""
    var redeemedPoints = 0
    var VM = KC_CashTransferSubmissionVM()
    
    var receiverName = ""
    var address = ""
    var districtID = -1
    var districtName = ""
    var redemptionDate = ""
    var totalRedemmablePts = 0
//    var pointBalance = 0
    var partyLoyaltyId = ""
    var redemptionIDs = ""
    var customerCartID = ""
    var totalCashData = ""
    var noOfQuantitys = ""
    var countryIDs = ""
    
    
    
    var loyaltyID = UserDefaults.standard.string(forKey: "LoyaltyId") ?? ""
    var mobilenumber = UserDefaults.standard.string(forKey: "CustomerMobileNumber") ?? ""
  //  let emailID = UserDefaults.standard.string(forKey: "CustomerEmail") ?? ""
    let firstname = UserDefaults.standard.string(forKey: "FirstName") ?? ""
    let merchantUserName = UserDefaults.standard.string(forKey: "MerchantEmail") ?? ""
    var merchanMobile = UserDefaults.standard.string(forKey: "MerchantMobile") ?? ""
    var pointBalance = UserDefaults.standard.string(forKey: "RedeemablePointBalance") ?? ""
    
    var selectedUserTypeName = ""
    var selectedUserTypeId = -1
    
    var mappedName = ""
    var mappedUserId = -1
    
    var selectedProductName = ""
    var selectedProductId = -1
    
    var noOfPointsRequired = ""
    var productCode = ""
    var productImage = ""
    var productName = ""
    var categoryId = ""
    var termsandCondition = ""
    var vendorId = ""
    var vendorName = ""
    var catalogeID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
//        self.otpView.isHidden = true
        
        otpView.dpOTPViewDelegate = self
        otpView.fontTextField = UIFont.systemFont(ofSize: 25)
        otpView.textEdgeInsets = UIEdgeInsets(top: 0, left: -1, bottom: 0, right: 0)
        otpView.editingTextEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let getLastFour = String(mobilenumber.suffix(4))
        print(getLastFour)
        self.mobileNumberLbl.text = getLastFour
        print(self.customerTypeId, "- CustomerType Id")
        if self.customerTypeId == "3"{
            self.cashTransferOtpView.isHidden = false
            self.cashTransferView.isHidden = true
            self.cashTransferSuccessPopUp.isHidden = true
            self.generateOTPApi()
        }else{
            self.cashTransferView.isHidden = false
            self.cashTransferOtpView.isHidden = true
            self.cashTransferSuccessPopUp.isHidden = true
        }
        
        self.VM.myAccountDetailsApi()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
        {
            let touch = touches.first
            if touch?.view != self.view
            {
                self.dismiss(animated: true, completion: nil) }
        }

    @IBAction func selectTypeBtn(_ sender: Any) {
        
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_DropDownVC") as! KC_DropDownVC
        vc.itsFrom = "USERTYPE"
        vc.delegate = self
        vc.customerType = self.customerType
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    
    @IBAction func nameButton(_ sender: Any) {
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
    @IBAction func closeButton(_ sender: Any) {
        self.VM.timer.invalidate()
        self.cashTransferView.isHidden = true
        self.dismiss(animated: true)
    }
    
    
    @IBAction func redeemButton(_ sender: Any) {
        
        if self.mappedUserId == -1{
            self.view.makeToast("Selectusertype".localiz(), duration: 2.0, position: .bottom)
        }else if self.selectedUserTypeId == -1{
            self.view.makeToast("Selectuser".localiz(), duration: 2.0, position: .bottom)
        }else{
            self.VM.timer.invalidate()
            self.cashTransferOtpView.isHidden = false
            self.generateOTPApi()
        }
    }
    @IBAction func resendBTN(_ sender: Any) {
            self.VM.timer.invalidate()
            self.generateOTPApi()
    }
    @IBAction func closeBtn(_ sender: Any) {
        self.VM.timer.invalidate()
        self.dismiss(animated: true)
    }
    @IBAction func redeemButtons(_ sender: Any) {
            if self.enteredValue.count == 0 {
                self.view.makeToast("EnterOTP".localiz(), duration: 2.0, position: .bottom)
            }else if self.enteredValue.count != 6{
                self.view.makeToast("EntervalidOTP".localiz(), duration: 2.0, position: .bottom)
            }
//        else if self.receivedOTP != self.enteredValue{
//                self.view.makeToast("EntercorrectOTP".localiz(), duration: 2.0, position: .bottom)
//            }
        else{
            self.VM.serverOTP(mobileNumber: self.mobile, otpNumber: self.enteredValue)
            self.VM.timer.invalidate()
                
//                print(self.stateID)
//                print(self.mobile)
//                print(self.address1)
//                print(self.stateName)
//                print(self.cityID)
//                print(self.cityName)
//                print(self.pincode)
//                print(self.customerName)
//                print(self.emailId)

//                if Int(self.noOfPointsRequired)! <= Int(self.pointBalance)!{
//                    self.cashTransferSubmissionApi(noOfPointsRequired: self.noOfPointsRequired, productCode: self.productCode, productImage: self.productImage, productName: self.productName, categoryId: Int(self.categoryId)!, termsandCondition: self.termsandCondition, vendorId: Int(self.vendorId)!, vendorName: self.vendorName)
//                }else{
//                    self.view.makeToast("Insufficentpointbalance".localiz(), duration: 2.0, position: .bottom)
//                }
            }
    }
    
    func cashVoucher(){
        if Int(self.noOfPointsRequired)! <= Int(self.pointBalance)!{
            self.cashTransferSubmissionApi(noOfPointsRequired: self.noOfPointsRequired, productCode: self.productCode, productImage: self.productImage, productName: self.productName, categoryId: Int(self.categoryId)!, termsandCondition: self.termsandCondition, vendorId: Int(self.vendorId)!, vendorName: self.vendorName)
        }else{
            self.view.makeToast("Insufficentpointbalance".localiz(), duration: 2.0, position: .bottom)
        }
    }
    
    
    
    
    @IBAction func okBtn(_ sender: Any) {
        self.VM.timer.invalidate()
        self.cashTransferView.isHidden = true
        self.cashTransferOtpView.isHidden = true
        self.cashTransferSuccessPopUp.isHidden = true
        self.dismiss(animated: true)
    }
    
    
    func generateOTPApi(){
        let parameter = [
//            "MerchantUserName": "KeshavCementDemo",
//            "MobileNo": mobilenumber,
//            "UserId": self.userID,
//            "UserName": self.loyaltyId,
//            "Name": self.customerName
            "MerchantUserName": MerchantUserName,
            "MobileNo": mobilenumber,
            "OTPType": "OTPForRewardCardsENCashAuthorization",
            "UserId": self.userID,
            "UserName": self.loyaltyId
            
        ] as [String: Any]
        print(parameter)
        self.VM.getOTPApi(parameter: parameter)
    }
    //                self.VC?.stateID = result?.lstCustomerJson?[0].stateId ?? -1
    //                self.VC?.mobile = result?.lstCustomerJson?[0].mobile ?? ""
    //                self.VC?.address1 = result?.lstCustomerJson?[0].address1 ?? "-"
    //                self.VC?.stateName = result?.lstCustomerJson?[0].stateName ?? "-"
    //                self.VC?.districtID = result?.lstCustomerJson?[0].districtId ?? -1
    //                    self.VC?.districtName = result?.lstCustomerJson?[0].districtName ?? ""
    //                self.VC?.cityID = result?.lstCustomerJson?[0].cityId ?? -1
    //                self.VC?.cityName = result?.lstCustomerJson?[0].cityName ?? "-"
    //                self.VC?.pincode = result?.lstCustomerJson?[0].zip ?? ""
    //                self.VC?.countryID = result?.lstCustomerJson?[0].countryId ?? -1
    //                self.VC?.countryName = result?.lstCustomerJson?[0].countryName ?? "-"
    //                self.VC?.customerName = result?.lstCustomerJson?[0].firstName ?? "-"
    //                self.VC?.emailId = result?.lstCustomerJson?[0].email ?? "-"
    
    
//    "CatalogueId": item.catalogueId ?? 0,
//    "DeliveryType": "In Store",
//    "HasPartialPayment": false,
//    "NoOfPointsDebit": "\(Int(item.pointsRequired!))",
//    "NoOfQuantity": item.noOfQuantity ?? 0,
//    "PointsRequired": "\(item.pointsRequired ?? 0)",
//    "ProductCode": "\(item.productCode ?? "")",
//    "ProductImage": "\(item.productImage ?? "")",
//    "ProductName": "\(item.productName ?? "")",
//    "RedemptionDate": "\(desiredDateFormat ?? "")",
//    "RedemptionId": item.redemptionId ?? 0,
//    "RedemptionTypeId": 1,
//    "Status": 13,
//    "CatogoryId": item.categoryID ?? 0,
//    "CustomerCartId": item.customerCartId ?? 0,
//    "TermsCondition": "\(item.termsCondition ?? "")",
//    "TotalCash": item.totalCash ?? 0,
//    "VendorId": item.vendorId ?? 0
    
    
    func cashTransferSubmissionApi(noOfPointsRequired: String, productCode: String, productImage: String, productName: String, categoryId: Int, termsandCondition: String, vendorId: Int, vendorName: String){
        let yesterday = "\(Calendar.current.date(byAdding: .day, value: 0, to: Date())!)"
        let today = yesterday.split(separator: " ")
        let desiredDateFormat = self.convertDateFormater("\(today[0])", fromDate: "yyyy-MM-dd", toDate: "yyyy-MM-dd")
       print("\(desiredDateFormat)")
        if self.customerTypeId == "3"{
            let parameter = [
                "ActionType": 51,
                "ActorId": self.userID,
                "MemberName": "\(self.customerName)",
                "DealerLoyaltyId": "",
                "ObjCatalogueList": [
                    [
                        "CatalogueId": self.catalogeID,
                        "DeliveryType": "In Store",
                        "HasPartialPayment": false,
                        "NoOfPointsDebit": noOfPointsRequired,
                        "NoOfQuantity": self.noOfQuantitys,
                        "PointsRequired": noOfPointsRequired,
                        "ProductCode": productCode,
                        "ProductImage": productImage,
                        "ProductName": productName,
                        "RedemptionDate": "\(desiredDateFormat)",
                        "RedemptionId": "\(redemptionIDs)",
                        "RedemptionTypeId": 9,
                        "Status": 0,
                        "CatogoryId": categoryId,
                        "CustomerCartId": "\(customerCartID)",
                        "TermsCondition": termsandCondition,
                        "TotalCash": self.totalCashData,
                        "VendorId": vendorId,
                        "VendorName": vendorName
                    ]
                ],
                "ObjCustShippingAddressDetails": [
                    "Address1": "\(self.address1)",
                    "CityId": "\(self.cityID)",
                    "Cityname": "\(self.cityName)",
                    "CountryId": countryID,
                    "Email": "\(self.emailId)",
                    "FullName": "\(self.customerName)",
                    "Mobile": "\(self.mobile)",
                    "StateId": "\(self.stateID)",
                    "StateName": "\(self.stateName)",
                    "Zip": "\(self.pincode)"
                ],
                "SourceMode": 5
            ] as [String: Any]
            print(parameter)
            self.VM.cashSubmissionApi(parameter: parameter)
        }else{
            let parameter = [
                "ActionType": 51,
                "ActorId": self.userID,
                "MemberName": "\(self.customerName)",
                "DealerLoyaltyId": "\(self.loyaltyID)",
                "ObjCatalogueList": [
                    [
                        "CatalogueId": self.catalogeID,
                        "DeliveryType": "In Store",
                        "HasPartialPayment": false,
                        "NoOfPointsDebit": noOfPointsRequired,
                        "NoOfQuantity": self.noOfQuantitys,
                        "PointsRequired": noOfPointsRequired,
                        "ProductCode": productCode,
                        "ProductImage": productImage,
                        "ProductName": productName,
                        "RedemptionDate": "\(desiredDateFormat)",
                        "RedemptionId": "\(redemptionIDs)",
                        "RedemptionTypeId": 9,
                        "Status": 0,
                        "CatogoryId": categoryId,
                        "CustomerCartId": "\(customerCartID)",
                        "TermsCondition": termsandCondition,
                        "TotalCash": self.totalCashData,
                        "VendorId": vendorId,
                        "VendorName": vendorName
                    ]
                ],
                "ObjCustShippingAddressDetails": [
                    "Address1": "\(self.address1)",
                    "CityId": "\(self.cityID)",
                    "Cityname": "\(self.cityName)",
                    "CountryId": countryID,
                    "Email": "\(self.emailId)",
                    "FullName": "\(self.customerName)",
                    "Mobile": "\(self.mobile)",
                    "StateId": "\(self.stateID)",
                    "StateName": "\(self.stateName)",
                    "Zip": "\(self.pincode)"
                ],
                "SourceMode": 5
            ] as [String: Any]
            print(parameter)
            self.VM.cashSubmissionApi(parameter: parameter)
        }
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
