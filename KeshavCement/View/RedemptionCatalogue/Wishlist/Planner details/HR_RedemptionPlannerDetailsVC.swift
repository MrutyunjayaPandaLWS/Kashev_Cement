//
//  HR_RedemptionPlannerDetailsVC.swift
//  HR_Johnson
//
//  Created by ArokiaIT on 2/11/22.
//

import UIKit
import LanguageManager_iOS
import SDWebImage
class HR_RedemptionPlannerDetailsVC: BaseViewController{
//, popUpAlertDelegate{
//    func popupAlertDidTap(_ vc: HR_PopUpVC) {}

    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var yellowView: UIView!
    @IBOutlet weak var overallstack: UIStackView!
    @IBOutlet weak var screenTitle: UILabel!
//    @IBOutlet weak var totalPts: UILabel!
//    @IBOutlet weak var pointsLbl: UILabel!
//    @IBOutlet weak var cartCount: UILabel!
    @IBOutlet weak var congratulationsLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var redeemNowLbl: UILabel!
//    @IBOutlet weak var recommendedLbl: UILabel!
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var redeemLbl: UILabel!
    @IBOutlet weak var redeempointsLbl: UILabel!
    @IBOutlet weak var totalRedeemPts: UILabel!
    @IBOutlet weak var redeemSummary: UILabel!
    @IBOutlet weak var redeemInfo: UILabel!
    @IBOutlet weak var redeemedPoints: UILabel!
    @IBOutlet weak var redeemedPtsTitle: UILabel!
    
    @IBOutlet weak var redeemBTN1: UIButton!
    @IBOutlet weak var redeemOfferBTN: UIButton!
    @IBOutlet weak var earningSummaryLbl: UILabel!
    @IBOutlet weak var earnedTotalPts: UILabel!
    @IBOutlet weak var earningPtsTitle: UILabel!
    @IBOutlet weak var expectInfoLbl: UILabel!
    
    @IBOutlet weak var redeemOfferBTNView: UIView!
    @IBOutlet weak var redeemBTNView: GradientView!
    @IBOutlet weak var infoLbl: UILabel!
    var VM = HR_RedemptionPlannerDetailsVM()
  
    var totalPoints = ""
    var selectedCatalogueID = 0
    var cartTotalCount = ""
    var redemptionId = 0
    
    var partyLoyaltyId = ""
    var catalogueId = 0
    var actualRedemptionDate = ""
    var cashValue = 0
    var catalogueType = 0
    var redemptionPlannerId = 0
    var vendorName = ""
    var vendorId = 0
    var productImage = ""
    var productName = ""
    var requiredPoints = 0
    var redeemableAverageEarning = ""
    var productDesc = ""
    var termsandContions = ""
    var totalCartValue = 0
    var mappedUserId = -1
    var redeemablePointsBalance = UserDefaults.standard.string(forKey: "RedeemablePointBalance") ?? ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        localization()
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
        
        if self.customerTypeId ?? "" == "3" && self.partyLoyaltyId != "" || self.customerTypeId ?? "" == "4" && self.partyLoyaltyId != ""{
        
                self.VM.getMycartList(PartyLoyaltyID: self.loyaltyId, LoyaltyID: self.partyLoyaltyId)
                self.VM.redemptionPlannerList(PartyLoyaltyID: self.partyLoyaltyId)
        
            
        }else if self.customerTypeId ?? "" == "3" && self.partyLoyaltyId == "" || self.customerTypeId ?? "" == "4" && self.partyLoyaltyId == ""{
            self.VM.getMycartList(PartyLoyaltyID: "", LoyaltyID: self.loyaltyId)
            self.VM.redemptionPlannerList(PartyLoyaltyID: "")
        }else{
            self.VM.getMycartList(PartyLoyaltyID: "", LoyaltyID: self.loyaltyId)
            self.VM.redemptionPlannerList(PartyLoyaltyID: "")
        }
        
        
        if self.requiredPoints >= Int(redeemablePointsBalance) ?? 0{
            self.redeemBTNView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            self.redeemBTN1.isEnabled = false
            self.redeemLbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.redeemOfferBTNView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            self.redeemOfferBTN.isEnabled = false
            let calcValues = Int(self.requiredPoints) - (Int(redeemablePointsBalance) ?? 0)
            self.yellowView.isHidden = false
            
            self.whiteView.isHidden = true
            self.infoLbl.text = "You need \(calcValues) more redeemable points to redeem this product"
        }else if self.requiredPoints <= Int(redeemablePointsBalance) ?? 0{
           // self.redeemBTNView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.redeemBTN1.isEnabled = true
            self.redeemOfferBTNView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.redeemLbl.textColor = #colorLiteral(red: 0.96686095, green: 0.8517517447, blue: 0.4868039489, alpha: 1)
            self.redeemOfferBTN.isEnabled = true
            self.infoLbl.text = "Your eligible to redeem this product."
            self.yellowView.isHidden = false
            self.whiteView.isHidden = true

        }
        
//        self.totalPts.text = self.totalPoints
//        self.cartCount.text = self.cartTotalCount
        self.productNameLbl.text = self.productName
        self.redeemedPoints.text = self.totalPoints
        self.totalRedeemPts.text = "\(self.requiredPoints)"
        self.earnedTotalPts.text = self.redeemableAverageEarning
        let urltoUse = String(productCatalogueImgURL + productImage).replacingOccurrences(of: " ", with: "%20")
        let urlt = URL(string: "\(urltoUse)")
        productImg.sd_setImage(with: urlt!, placeholderImage: #imageLiteral(resourceName: "ic_default_img"))
    }
    func localization(){
        self.screenTitle.text = "RedemptionPlannerDetails".localiz()
     //   self.pointsLbl.text = "POINTS"
        self.congratulationsLbl.text = "Congratulations".localiz()
        self.messageLbl.text = "eligibleMsg".localiz()
        self.redeemNowLbl.text = "RedeemNow".localiz()
//        self.recommendedLbl.text = "RecommendedProducts".localiz()
        self.redeemedPoints.text = "POINTS".localiz()
        self.redeemLbl.text = "RedeemNow".localiz()
        self.redeemSummary.text = "RedemptionPlannerSummary".localiz()
        self.redeemInfo.text = "RedeemablePointsAsOnToday".localiz()
        self.redeemedPoints.text = "POINTS".localiz()
        self.earningSummaryLbl.text = "AverageEarning".localiz()
        self.earningPtsTitle.text = "Points".localiz()
        self.expectInfoLbl.text = "Your expected redemption of \(self.productName) is in \(actualRedemptionDate)"
        
    }
    
    
    @IBAction func backBTN(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
//    @IBAction func cartBTN(_ sender: Any) {
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_MyCartVC") as!
//        KC_MyCartVC
//        
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
    @IBAction func redeemNowBTN(_ sender: Any) {
        let filterCategory = self.VM.myCartListArray.filter { $0.catalogueId == selectedCatalogueID}
        if filterCategory.count > 0{
            DispatchQueue.main.async{
                self.view.makeToast("Giftproductlreadyaddedlist".localiz(), duration: 2.0, position: .bottom)
            }
        }else{
            print(self.totalCartValue)
            print(self.redeemablePointsBalance)
            if self.totalCartValue <= (Int(self.redeemablePointsBalance) ?? 0) {
                let calcValue = self.totalCartValue + Int(redeemablePointsBalance)!
                if calcValue <= Int(self.redeemablePointsBalance) ?? 0{
                    if self.customerTypeId ?? "" == "3" && self.partyLoyaltyId != "" || self.customerTypeId ?? "" == "4" && self.partyLoyaltyId != ""{
                       
                            self.VM.addToCartApi(redemptionPlannerId: redemptionPlannerId, PartyLoyaltyID: self.partyLoyaltyId, LoyaltyID: self.loyaltyId)
                       
                        
                    }else if self.customerTypeId ?? "" == "3" && self.partyLoyaltyId == "" || self.customerTypeId ?? "" == "4" && self.partyLoyaltyId == ""{
                        self.VM.addToCartApi(redemptionPlannerId: redemptionPlannerId, PartyLoyaltyID: "", LoyaltyID: self.loyaltyId)
                    }else{
                        self.VM.addToCartApi(redemptionPlannerId: redemptionPlannerId, PartyLoyaltyID: "", LoyaltyID: self.loyaltyId)
                    }
                }
                }else{
                DispatchQueue.main.async{
                    
                    self.view.makeToast("InsufficientPointBalance".localiz(), duration: 2.0, position: .bottom)
                }
            }
            
        }
    }
  
    @IBAction func redeemBTN(_ sender: Any) {
        print(self.selectedCatalogueID)
        let filterCategory = self.VM.myCartListArray.filter { $0.catalogueId == selectedCatalogueID}
        print(filterCategory.count)
        if filterCategory.count > 0{
            DispatchQueue.main.async{
                self.view.makeToast("Giftproductlreadyaddedlist".localiz(), duration: 2.0, position: .bottom)
            }
        }else{
            print(self.totalCartValue)
            print(self.redeemablePointsBalance)
            if self.totalCartValue <= (Int(self.redeemablePointsBalance) ?? 0) {
                let calcValue = self.totalCartValue + Int(redeemablePointsBalance)!
                if calcValue <= Int(self.redeemablePointsBalance) ?? 0{
                    if self.customerTypeId ?? "" == "3" && self.partyLoyaltyId != "" || self.customerTypeId ?? "" == "4" && self.partyLoyaltyId != ""{
                            self.VM.addToCartApi(redemptionPlannerId: redemptionPlannerId, PartyLoyaltyID: self.partyLoyaltyId, LoyaltyID: self.loyaltyId)
                        }else if self.customerTypeId ?? "" == "3" && self.partyLoyaltyId == "" || self.customerTypeId ?? "" == "4" && self.partyLoyaltyId == ""{
                        self.VM.addToCartApi(redemptionPlannerId: redemptionPlannerId, PartyLoyaltyID: "", LoyaltyID: self.loyaltyId)
                    }else{
                        self.VM.addToCartApi(redemptionPlannerId: redemptionPlannerId, PartyLoyaltyID: "", LoyaltyID: self.loyaltyId)
                    }
                    
                    
                    
                    
                    }else{
                        DispatchQueue.main.async{
                            self.view.makeToast("InsufficientPointBalance".localiz(), duration: 2.0, position: .bottom)
                          
                        }
                    }}else{
                DispatchQueue.main.async{
                    self.view.makeToast("InsufficientPointBalance".localiz(), duration: 2.0, position: .bottom)
                }
            }
            
        }
    }
    @IBAction func removeProductsBTN(_ sender: Any) {
        
        if self.customerTypeId ?? "" == "3" && self.partyLoyaltyId != "" || self.customerTypeId ?? "" == "4" && self.partyLoyaltyId != ""{
            
                self.VM.removeRedemptionPlanner1(redemptionPlannerId: self.redemptionPlannerId, PartyLoyaltyID: self.partyLoyaltyId)
        }else if self.customerTypeId ?? "" == "3" && self.partyLoyaltyId == "" || self.customerTypeId ?? "" == "4" && self.partyLoyaltyId == ""{
            self.VM.removeRedemptionPlanner1(redemptionPlannerId: self.redemptionPlannerId, PartyLoyaltyID: "")
        }else{
            self.VM.removeRedemptionPlanner1(redemptionPlannerId: self.redemptionPlannerId, PartyLoyaltyID: "")
        }
        
        
        self.navigationController?.popViewController(animated: true)
    }
}
