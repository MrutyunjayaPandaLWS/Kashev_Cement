//
//  KC_OrderConfirmationTVC.swift
//  KeshavCement
//
//  Created by ADMIN on 07/01/2023.
//

import UIKit

class KC_OrderConfirmationTVC: UITableViewCell {

    @IBOutlet weak var qtyValueLbl: UILabel!
    @IBOutlet weak var qtyLbl: UILabel!
    @IBOutlet weak var pointsTitleLbl: UILabel!
    @IBOutlet weak var pointsLbl: UILabel!
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
