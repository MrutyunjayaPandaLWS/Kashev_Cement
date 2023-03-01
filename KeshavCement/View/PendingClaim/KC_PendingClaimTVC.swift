//
//  KC_PendingClaimTVC.swift
//  KeshavCement
//
//  Created by ADMIN on 14/01/2023.
//

import UIKit

protocol DataUpdateDelegate: AnyObject{
    func didTapPlusButton(_ cell: KC_PendingClaimTVC)
    func didTapMinusButton(_ cell: KC_PendingClaimTVC)
    func didApprovedButton(_ cell: KC_PendingClaimTVC)
    func didRejectedButton(_ cell: KC_PendingClaimTVC)
    func didEnteredQtyValue(_ cell: KC_PendingClaimTVC)
    func didEnteredRemarks(_ cell: KC_PendingClaimTVC)
}

class KC_PendingClaimTVC: UITableViewCell {
    @IBOutlet weak var qtyTF: UITextField!
    
    @IBOutlet weak var remarksTF: UITextField!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var approve: UIButton!
    @IBOutlet weak var reject: UIButton!
    @IBOutlet weak var remarks: UILabel!
    @IBOutlet weak var orderQtyLbl: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var categoryTypeLbl: UILabel!
    @IBOutlet weak var claimImage: UIImageView!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var claimDateLbl: UILabel!
    
    var delegate: DataUpdateDelegate!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.remarksTF.setLeftPaddingPoints(13)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func qtyEditingDidEnd(_ sender: Any) {
        self.delegate.didEnteredQtyValue(self)
    }
    
    @IBAction func plusBtn(_ sender: Any) {
        self.delegate.didTapPlusButton(self)
    }
    @IBAction func minusBtn(_ sender: Any) {
        self.delegate.didTapMinusButton(self)
    }
    @IBAction func rejectBtn(_ sender: Any) {
        self.delegate.didRejectedButton(self)
    }
    
    @IBAction func approveBtn(_ sender: Any) {
        self.delegate.didApprovedButton(self)
    }
    
    @IBAction func remarksEditingDidEnd(_ sender: Any) {
        self.delegate.didEnteredRemarks(self)
    }
}
