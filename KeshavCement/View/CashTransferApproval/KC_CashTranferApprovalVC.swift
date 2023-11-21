//
//  KC_CashTranferApprovalVC.swift
//  KeshavCement
//
//  Created by ADMIN on 13/01/2023.
//

import UIKit
import Toast_Swift
import DPOTPView
import Kingfisher
import LanguageManager_iOS
class KC_CashTranferApprovalVC: BaseViewController, DPOTPViewDelegate, CashTransferDataUpdateDelegate {
    func didApprovedButton(_ cell: KC_CashTransferApprovalTVC) {
        guard let tappedIndexPath = self.cashTransferApprovalTableView.indexPath(for: cell) else{return}
        if cell.approveBtn.tag == tappedIndexPath.row{
            self.successPopupView.isHidden = true
            self.otpPopUpView.isHidden = true
            self.customerLoyaltyId = self.VM.cashTransferApprovalListingArray[tappedIndexPath.row].loyaltyId ?? ""
            self.remarks = cell.remarksTF.text ?? ""
            self.status = 1
            self.cashTransferId = self.VM.cashTransferApprovalListingArray[tappedIndexPath.row].cashTransferId ?? -1
            self.customerMobile = self.VM.cashTransferApprovalListingArray[tappedIndexPath.row].customerMobile ?? ""
            let getLastFour = String(customerMobile.suffix(4))
            print(getLastFour)
            self.infoLbl.text = getLastFour
            self.generateOTPApi()
        }
    }
    
    func didRejectedButton(_ cell: KC_CashTransferApprovalTVC) {
        guard let tappedIndexPath = self.cashTransferApprovalTableView.indexPath(for: cell) else{return}
        if cell.reject.tag == tappedIndexPath.row{
            if self.remarks != ""{
                self.customerLoyaltyId = self.VM.cashTransferApprovalListingArray[tappedIndexPath.row].loyaltyId ?? ""
                self.remarks = cell.remarksTF.text ?? ""
                self.status = -1
                self.cashTransferId = self.VM.cashTransferApprovalListingArray[tappedIndexPath.row].cashTransferId ?? -1
                self.customerMobile = self.VM.cashTransferApprovalListingArray[tappedIndexPath.row].customerMobile ?? ""
                let getLastFour = String(customerMobile.suffix(4))
                print(getLastFour)
                self.infoLbl.text = getLastFour
//                self.generateOTPApi()
                self.cashTransferSubmissionApi(partyLoyalty: self.customerLoyaltyId, remarks: self.remarks, status: self.status, cashTransferId: self.cashTransferId)
//                self.successPopupView.isHidden = false
//                self.successMessageLbl.text = "Yourclaimhasbeenrejected".localiz()
            }else{
                self.view.makeToast("Enterremarks".localiz(), duration: 2.0, position: .center)
            }
        }
    }
    
    
    
    func didEnteredRemarks(_ cell: KC_CashTransferApprovalTVC) {
        guard let tappedIndexPath = self.cashTransferApprovalTableView.indexPath(for: cell) else{return}
        if cell.remarksTF.tag == tappedIndexPath.row{
            self.remarks = cell.remarksTF.text ?? ""
        }
    }
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var headerText: UILabel!
    @IBOutlet weak var cashTransferApprovalTableView: UITableView!
    
    @IBOutlet weak var noDataFoundLbl: UILabel!
    @IBOutlet weak var successPopupView: UIView!
    
    @IBOutlet weak var successMessageLbl: UILabel!
    @IBOutlet weak var otpPopUpView: UIView!
    
    
    @IBOutlet weak var redeemBtn: UIButton!
    @IBOutlet weak var resendOTPBtn: UIButton!
    @IBOutlet weak var otpInfoLbl: UILabel!
    @IBOutlet weak var otpView: DPOTPView!
    @IBOutlet weak var otpValueLbl: UILabel!
    @IBOutlet weak var otpLbl: UILabel!
    @IBOutlet weak var infoLbl: UILabel!
    
    
    var VM = KC_CashTransferApprovalVM()
    var noofelements = 0
    var startIndex = 1
    var noOfQuantity = 0
//    var claimPurchaseListArray: Array = [PendingClaimPurcase]()
    var enteredValue = ""
    var approvalMeassage = ""
    
    var loyaltyID = UserDefaults.standard.string(forKey: "LoyaltyId") ?? ""
    var mobilenumber = UserDefaults.standard.string(forKey: "CustomerMobileNumber") ?? ""
    let emailID = UserDefaults.standard.string(forKey: "CustomerEmail") ?? ""
    let firstname = UserDefaults.standard.string(forKey: "FirstName") ?? ""
    let merchantUserName = UserDefaults.standard.string(forKey: "MerchantEmail") ?? ""
    var merchanMobile = UserDefaults.standard.string(forKey: "MerchantMobile") ?? ""
    var pointBalance = UserDefaults.standard.string(forKey: "RedeemablePointBalance") ?? ""
    
    var customerMobile = ""
    var customerLoyaltyId = ""
    var partyLoyaltId = ""
    var remarks = ""
    var approvedStatus = "-1"
    var status = -1
    var receivedOTP = ""
    var cashTransferId = -1
    
    var temperId = 0
    var quantity = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.searchTF.textColor = .white
        self.headerText.text = "CashTransferApproval".localiz()
        self.searchTF.attributedPlaceholder = NSAttributedString(string: "SearchName".localiz(), attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        self.noDataFoundLbl.isHidden = true
        self.cashTransferApprovalTableView.delegate = self
        self.cashTransferApprovalTableView.dataSource = self
        self.cashTransferListingApi(startIndex: 1, fromDate: "", toDate: "", status: "0", searchText: "")
        otpView.dpOTPViewDelegate = self
        otpView.fontTextField = UIFont.systemFont(ofSize: 25)
        otpView.textEdgeInsets = UIEdgeInsets(top: 0, left: -1, bottom: 0, right: 0)
        otpView.editingTextEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func searchEditingDidEnd(_ sender: Any) {
      //  self.clearTable()
        self.VM.cashTransferApprovalListingArray.removeAll()
        self.startIndex = 1
        self.cashTransferListingApi(startIndex: self.startIndex, fromDate: "", toDate: "", status: "0", searchText: self.searchTF.text ?? "")
    }
    
    @IBAction func oKButton(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }

    
    @IBAction func resendOTPBtn(_ sender: Any) {
            self.VM.timer.invalidate()
            self.generateOTPApi()
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
            
            self.VM.serverOTP(mobileNumber: self.customerMobile, otpNumber: enteredValue)
            
        }
    }
    
    @IBAction func closeActBTN(_ sender: Any) {
        self.successPopupView.isHidden = true
        self.otpPopUpView.isHidden = true
    }
    
    
    
    func cashTransferSubmissionApi(partyLoyalty: String, remarks: String, status: Int, cashTransferId: Int){
        let parameter = [
            "ActionType": 4,
            "ActorId": self.userID,
            "LoyaltyId": partyLoyalty,
            "PartyLoyaltyId": self.loyaltyID,
            "Remarks": remarks,
            "Status": status,
            "CashTranId": cashTransferId
        ] as [String: Any]
        print(parameter)
        self.VM.cashTransferApproveorRejectionSubmissionApi(parameter: parameter)
    }
    
    func generateOTPApi(){
        let parameter = [
            "MerchantUserName": MerchantUserName,
            "MobileNo": customerMobile,
            "UserId": self.userID,
            "UserName": self.loyaltyId,
            "OTPType": "OTPForRewardCardsENCashAuthorization",
        ] as [String: Any]
        print(parameter)
        self.VM.getOTPApi(parameter: parameter)
    }
    func cashTransferListingApi(startIndex: Int, fromDate: String, toDate: String, status: String, searchText: String){
        let parameter = [
            "ActionType": 3,
            "ActorId": self.userID, // dealer subdealer userId
               "StartIndex":startIndex,
               "PageSize":10,
               "SearchText": searchText,
               "IsTranHistory": "-1",
               "Status": status,
               "FromDate": fromDate,
               "Todate": toDate,
            "CustomerTypeId": ""
        ] as [String: Any]
        print(parameter)
        self.VM.cashTransferApprovalHistoryApi(parameter: parameter)
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
extension KC_CashTranferApprovalVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VM.cashTransferApprovalListingArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "KC_CashTransferApprovalTVC", for: indexPath) as! KC_CashTransferApprovalTVC
        cell.delegate = self
        cell.approveBtn.tag = indexPath.row
        cell.reject.tag = indexPath.row
        cell.remarksTF.tag = indexPath.row
        cell.mobileLbl.text = self.VM.cashTransferApprovalListingArray[indexPath.row].customerMobile ?? ""
        cell.pointLbl.text = "\(self.VM.cashTransferApprovalListingArray[indexPath.row].points ?? -1)"
        cell.voucherLbl.text = "\(self.VM.cashTransferApprovalListingArray[indexPath.row].transferedPointsinAmount ?? -1)"
        let receivedDate = String(self.VM.cashTransferApprovalListingArray[indexPath.row].createdDate ?? "").split(separator: " ")
        
        if receivedDate.count != 0{
            let convertFormatter = self.convertDateFormater("\(receivedDate[0])", fromDate: "MM-dd-yyyy", toDate: "dd/MM/yyyy")
            cell.dateLbl.text = "\(convertFormatter)"
        }else{
            cell.dateLbl.text = "-"
        }
        
//        let convertFormatter = self.convertDateFormater("\(receivedDate[0])", fromDate: "MM-dd-yyyy", toDate: "dd/MM/yyyy")
//        if convertFormatter.count != 0 {
//            cell.dateLbl.text = "\(convertFormatter)"
//        }else{
//            cell.dateLbl.text = "-"
//        }
        if self.VM.cashTransferApprovalListingArray[indexPath.row].dispalyImage ?? "" != ""{
            
            let receivedImage = String(self.VM.cashTransferApprovalListingArray[indexPath.row].dispalyImage ?? "").dropFirst(1)
            let userImage = URL(string: "\(PROMO_IMG1)\(receivedImage)")
            cell.cashTransferImage.kf.setImage(with: userImage, placeholder: UIImage(named: "Mask Group 1"))
            
        }else{
            cell.cashTransferImage.image = UIImage(named: "Mask Group 1")
        }
        cell.categoryLbl.text = self.VM.cashTransferApprovalListingArray[indexPath.row].customerType ?? ""
        cell.userNameLbl.text = self.VM.cashTransferApprovalListingArray[indexPath.row].customerName ?? ""
        cell.locationName.text = self.VM.cashTransferApprovalListingArray[indexPath.row].locationName ?? ""
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 270
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

            if indexPath.row == self.VM.cashTransferApprovalListingArray.count - 2{
                if self.noofelements == 10{
                    self.startIndex = self.startIndex + 1
                    self.cashTransferListingApi(startIndex: self.startIndex, fromDate: "", toDate: "", status: "0", searchText: self.searchTF.text ?? "")
                }else if self.noofelements > 10{
                    self.startIndex = self.startIndex + 1
                    self.cashTransferListingApi(startIndex: self.startIndex, fromDate: "", toDate: "", status: "0", searchText: self.searchTF.text ?? "")
                }else if self.noofelements < 10{
                    print("no need to hit API")
                    return
                }else{
                    print("n0 more elements")
                    return
                }
            }
       }
}
