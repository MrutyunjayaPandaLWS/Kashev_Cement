//
//  KC_MyActivityTVC.swift
//  KeshavCement
//
//  Created by Arokia-M3 on 09/03/23.
//

import UIKit

class KC_MyActivityTVC: UITableViewCell {

 
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
        self.statusLbl.clipsToBounds = true
        self.remarks.clipsToBounds = true
    }

}
