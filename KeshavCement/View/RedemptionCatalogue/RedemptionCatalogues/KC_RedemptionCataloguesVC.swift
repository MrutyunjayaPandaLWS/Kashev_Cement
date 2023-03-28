//
//  KC_RedemptionCataloguesVC.swift
//  KeshavCement
//
//  Created by ADMIN on 03/01/2023.
//

import UIKit

class KC_RedemptionCataloguesVC: BaseViewController {

    @IBOutlet weak var deliveryTypeView: UIView!
    @IBOutlet weak var redeemablePts: UILabel!
    @IBOutlet weak var selectionType: UILabel!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var redemptionTypeCollectionView: UICollectionView!
    
    @IBOutlet weak var subView: UIView!
    var categoryListingArray = ["Products", "eVouchers", "Cash Transfer", "Wishlist"]
    var categoryListingArray1 = ["Products", "eVouchers", "Cash Voucher", "Wishlist"]
    var categoryListImageArray = ["Products", "evouchers", "cashTransfer", "wishlist"]
    var totalRedeemablePoints = UserDefaults.standard.string(forKey: "RedeemablePointBalance") ?? ""
    var itsFrom = ""
    var partyLoyaltyId = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.redemptionTypeCollectionView.delegate = self
        self.redemptionTypeCollectionView.dataSource = self
        subView.clipsToBounds = false
        subView.layer.cornerRadius = 36
        subView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.redeemablePts.text = "\(self.totalRedeemablePoints)"
        
//        headerView.layer.masksToBounds = false
//        headerView.layer.shadowRadius = 2
//        headerView.layer.shadowOpacity = 0.2
//        headerView.layer.shadowColor = UIColor.gray.cgColor
//        headerView.layer.shadowOffset = CGSize(width: 0 , height:2)
  
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.deliveryTypeView.isHidden = true
    }
    
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func forSelfBtn(_ sender: Any) {
        if self.itsFrom == "CATALOGUE"{
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_ProductCatalogueVC") as! KC_ProductCatalogueVC
            vc.partyLoyaltyId = ""
            self.navigationController?.pushViewController(vc, animated: true)
        }else if self.itsFrom == "eVoucher"{
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "QS_MyVouchers_VC") as! QS_MyVouchers_VC
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_RedemptionPlannerVC") as! HR_RedemptionPlannerVC
            vc.partyLoyaltyId = ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
            
    }
    
    @IBAction func forOtherBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_MappedCustomerListVC") as! KC_MappedCustomerListVC
        vc.itsFrom = self.itsFrom
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension KC_RedemptionCataloguesVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.customerTypeId == "3"{
            return self.categoryListingArray1.count
        }else{
            return self.categoryListingArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KC_RedemptionCatalogueCVC", for: indexPath) as! KC_RedemptionCatalogueCVC
       
        if customerTypeId == "3"{
            cell.categoryTitle.text = self.categoryListingArray1[indexPath.row]
            if cell.categoryTitle.text! == "Products"{
                cell.categoryImage.image = UIImage(named: "Products")
                cell.subView.backgroundColor = UIColor(hexString: "#FFF7F7")
            }else if cell.categoryTitle.text! == "eVouchers"{
                cell.categoryImage.image = UIImage(named: "evouchers")
                cell.subView.backgroundColor = UIColor(hexString: "#F8EFFD")
            }else if cell.categoryTitle.text! == "Cash Voucher"{
                cell.categoryImage.image = UIImage(named: "cashTransfer")
                cell.subView.backgroundColor = UIColor(hexString: "#FEF5E4")
            }else if cell.categoryTitle.text! == "Wishlist"{
                cell.categoryImage.image = UIImage(named: "wishlist")
                cell.subView.backgroundColor = UIColor(hexString: "#EBFEFF")
            }
        }else{
            cell.categoryTitle.text = self.categoryListingArray[indexPath.row]
            if cell.categoryTitle.text! == "Products"{
                cell.categoryImage.image = UIImage(named: "Products")
                cell.subView.backgroundColor = UIColor(hexString: "#FFF7F7")
            }else if cell.categoryTitle.text! == "eVouchers"{
                cell.categoryImage.image = UIImage(named: "evouchers")
                cell.subView.backgroundColor = UIColor(hexString: "#F8EFFD")
            }else if cell.categoryTitle.text! == "Cash Transfer"{
                cell.categoryImage.image = UIImage(named: "cashTransfer")
                cell.subView.backgroundColor = UIColor(hexString: "#FEF5E4")
            }else if cell.categoryTitle.text! == "Wishlist"{
                cell.categoryImage.image = UIImage(named: "wishlist")
                cell.subView.backgroundColor = UIColor(hexString: "#EBFEFF")
            }
        }
       
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.customerTypeId == "3"{
            switch self.categoryListingArray1[indexPath.row]{
            case "Products":
                if self.customerTypeId == "1" || self.customerTypeId == "2"{
                    let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_ProductCatalogueVC") as! KC_ProductCatalogueVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }else{
                    self.itsFrom = "CATALOGUE"
                    self.deliveryTypeView.isHidden = false
                }
                
            case "eVouchers":
                if self.customerTypeId == "1" || self.customerTypeId == "2"{
                    let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "QS_MyVouchers_VC") as! QS_MyVouchers_VC
                    self.navigationController?.pushViewController(vc, animated: true)
                }else{
                    self.itsFrom = "eVoucher"
                    self.deliveryTypeView.isHidden = false
                }
            case "Cash Voucher":
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_CashTransferVC") as! KC_CashTransferVC
                self.navigationController?.pushViewController(vc, animated: true)
            case "Wishlist":
                if self.customerType == "1" || self.customerType == "2"{
                    let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_RedemptionPlannerVC") as! HR_RedemptionPlannerVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }else{
                    self.itsFrom = "WISHLIST"
                    self.deliveryTypeView.isHidden = false
                }
            default:
                print("Unknown")
            }
        }else{
            switch self.categoryListingArray[indexPath.row]{
            case "Products":
                if self.customerTypeId == "1" || self.customerTypeId == "2"{
                    let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_ProductCatalogueVC") as! KC_ProductCatalogueVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }else{
                    self.itsFrom = "CATALOGUE"
                    self.deliveryTypeView.isHidden = false
                }
                
            case "eVouchers":
                if self.customerTypeId == "1" || self.customerTypeId == "2"{
                    let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "QS_MyVouchers_VC") as! QS_MyVouchers_VC
                    self.navigationController?.pushViewController(vc, animated: true)
                }else{
                    self.itsFrom = "eVoucher"
                    self.deliveryTypeView.isHidden = false
                }
            case "Cash Transfer":
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_CashTransferSubmissionVC") as! KC_CashTransferSubmissionVC
                self.navigationController?.pushViewController(vc, animated: true)
            case "Wishlist":
                if self.customerTypeId == "1" || self.customerTypeId == "2"{
                    let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_RedemptionPlannerVC") as! HR_RedemptionPlannerVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }else{
                    self.itsFrom = "WISHLIST"
                    self.deliveryTypeView.isHidden = false
                }
            default:
                print("Unknown")
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let height = collectionView.frame.height
        let width  = collectionView.frame.width / 2.5
        return CGSize(width: width, height: height)
    }
    
}
