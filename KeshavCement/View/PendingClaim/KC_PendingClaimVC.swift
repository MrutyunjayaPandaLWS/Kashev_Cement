//
//  KC_PendingClaimVC.swift
//  KeshavCement
//
//  Created by ADMIN on 13/01/2023.
//

import UIKit
import CoreData
import DPOTPView
import Kingfisher
import LanguageManager_iOS
class KC_PendingClaimVC: BaseViewController, DataUpdateDelegate, DPOTPViewDelegate{
    func didTapPlusButton(_ cell: KC_PendingClaimTVC) {
        guard let tappedIndexPath = self.pendingClaimTableView.indexPath(for: cell) else{return}
        if cell.plusButton.tag == tappedIndexPath.row{
            self.noOfQuantity = Int(self.claimPurchaseListArray[tappedIndexPath.row].quantity ?? "")!
            let calcValue = self.noOfQuantity + 1
            for receievedData in self.VM.pendingClaimListArray{
                
                if receievedData.ltyTranTempID ?? -1 == Int(self.claimPurchaseListArray[tappedIndexPath.row].temperId ?? "")!{
                    
                    if calcValue <= Int(receievedData.quantity ?? 0.0){
                        for data in self.claimPurchaseListArray{
                            if Int(data.temperId ?? "")! == Int(self.claimPurchaseListArray[tappedIndexPath.row].temperId ?? "-1")!{
                                data.quantity = "\(calcValue)"
                                Persistanceservice.saveContext()
                                self.fetchCartDetails()
                            }
                        }
                    }
                    
                    
                }
            }
            
        }
    }
    
    func didTapMinusButton(_ cell: KC_PendingClaimTVC) {
        guard let tappedIndexPath = self.pendingClaimTableView.indexPath(for: cell) else{return}
        if cell.minusButton.tag == tappedIndexPath.row{
            self.noOfQuantity = Int(self.claimPurchaseListArray[tappedIndexPath.row].quantity ?? "")!
            let calcValue = self.noOfQuantity - 1
            if calcValue != 0{
                for data in self.claimPurchaseListArray{
                    if Int(data.temperId ?? "")! == Int(self.claimPurchaseListArray[tappedIndexPath.row].temperId ?? "-1")!{
                        data.quantity = "\(calcValue)"
                        Persistanceservice.saveContext()
                        self.fetchCartDetails()
                    }
                }
            }
            
        }
    }
    
    func didApprovedButton(_ cell: KC_PendingClaimTVC) {
        guard let tappedIndexPath = self.pendingClaimTableView.indexPath(for: cell) else{return}
        if cell.approve.tag == tappedIndexPath.row{
            self.successPopupView.isHidden = true
            self.otpPopUpView.isHidden = true
            self.temperId = Int(self.claimPurchaseListArray[tappedIndexPath.row].temperId ?? "")!
            self.quantity = Int(self.claimPurchaseListArray[tappedIndexPath.row].quantity ?? "")!
            self.approvedStatus = "1"
            self.remarks = self.claimPurchaseListArray[tappedIndexPath.row].remarks ?? ""
            
            self.validatePointBalanceApi(productCode: self.claimPurchaseListArray[tappedIndexPath.row].productCode ?? "", quantity: String(self.quantity))
            
            
        }
    }
    
    func didRejectedButton(_ cell: KC_PendingClaimTVC) {
        guard let tappedIndexPath = self.pendingClaimTableView.indexPath(for: cell) else{return}
        if cell.reject.tag == tappedIndexPath.row{
            
            for data in self.claimPurchaseListArray{
                if Int(data.temperId ?? "") == Int(self.claimPurchaseListArray[tappedIndexPath.row].temperId ?? "")!{
                    if self.claimPurchaseListArray[tappedIndexPath.row].remarks ?? "" == ""{
                        self.view.makeToast("Enter remarks", duration: 2.0, position: .bottom)
                    }else{
                        self.temperId = Int(self.claimPurchaseListArray[tappedIndexPath.row].temperId ?? "")!
                        
                        self.approvedStatus = "-1"
                        self.remarks = self.claimPurchaseListArray[tappedIndexPath.row].remarks ?? ""
                        
                        for receievedData in self.VM.pendingClaimListArray{
                            if receievedData.ltyTranTempID ?? -1 == Int(self.claimPurchaseListArray[tappedIndexPath.row].temperId ?? "")!{
                                self.quantity = Int(receievedData.quantity ?? -1)
                            }
                        }
                        
                        self.generateOTPApi()
                    }
                }
            }
            
        }
    }
    
    func didEnteredQtyValue(_ cell: KC_PendingClaimTVC) {
        guard let tappedIndexPath = self.pendingClaimTableView.indexPath(for: cell) else{return}
        if cell.qtyTF.tag == tappedIndexPath.row{
            self.noOfQuantity = Int(self.claimPurchaseListArray[tappedIndexPath.row].quantity ?? "")!
            for data in self.claimPurchaseListArray{
                if Int(data.temperId ?? "")! == Int(self.claimPurchaseListArray[tappedIndexPath.row].temperId ?? "-1")!{
                    data.quantity = cell.qtyTF.text ?? ""
                    Persistanceservice.saveContext()
                    self.fetchCartDetails()
                }
            }
        }
    }
    
    func didEnteredRemarks(_ cell: KC_PendingClaimTVC) {
        guard let tappedIndexPath = self.pendingClaimTableView.indexPath(for: cell) else{return}
        if cell.remarksTF.tag == tappedIndexPath.row{
            for data in self.claimPurchaseListArray{
                if Int(data.temperId ?? "")! == Int(self.claimPurchaseListArray[tappedIndexPath.row].temperId ?? "-1")!{
                    data.remarks = cell.remarksTF.text ?? ""
                    Persistanceservice.saveContext()
                    self.fetchCartDetails()
                }
            }
        }
    }
    

  
    @IBOutlet weak var noDataFoundLbl: UILabel!
    @IBOutlet weak var headerText: UILabel!
    @IBOutlet weak var pendingClaimTableView: UITableView!
    @IBOutlet weak var searchByNameTF: UITextField!
    
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
    
    @IBOutlet weak var mobileNumberLbl: UILabel!
    var noofelements = 0
    var startIndex = 1
    var noOfQuantity = 0
    var claimPurchaseListArray: Array = [PendingClaimPurcase]()
    var enteredValue = ""
    
    var loyaltyID = UserDefaults.standard.string(forKey: "LoyaltyId") ?? ""
    var mobilenumber = UserDefaults.standard.string(forKey: "CustomerMobileNumber") ?? ""
    let emailID = UserDefaults.standard.string(forKey: "CustomerEmail") ?? ""
    let firstname = UserDefaults.standard.string(forKey: "FirstName") ?? ""
    let merchantUserName = UserDefaults.standard.string(forKey: "MerchantEmail") ?? ""
    var merchanMobile = UserDefaults.standard.string(forKey: "MerchantMobile") ?? ""
    var pointBalance = UserDefaults.standard.string(forKey: "RedeemablePointBalance") ?? ""
    
    var receivedOTP = ""
    
    var temperId = 0
    var quantity = 0
    var approvedStatus = ""
    var remarks = ""
    
    
    var VM = KC_PendingClaimListVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.successPopupView.isHidden = true
        self.otpPopUpView.isHidden = true
        self.clearTable()
        self.pendingClaimTableView.delegate = self
        self.pendingClaimTableView.dataSource = self
        self.headerText.text = "PendingClaims".localiz()
        self.searchByNameTF.attributedPlaceholder = NSAttributedString(
            string: "Searchbyname/mobilenumber".localiz(),
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        self.searchByNameTF.textColor = .white
        self.pendingClaimTableView.estimatedRowHeight = 260
        self.pendingClaimListApi(startIndex: 1, SearchText: "")
        
        otpView.dpOTPViewDelegate = self
        otpView.fontTextField = UIFont.systemFont(ofSize: 25)
        otpView.textEdgeInsets = UIEdgeInsets(top: 0, left: -1, bottom: 0, right: 0)
        otpView.editingTextEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let getLastFour = String(mobilenumber.suffix(4))
        print(getLastFour)
        self.mobileNumberLbl.text = getLastFour
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func closeBtn(_ sender: Any) {
        self.VM.timer.invalidate()
        self.otpPopUpView.isHidden = true
    }
    
    @IBAction func searchByNameEditingDidEnd(_ sender: Any) {
        self.clearTable()
        self.startIndex = 1
        self.pendingClaimListApi(startIndex: self.startIndex, SearchText: self.searchByNameTF.text ?? "")
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
        }else if self.receivedOTP != self.enteredValue{
            self.view.makeToast("EntercorrectOTP".localiz(), duration: 2.0, position: .bottom)
        }else{
            let yesterday = "\(Calendar.current.date(byAdding: .day, value: 0, to: Date())!)"
            let today = yesterday.split(separator: " ")
            let desiredDateFormat = self.convertDateFormater("\(today[0])", fromDate: "yyyy-MM-dd", toDate: "yyyy-MM-dd")
           print("\(desiredDateFormat)")
            self.pendingClaimSubmissionApi()
        }
    }
    
    
    
    func pendingClaimListApi(startIndex: Int, SearchText: String){
        let parameter = [
            "ActionType": 21,
            "ActorId": self.userID,
            "ApprovalStatusID": 0,
            "CustomerTypeId": -1,
            "NoOfRows": 10,
            "SearchText": SearchText,
            "StartIndex": startIndex
        ] as [String: Any]
        print(parameter)
        self.VM.pendinClaimListRequest(parameter: parameter)
    }
    
    func pendingClaimSubmissionApi(){
        let parameter = [
            "ActorId": self.userID,
            "ApprovalRemarks": self.remarks,
            "ApprovalStatusID": self.approvedStatus,
            "lstTransactionApprovals": [
                [
                    "LtyTranTempID": self.temperId,
                    "Quantity": self.quantity
                ]
            ]
        ] as [String: Any]
        print(parameter)
        self.VM.pendingClaimSubmission(parameter: parameter)
    }
 
    func validatePointBalanceApi(productCode: String, quantity: String){
        if self.customerTypeId == "5"{
            let parameter = [
                "ActorId": UserDefaults.standard.string(forKey: "mappedCustomerId") ?? "",
                "ProductSaveDetailList": [
                    [
                        "ProductCode": productCode,
                        "Quantity":quantity
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
                        "ProductCode": productCode,
                        "Quantity":quantity
                    ]
                ],
                "RitailerId":  self.userID,
                "Approval_Status": "5"
            ] as [String: Any]
            print(parameter)
            self.VM.checkPointBalanceApi(parameter: parameter)
        }
        
       
        
        
    }
    
    func generateOTPApi(){
        let parameter = [
            "MerchantUserName": "KeshavCementDemo",
            "MobileNo": mobilenumber,
            "UserId": self.userID,
            "UserName": self.loyaltyId,
            "Name": self.firstname
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

extension KC_PendingClaimVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.claimPurchaseListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "KC_PendingClaimTVC", for: indexPath) as! KC_PendingClaimTVC
        cell.delegate = self
        let receivedTransactionDate = String(self.claimPurchaseListArray[indexPath.row].transactionDate ?? "").split(separator: " ")
        if receivedTransactionDate.count != 0 {
            cell.claimDateLbl.text = "\(receivedTransactionDate[0])"
        }else{
            cell.claimDateLbl.text = "-"
        }
        if self.claimPurchaseListArray[indexPath.row].productImage ?? "" != ""{
            
            let receivedImage = String(self.claimPurchaseListArray[indexPath.row].productImage ?? "").dropFirst(1)
            let userImage = URL(string: "\(PROMO_IMG1)\(receivedImage)")
            cell.claimImage.kf.setImage(with: userImage, placeholder: UIImage(named: "ic_default_img"))
            
        }else{
            cell.claimImage.image = UIImage(named: "ic_default_img")
        }
        cell.categoryTypeLbl.text = self.claimPurchaseListArray[indexPath.row].memberType ?? ""
        cell.userNameLbl.text = self.claimPurchaseListArray[indexPath.row].memberName ?? ""
        cell.locationLbl.text = self.claimPurchaseListArray[indexPath.row].locationName ?? ""
        cell.productName.text = self.claimPurchaseListArray[indexPath.row].productName ?? ""
        cell.qtyTF.text = self.claimPurchaseListArray[indexPath.row].quantity ?? ""
        if self.claimPurchaseListArray[indexPath.row].remarks ?? "" == ""{
            cell.remarksTF.text = ""
        }else{
            cell.remarksTF.text = self.claimPurchaseListArray[indexPath.row].remarks ?? ""
        }
        
        cell.claimIdLbl.text = self.claimPurchaseListArray[indexPath.row].invoiceNo ?? "-"
        
        cell.minusButton.tag = indexPath.row
        cell.plusButton.tag = indexPath.row
        cell.approve.tag = indexPath.row
        cell.reject.tag = indexPath.row
        cell.qtyTF.tag = indexPath.row
        cell.remarksTF.tag = indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 270
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

            if indexPath.row == self.claimPurchaseListArray.count - 1{
                if self.noofelements == 10{
                    self.startIndex = self.startIndex + 1
                    self.pendingClaimListApi(startIndex: self.startIndex, SearchText: self.searchByNameTF.text ?? "")
                }else if self.noofelements > 10{
                    self.startIndex = self.startIndex + 1
                    self.pendingClaimListApi(startIndex: self.startIndex, SearchText: self.searchByNameTF.text ?? "")
                }else if self.noofelements < 10{
                    print("no need to hit API")
                    return
                }else{
                    print("n0 more elements")
                    return
                }
            }
       }
    
    func fetchCartDetails(){
      //  self.claimPurchaseListArray.removeAll()
        let fetchRequest:NSFetchRequest<PendingClaimPurcase> = PendingClaimPurcase.fetchRequest()
        do{
            self.claimPurchaseListArray = try Persistanceservice.context.fetch(fetchRequest)
            print(self.claimPurchaseListArray.count, "ClaimPurchaseListArray Count")
            
            if self.VM.pendingClaimListArray.count != 0 {
                self.pendingClaimTableView.isHidden = false
                self.noDataFoundLbl.isHidden = true
                self.pendingClaimTableView.reloadData()
            }else{
                self.pendingClaimTableView.isHidden = true
                self.noDataFoundLbl.isHidden = false
                self.noDataFoundLbl.textColor = .white
            }
            
            self.pendingClaimTableView.reloadData()
        }catch{
            print("error while fetching data")
        }
        
    }
    func clearTable(){
        
        let context = Persistanceservice.persistentContainer.viewContext
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "PendingClaimPurcase")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
    
}
