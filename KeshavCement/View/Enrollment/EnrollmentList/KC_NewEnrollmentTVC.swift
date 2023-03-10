//
//  KC_NewEnrollmentTVC.swift
//  KeshavCement
//
//  Created by ADMIN on 13/01/2023.
//

import UIKit

class KC_NewEnrollmentTVC: UITableViewCell {

    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var ptslbl: UILabel!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var mobileLbl: UILabel!
    @IBOutlet weak var membershipIdLbl: UILabel!
    @IBOutlet weak var lastPurchaseDateLbl: UILabel!
    @IBOutlet weak var lastRedemptionDateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
