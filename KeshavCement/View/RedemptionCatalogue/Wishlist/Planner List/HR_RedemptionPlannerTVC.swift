//
//  HR_RedemptionPlannerTVC.swift
//  HR_Johnson
//
//  Created by ArokiaIT on 2/22/22.
//

import UIKit
protocol RedeemePlannedProductDelegate {
    func redeemProducts(_ cell: HR_RedemptionPlannerTVC)
    func removeProducts(_ cell: HR_RedemptionPlannerTVC)
}

class HR_RedemptionPlannerTVC: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPoints: UILabel!
    @IBOutlet weak var desiredDate: UILabel!
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var redeemBTN: GradientButton!
    @IBOutlet weak var dateTitle: UILabel!
    @IBOutlet weak var productView: UIView!
    var delegate: RedeemePlannedProductDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        productView.layer.masksToBounds = false
        productView?.layer.shadowColor = UIColor.black.cgColor
        productView?.layer.shadowOffset =  CGSize.zero
        productView?.layer.shadowOpacity = 0.5
        productView?.layer.shadowRadius = 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func redeemProducts(_ sender: Any) {
        self.delegate.redeemProducts(self)
    }
    @IBAction func removeProductsBTN(_ sender: Any) {
        self.delegate.removeProducts(self)
    }
    
}
