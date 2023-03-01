//
//  dropdownTableViewCell.swift
//  GogrejLocksMobileApplication
//
//  Created by Arokia IT on 3/12/20.
//  Copyright © 2020 Arokiait Pvt Ltd. All rights reserved.
//

import UIKit


class dropdownTableViewCell: UITableViewCell {

    @IBOutlet weak var dropdownvalue: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
