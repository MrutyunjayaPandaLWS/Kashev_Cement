//
//  KC_CashTransferApprovalTVC.swift
//  KeshavCement
//
//  Created by ADMIN on 14/01/2023.
//

import UIKit

protocol CashTransferDataUpdateDelegate: AnyObject{
    
    func didApprovedButton(_ cell: KC_CashTransferApprovalTVC)
    func didRejectedButton(_ cell: KC_CashTransferApprovalTVC)
    func didEnteredRemarks(_ cell: KC_CashTransferApprovalTVC)
}
class KC_CashTransferApprovalTVC: UITableViewCell{
    @IBOutlet weak var mobileLbl: UILabel!
    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var approveBtn: UIButton!
    @IBOutlet weak var reject: UIButton!
    @IBOutlet weak var remarksLbl: UILabel!
    @IBOutlet weak var pointLbl: UITextField!
    @IBOutlet weak var ptsLbl: UILabel!
    @IBOutlet weak var voucherLbl: UILabel!
    @IBOutlet weak var voucherName: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var remarksTF: UITextField!
    @IBOutlet weak var cashTransferImage: UIImageView!
    
    @IBOutlet weak var categoryLbl: UILabel!
    
    @IBOutlet weak var userNameLbl: UILabel!
    var delegate: CashTransferDataUpdateDelegate!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.remarksTF.setLeftPaddingPoints(13)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func remarksEditingDidEnd(_ sender: Any) {
        self.delegate.didEnteredRemarks(self)
    }
    @IBAction func approveButton(_ sender: Any) {
        self.delegate.didApprovedButton(self)
    }
    
    @IBAction func rejectButton(_ sender: Any) {
        self.delegate.didRejectedButton(self)
    }
}
