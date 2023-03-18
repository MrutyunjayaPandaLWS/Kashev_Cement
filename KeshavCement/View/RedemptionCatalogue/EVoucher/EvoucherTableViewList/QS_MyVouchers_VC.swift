//
//  QS_MyVouchers_VC.swift
//  Quba Safalta
//
//  Created by Arokia-M3 on 10/03/21.
//

import UIKit
//import LanguageManager_iOS
//import Firebase
import DPOTPView
import Kingfisher
class QS_MyVouchers_VC: BaseViewController, UITableViewDelegate,UITableViewDataSource, vouchersDelegate, pointsDelegate, popUpAlertDelegate, DPOTPViewDelegate{
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
                if amt < Int(self.vm.myvouchersArray[tappedIndexPath.row].min_points!)! || amt > Int(self.vm.myvouchersArray[tappedIndexPath.row].max_points!)!{
                    cell.filter.backgroundColor = UIColor.gray
                    cell.filter.isEnabled = false
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
        NotificationCenter.default.post(name: Notification.Name("SHOWDATA23"), object: self)
    }
    
    func redeemDidTap(_ cell: QS_Vouchers_TVC) {
        print(cell.vouchersdata[0].min_points ?? "-1")
        if cell.vouchersdata[0].min_points ?? "-1" != "-1" || cell.vouchersdata[0].max_points ?? "-1" != "-1"{
            if cell.amounttf.text?.count == 0{
                self.alertmsg(alertmsg: "Enter_amount_to_redeem", buttonalert: "OK")
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
                        self.popView.isHidden = false
                        self.generateOTPApi()
                        self.receiverMobile = self.mobilenumber
                        self.actorId = userID
                        self.countryID = cell.vouchersdata[0].countryID ?? -1
                        self.merchantId = "\(self.merchantID)"
                        self.catalogueId = cell.vouchersdata[0].catalogueId ?? -1
                        self.deliveryType = cell.vouchersdata[0].deliveryType ?? ""
                        self.pointsrequired = cell.amounttf.text ?? "0"
                        self.productCode = cell.vouchersdata[0].productCode ?? ""
                        self.productImage = cell.vouchersdata[0].productImage ?? ""
                        self.productName = cell.vouchersdata[0].productName ?? ""
                        self.noOfQuantity = "1"
                        self.vendorId = "\(cell.vouchersdata[0].vendorId ?? -1)"
                        self.vendorName = cell.vouchersdata[0].vendorName ?? ""
                        self.receiverEmail = emailid
                        self.receiverName = firstname
         
                    }
                }else{
                    self.alertmsg(alertmsg: "Insufficient Points Balance", buttonalert: "OK")
                }
            }
        }else{
            if cell.amount.currentTitle == "Amount"{
                self.alertmsg(alertmsg: "Select_Amount_to_Redeem", buttonalert: "OK")
            }else{
                if Int(self.overAllPts)! >= self.selectedPoints{
                    self.popView.isHidden = false
                    self.generateOTPApi()
                    self.receiverMobile = self.mobilenumber
                    self.actorId = userID
                    self.countryID = cell.vouchersdata[0].countryID ?? -1
                    self.merchantId = "\(self.merchantID)"
                    self.catalogueId = cell.vouchersdata[0].catalogueId ?? -1
                    self.deliveryType = cell.vouchersdata[0].deliveryType ?? ""
                    self.pointsrequired = cell.amount.currentTitle!
                    self.productCode = cell.vouchersdata[0].productCode ?? ""
                    self.productImage = cell.vouchersdata[0].productImage ?? ""
                    self.productName = cell.vouchersdata[0].productName ?? ""
                    self.noOfQuantity = "1"
                    self.vendorId = "\(cell.vouchersdata[0].vendorId ?? -1)"
                    self.vendorName = cell.vouchersdata[0].vendorName ?? ""
                    self.receiverEmail = emailid
                    self.receiverName = firstname
                    

                }else{
                    self.alertmsg(alertmsg: "Insufficient points balance", buttonalert: "OK")
                }
                }
        }
    }

    
    func amountDidTap(_ cell: QS_Vouchers_TVC) {
        DispatchQueue.main.async{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "QS_redeemQuantity_VC") as? QS_redeemQuantity_VC
            vc!.productCodefromPrevious = cell.vouchersdata[0].productCode ?? ""
            vc!.delegate = self
            vc!.modalPresentationStyle = .overCurrentContext
            vc!.modalTransitionStyle = .crossDissolve
            self.present(vc!, animated: true, completion: nil)
        }
        
    }
    
    func alertDidTap(_ cell: QS_Vouchers_TVC) {
        self.alertmsg(alertmsg: "\(cell.alertMsg)", buttonalert: "OK")
    }
    
    @IBOutlet var myVouchersTableview: UITableView!
    
    @IBOutlet var noDataFoundLabel: UILabel!
    @IBOutlet var vouchersHeadingLabel: UILabel!
//    @IBOutlet var redeemablebalance: UILabel!
    @IBOutlet var points: UILabel!
    
    
    @IBOutlet weak var successPopupView: UIView!
    @IBOutlet weak var successMessageLbl: UILabel!
    @IBOutlet weak var otpPopUpView: UIView!
    @IBOutlet weak var resendOTPBtn: UIButton!
    @IBOutlet weak var otpView: DPOTPView!
    @IBOutlet weak var otpValueLbl: UILabel!
    @IBOutlet weak var mobileNumberLbl: UILabel!
    
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var popView: UIView!
    var selectedPoints = 0
    var productcodeselected = ""
    var selectedProductValue = 0
    var receivedOTP = ""
    
    var partyLoyaltyId = ""
    let vm = QS_Vouchers_VM()
    var filteredArray = [GetDataFromVoucher]()
    
//    let userID = UserDefaults.standard.string(forKey: "UserID") ?? "-1"
        var redbal = UserDefaults.standard.string(forKey: "PointsBalance") ?? "0"
    var mobilenumber = UserDefaults.standard.string(forKey: "CustomerMobileNumber") ?? ""
        var emailid = UserDefaults.standard.string(forKey: "CustomerEmail") ?? ""
        var firstname = UserDefaults.standard.string(forKey: "FirstName") ?? ""
        var merchantID = UserDefaults.standard.integer(forKey: "MerchantID") ?? 1
        let layaltyID = UserDefaults.standard.string(forKey: "LoyaltyID") ?? ""
    var enteredValue = ""
    let merchantUserName = UserDefaults.standard.string(forKey: "MerchantEmail") ?? ""
    var merchanMobile = UserDefaults.standard.string(forKey: "MerchantMobile") ?? ""
    var pointBalance = UserDefaults.standard.string(forKey: "RedeemablePointBalance") ?? ""
    
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.popView.isHidden = true
        self.myVouchersTableview.delegate = self
        self.myVouchersTableview.dataSource = self
        self.successPopupView.isHidden = true
        self.otpPopUpView.isHidden = true
        self.vm.VC = self
        self.points.text = "\(self.overAllPts)"
        self.subView.clipsToBounds = true
        self.subView.cornerRadius = 20
        self.subView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        otpView.dpOTPViewDelegate = self
        otpView.fontTextField = UIFont.systemFont(ofSize: 25)
        otpView.textEdgeInsets = UIEdgeInsets(top: 0, left: -1, bottom: 0, right: 0)
        otpView.editingTextEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let getLastFour = String(mobilenumber.suffix(4))
        print(getLastFour)
        self.mobileNumberLbl.text = getLastFour
        
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
        self.vm.myVouchersAPI(userID: userID)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(handlepopupdateclose), name: Notification.Name.showPopUp, object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    func localization() {
        self.vouchersHeadingLabel.text = "Vouchers"
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
            self.generateOTPApi()
    }
    @IBAction func closeBtn(_ sender: Any) {
        self.otpPopUpView.isHidden = true
    }
    
    @IBAction func otpSubmitBtn(_ sender: Any) {
        if self.enteredValue.count == 0 {
            self.view.makeToast("Enter OTP", duration: 2.0, position: .bottom)
        }else if self.enteredValue.count != 6{
            self.view.makeToast("Enter valid OTP", duration: 2.0, position: .bottom)
        }else if self.receivedOTP != self.enteredValue{
            self.view.makeToast("Enter correct OTP", duration: 2.0, position: .bottom)
        }else{
            let yesterday = "\(Calendar.current.date(byAdding: .day, value: 0, to: Date())!)"
            let today = yesterday.split(separator: " ")
            let desiredDateFormat = self.convertDateFormater("\(today[0])", fromDate: "yyyy-MM-dd", toDate: "yyyy-MM-dd")
           print("\(desiredDateFormat)")
            self.vm.voucherSubmission(ReceiverMobile: self.receiverMobile, ActorId: self.userID, CountryID: self.countryID, MerchantId: Int(self.merchantId)!, CatalogueId: self.catalogueId, DeliveryType: self.deliveryType, pointsrequired: self.pointsrequired, ProductCode: self.productCode, ProductImage: self.productImage, ProductName: self.productName, NoOfQuantity: "1", VendorId: Int(self.vendorId)!, VendorName: self.vendorName, ReceiverEmail: self.receiverEmail, ReceiverName: self.receiverEmail)
            
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
            cell?.inrbalance.text = "Select_Amount_in_Range"
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
