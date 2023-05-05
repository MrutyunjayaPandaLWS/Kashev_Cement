//
//  KC_CashTransferDetailsVC.swift
//  KeshavCement
//
//  Created by ADMIN on 27/02/2023.
//

import UIKit
import SDWebImage
import LanguageManager_iOS
class KC_CashTransferDetailsVC: BaseViewController {

    
    @IBOutlet weak var redeemButton: UIButton!
    @IBOutlet weak var totalPts: UILabel!
    @IBOutlet weak var termandConditionLbl: UILabel!
    @IBOutlet weak var headerLbl: UILabel!
    
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var descriptionView: UIView!
    var categoryTitle = ""
    var productName = ""
    var descriptions = ""
    var termsandCondition = ""
    var totalPoints = ""
    var productImageURL = ""
    var totalRedeemablePoints = UserDefaults.standard.string(forKey: "RedeemablePointBalance") ?? ""
    var categoryId = ""
    
    var noOfPointsRequired = ""
    var productCode = ""
    var productimage = ""
    var productname = ""
    var termandCondition = ""
    var vendorId = ""
    var vendorName = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.customerTypeId == "3"{
            self.headerLbl.text = "CashVoucher".localiz()
            self.categoryLbl.text = "Cash Voucher / \(self.categoryTitle)"
            self.categoryId = "9"
        }else{
            self.categoryId = "8"
            self.headerLbl.text = "CashTransfer".localiz()
            self.categoryLbl.text = "Cash Transfer / \(self.categoryTitle)"
//            self.cashTranferApi(categoryId: self.categoryId, startIndex: 1)
        }
        
        self.productNameLbl.text = productName
        self.descriptionLbl.text = descriptions
        self.termandConditionLbl.text = termsandCondition
        self.totalPts.text = "\(totalPoints)"
        
//        self.descriptionView.roundCorners(corners: [.topLeft, .topRight], radius: 20)
        self.descriptionView.clipsToBounds = true
        self.descriptionView.layer.cornerRadius = 20
        self.descriptionView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        let imageURL = self.productImageURL
        if imageURL != ""{
            let urltoUse = String(productCatalogueImgURL + imageURL).replacingOccurrences(of: " ", with: "%20")
            let urlt = URL(string: "\(urltoUse)")
            self.productImage.sd_setImage(with: urlt!, placeholderImage: #imageLiteral(resourceName: "ic_default_img"))
        }else{
            self.productImage.image = UIImage(named: "ic_default_img")
        }
        if Int(self.noOfPointsRequired)! <= Int(self.totalRedeemablePoints)!{
            self.redeemButton.backgroundColor = .black
            self.redeemButton.setTitleColor(.systemYellow, for: .normal)
        }else{

            self.redeemButton.backgroundColor = .lightGray
            self.redeemButton.setTitleColor(.systemYellow, for: .normal)
        }
        
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func redeemButton(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_CashTranferPopUpVC") as! KC_CashTranferPopUpVC
        vc.noOfPointsRequired = self.noOfPointsRequired
        vc.productCode = self.productCode
        vc.productImage = self.productImageURL
        vc.productName = self.productName
        vc.termsandCondition = self.termsandCondition
        vc.vendorId = self.vendorId
        vc.vendorName = self.vendorName
        vc.categoryId = self.categoryId
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
