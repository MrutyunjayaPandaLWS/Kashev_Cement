//
//  KC_RedemptionTypCell.swift
//  KeshavCement
//
//  Created by ADMIN on 06/05/2023.
//

import UIKit

class KC_RedemptionTypCell: UITableViewCell {
    
    
    @IBOutlet weak var statusWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var cashPtsLbl: UILabel!
    @IBOutlet weak var valueLbl: UILabel!
    @IBOutlet weak var currentTransferDateLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var cashTransferLbl: UILabel!
    @IBOutlet weak var requestedToLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.cashTransferLbl.roundCorners(corners: [.topLeft, .bottomRight], radius: 20)
        self.cashTransferLbl.clipsToBounds = true
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
