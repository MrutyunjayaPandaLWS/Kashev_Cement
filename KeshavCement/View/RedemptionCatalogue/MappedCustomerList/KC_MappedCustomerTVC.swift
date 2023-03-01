//
//  KC_MappedCustomerTVC.swift
//  KeshavCement
//
//  Created by ADMIN on 25/02/2023.
//

import UIKit

class KC_MappedCustomerTVC: UITableViewCell {

    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var ptslbl: UILabel!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var mobileLbl: UILabel!
    @IBOutlet weak var membershipIdLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
