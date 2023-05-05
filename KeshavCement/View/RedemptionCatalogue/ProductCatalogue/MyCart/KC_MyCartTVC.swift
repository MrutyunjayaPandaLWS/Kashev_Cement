//
//  KC_MyCartTVC.swift
//  KeshavCement
//
//  Created by ADMIN on 07/01/2023.
//

import UIKit
protocol MyCartDelegate{
    
    func increaseCount(_ cell: KC_MyCartTVC)
    func decreaseCount(_ cell: KC_MyCartTVC)
    func removeProduct(_ cell: KC_MyCartTVC)
}
class KC_MyCartTVC: UITableViewCell {

    @IBOutlet weak var countTF: UITextField!
    @IBOutlet weak var totalPointsLbl: UILabel!
    @IBOutlet weak var ptsTitle: UILabel!
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var removeBtn: UIButton!
    var delegate: MyCartDelegate!
    let verifiedStatus = UserDefaults.standard.integer(forKey: "VerifiedStatus")
    var checkAccountStatus = UserDefaults.standard.string(forKey: "SemiActiveAccount") ?? ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        self.countTF.isUserInteractionEnabled = false
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func minusBtn(_ sender: Any) {
        self.delegate.decreaseCount(self)
    
}
    @IBAction func plusBtn(_ sender: Any) {
        print(self.verifiedStatus)
//        if self.verifiedStatus != 1{
//            self.makeToast("You are not allowled to redeem .Please contact your administrator", duration: 2.0, position: .bottom)
//        }else{
        self.delegate.increaseCount(self)
//        }
    }
    @IBAction func removeBTN(_ sender: Any) {
        self.delegate.removeProduct(self)
    }
}
