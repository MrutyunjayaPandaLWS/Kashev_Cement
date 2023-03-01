//
//  KC_LodgeQueryTVC.swift
//  KeshavCement
//
//  Created by ADMIN on 16/01/2023.
//

import UIKit

class KC_LodgeQueryTVC: UITableViewCell {

    @IBOutlet weak var queryTime: UILabel!
    @IBOutlet weak var queryDate: UILabel!
    @IBOutlet weak var queryInfo: UILabel!
    @IBOutlet weak var queryStatus: GradientLabel!
    @IBOutlet weak var queryId: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
