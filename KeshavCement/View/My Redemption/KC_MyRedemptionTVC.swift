//
//  KC_MyRedemptionTVC.swift
//  KeshavCement
//
//  Created by Arokia-M3 on 02/01/23.
//

import UIKit

class KC_MyRedemptionTVC: UITableViewCell {
    @IBOutlet weak var referenceIdLbl: UILabel!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var pointsPerUnitLbl: UILabel!
    @IBOutlet var redemptionDateLbl: UILabel!
    @IBOutlet var statusLbl: UILabel!
    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var productView: UIView!
    @IBOutlet var productHeaderLbl: UILabel!
    @IBOutlet var productNameLbl: UILabel!
    @IBOutlet var pointsHeadingLbl: UILabel!
    @IBOutlet var quantityHeadingLbl: UILabel!
    @IBOutlet var qtyLbl: UILabel!
    
    @IBOutlet weak var productTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.productTitle.roundCorners(corners: [.topLeft, .bottomRight], radius: 20)
        self.productTitle.clipsToBounds = true
        selectionStyle = .none
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func roundCorners(with CACornerMask: CACornerMask, radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = [CACornerMask]
    }
    
}
