//
//  KC_SideMenuTVC.swift
//  KeshavCement
//
//  Created by ADMIN on 02/01/2023.
//

import UIKit

class KC_SideMenuTVC: UITableViewCell {

    @IBOutlet weak var dropDownImage: UIImageView!
    @IBOutlet weak var leadingSpaceConstraint: NSLayoutConstraint!
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
