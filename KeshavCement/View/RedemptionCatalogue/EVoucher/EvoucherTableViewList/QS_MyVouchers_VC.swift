//
//  QS_MyVouchers_VC.swift
//  Quba Safalta
//
//  Created by Arokia-M3 on 10/03/21.
//

import UIKit
import LanguageManager_iOS
//import Firebase
import DPOTPView
import Kingfisher

class QS_MyVouchers_VC: BaseViewController, UITableViewDelegate,UITableViewDataSource, vouchersDelegate, popUpAlertDelegate, DPOTPViewDelegate, pointsDelegate{
    func popupAlertDidTap(_ vc: RGT_popupAlertOne_VC) {}
    
    func enteredAmount(_ cell: QS_Vouchers_TVC) {
        guard let tappedIndexPath = self.myVouchersTableview.indexPath(for: cell) else {return}
        print(cell.amounttf.text ?? "", "Entered Value")
        if cell.amounttf.text?.count != 0{
            if cell.amounttf.tag == self.vm.myvouchersArray[tappedIndexPath.row].catalogueId ?? 0{
                
                let amt = Int(cell.amounttf.text ?? "0") ?? 0
                print(Int(self.vm.myvouchersArray[tappedIndexPath.row].min_points!)!)
                print(Int(self.vm.myvouchersArray[tappedIndexPath.row].max_points!)!)
                print(amt)
                self.mimPoints = self.vm.myvouchersArray[tappedIndexPath.row].min_points ?? ""
                self.maxPoints = self.vm.myvouchersArray[tappedIndexPath.row].max_points ?? ""
                if amt < Int(self.vm.myvouchersArray[tappedIndexPath.row].min_points!)! || amt > Int(self.vm.myvouchersArray[tappedIndexPath.row].max_points!)!{
//                    cell.filter.backgroundColor = UIColor.gray
//                    cell.filter.isEnabled = false
                    self.alertmsg(alertmsg: "Enter_redeemable_amount_in_range".localiz(), buttonalert: "OK")
                    cell.filter.isEnabled = false
                    cell.amounttf.text = ""
                }else{
                   // cell.filter.backgroundColor = UIColor(red: 1/255, green: 105/255, blue: 56/255, alpha: 1.0)
                    cell.filter.isEnabled = true
                }
                
               
            }
            self.filteredArray.append(GetDataFromVoucher(productCatalogueId: self.vm.myvouchersArray[tappedIndexPath.row].catalogueId ?? 0, enteredQuantity: Int(cell.amounttf.text ?? "") ?? 0))
            print(self.filteredArray.count, "Filtered Array Count")
        }else{
//            cell.filter.backgroundColor = UIColor(red: 0/255, green: 183/255, blue: 241/255, alpha: 1.0)
            cell.filter.isEnabled = true
            cell.amounttf.text = ""
            
            if let index = filteredArray.firstIndex(where: {$0.productCatalogueId == self.vm.myvouchersArray[tappedIndexPath.row].catalogueId ?? 0}) {
                filteredArray.remove(at: index)
            }
            print(self.filteredArray.count, "After remove Array Count")
        }
        

    }
    func selectPointsDidTap(_ VC: QS_redeemQuantity_VC) {
        self.selectedPoints = VC.selectedpoints
        self.productcodeselected = VC.productCodefromPrevious
        print(VC.selectedpoints)
        print(VC.productCodefromPrevious)
        print(productcodeselected,"sdkjdn")
        self.myVouchersTableview.reloadData()
       // self.delegate.sendDatatoTVC(self)
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: .SHOWDATA23 , object: self)
        }
        
        //NotificationCenter.default.post(name: Notification.Name("SHOWDATA23"), object: self)
    }
    
    func redeemDidTap(_ cell: QS_Vouchers_TVC) {
        print(cell.vouchersdata[0].min_points ?? "-1","minPoints")
        print(cell.vouchersdata[0].max_points ?? "-1","maxPoints")
        if cell.vouchersdata[0].min_points ?? "-1" != "-1" || cell.vouchersdata[0].max_points ?? "-1" != "-1"{
            
            let amt = Int(cell.amounttf.text ?? "0") ?? 0
            self.mimPoints = cell.vouchersdata[0].min_points ?? ""
            self.maxPoints = cell.vouchersdata[0].max_points ?? ""
            print(self.mimPoints,"khubu")
            print(self.maxPoints,"kmhjopgjfnio")
            if amt < Int(cell.vouchersdata[0].min_points ?? "")! || amt > Int(cell.vouchersdata[0].max_points ?? "")! || cell.amounttf.text?.count == 0{
                self.alertmsg(alertmsg: "Enter_amount_to_redeem".localiz(), buttonalert: "OK")
            }else{
                if Int(self.overAllPts)! >= Int(cell.amounttf.text ?? "0")!{
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
                        print(self.mimPoints,"MimPoints")
                        print(self.maxPoints,"MaxPoints")
                        self.popView.isHidden = false
                        
                        if self.mobile == ""{
                            self.receiverMobile = self.mobilenumber
                            self.generateOTPApi(mobilenumber: self.mobilenumber, userID: self.userID, loyaltyId: self.loyaltyId, firstname: self.firstname)
                            self.actorId = userID
                            self.receiverEmail = emailid
                            self.receiverName = firstname
                        }else{
                            self.receiverMobile = self.mobile
                            self.generateOTPApi(mobilenumber: self.mobile, userID: "\(self.mappedUserId)", loyaltyId: self.partyLoyaltyId, firstname: self.firstNAME)
                            self.actorId = "\(self.mappedUserId)"
                            self.receiverEmail = self.emailData
                            self.receiverName = firstNAME
                        }
                       
                        self.countryID = cell.vouchersdata[0].countryID ?? -1
                        self.merchantId = "\(self.merchantID)"
                        self.catalogueId = cell.vouchersdata[0].catalogueId ?? -1
                        self.deliveryType = cell.vouchersdata[0].deliveryType ?? ""
                        self.pointsrequired = cell.amounttf.text ?? "0"
                        self.productCode = cell.vouchersdata[0].productCode ?? ""
                        self.productImage = cell.vouchersdata[0].productImage ?? ""
                        print(self.productImage)
                        self.productName = cell.vouchersdata[0].productName ?? ""
                        self.noOfQuantity = "1"
                        self.vendorId = "\(cell.vouchersdata[0].vendorId ?? -1)"
                        self.vendorName = cell.vouchersdata[0].vendorName ?? ""
                        
         
                    }
                }else{
                    self.alertmsg(alertmsg: "InsufficientPointBalance".localiz(), buttonalert: "OK".localiz())
                }
            }
        }else{
            if cell.amount.currentTitle == "Amount"{
                self.alertmsg(alertmsg: "Select_Amount_to_Redeem".localiz(), buttonalert: "OK".localiz())
            }else{
                if Int(self.overAllPts)! >= self.selectedPoints{
                    self.popView.isHidden = false
                    
                    if self.mobile == ""{
                        self.receiverMobile = self.mobilenumber
                        self.generateOTPApi(mobilenumber: self.mobilenumber, userID: self.userID, loyaltyId: self.loyaltyId, firstname: self.firstname)
                        self.actorId = userID
                        self.receiverName = firstname
                        self.receiverEmail = emailid
                    }else{
                        self.receiverMobile = self.mobile
                        self.generateOTPApi(mobilenumber: self.mobile, userID: "\(self.mappedUserId)", loyaltyId: self.partyLoyaltyId, firstname: self.firstNAME)
                        self.actorId = "\(self.mappedUserId)"
                        self.receiverName = firstNAME
                        self.receiverEmail = emailData
                    }
                   
                    self.countryID = cell.vouchersdata[0].countryID ?? -1
                    self.merchantId = "\(self.merchantID)"
                    self.catalogueId = cell.vouchersdata[0].catalogueId ?? -1
                    self.deliveryType = cell.vouchersdata[0].deliveryType ?? ""
                    self.pointsrequired = cell.amount.currentTitle!
                    self.productCode = cell.vouchersdata[0].productCode ?? ""
                    self.productImage = cell.vouchersdata[0].productImage ?? ""
                    print(self.productImage)
                    self.productName = cell.vouchersdata[0].productName ?? ""
                    self.noOfQuantity = "1"
                    self.vendorId = "\(cell.vouchersdata[0].vendorId ?? -1)"
                    self.vendorName = cell.vouchersdata[0].vendorName ?? ""
                    
                    
                    

                }else{
                    self.alertmsg(alertmsg: "InsufficientPointBalance".localiz(), buttonalert: "OK".localiz())
                }
                }
        }
    }

    
    func amountDidTap(_ cell: QS_Vouchers_TVC) {
        guard let tappedIndexPath = self.myVouchersTableview.indexPath(for: cell) else {return}
        DispatchQueue.main.async{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "QS_redeemQuantity_VC") as? QS_redeemQuantity_VC
            vc!.productCodefromPrevious = self.vm.myvouchersArray[tappedIndexPath.row].productCode ?? ""
            vc!.delegate = self
            vc!.modalPresentationStyle = .overCurrentContext
            vc!.modalTransitionStyle = .crossDissolve
            self.present(vc!, animated: true, completion: nil)
        }
        
    }
    
    func alertDidTap(_ cell: QS_Vouchers_TVC) {
        self.alertmsg(alertmsg: "\(cell.alertMsg)", buttonalert: "OK".localiz())
    }
    
    @IBOutlet var myVouchersTableview: UITableView!
    
    @IBOutlet var noDataFoundLabel: UILabel!
    @IBOutlet var vouchersHeadingLabel: UILabel!
//    @IBOutlet var redeemablebalance: UILabel!
    @IBOutlet var points: UILabel!
    
    @IBOutlet weak var totalPointss: UILabel!
    
    @IBOutlet weak var successPopupView: UIView!
    @IBOutlet weak var otpPopUpView: UIView!
    @IBOutlet weak var resendOTPBtn: UIButton!
    @IBOutlet weak var otpView: DPOTPView!
    @IBOutlet weak var otpValueLbl: UILabel!
    @IBOutlet weak var mobileNumberLbl: UILabel!
    
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var popView: UIView!
    
    @IBOutlet weak var successfullyLbl: UILabel!
    
    @IBOutlet weak var sucessMsg: UILabel!
    
    @IBOutlet weak var okBtn: UIButton!
    
    @IBOutlet weak var otpInfoLbl: UILabel!
    
    @IBOutlet weak var otpLbl: UILabel!
    
    @IBOutlet weak var OTPinfoHeaderLbl: UILabel!
    
    @IBOutlet weak var redeemBtn: UIButton!
    @IBOutlet weak var popUpHeaderLbl: UILabel!
    var selectedPoints = 0
    var productcodeselected = ""
    var selectedProductValue = 0
    var receivedOTP = ""
    var mobile = ""
    var firstNAME = ""
    var mimPoints = ""
    var maxPoints = ""
    var partyLoyaltyId = ""
    let vm = QS_Vouchers_VM()
    var filteredArray = [GetDataFromVoucher]()
    
//    let userID = UserDefaults.standard.string(forKey: "UserID") ?? "-1"
        var redbal = UserDefaults.standard.string(forKey: "PointsBalance") ?? "0"
    var mobilenumber = UserDefaults.standard.string(forKey: "CustomerMobileNumber") ?? ""
        var emailid = UserDefaults.standard.string(forKey: "CustomerEmail") ?? ""
        var firstname = UserDefaults.standard.string(forKey: "FirstName") ?? ""
    let layaltyID = UserDefaults.standard.string(forKey: "LoyaltyId") ?? ""
    var pointBalance = UserDefaults.standard.string(forKey: "RedeemablePointBalance") ?? ""
    
    
    var merchantID = UserDefaults.standard.integer(forKey: "MerchantID") ?? 1
    let merchantUserName = UserDefaults.standard.string(forKey: "MerchantEmail") ?? ""
    var merchanMobile = UserDefaults.standard.string(forKey: "MerchantMobile") ?? ""
    
    var merchantIds = ""
    let merchantUserNamE = ""
    var merchanMobilE = ""
    var enteredValue = ""
        var emailData = ""
        var receiverMobile = ""
        var actorId = ""
        var countryID = 0
        var merchantId = ""
        var catalogueId = -1
        var deliveryType = ""
        var pointsrequired = ""
        var productCode = ""
        var productImage = ""
        var productName = ""
        var noOfQuantity = ""
        var vendorId = ""
        var vendorName = ""
        var receiverEmail = ""
        var receiverName = ""
    var mappedUserId = -1
    var productTotalPoints = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.localization()
        self.popView.isHidden = true
        self.myVouchersTableview.delegate = self
        self.myVouchersTableview.dataSource = self
        self.successPopupView.isHidden = true
        self.otpPopUpView.isHidden = true
        self.vm.VC = self
        if self.mappedUserId == -1{
            self.points.text = "\(self.overAllPts)"
            let getLastFour = String(mobilenumber.suffix(4))
            print(getLastFour)
            self.mobileNumberLbl.text = getLastFour
        }else{
            self.points.text = "\(self.productTotalPoints)"
            let getLastFour = String(mobile.suffix(4))
            print(getLastFour)
            self.mobileNumberLbl.text = getLastFour
            }
       
        self.subView.clipsToBounds = true
        self.subView.cornerRadius = 20
        self.subView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        otpView.dpOTPViewDelegate = self
        otpView.fontTextField = UIFont.systemFont(ofSize: 25)
        otpView.textEdgeInsets = UIEdgeInsets(top: 0, left: -1, bottom: 0, right: 0)
        otpView.editingTextEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
     
        
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
            if self.mappedUserId == -1{
                self.vm.myVouchersAPI(userID: userID)
            }else{
            
                self.vm.myVouchersAPI(userID: "\(mappedUserId)")
                }
        
        }
        NotificationCenter.default.addObserver(self, selector: #selector(handlepopupdateclose), name: Notification.Name.showPopUp, object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    func localization() {
        self.vouchersHeadingLabel.text = "Vouchers".localiz()
        self.totalPointss.text = "TotalPoints".localiz()
        self.noDataFoundLabel.text = "NoDataFound".localiz()
        self.otpInfoLbl.text = "OTPwillreceiveat".localiz()
        self.resendOTPBtn.setTitle("ResendOTP".localiz(), for: .normal)
        self.otpLbl.text = "OTP".localiz()
        self.OTPinfoHeaderLbl.text = "enterOTPRaiseaRequest".localiz()
        self.popUpHeaderLbl.text = "VoucherSubmission".localiz()
        self.sucessMsg.text = "Youredeemedthisvoucher".localiz()
        self.redeemBtn.setTitle("Redeem".localiz(), for: .normal)
       // self.redeemablebalance.text = "Redeemable_Balance"
       // self.points.text = "\("Points") \(redbal)"
    }
    
    @objc func handlepopupdateclose() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func oKButton(_ sender: Any) {
        self.otpPopUpView.isHidden = true
        self.popView.isHidden = true
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func resendOTPBtn(_ sender: Any) {
            self.vm.timer.invalidate()
        
        if self.mobile == ""{
            //self.receiverMobile = self.mobilenumber
            self.generateOTPApi(mobilenumber: self.mobilenumber, userID: self.userID, loyaltyId: self.loyaltyId, firstname: self.firstname)
            //self.actorId = userID
//            self.receiverName = firstname
//            self.receiverEmail = emailid
        }else{
            //self.receiverMobile = self.mobile
            self.generateOTPApi(mobilenumber: self.mobile, userID: "\(self.mappedUserId)", loyaltyId: self.partyLoyaltyId, firstname: self.firstNAME)
//            self.actorId = "\(self.mappedUserId)"
//            self.receiverName = firstNAME
//            self.receiverEmail = emailData
        }
        //self.generateOTPApi(mobilenumber: <#String#>, userID: <#String#>, loyaltyId: <#String#>, firstname: <#String#>)
    }
    @IBAction func closeBtn(_ sender: Any) {
        self.otpPopUpView.isHidden = true
        self.successPopupView.isHidden = true
        self.popView.isHidden = true
    }
    
    @IBAction func otpSubmitBtn(_ sender: Any) {
        if self.enteredValue.count == 0 {
            self.view.makeToast("EnterOTP".localiz(), duration: 2.0, position: .bottom)
        }else if self.enteredValue.count != 6{
            self.view.makeToast("EntervalidOTP".localiz(), duration: 2.0, position: .bottom)
        }
//        else if self.receivedOTP != self.enteredValue{
//            self.view.makeToast("EntercorrectOTP".localiz(), duration: 2.0, position: .bottom)
//        }
        else{
            let yesterday = "\(Calendar.current.date(byAdding: .day, value: 0, to: Date())!)"
            let today = yesterday.split(separator: " ")
            let desiredDateFormat = self.convertDateFormater("\(today[0])", fromDate: "yyyy-MM-dd", toDate: "yyyy-MM-dd")
           print("\(desiredDateFormat)")
            print(layaltyID,"dlksd")
            
            self.vm.serverOTP(mobileNumber: self.receiverMobile, otpNumber: self.enteredValue)
            
            
            
        }
        
    }
    
    
    func voucherSubmitAPI(){
        self.vm.voucherSubmission(ReceiverMobile: self.receiverMobile, ActorId: self.actorId, CountryID: self.countryID, MerchantId: Int(self.merchantId)!, CatalogueId: self.catalogueId, DeliveryType: self.deliveryType, pointsrequired: self.pointsrequired, ProductCode: self.productCode, ProductImage: self.productImage, ProductName: self.productName, NoOfQuantity: "1", VendorId: Int(self.vendorId)!, VendorName: self.vendorName, ReceiverEmail: self.receiverEmail, ReceiverName: self.firstname, LoyaltyId: layaltyID)
    }

    
    func generateOTPApi(mobilenumber: String,userID: String,loyaltyId: String, firstname: String){
        let parameter = [
            "MerchantUserName": MerchantUserName,
            "MobileNo": mobilenumber,
            "UserId": userID,
            "UserName": loyaltyId,
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
extension QS_MyVouchers_VC{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.myvouchersArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QS_Vouchers_TVC", for: indexPath) as? QS_Vouchers_TVC
        cell?.imageview.sd_setImage(with: URL(string: self.vm.myvouchersArray[indexPath.row].productImage ?? ""), placeholderImage: UIImage(named: "ic_default_img"));
        cell?.vouchersdata.removeAll()
        cell?.vouchersdata.append(self.vm.myvouchersArray[indexPath.row])
        cell?.delegate = self
        
        cell?.productname.text = self.vm.myvouchersArray[indexPath.row].productName ?? ""
        if self.vm.myvouchersArray[indexPath.row].min_points ?? "" == "" || self.vm.myvouchersArray[indexPath.row].max_points ?? "" == ""{
            cell?.inrbalance.text = "Select_Amount_in_Range".localiz()
//            cell?.amount.setTitle("Amount", for: .normal)
            cell?.amount.tag = self.vm.myvouchersArray[indexPath.row].catalogueId ?? 0
            cell?.amounttfView.isHidden = true
            cell?.amountView.isHidden = false
        }else{
            cell?.inrbalance.text = "INR \(self.vm.myvouchersArray[indexPath.row].min_points ?? "") - INR \(self.vm.myvouchersArray[indexPath.row].max_points ?? "")"
            cell?.amounttfView.isHidden = false
            cell?.amountView.isHidden = true
            cell?.amounttf.tag = self.vm.myvouchersArray[indexPath.row].catalogueId ?? 0
//            cell?.setdata(redemablePoints: Int(redbal)!)
        
//            let filterArray = self.filteredArray.filter{$0.data.productCatalogueId == self.vm.myvouchersArray[indexPath.row].catalogueId ?? 0}
            
            
            for data in self.filteredArray{
                print(data.productCatalogueId, "Catalogue ID")
                print(self.vm.myvouchersArray[indexPath.row].catalogueId ?? 0)
                if data.productCatalogueId == self.vm.myvouchersArray[indexPath.row].catalogueId ?? 0{
                    
                    let amt = data.enteredQuantity ?? 0
                    if amt < Int(self.vm.myvouchersArray[indexPath.row].min_points!)! || amt > Int(self.vm.myvouchersArray[indexPath.row].max_points!)!{
                        cell?.filter.backgroundColor = UIColor.gray
                        cell?.filter.isEnabled = false
                        
                    }else{
                      //  cell?.filter.backgroundColor = UIColor(red: 1/255, green: 105/255, blue: 56/255, alpha: 1.0)
                        cell?.filter.isEnabled = true
                    }
                    cell?.amounttf.text = "\(data.enteredQuantity ?? 0)"
                }else{

                //    cell?.filter.backgroundColor = UIColor(red: 0/255, green: 183/255, blue: 241/255, alpha: 1.0)
                    cell?.filter.isEnabled = true
                    cell?.amounttf.text = ""
                }
            }
            
            
        }
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EgiftVoucherDetailsVC") as? EgiftVoucherDetailsVC
            vc?.voucherID = self.vm.myvouchersArray[indexPath.row].catalogueId ?? -1
            vc?.voucherName = self.vm.myvouchersArray[indexPath.row].productName ?? ""
            vc?.voucherTC = self.vm.myvouchersArray[indexPath.row].termsCondition ?? ""
            vc?.voucherDesc = self.vm.myvouchersArray[indexPath.row].productDesc ?? ""
            vc?.redeemoptions = self.vm.myvouchersArray[indexPath.row].deliveryType ?? ""
            vc?.voucherImag = self.vm.myvouchersArray[indexPath.row].productImage ?? ""
            vc?.voucherCode = self.vm.myvouchersArray[indexPath.row].productCode ?? ""
            vc?.voucherMinPoints = self.vm.myvouchersArray[indexPath.row].min_points ?? "-1"
            vc?.voucherMaxPoints = self.vm.myvouchersArray[indexPath.row].max_points ?? "-1"
            vc?.vouchercategory = self.vm.myvouchersArray[indexPath.row].catogoryName ?? ""
            vc?.vouchervendorname = self.vm.myvouchersArray[indexPath.row].vendorName ?? ""
            vc?.vouchervendorID = self.vm.myvouchersArray[indexPath.row].vendorId ?? -1
            vc?.voucherCountryID = self.vm.myvouchersArray[indexPath.row].countryID ?? -1
            vc?.voucherdelivarytype = self.vm.myvouchersArray[indexPath.row].deliveryType ?? ""
            vc?.mappedUserId = self.mappedUserId
            vc?.firstNAME = self.firstNAME
            print(self.mobile)
            if self.mobile == ""{
                vc?.recieverMobile = self.mobilenumber
            
            }else{
                vc?.recieverMobile = self.mobile
            }
            
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
}

class GetDataFromVoucher: NSObject{
    let productCatalogueId: Int!
    let enteredQuantity: Int!
    init(productCatalogueId: Int, enteredQuantity: Int)
    {
        self.productCatalogueId = productCatalogueId
        self.enteredQuantity = enteredQuantity
    }
}
