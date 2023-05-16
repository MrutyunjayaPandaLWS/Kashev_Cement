//
//  EgiftVoucherDetailsVC.swift
//  SurfaceSellersClubCustomerMobileApplicationiOS
//
//  Created by Arokia IT on 4/29/20.
//  Copyright © 2020 Arokiait Pvt Ltd. All rights reserved.
//

import UIKit
import LanguageManager_iOS
//import Firebase
import DPOTPView
import Kingfisher
class EgiftVoucherDetailsVC: BaseViewController, UITextFieldDelegate, pointsDelegate, popUpAlertDelegate, DPOTPViewDelegate{
    func popupAlertDidTap(_ vc: RGT_popupAlertOne_VC) {}
    
//    func popupAlertDidTap(_ vc: RGT_popupAlertOne_VC) {
//
//    }
    
    
    func selectPointsDidTap(_ VC: QS_redeemQuantity_VC) {
        self.selectedPoints = VC.selectedpoints
        self.productcodeselected = VC.productCodefromPrevious
        self.selectAmountButton.setTitle(String(self.selectedPoints), for: .normal)
    }
    
    var myredemptionsVouchers = [myredemptionsVouchersModels]()
    @IBOutlet weak var myVouchersDetailsTableView: UITableView!
    
    @IBOutlet weak var successPopupView: UIView!
    @IBOutlet weak var successMessageLbl: UILabel!
    @IBOutlet weak var otpPopUpView: UIView!
    @IBOutlet weak var resendOTPBtn: UIButton!
    @IBOutlet weak var otpView: DPOTPView!
    @IBOutlet weak var otpValueLbl: UILabel!
    @IBOutlet weak var mobileNumberLbl: UILabel!
    @IBOutlet weak var popView: UIView!
    
   
    
    @IBOutlet weak var vouchername: UILabel!
    @IBOutlet weak var voucherimage: UIImageView!
    @IBOutlet weak var amountRange: UILabel!
    @IBOutlet weak var amounttextfield: UITextField!
    @IBOutlet weak var selectamountView: UIView!
    @IBOutlet weak var selectAmountButton: UIButton!
    @IBOutlet weak var redeemButton: UIButton!
    //@IBOutlet var categoryHeadingLabel: UILabel!
    @IBOutlet var vouchersHeadingLabel: UILabel!
    
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var voucherDescLbl: UILabel!
    @IBOutlet weak var termsandconditionLbl: UILabel!
    
    var receivedOTP = ""
    
    var selectedRowIndex = -1
    var voucherID = -1
    var amountselected = 0
    var redemptiondate = ""
    var voucherName = ""
    var voucherTC = ""
    var voucherDesc = ""
    var redeemoptions = ""
    var voucherImag = ""
    var voucherCode = ""
    var voucherMinPoints = "-1"
    var voucherMaxPoints = "-1"
    var vouchercategory = ""
    var selectedPoints = 0
    var productcodeselected = ""
    var voucherdelivarytype = ""
    var vouchervendorID = -1
    var vouchervendorname = ""
    var voucherCountryID = -1
    var productDesc = ""
    var termsandCond = ""
    var enteredValue = ""
    var mobile = ""
    var firstNAME = ""
    
    var mappedUserId = -1
    var vm = QS_VouchersDetails_VM()
    var recieverMobile = ""
    let redemablePointBalance = UserDefaults.standard.integer(forKey: "PointsBalance")
//    let userID = UserDefaults.standard.string(forKey: "UserID") ?? "-1"
    let layaltyID = UserDefaults.standard.string(forKey: "LoyaltyID") ?? ""
//    var mobilenumber = UserDefaults.standard.string(forKey: "Mobile") ?? ""
    var emailid = UserDefaults.standard.string(forKey: "CustomerEmail") ?? ""
    var firstname = UserDefaults.standard.string(forKey: "FirstName") ?? ""
    var merchantID = UserDefaults.standard.integer(forKey: "MerchantID") ?? 1
    
    var mobilenumber = UserDefaults.standard.string(forKey: "CustomerMobileNumber") ?? ""
    let merchantUserName = UserDefaults.standard.string(forKey: "MerchantEmail") ?? ""
    var merchanMobile = UserDefaults.standard.string(forKey: "MerchantMobile") ?? ""
    var pointBalance = UserDefaults.standard.string(forKey: "RedeemablePointBalance") ?? ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vm.VC = self
        self.popView.isHidden = true
        localization()
//        myVouchersDetailsTableView.delegate = self
//        myVouchersDetailsTableView.dataSource = self
        let date = Date()
        amounttextfield.delegate = self
        print(date.string(format: "yyyy-MM-dd"))
        self.redemptiondate = date.string(format: "yyyy-MM-dd")
//        myVouchersDetailsTableView.delegate = self
//        myVouchersDetailsTableView.dataSource = self
        if voucherMaxPoints != "-1"{
            selectamountView.isHidden = true
            amounttextfield.isHidden = false
            amountRange.text = "\("EnterAmountinRange".localiz()): \(voucherMinPoints) - \(voucherMaxPoints)"
            selectAmountButton.setTitle("Amount".localiz(), for: .normal)
            amounttextfield.placeholder = "Amount".localiz()
            redeemButton.setTitle("Redeem".localiz(), for: .normal)
            
            let points = redemablePointBalance
            let minpoints = Int(voucherMinPoints)
            if points < minpoints! {
                redeemButton.isHidden = false
            }else{
                redeemButton.isHidden = false
            }
        }else if voucherMaxPoints == "-1"{
            selectamountView.isHidden = false
            amounttextfield.isHidden = true
            selectAmountButton.setTitle("Amount".localiz(), for: .normal)
            amountRange.text = "SelectAmount".localiz()
            amounttextfield.placeholder = "Amount".localiz()
            redeemButton.setTitle("Redeem".localiz(), for: .normal)
        }
        self.vouchername.text = voucherName
        self.categoryLbl.text = vouchercategory
        self.voucherimage.sd_setImage(with: URL(string: voucherImag), placeholderImage: UIImage(named: "ic_default_img"));
        self.myredemptionsVouchers.append(myredemptionsVouchersModels.init(descriptions: "Descriptions", termsandconditions: voucherDesc))
        self.myredemptionsVouchers.append(myredemptionsVouchersModels.init(descriptions: "Terms_&_Conditions", termsandconditions: voucherTC))
        self.myredemptionsVouchers.append(myredemptionsVouchersModels.init(descriptions: "Redeem_Options", termsandconditions: redeemoptions))
        self.termsandconditionLbl.text = self.voucherTC
        self.voucherDescLbl.text = "\(self.voucherDesc)"
        
//        self.myVouchersDetailsTableView.reloadData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handlepopupdateclose), name: Notification.Name.showPopUp, object: nil)
//        self.redeemButton.backgroundColor = UIColor(red: 0/255, green: 183/255, blue: 241/255, alpha: 1.0)
        otpView.dpOTPViewDelegate = self
        otpView.fontTextField = UIFont.systemFont(ofSize: 25)
        otpView.textEdgeInsets = UIEdgeInsets(top: 0, left: -1, bottom: 0, right: 0)
        otpView.editingTextEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        print(self.recieverMobile,"skjds")
        if self.recieverMobile == ""{
            let getLastFour = String(mobilenumber.suffix(4))
            print(getLastFour)
            self.mobileNumberLbl.text = getLastFour
        }else{
            let getLastFour = String(recieverMobile.suffix(4))
            print(getLastFour)
            self.mobileNumberLbl.text = getLastFour
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "E-Gift VoucherDetails")
//
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])
    }
    
    func localization() {
        //self.categoryHeadingLabel.text = "Category"
        self.vouchersHeadingLabel.text = "Vouchers".localiz()
        //self.brandHeadingLabel.text = "Brand"
    }
    
    @objc func handlepopupdateclose() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == amounttextfield{
            guard let textFieldText = amounttextfield.text,
                   let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                       return false
               }
               let substringToReplace = textFieldText[rangeOfTextToReplace]
               let count = textFieldText.count - substringToReplace.count + string.count
               return count <= 6
            
        }
        return true
    }
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return myredemptionsVouchers.count
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "MyVouchersTVC", for: indexPath) as? MyVouchersTVC
//        cell?.topic.text = myredemptionsVouchers[indexPath.row].descriptions ?? ""
//        cell?.details.text = myredemptionsVouchers[indexPath.row].termsandconditions ?? ""
//        cell?.selectionStyle = .none
//        return cell!
//    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.row == selectedRowIndex {
//            return UITableView.automaticDimension //Not expanded
//        }
//        return 50 //Not expanded
//    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if selectedRowIndex == indexPath.row {
//            selectedRowIndex = -1
//        } else {
//            selectedRowIndex = indexPath.row
//        }
//        myVouchersDetailsTableView.reloadRows(at: [indexPath], with: .automatic)
//    }
    
    
    
    @IBAction func selectAmount(_ sender: Any) {
        DispatchQueue.main.async{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "QS_redeemQuantity_VC") as? QS_redeemQuantity_VC
            vc!.productCodefromPrevious = self.voucherCode
            vc!.delegate = self
            vc!.modalPresentationStyle = .overCurrentContext
            vc!.modalTransitionStyle = .crossDissolve
            self.present(vc!, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func redeemButton(_ sender: Any) {
        if voucherMinPoints != "-1" || voucherMaxPoints != "-1"{
            if self.amounttextfield.text?.count == 0{
                self.alertmsg(alertmsg: "Enter_amount_to_redeem".localiz(), buttonalert: "OK".localiz())
            }else{
                if Int(self.overAllPts)! >= Int(self.amounttextfield.text ?? "0")!{
                    if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
                        DispatchQueue.main.async{
                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RGT_popupAlertOne_VC") as? RGT_popupAlertOne_VC
                            vc!.delegate = self
                            vc!.titleInfo = ""
                            vc!.descriptionInfo = "No Internet. Please check your internet connection"
                            vc!.modalPresentationStyle = .overCurrentContext
                            vc!.modalTransitionStyle = .crossDissolve
                            self.present(vc!, animated: true, completion: nil)
                        }
                    }else{
                        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
                            DispatchQueue.main.async{
                                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RGT_popupAlertOne_VC") as? RGT_popupAlertOne_VC
                                vc!.delegate = self
                                vc!.titleInfo = ""
                                vc!.descriptionInfo = "No Internet. Please check your internet connection"
                                vc!.modalPresentationStyle = .overCurrentContext
                                vc!.modalTransitionStyle = .crossDissolve
                                self.present(vc!, animated: true, completion: nil)
                            }
                        }else{
                            self.popView.isHidden = false
                            if self.mobile == ""{
                                self.generateOTPApi(mobilenumber: mobilenumber , userID: self.userID, firstname: firstname)
                                
                            }else{
                                self.generateOTPApi(mobilenumber: mobile , userID: "\(self.mappedUserId)", firstname: firstNAME)
                            }
                            
                            
//                        self.vm.voucherSubmission(ReceiverMobile: mobilenumber, ActorId: userID, CountryID: voucherCountryID, MerchantId: merchantID, CatalogueId: voucherID, DeliveryType: voucherdelivarytype, pointsrequired: self.amounttextfield.text ?? "0", ProductCode: voucherCode, ProductImage: voucherImag, ProductName: voucherName, NoOfQuantity: "1", VendorId: vouchervendorID, VendorName: vouchervendorname, ReceiverEmail: emailid, ReceiverName: firstname)
                        }
                    }
                }else{
                    self.alertmsg(alertmsg: "InsufficientPointBalance".localiz(), buttonalert: "OK".localiz())
                }
            }
        }else{
            if self.selectAmountButton.currentTitle == "Amount"{
                self.alertmsg(alertmsg: "Select_Amount_to_Redeem".localiz(), buttonalert: "OK".localiz())
            }else{
                if Int((UserDefaults.standard.string(forKey:"PointsBalance") ?? ""))! >= self.selectedPoints{
                    if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
                        DispatchQueue.main.async{
                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RGT_popupAlertOne_VC") as? RGT_popupAlertOne_VC
                            vc!.delegate = self
                            vc!.titleInfo = ""
                            vc!.descriptionInfo = "No Internet. Please check your internet connection"
                            vc!.modalPresentationStyle = .overCurrentContext
                            vc!.modalTransitionStyle = .crossDissolve
                            self.present(vc!, animated: true, completion: nil)
                        }
                    }else{
                        self.popView.isHidden = false
                        if self.mobile == ""{
                            self.generateOTPApi(mobilenumber: mobilenumber , userID: self.userID, firstname: firstname)
                            
                        }else{
                            self.generateOTPApi(mobilenumber: mobile , userID: "\(self.mappedUserId)", firstname: firstNAME)
                        }
                    }
                }else{
                    self.alertmsg(alertmsg: "InsufficientPointBalance".localiz(), buttonalert: "OK".localiz())
                }
            }
        }
    }
    @IBAction func enteramounttf(_ sender: Any) {
        if amounttextfield.text != ""{
            let amt = Int(amounttextfield.text ?? "0")!
            if amt < Int(voucherMinPoints)! || amt > Int(voucherMaxPoints)!{
                self.redeemButton.backgroundColor = UIColor.lightGray
                self.redeemButton.isEnabled = false
            }else{
//                self.redeemButton.backgroundColor = UIColor(red: 1/255, green: 105/255, blue: 56/255, alpha: 1.0)
                self.redeemButton.isEnabled = true
                self.selectedPoints = Int(self.amounttextfield.text ?? "") ?? 0
            }
        }else{
//            self.redeemButton.backgroundColor = UIColor(red: 0/255, green: 183/255, blue: 241/255, alpha: 1.0)
            self.redeemButton.isEnabled = true
        }
    }
    @IBAction func oKButton(_ sender: Any) {
        self.otpPopUpView.isHidden = true
        self.popView.isHidden = true
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func resendOTPBtn(_ sender: Any) {
            self.vm.timer.invalidate()
        if self.mobile == ""{
            self.generateOTPApi(mobilenumber: mobilenumber , userID: self.userID, firstname: firstname)
            
        }else{
            self.generateOTPApi(mobilenumber: mobile , userID: "\(self.mappedUserId)", firstname: firstNAME)
        }
    }
    @IBAction func closeBtn(_ sender: Any) {
        self.vm.timer.invalidate()
        self.otpPopUpView.isHidden = true
    }
    
    @IBAction func otpSubmitBtn(_ sender: Any) {
        if self.enteredValue.count == 0 {
            self.view.makeToast("EnterOTP".localiz(), duration: 2.0, position: .bottom)
        }else if self.enteredValue.count != 6{
            self.view.makeToast("EntervalidOTP".localiz(), duration: 2.0, position: .bottom)
        }else if self.receivedOTP != self.enteredValue{
            self.view.makeToast("EntercorrectOTP".localiz(), duration: 2.0, position: .bottom)
        }else{
            let yesterday = "\(Calendar.current.date(byAdding: .day, value: 0, to: Date())!)"
            let today = yesterday.split(separator: " ")
            let desiredDateFormat = self.convertDateFormater("\(today[0])", fromDate: "yyyy-MM-dd", toDate: "yyyy-MM-dd")
            print("\(desiredDateFormat)")
            if self.recieverMobile == ""{
                self.vm.voucherSubmission(ReceiverMobile: mobilenumber, ActorId: userID, CountryID: voucherCountryID, MerchantId: merchantID, CatalogueId: voucherID, DeliveryType: voucherdelivarytype, pointsrequired: String(selectedPoints), ProductCode: voucherCode, ProductImage: voucherImag, ProductName: voucherName, NoOfQuantity: "1", VendorId: vouchervendorID, VendorName: vouchervendorname, ReceiverEmail: emailid, ReceiverName: firstname, LoyaltyId: layaltyID)
            }else{
                self.vm.voucherSubmission(ReceiverMobile: self.recieverMobile, ActorId: "\(self.mappedUserId)", CountryID: voucherCountryID, MerchantId: merchantID, CatalogueId: voucherID, DeliveryType: voucherdelivarytype, pointsrequired: String(selectedPoints), ProductCode: voucherCode, ProductImage: voucherImag, ProductName: voucherName, NoOfQuantity: "1", VendorId: vouchervendorID, VendorName: vouchervendorname, ReceiverEmail: emailid, ReceiverName: firstname, LoyaltyId: layaltyID)
            }
            
        }
        
    }
    

    
    func generateOTPApi(mobilenumber: String, userID:String, firstname: String){
        let parameter = [
            "MerchantUserName": MerchantUserName,
            "MobileNo": mobilenumber,
            "UserId": userID,
            "UserName": self.loyaltyId,
            "Name": firstname
        ] as [String: Any]
        print(parameter)
        self.vm.getOTPApi(parameter: parameter)
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
extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
class myredemptionsVouchersModels: NSObject {
    var descriptions :String!
    var termsandconditions : String!
    init(descriptions:String!, termsandconditions:String!){
        self.descriptions = descriptions
        self.termsandconditions = termsandconditions
        
        
    }
}
