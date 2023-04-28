//
//  KC_OrderConfirmationVC.swift
//  KeshavCement
//
//  Created by ADMIN on 07/01/2023.
//

import UIKit
import Lottie
import LanguageManager_iOS
class KC_OrderConfirmationVC: BaseViewController, SendUpdatedAddressDelegate {
    func updatedAddressDetails(_ vc: KC_EditAddressVC) {
        DispatchQueue.main.async {
            self.customerNameLbl.text = vc.selectedname
            print(self.customerNameLbl.text ?? "")
            self.addressTextView.text = "\(vc.selectedaddress),\n\(vc.selectedState),\n\(vc.selectedDistrictName), \(vc.selectedpincode),\nMobile No: \(vc.selectedmobile)"
            self.pincode = vc.selectedpincode
            self.stateID = vc.selectedStateID
            self.stateName = vc.selectedState
            self.districtName = vc.selectedDistrictName
            self.districtID = vc.selectedDistrictId
            print(vc.selectedStateID)
            self.cityID = vc.selectedCityID
            print(vc.selectedCityID)
            self.address1 = vc.selectedaddress
            self.countryID = 15
            self.countryName = "India"
            self.mobile = vc.selectedmobile
        }
    }
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var tableViewHeightConstarint: NSLayoutConstraint!
    @IBOutlet weak var animation: LottieAnimationView!
    @IBOutlet weak var pointsBalanceLbl: UILabel!
    @IBOutlet weak var ptsLbl: UILabel!
    @IBOutlet weak var totalPoints: UILabel!
    @IBOutlet weak var redeemLbl: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var orderConfirmationTableView: UITableView!
    @IBOutlet weak var addressTextView: UITextView!
    @IBOutlet weak var customerNameLbl: UILabel!
    @IBOutlet weak var changeBtn: UIButton!
    @IBOutlet weak var deliveryToLbl: UILabel!
    @IBOutlet weak var deliveryAddressLbl: UILabel!
    @IBOutlet weak var orderConfirmationLbl: UILabel!
    
    @IBOutlet weak var lineLabel: UILabel!
    @IBOutlet weak var swipeBtn: UILabel!
    
    @IBOutlet weak var deliveryItemLbl: UILabel!
    @IBOutlet weak var checkImage: UIImageView!
    @IBOutlet weak var swipeButton: TGFlingActionButton!
    
    var redeemablePointsBalance = UserDefaults.standard.string(forKey: "RedeemablePointBalance") ?? "0"
    var VM = KC_DefaultAddressVM()
    var receiverName = ""
    var address = ""
    var stateID = -1
    var stateName = ""
    var districtID = -1
    var districtName = ""
    var cityID = -1
    var cityName = ""
    var pincode = ""
    var emailID = ""
    var address1 = ""
    var countryID = -1
    var countryName = ""
    var redemptionDate = ""
    var mobile = ""
    var totalRedemmablePts = 0
    var pointBalance = 0
    var partyLoyaltyId = ""
    
    var finalPoints = 0
    var redemptionTypeId = 0
    var isComingFrom = ""
    var totalPoint = 0
    var dreamGiftID = 0
    var giftName = ""
    var contractorName = ""
    var giftStatusId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.VM.myAccountDetailsApi()
        self.orderConfirmationTableView.delegate = self
        self.orderConfirmationTableView.dataSource = self
        mainView.clipsToBounds = false
        mainView.layer.cornerRadius = 36
        mainView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.totalPoints.text = "\(self.finalPoints)"
        headerView.layer.masksToBounds = false
        headerView.layer.shadowRadius = 2
        headerView.layer.shadowOpacity = 0.2
        headerView.layer.shadowColor = UIColor.gray.cgColor
        headerView.layer.shadowOffset = CGSize(width: 0 , height:2)
        NotificationCenter.default.addObserver(self, selector: #selector(navigateToOrderConfirm), name: Notification.Name.navigateToOrderConfirmation, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(afterQuerySubmitted), name: Notification.Name.navigateToMyRedemption, object: nil)
        let calcValue = Int(redeemablePointsBalance)! - self.totalRedemmablePts
        self.pointBalance = calcValue
        self.pointsBalanceLbl.text = "Point balance \(calcValue) after this purchase"

        
        self.orderConfirmationLbl.text = "OrderConfirmation".localiz()
        self.deliveryAddressLbl.text = "DeliveryAddress".localiz()
        self.deliveryToLbl.text = "DeliveryTo".localiz()
        self.changeBtn.setTitle("Change".localiz(), for: .normal)
        self.deliveryItemLbl.text = "DeliveryItem".localiz()
        self.redeemLbl.text = "Redeem".localiz()
       
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            self.view.makeToast("No Internet connection!!", duration: 2.0, position: .bottom)
        }else{
            if self.isComingFrom == "DreemGift" {
                self.orderConfirmationTableView.isHidden = true
                self.checkImage.isHidden = true
                self.deliveryItemLbl.isHidden = true
                self.lineLabel.isHidden = true
                self.totalPoints.text = "\(self.totalPoint)"
                self.addressTextView.isUserInteractionEnabled = false
                let calcValue = Int(redeemablePointsBalance)! - self.totalPoint
                self.pointBalance = calcValue
                self.pointsBalanceLbl.text = "Point balance \(calcValue) after this purchase"
            }else{
               // self.buttonViewTopSpace.constant = 545
                if self.customerTypeId ?? "" == "3" && self.partyLoyaltyId != "" || self.customerTypeId ?? "" == "4" && self.partyLoyaltyId != ""{
                    
                    self.VM.getMycartList(PartyLoyaltyID: self.loyaltyId, LoyaltyID: self.partyLoyaltyId)
                    
                    
                }else if self.customerTypeId ?? "" == "3" && self.partyLoyaltyId == "" || self.customerTypeId ?? "" == "4" && self.partyLoyaltyId == ""{
                    self.VM.getMycartList(PartyLoyaltyID: "", LoyaltyID: self.loyaltyId)
                }else{
                    self.VM.getMycartList(PartyLoyaltyID: "", LoyaltyID: self.loyaltyId)
                }
                self.addressTextView.isUserInteractionEnabled = false
                let calcValue = Int(redeemablePointsBalance)! - self.totalRedemmablePts
                self.pointBalance = calcValue
                self.pointsBalanceLbl.text = "Point balance \(calcValue) after this purchase"
            }
            
         
        }
    }
    
    @objc func afterQuerySubmitted(notification: Notification){
        self.swipeButton.reset()
        self.swipeButton.setTitleColor(.darkGray, for: .normal)
        self.swipeButton.backgroundColor = .white
           self.navigationController?.popToRootViewController(animated: true)
           }
    
    @objc func navigateToOrderConfirm(){
        self.swipeButton.reset()
        self.swipeButton.setTitleColor(.darkGray, for: .normal)
        self.swipeButton.backgroundColor = .white
        
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func swipeButtonPlaceOrder(_ sender: TGFlingActionButton) {

        if UserDefaults.standard.string(forKey: "verificationStatus") == "1"{
            if stateID == -1 || districtID == -1 || address1 == "" || pincode == "" || mobile == ""{
                DispatchQueue.main.async{
                    self.view.makeToast("currentlyContactAdministrator".localiz(), duration: 2.0, position: .bottom)
                }
            }else{
                if self.totalRedemmablePts <= Int(self.redeemablePointsBalance)!{
                    print(sender.swipe_direction)
                       if sender.swipe_direction == .right {
                           DispatchQueue.main.asyncAfter(deadline: .now()+0.9, execute: {
                               let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_EvoucherPopUpVC") as? KC_EvoucherPopUpVC
                               vc!.itsComeFrom = "REDEMPTIONSUBMISSION"
                               vc!.stateID = self.stateID
                               vc!.cityID = self.cityID
                               vc!.stateName = self.stateName
                               vc!.cityName = self.cityName
                               vc!.pincode = self.pincode
                               vc!.address1 = self.address1
                               vc!.customerName = self.customerNameLbl.text ?? ""
                               vc!.mobile = self.mobile
                               vc!.emailId = self.emailID
                               vc!.countryId = self.countryID
                               vc!.countryName = self.countryName
                               vc!.redeemedPoints = self.totalRedemmablePts
                               vc!.pointBalance = "\(self.pointBalance)"
                               vc!.partyLoyaltyId = self.partyLoyaltyId
                               vc!.redemptionTypeId = self.redemptionTypeId
                               print(self.redemptionTypeId)
                               vc!.contractorName = self.contractorName
                               vc!.giftStatusId = self.giftStatusId
                               vc!.dreamGiftId = self.dreamGiftID
                               vc!.giftPts = self.totalPoint
                               vc!.giftName = self.giftName
                               vc!.modalTransitionStyle = .coverVertical
                               vc!.modalPresentationStyle = .overFullScreen
                               self.present(vc!, animated: true)
                               self.swipeButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                           }
                               )
                       }
                }else{
                    self.view.makeToast("Insufficientpointbalance".localiz(), duration: 2.0, position: .bottom)
                }
                    
            }
            
        }else{
            DispatchQueue.main.async{
                self.view.makeToast("ForRedemptioKYCverificationprocess".localiz(), duration: 2.0, position: .bottom)
            }
        }

    
    }
//    func claimSubmissionApi(){
//        if self.selectedUserTypeId == -1{
//            self.view.makeToast("Please select user type", duration: 2.0, position: .bottom)
//            self.swipeButton.reset()
//            self.swipeButton.backgroundColor = .white
//        }else if self.mappedUserId == -1{
//            self.view.makeToast("Please select mapped user", duration: 2.0, position: .bottom)
//            self.swipeButton.reset()
//            self.swipeButton.backgroundColor = .white
//        }else if self.selectedProductId == -1{
//            self.view.makeToast("Please select product", duration: 2.0, position: .bottom)
//            self.swipeButton.reset()
//            self.swipeButton.backgroundColor = .white
//        }else if self.quantity == 0{
//            self.view.makeToast("Quantity shouln't be 0", duration: 2.0, position: .bottom)
//            self.swipeButton.reset()
//            self.swipeButton.backgroundColor = .white
//        }else{
//            
//            self.swipeButton.backgroundColor = #colorLiteral(red: 1, green: 0.9882352941, blue: 0.6117647059, alpha: 1)
//            let parameter = [
//                "ActorId": self.userID,
//                "ProductSaveDetailList": [
//                    [
//                        "ProductCode": self.selectedProductName,
//                        "Quantity": self.quantity
//                    ]
//                ],
//                "RitailerId": self.mappedUserId,
//                "SourceDevice": 1
//            ] as [String: Any]
//            print(parameter)
//            self.VM.claimPurchaseSubmissionApi(parameter: parameter)
//        }
//    }
    

    @IBAction func changeAddressBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_EditAddressVC") as! KC_EditAddressVC
        vc.delegate = self
        vc.selectedname = self.customerNameLbl.text ?? ""
        vc.selectedemail = self.emailID
        vc.selectedmobile = self.mobile
        vc.selectedState = self.stateName
        vc.selectedStateID = self.stateID
        vc.selectedCountry = self.countryName
        vc.selectedCountryId = self.countryID
        vc.selectedDistrictName = self.districtName
        vc.selectedDistrictId = self.districtID
        vc.selectedaddress = self.address1
        vc.selectedpincode = self.pincode
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
extension KC_OrderConfirmationVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VM.myCartListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "KC_OrderConfirmationTVC", for: indexPath) as! KC_OrderConfirmationTVC
//        cell.delegate = self
        cell.selectionStyle = .none
 
        cell.productNameLbl.text = self.VM.myCartListArray[indexPath.row].productName ?? ""
        cell.pointsLbl.text = "\(self.VM.myCartListArray[indexPath.row].pointsRequired ?? 0)"
        let receivedImage = self.VM.myCartListArray[indexPath.row].productImage ?? ""
        let totalImgURL = productCatalogueImgURL + receivedImage
        cell.productImage.sd_setImage(with: URL(string: totalImgURL), placeholderImage: UIImage(named: "ic_default_img"))
        
            cell.qtyValueLbl.text = "\(self.VM.myCartListArray[indexPath.row].noOfQuantity ?? 0)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
}
