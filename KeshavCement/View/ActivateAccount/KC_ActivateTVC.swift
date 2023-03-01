//
//  KC_ActivateTVC.swift
//  KeshavCement
//
//  Created by ADMIN on 02/01/2023.
//

import UIKit

class KC_ActivateTVC: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
