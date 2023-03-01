//
//  KC_WorksiteDetailsTVC.swift
//  KeshavCement
//
//  Created by ADMIN on 09/01/2023.
//

import UIKit

class KC_WorksiteDetailsTVC: UITableViewCell {

    @IBOutlet weak var ownerNametopSpaceConstraint: NSLayoutConstraint!
    @IBOutlet weak var createdDateLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
   
    @IBOutlet weak var statusLbl: UILabel!
    
    @IBOutlet weak var ownerNameLbl: UILabel!
    
    @IBOutlet weak var ownerName: UILabel!
    
    @IBOutlet weak var ownerMobileLbl: UILabel!
    
    @IBOutlet weak var engineerNameLbl: UILabel!
    
    @IBOutlet weak var engineerName: UILabel!
    
    @IBOutlet weak var engineerMobileLbl: UILabel!
    
    @IBOutlet weak var workDetailsLbl: UILabel!
    
    @IBOutlet weak var workLevelLbl: UILabel!
    
    @IBOutlet weak var workLevel: UILabel!
    
    @IBOutlet weak var tentativeDateLbl: UILabel!
    
    @IBOutlet weak var tentativeDate: UILabel!
    
    @IBOutlet weak var remarksLbl: UILabel!
    
    @IBOutlet weak var remarks: UILabel!
    
    @IBOutlet weak var ownerResidentDetailsLbl: UILabel!
    
    @IBOutlet weak var ownerResidentDetails: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
