//
//  KC_CashTransferApprovalTVC.swift
//  KeshavCement
//
//  Created by ADMIN on 14/01/2023.
//

import UIKit

class KC_CashTransferApprovalTVC: UITableViewCell {

    @IBOutlet weak var approveBtn: UIButton!
    @IBOutlet weak var reject: UIButton!
    @IBOutlet weak var remarks: UILabel!
    @IBOutlet weak var remarksLbl: UILabel!
    @IBOutlet weak var pointLbl: UITextField!
    @IBOutlet weak var ptsLbl: UILabel!
    @IBOutlet weak var voucherLbl: UILabel!
    @IBOutlet weak var voucherName: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    @IBOutlet weak var cashTransferImage: UIImageView!
    
    @IBOutlet weak var categoryLbl: UILabel!
    
    @IBOutlet weak var userNameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func approveButton(_ sender: Any) {
    }
    
    @IBAction func rejectButton(_ sender: Any) {
    }
}
