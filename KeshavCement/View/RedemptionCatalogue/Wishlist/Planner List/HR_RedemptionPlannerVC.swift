//
//  HR_RedemptionPlannerVC.swift
//  HR_Johnson
//
//  Created by ArokiaIT on 2/10/22.
//

import UIKit
import SDWebImage
//import LanguageManager_iOS
class HR_RedemptionPlannerVC: BaseViewController, RedeemePlannedProductDelegate{
//    func popupAlertDidTap(_ vc: HR_PopUpVC) {}

    
    func redeemProducts(_ cell: HR_RedemptionPlannerTVC) {
        self.selectedCatalogueID = -1
        guard let tappedIndex = redemptionPlannerTableView.indexPath(for: cell) else{return}
        self.selectedCatalogueID = self.VM.plannerListArray[tappedIndex.row].catalogueId ?? 0
        if cell.redeemBTN.tag == tappedIndex.row{
            let filterCategory = self.VM.myCartListArray.filter { $0.catalogueId == self.VM.plannerListArray[tappedIndex.row].catalogueId ?? 0}
            if filterCategory.count > 0{
                DispatchQueue.main.async{
                    self.view.makeToast("Gift product is already added in the Redeem list", duration: 2.0, position: .bottom)
                }
            }else{
                print(self.totalCartValue, "Cart Value")
                print(self.redeemablePointsBalance, "Total points")
                print(self.selectedCatalogueID ?? 0)
                if self.totalCartValue < (Int(self.redeemablePointsBalance) ?? 0) {
                    let calcValue = self.totalCartValue + Int(self.VM.plannerListArray[tappedIndex.row].pointsRequired ?? 0)
                    print(calcValue)
                    if calcValue <= (Int(self.redeemablePointsBalance) ?? 0){
                        
                        
                        if self.customerTypeId ?? "" == "3" && self.partyLoyaltyId != "" || self.customerTypeId ?? "" == "4" && self.partyLoyaltyId != ""{
                          
                                self.VM.addToCartApi(redemptionPlannerId: self.VM.plannerListArray[tappedIndex.row].redemptionPlannerId ?? 0, PartyLoyaltyID: self.partyLoyaltyId, LoyaltyID: self.loyaltyId)
                            
                        }else if self.customerTypeId ?? "" == "3" && self.partyLoyaltyId == "" || self.customerTypeId ?? "" == "4" && self.partyLoyaltyId == ""{
                            self.VM.addToCartApi(redemptionPlannerId: self.VM.plannerListArray[tappedIndex.row].redemptionPlannerId ?? 0, PartyLoyaltyID: "", LoyaltyID: self.loyaltyId)
                        }else{
                            self.VM.addToCartApi(redemptionPlannerId: self.VM.plannerListArray[tappedIndex.row].redemptionPlannerId ?? 0, PartyLoyaltyID: "", LoyaltyID: self.loyaltyId)
                        }
                        
                    }else{
                        DispatchQueue.main.async{
                            self.view.makeToast("Insufficent Point Balance", duration: 2.0, position: .bottom)
                        }
                    }
                }else{
                    DispatchQueue.main.async{
                        self.view.makeToast("Insufficent Point Balance", duration: 2.0, position: .bottom)
                    }
                }
             
            }
            
            
            self.redemptionPlannerTableView.reloadData()
        }
    }
    
    
    func removeProducts(_ cell: HR_RedemptionPlannerTVC) {
        guard let tappedIndexPath = redemptionPlannerTableView.indexPath(for: cell) else {return}
        if cell.removeButton.tag == tappedIndexPath.row{
            self.removeProductId = self.VM.plannerListArray[tappedIndexPath.row].redemptionPlannerId ?? 0
            print(self.removeProductId, "Selected Product Id")
            
            if self.customerTypeId ?? "" == "3" && self.partyLoyaltyId != "" || self.customerTypeId ?? "" == "4" && self.partyLoyaltyId != ""{
             
                    self.VM.removeRedemptionPlanner(redemptionPlannerId: self.removeProductId, PartyLoyaltyID: self.partyLoyaltyId)
             
            }else  if self.customerTypeId ?? "" == "3" && self.partyLoyaltyId == "" || self.customerTypeId ?? "" == "4" && self.partyLoyaltyId == ""{
                
                self.VM.removeRedemptionPlanner(redemptionPlannerId: self.removeProductId, PartyLoyaltyID: "")
         
            }else{
                self.VM.removeRedemptionPlanner(redemptionPlannerId: self.removeProductId, PartyLoyaltyID: "")
            }
        }
    }
    

    @IBOutlet weak var screenTitle: UILabel!
//    @IBOutlet weak var totalPts: UILabel!
//    @IBOutlet weak var points: UILabel!
//    @IBOutlet weak var cartCount: UILabel!
    @IBOutlet weak var redemptionPlannerTableView: UITableView!
    
    @IBOutlet weak var addToPlanner: GradientButton!
    
    var redeemablePointsBalance = UserDefaults.standard.string(forKey: "RedeemablePointBalance") ?? ""
    var VM = KC_RedemptionPlannerVM()
    var removeProductId = 0
    var itsComeFrom = ""
    var selectedCatalogueID = -1
    var selectedPlannerID = -1
    var totalCartValue = 0
    var partyLoyaltyId = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.screenTitle.text = "Wishlist"
    //    self.points.text = "POINTS"
    //    self.totalPts.text! = "\(redeemablePointsBalance)"
        redemptionPlannerTableView.register(UINib(nibName: "HR_RedemptionPlannerTVC", bundle: nil), forCellReuseIdentifier: "HR_RedemptionPlannerTVC")
//        NotificationCenter.default.addObserver(self, selector: #selector(callAPi), name: Notification.Name.plannerList, object: nil)
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.redemptionPlannerTableView.delegate = self
        self.redemptionPlannerTableView.dataSource = self
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                self.view.makeToast("No internet connection", duration: 2.0, position: .bottom)
            }
        }else{
            if self.customerTypeId ?? "" == "3" && self.partyLoyaltyId != "" || self.customerTypeId ?? "" == "4" && self.partyLoyaltyId != ""{
                
                self.VM.getMycartList(PartyLoyaltyID: self.partyLoyaltyId, LoyaltyID: self.loyaltyId)
                self.VM.redemptionPlannerList(PartyLoyaltyID: self.partyLoyaltyId)
                
            }else if self.customerTypeId ?? "" == "3" && self.partyLoyaltyId == "" || self.customerTypeId ?? "" == "4" && self.partyLoyaltyId == ""{
                
                self.VM.getMycartList(PartyLoyaltyID: "", LoyaltyID: self.loyaltyId)
                self.VM.redemptionPlannerList(PartyLoyaltyID: "")
           
        }else{
                self.VM.getMycartList(PartyLoyaltyID: "", LoyaltyID: self.loyaltyId)
                self.VM.redemptionPlannerList(PartyLoyaltyID: "")
            }
           
//            self.VM.cartCountApi()
        }
    }
    @objc func callAPi(){
        
        if self.customerTypeId ?? "" == "3" && self.partyLoyaltyId != "" || self.customerTypeId ?? "" == "4" && self.partyLoyaltyId != ""{
            
                self.VM.redemptionPlannerList(PartyLoyaltyID: self.partyLoyaltyId)
            
        }else if self.customerTypeId ?? "" == "3" && self.partyLoyaltyId == "" || self.customerTypeId ?? "" == "4" && self.partyLoyaltyId == ""{
            self.VM.redemptionPlannerList(PartyLoyaltyID: "")
        }else{
            self.VM.redemptionPlannerList(PartyLoyaltyID: "")
        }
    }
    
    @IBAction func backBTN(_ sender: Any) {
        if self.itsComeFrom == "SideMenu"{
//            NotificationCenter.default.post(name: .sideMenuClosing, object: nil)
            self.navigationController?.popViewController(animated: true)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
//    @IBAction func cartBTN(_ sender: Any) {
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_MyCartVC") as! KC_MyCartVC
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
    @IBAction func addToPlannerBTN(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_ProductCatalogueVC") as! KC_ProductCatalogueVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension HR_RedemptionPlannerVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VM.plannerListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HR_RedemptionPlannerTVC", for: indexPath) as! HR_RedemptionPlannerTVC
        cell.delegate = self
        cell.selectionStyle = .none
        cell.productName.text = self.VM.plannerListArray[indexPath.row].productName ?? ""
        cell.productPoints.text = "\(self.VM.plannerListArray[indexPath.row].pointsRequired ?? 0)"
        cell.desiredDate.text = self.VM.plannerListArray[indexPath.row].actualRedemptionDate ?? "00/00/0000"
        let imageURL = self.VM.plannerListArray[indexPath.row].productImage ?? ""
        if imageURL != ""{
            let urltoUse = String(productCatalogueImgURL + imageURL).replacingOccurrences(of: " ", with: "%20")
            let urlt = URL(string: "\(urltoUse)")
            cell.productImage.sd_setImage(with: urlt!, placeholderImage: #imageLiteral(resourceName: "ic_default_img"))
        }
        print(self.VM.plannerListArray[indexPath.row].sumOfTotalPointsRequired ?? 0, "TotalSum")
        print(self.VM.plannerListArray[indexPath.row].pointsRequired ?? 0)
        print(self.redeemablePointsBalance)
        if self.VM.plannerListArray[indexPath.row].pointsRequired ?? 0 >= Int(self.redeemablePointsBalance) ?? 0{
            cell.redeemBTN.isEnabled = false
            cell.redeemBTN.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
          //  cell.redeemBTN.setTitleColor(.white, for: .normal)
        }else{
            cell.redeemBTN.isEnabled = true
            cell.redeemBTN.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            cell.redeemBTN.setTitleColor(#colorLiteral(red: 0.9049103856, green: 0.865305841, blue: 0.1212991104, alpha: 1), for: .normal)
        }
        cell.removeButton.tag = indexPath.row
        cell.redeemBTN.tag = indexPath.row
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_RedemptionPlannerDetailsVC") as! HR_RedemptionPlannerDetailsVC
        vc.totalPoints = UserDefaults.standard.string(forKey: "RedeemablePointBalance") ?? ""
        vc.cartTotalCount = "\(self.VM.myCartListArray.count)"
        vc.redemptionPlannerId = self.VM.plannerListArray[indexPath.row].redemptionPlannerId ?? 0
        vc.selectedCatalogueID = self.VM.plannerListArray[indexPath.row].catalogueId ?? 0
        vc.catalogueId = self.VM.plannerListArray[indexPath.row].catalogueId ?? 0
        vc.cashValue = self.VM.plannerListArray[indexPath.row].cashValue ?? 0
        vc.vendorId = self.VM.plannerListArray[indexPath.row].vendorId ?? 0
        vc.vendorName = self.VM.plannerListArray[indexPath.row].vendorName ?? ""
        vc.productName = self.VM.plannerListArray[indexPath.row].productName ?? ""
        vc.productImage = self.VM.plannerListArray[indexPath.row].productImage ?? ""
        vc.redeemableAverageEarning = self.VM.plannerListArray[indexPath.row].redeemableAverageEarning ?? ""
        vc.requiredPoints = self.VM.plannerListArray[indexPath.row].pointsRequired ?? 0
        vc.productDesc = self.VM.plannerListArray[indexPath.row].productDesc ?? ""
        vc.termsandContions = self.VM.plannerListArray[indexPath.row].termsCondition ?? ""
        vc.actualRedemptionDate = self.VM.plannerListArray[indexPath.row].actualRedemptionDate ?? ""
        vc.partyLoyaltyId = self.partyLoyaltyId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
