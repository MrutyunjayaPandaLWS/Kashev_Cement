//
//  KC_MyPurchaseClaimTVC.swift
//  KeshavCement
//
//  Created by ADMIN on 03/01/2023.
//

import UIKit

class KC_MyPurchaseClaimTVC: UITableViewCell {

    @IBOutlet weak var approvedQTYHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var createdDateLbl: UILabel!
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var requestedToLbl: UILabel!
    @IBOutlet weak var statusLbl: UIButton!
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var orderQtyLbl: UILabel!
    @IBOutlet weak var approvedQTYView: UIView!
    @IBOutlet weak var approvedQTYLbl: UILabel!
    @IBOutlet weak var remarks: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
