//
//  KC_ProductsCatelogueCVC.swift
//  KeshavCement
//
//  Created by ADMIN on 05/01/2023.
//

import UIKit
import SDWebImage
protocol AddToCartDelegate {
    func addToCartProducts(_ cell: KC_ProductsCatelogueCVC)
    func addToPlanner(_ cell: KC_ProductsCatelogueCVC)
}
class KC_ProductsCatelogueCVC: UICollectionViewCell {
    
    @IBOutlet weak var addedToPlannerBtn: UIButton!
    @IBOutlet weak var addToPlannerBtn: GradientButton!
    @IBOutlet weak var addToCartBtn: UIButton!
    @IBOutlet weak var addedToCartBtn: UIButton!
    @IBOutlet weak var productPts: UILabel!
    @IBOutlet weak var pointsTitle: UILabel!
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    var delegate: AddToCartDelegate!
    
    override func awakeFromNib() {
    }

    @IBAction func addToCartBTN(_ sender: Any) {
        self.delegate.addToCartProducts(self)
        
    }
    @IBAction func addToPlannerBTN(_ sender: Any) {
        self.delegate.addToPlanner(self)
    }
    
    func setCollectionData(redemptionDetailObj: ObjCatalogueList, redeemedPointBalance: Int, cartItems:[AddToCART]){
        self.productNameLbl.text = redemptionDetailObj.productName ?? ""
        print(redemptionDetailObj.productName ?? "")
        self.productPts.text = "\(redemptionDetailObj.pointsRequired ?? 0)"
        let imageURL = redemptionDetailObj.productImage ?? ""
        print(imageURL)
        if imageURL != ""{
            let urltoUse = String(productCatalogueImgURL + imageURL).replacingOccurrences(of: " ", with: "%20")
            let urlt = URL(string: "\(urltoUse)")
            productImage.sd_setImage(with: urlt!, placeholderImage: #imageLiteral(resourceName: "ic_default_img"))
        }else{
            self.productImage.image = UIImage(named: "ic_default_img")
        }
    }
    
}
