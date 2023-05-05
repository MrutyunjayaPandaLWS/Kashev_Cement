//
//  MSP_ProductCatalogueDetailsVC.swift
//  MSP_Customer
//
//  Created by ADMIN on 18/11/2022.
//

import UIKit
import ImageSlideshow
//import Firebase
import LanguageManager_iOS
protocol SelectedItemsDelegate: class{
    
    func selectedItem(_ vc: KC_ProductCatalogueDetailsVC)
}
class KC_ProductCatalogueDetailsVC: BaseViewController{
    
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var pts: UILabel!
    @IBOutlet weak var headerLbl: UILabel!

    @IBOutlet var countLabel: UILabel!
    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var categoryTypeLabel: UILabel!
    @IBOutlet var productNameLabel: UILabel!
    @IBOutlet var pointsLabel: UILabel!
    @IBOutlet weak var addToCart: GradientButton!
    @IBOutlet weak var addToPlanner: GradientButton!
    @IBOutlet weak var addedToPlannerBTN: GradientButton!
    @IBOutlet weak var addedToCart: GradientButton!
    @IBOutlet weak var descriptions: UILabel!
    @IBOutlet weak var termsandConditions: UILabel!
    
    @IBOutlet weak var cartCount: UILabel!
    @IBOutlet weak var descriptionDetailsLbl: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var tcLbl: UILabel!
    
    @IBOutlet weak var descriptionsLbl: UILabel!
    @IBOutlet weak var totalPointsLbl: UILabel!
    @IBOutlet weak var totalPtsLbl: UILabel!
    
    @IBOutlet weak var cartButtonView: UIStackView!
    var delegate: SelectedItemsDelegate?
    
    var productImage = ""
    var prodRefNo = ""
    var productCategory = ""
    var productName = ""
    var productPoints = ""
    var productDescription = ""
    var termsandContions = ""
    var productPts = 0
    var is_Reedemable = 0
    var pointsRangePts = ""
    var sortedBy = 0
    var itsFrom = ""
    var plannerProductId = 0
    var partyLoyaltyId = ""
    
    var tdspercentage1 = 0.0
    var applicabletds = 0.0
    var productDetails = ""
    
    var quantity = 0
    var categoryId = 0
    var catalogueId = 0
    var isComeFrom = ""
    var pointBalance = UserDefaults.standard.string(forKey: "RedeemablePointBalance") ?? ""
//    let loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyID") ?? ""
//    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    let verifiedStatus = UserDefaults.standard.integer(forKey: "VerifiedStatus")
    var checkAccountStatus = UserDefaults.standard.string(forKey: "SemiActiveAccount") ?? ""
    var totalCartValue = 0
    var isPlanner: Bool?
    var selectedCatalogueID = 0
    var productTotalPoints = 0
    
    
    var VM = KC_ProductCatalgoueDetailsVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.headerLbl.text = "ProductDetails".localiz()
        self.descriptionsLbl.text = "Descriptions".localiz()
        self.termsandConditions.text = "Termsandconditions".localiz()
        self.totalPtsLbl.text = "TotalPoints".localiz()
        
        categoryTypeLabel.text = productCategory
        
        mainView.clipsToBounds = false
        mainView.layer.cornerRadius = 36
        mainView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        productNameLabel.text = productName
        pointsLabel.text = productPoints
        self.descriptionDetailsLbl.text = productDescription
        self.tcLbl.text = termsandContions
        let receivedImage = productImage
        print(receivedImage)
        let totalImgURL = productCatalogueImgURL + receivedImage
        productImageView.sd_setImage(with: URL(string: totalImgURL), placeholderImage: UIImage(named: "ic_default_img"))
        
       
            self.totalPointsLbl.text = "\(self.productPts)"
        
        
        self.categoryTypeLabel.text = self.productCategory
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print(self.partyLoyaltyId)
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
        print(self.is_Reedemable, "asjdklfjklasdfjkldasfljksfdlsjkafdslj")
        
        
//        if self.is_Reedemable  == 1{
//            if productPts < Int(self.pointBalance) ?? 0{
//                self.addedToCartBtn.isHidden = true
//                self.addToPlannerBtn.isHidden = true
//                self.addToCartBtn.isHidden = false
//                self.addedToPlannerBtn.isHidden = true
//                if filterCategory.count > 0 {
//                    self.addedToCartBtn.isHidden = false
//                    self.addedToCartBtn.backgroundColor = .lightGray
//                    //  cell.addedToCartBtn.backgroundColor = #colorLiteral(red: 1, green: 0.9877298474, blue: 0.5554133654, alpha: 1)
//                    //cell.addedToCartBtn.setTitleColor(.darkGray, for: .normal)
//                    self.addToPlannerBtn.isHidden = true
//                    self.addToCartBtn.isHidden = true
//                    self.addedToPlannerBtn.isHidden = true
//                }
//            }else{
//                if self.VM.catalgoueListArray[indexPath.row].isPlanner! == true{
//                    self.addedToCartBtn.isHidden = true
//                    self.addToPlannerBtn.isHidden = false
//
//                    self.addToCartBtn.isHidden = true
//                    self.addedToPlannerBtn.isHidden = true
//                }else{
//                    self.addedToCartBtn.isHidden = true
//                    self.addToPlannerBtn.isHidden = true
//                    self.addToCartBtn.isHidden = true
//                    self.addedToPlannerBtn.isHidden = true
//                }
//                if filterCategory1.count > 0 {
//                    self.addedToCartBtn.isHidden = true
//                    self.addToPlannerBtn.isHidden = false
//                    self.addToCartBtn.isHidden = true
//                    self.addedToPlannerBtn.isHidden = true
//                }
//            }
//        }else{
//            self.addedToCartBtn.isHidden = true
//            self.addToPlannerBtn.isHidden = true
//            self.addToCartBtn.isHidden = true
//            self.addedToPlannerBtn.isHidden = true
//        }
//}
        
        
       
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.delegate?.selectedItem(self)
        self.navigationController?.popViewController(animated: true)
    }

    
    @IBAction func cartViewBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_MyCartVC") as! KC_MyCartVC
        vc.partyLoyaltyId = self.partyLoyaltyId
        print(self.productTotalPoints)
        vc.productTotalPoints = self.productTotalPoints
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func addToCartBtn(_ sender: Any) {
     
//        if self.verifiedStatus != 1{
//            self.view.makeToast("You are not allowled to redeem .Please contact your administrator", duration: 2.0, position: .bottom)
//
//        }else{
            
        if Int(productPts) <= Int(pointBalance) ?? 0{
            if self.customerTypeId ?? "" == "3" && self.partyLoyaltyId != "" || self.customerTypeId ?? "" == "4" && self.partyLoyaltyId != ""{
                    self.VM.addToCartApi(PartyLoyaltyID: self.loyaltyId, LoyaltyID: self.partyLoyaltyId)
            }else if self.customerTypeId ?? "" == "3" && self.partyLoyaltyId == "" || self.customerTypeId ?? "" == "4" && self.partyLoyaltyId == ""{
                self.VM.addToCartApi(PartyLoyaltyID: "", LoyaltyID: self.loyaltyId)
            }else{
                self.VM.addToCartApi(PartyLoyaltyID: "", LoyaltyID: self.loyaltyId)
            }
            }else{
                self.view.makeToast("InsufficentPointBalance".localiz(), duration: 2.0, position: .bottom)
            }
//        }
//
        
    }
    
    @IBAction func addToPlannerBtn(_ sender: Any) {
        let filterCategory = self.VM.plannerListArray.filter{$0.catalogueId == self.catalogueId}
        if filterCategory.count > 0 {
            DispatchQueue.main.async{
                self.view.makeToast("Alreadyaddedtoplanner".localiz(), duration: 2.0, position: .bottom)
        }
        }else{
            if self.customerTypeId ?? "" == "3" && self.partyLoyaltyId != "" || self.customerTypeId ?? "" == "4" && self.partyLoyaltyId != ""{
                    self.VM.addedToPlanner(PartyLoyaltyID: self.partyLoyaltyId)
            }else if self.customerTypeId ?? "" == "3" && self.partyLoyaltyId == "" || self.customerTypeId ?? "" == "4" && self.partyLoyaltyId == ""{
                self.VM.addedToPlanner(PartyLoyaltyID: "")
            }else{
                self.VM.addedToPlanner(PartyLoyaltyID: "")
            }
        }
    }

    

    
    
   
}
