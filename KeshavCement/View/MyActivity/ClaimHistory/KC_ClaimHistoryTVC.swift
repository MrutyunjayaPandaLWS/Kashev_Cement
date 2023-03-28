//
//  KC_ClaimHistoryTVC.swift
//  KeshavCement
//
//  Created by ADMIN on 14/01/2023.
//

import UIKit

class KC_ClaimHistoryTVC: UITableViewCell {

    @IBOutlet weak var claimIdLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    @IBOutlet weak var categoryLbl: UILabel!
    
    @IBOutlet weak var userNameLbl: UILabel!
    
    @IBOutlet weak var statusLbl: UILabel!
    
    @IBOutlet weak var productNameTitle: UILabel!
    
    @IBOutlet weak var productNameLbl: UILabel!
    
    @IBOutlet weak var orderquantity: UILabel!
    
    @IBOutlet weak var orderedQty: UILabel!
    
    @IBOutlet weak var qtyStatusLbl: UILabel!
    
    @IBOutlet weak var qtyLb: UILabel!
    
    @IBOutlet weak var remarksLbl: UILabel!
    
    @IBOutlet weak var remarks: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
