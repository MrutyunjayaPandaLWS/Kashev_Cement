//
//  KC_MyEarningTVC.swift
//  KeshavCement
//
//  Created by Arokia-M3 on 02/01/23.
//

import UIKit

class KC_MyEarningTVC: UITableViewCell {

    @IBOutlet var dateHeaderLbl: UILabel!
    
    @IBOutlet var dealerTypeLbl: UILabel!
    
    @IBOutlet var customerTypeNameLbl: UILabel!
    
    @IBOutlet var timeLbl: UILabel!
    
    @IBOutlet var productNameHeadingLbl: UILabel!
    @IBOutlet var createPointsHeadingLbl: UILabel!
    
    @IBOutlet var productNameLbl: UILabel!
    
    @IBOutlet var pointsLbl: UILabel!
    
    @IBOutlet var remarksHeadingLbl: UILabel!
    
    @IBOutlet var remarksDetailsLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
