//
//  KC_DealerHelpTVC.swift
//  KeshavCement
//
//  Created by ADMIN on 22/04/2023.
//

import UIKit

class KC_DealerHelpTVC: UITableViewCell {

    
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var quantityLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
