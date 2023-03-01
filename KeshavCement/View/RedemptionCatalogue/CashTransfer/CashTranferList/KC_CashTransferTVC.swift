//
//  KC_CashTransferTVC.swift
//  KeshavCement
//
//  Created by ADMIN on 07/01/2023.
//

import UIKit
protocol CashTranferDelegate: AnyObject{
    func didTapRedeemBtn(_ cell: KC_CashTransferTVC )
}
class KC_CashTransferTVC: UITableViewCell {

    @IBOutlet weak var pointsValueLbl: UILabel!
    @IBOutlet weak var pointsLbl: UILabel!
    @IBOutlet weak var redeemButton: UIButton!
    @IBOutlet weak var infoLbl: UILabel!
    @IBOutlet weak var offerInfoLbl: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    var delegate: CashTranferDelegate!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func redeemBtn(_ sender: Any) {
        self.delegate.didTapRedeemBtn(self)
    }
}
