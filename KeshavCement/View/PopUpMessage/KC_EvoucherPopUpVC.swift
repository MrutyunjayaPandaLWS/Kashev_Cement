//
//  KC_EvoucherPopUpVC.swift
//  KeshavCement
//
//  Created by ADMIN on 06/01/2023.
//

import UIKit
import DPOTPView
import LanguageManager_iOS
class KC_EvoucherPopUpVC: BaseViewController, DPOTPViewDelegate{
  
    @IBOutlet weak var popUpInfoText: UILabel!
    @IBOutlet weak var popUpTitleText: UILabel!
    @IBOutlet weak var successPopUpView: UIView!
    @IBOutlet weak var redemptionTitleLbL: UILabel!
    @IBOutlet weak var redeemBtn: UIButton!
    @IBOutlet weak var resendOTPBtn: UIButton!
    @IBOutlet weak var otpInfoLbl: UILabel!
    @IBOutlet weak var otpView: DPOTPView!
    @IBOutlet weak var otpValueLbl: UILabel!
    @IBOutlet weak var otpLbl: UILabel!
    @IBOutlet weak var infoLbl: UILabel!
    
    @IBOutlet weak var mobileNumberLbl: UILabel!
    var itsComeFrom = ""
    var titleLbl = ""
    var infoMessageLbl = ""
    var redeemBtnTitle = ""
    var enteredValue = ""
    var receivedOTP = ""
    
    var dreamGiftId = 0
    var giftPts = 0
    var giftName = ""
    var contractorName = ""
    var giftStatusId = 0
    var redemptionTypeId = 0
    
    var stateID = 0
    var cityID = 0
    var cityName = ""
    var stateName = ""
    var countryId = 0
    var countryName = ""
    var pincode = ""
    var address1 = ""
    var customerName = ""
    var mobile = ""
    var emailId = ""
    var OTPforVerification = ""
    var redeemedPoints = 0
    var VM = KC_RedemptionOTPVM()
    var productsParameter:JSON?
    var sentSMSParameter:JSON?
    var partyLoyaltyId = ""
    var loyaltyID = UserDefaults.standard.string(forKey: "LoyaltyId") ?? ""
    var mobilenumber = UserDefaults.standard.string(forKey: "CustomerMobileNumber") ?? ""
    let emailID = UserDefaults.standard.string(forKey: "CustomerEmail") ?? ""
    let firstname = UserDefaults.standard.string(forKey: "FirstName") ?? ""
    let merchantUserName = UserDefaults.standard.string(forKey: "MerchantEmail") ?? ""
    var merchanMobile = UserDefaults.standard.string(forKey: "MerchantMobile") ?? ""
    var pointBalance = UserDefaults.standard.string(forKey: "RedeemablePointBalance") ?? ""
    
    var productTotalPoints = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.resendOTPBtn.isHidden = true
        self.userStatusApi()
        otpView.dpOTPViewDelegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(afterQuerySubmitted), name: Notification.Name.dismissToPrevious, object: nil)
        otpView.fontTextField = UIFont.systemFont(ofSize: 25)
        otpView.textEdgeInsets = UIEdgeInsets(top: 0, left: -1, bottom: 0, right: 0)
        otpView.editingTextEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let getLastFour = String(mobilenumber.suffix(4))
        print(getLastFour)
        self.mobileNumberLbl.text = getLastFour
        
        if self.itsComeFrom == "CashTransfer"{
            self.redemptionTitleLbL.text = self.titleLbl
            self.infoLbl.text = self.infoMessageLbl
            
        }else if self.itsComeFrom == "REDEMPTIONSUBMISSION"{
            self.redemptionTitleLbL.text = "Redemption".localiz()
            self.infoLbl.text = "EntertheOTPSubmitRedemption".localiz()
            
        }
    }
    @objc func afterQuerySubmitted(notification: Notification){
       
        self.dismiss(animated: true){
            NotificationCenter.default.post(name: .navigateToMyRedemption, object: nil)
            self.VM.timer.invalidate()
        }
    }
           
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
//        {
//            let touch = touches.first
//            if touch?.view != self.view
//            {
//                self.dismiss(animated: true, completion: nil) }
//        }
    
    @IBAction func resendBTN(_ sender: Any) {
        self.VM.timer.invalidate()
        if self.partyLoyaltyId == ""{
            self.generateOTPApi(loyaltyId: self.loyaltyID)
        }else{
            self.generateOTPApi(loyaltyId: self.partyLoyaltyId)
        }
    }
    
    
    @IBAction func closeBtn(_ sender: Any) {
        NotificationCenter.default.post(name: .navigateToOrderConfirmation, object: nil)
        self.VM.timer.invalidate()
        self.dismiss(animated: true)
    }
    @IBAction func redeemButton(_ sender: Any) {
        if self.itsComeFrom == "REDEMPTIONSUBMISSION" {
            print(self.enteredValue, "- Entered Value")
            if self.enteredValue.count == 0 {
                self.view.makeToast("EnterOTP".localiz(), duration: 2.0, position: .bottom)
            }else if self.enteredValue.count != 6{
                self.view.makeToast("EntervalidOTP".localiz(), duration: 2.0, position: .bottom)
            }else if self.receivedOTP != self.enteredValue{
                self.view.makeToast("EntercorrectOTP".localiz(), duration: 2.0, position: .bottom)
            }else{
                self.VM.timer.invalidate()
            
                if self.partyLoyaltyId == ""{
                    self.redemptionSubmissionApi(loyaltyId: self.loyaltyID)
                }else{
                    self.redemptionSubmissionApi(loyaltyId: self.partyLoyaltyId)
                }
            }

        }else{
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_ForgetPwdSuccessVC") as! KC_ForgetPwdSuccessVC
            vc.itsComeFrom = self.itsComeFrom
            vc.modalTransitionStyle = .coverVertical
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func okBtn(_ sender: Any) {
        self.dismiss(animated: true)
        self.successPopUpView.isHidden = true
        NotificationCenter.default.post(name: .navigateToMyRedemption, object: nil)
        self.VM.timer.invalidate()
        
    }
    
    
    func userStatusApi(){
        
        let paramter = [
            "userid":"\(self.userID)"
        ] as [String: Any]
        print(paramter)
        self.VM.checkUserStatusApi(parameter: paramter)
        
    }
    func generateOTPApi(loyaltyId: String){
            let parameter = [
                "MerchantUserName": "KeshavCementDemo",
                "MobileNo": mobilenumber,
                "UserId": self.userID,
                "UserName": loyaltyId,
                "Name": self.customerName
            ] as [String: Any]
            print(parameter)
            self.VM.getOTPApi(parameter: parameter)
    }
    
    func redemptionSubmissionApi(loyaltyId: String){
//        let parameter = [
//            "ActionType": 51,
//            "ActorId": userID,
//            "MemberName": "\(self.customerName)",
//            "ObjCatalogueList": self.VM.newproductArray as [[String: Any]],
//            "ObjCustShippingAddressDetails":["Address1":"\(self.address1)","CityId":"\(self.cityID)", "CityName":"\(self.cityName)","CountryId":"\(self.countryId)","StateName": "\(self.stateName)","StateId":"\(self.stateID)","Zip":"\(self.pincode)","Email":"\(self.emailId)","FullName":"\(self.customerName)","Mobile": self.mobile],"SourceMode":5
//        ] as [String: Any]
//        print(parameter)
//        self.VM.redemptionSubmissionApi(parameter: parameter)
        
        self.VM.timer.invalidate()
        if self.contractorName == ""{
            productsParameter = [
                "ActionType": 51,
                "ActorId": userID,
                "MemberName": "\(self.customerName)",
                "DealerLoyaltyId": loyaltyId,
                "ObjCatalogueDetails": [
                            "DomainName": "KESHAV_CEMENT"
                    ],
                "ObjCatalogueList": self.VM.newproductArray  as [[String: Any]],
                "ObjCustShippingAddressDetails":["Address1":"\(self.address1)","CityId":"\(self.cityID)", "CityName":"\(self.cityName)","CountryId":"\(self.countryId)","StateName": "\(self.stateName)","StateId":"\(self.stateID)","Zip":"\(self.pincode)","Email":"\(self.emailId)","FullName":"\(self.customerName)","Mobile": self.mobile],"SourceMode":5
            ]
            print(productsParameter ?? [])
        }else{
            self.productsParameter = [
                    "ActionType": 51,
                    "ActorId": userID,
                    "MemberName": "\(contractorName)",
                    "ObjCatalogueDetails": [
                                "DomainName": "KESHAV_CEMENT"
                        ],
                    "ObjCatalogueList": [
                        [
                            "DreamGiftId": "\(dreamGiftId)",
                            "LoyaltyId": loyaltyId,
                            "PointBalance": "\(pointBalance)",
                            "NoOfPointsDebit": "\(giftPts)",
                            "NoOfQuantity": 1,
                            "PointsRequired": "\(giftPts)",
                            "ProductName": "\(giftName)",
                            "RedemptionTypeId": self.redemptionTypeId
                        ]
                    ],
                    "ObjCustShippingAddressDetails": [
                        "Address1": "\(self.address1)",
                        "CityId": self.cityID,
                        "CityName": "\(self.cityName)",
                        "CountryId": 103,
                        "Email": "\(self.emailId)",
                        "FullName": "\(contractorName)",
                        "Mobile": loyaltyId,
                        "StateId": self.stateID,
                        "StateName": "\(self.stateName)",
                        "Zip": "\(self.pincode)"
                    ],
                    "SourceMode": 5
                
            ] as [String: Any]
            print(self.productsParameter ?? [], "Dream Gift")
        }
        
        self.VM.redemptionSubmissionApi(parameter: self.productsParameter!)
        
    }
    func sendSuccessMessage(loyaltyId: String){
       let parameter =  [
                "CustomerName": "\(firstname)",
                "EmailID": "",
                "LoyaltyID": "\(loyaltyId)",
                "Mobile": "\(mobilenumber)",
                "PointBalance": "\(self.pointBalance)",
                "RedeemedPoint": "\(self.redeemedPoints)"
            ] as [String:Any]
        print(parameter)
        self.VM.sendSMSApi(parameter: parameter)
        }
    
    
    func removeDreamGift(){
           let parameters = [
                   "ActionType": 4,
                   "ActorId": "\(self.userID)",
                   "DreamGiftId": "\(dreamGiftId)",
                   "GiftStatusId": 4
           ] as [String: Any]
           print(parameters)
           self.VM.removeDreamGift(parameters: parameters) { response in
               let result = response?.returnValue ?? 0
               print(result, "dreamGift Results")
               
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
