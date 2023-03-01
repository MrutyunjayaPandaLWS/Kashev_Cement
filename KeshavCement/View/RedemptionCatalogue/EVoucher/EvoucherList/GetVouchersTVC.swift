//
//  GetVouchersTVC.swift
//  GogrejLocksMobileApplication
//
//  Created by Arokia IT on 2/14/20.
//  Copyright © 2020 Arokiait Pvt Ltd. All rights reserved.
//

import UIKit
import NotificationCenter
import UserNotifications

protocol voucherRedemptionDelegate : class {
    func redemptionTableViewCellDidTap(_ cell: GetVouchersTVC)
    func wishlistTableViewCellDidTap(_ cell: GetVouchersTVC)
    func selectamountTableViewCellDidTap(_ cell: GetVouchersTVC)

}
class GetVouchersTVC: UITableViewCell, UITextFieldDelegate {
    @IBOutlet weak var voucherImage: UIImageView!
    @IBOutlet weak var wishlistbutton: UIButton!
    @IBOutlet weak var voucherName: UILabel!
    @IBOutlet weak var pleaseselectAmount: UILabel!
    @IBOutlet weak var amountTextfield: UITextField!
    @IBOutlet weak var amountButton: UIButton!
    @IBOutlet weak var redeemButton: UIButton!
  //  var voucherDetails = manageBalanceModels()
    weak var delegate: voucherRedemptionDelegate?

    let pointsBalance = UserDefaults.standard.string(forKey: "redeemableEncashBalance") ?? "0"
    var amountselected = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        wishlistbutton.isHidden = true
        amountTextfield.delegate = self
        // NotificationCenter.default.addObserver(self, selector: #selector(handlepopupvoucherclose), name: Notification.Name.selectdropdown, object: nil)
        

        
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       // if voucherDetails.max_points != nil{
        if textField == amountTextfield{
            let maxLength = 6
            let currentString: NSString = (amountTextfield.text ?? "") as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
       // }
        return false
    }
//    @objc func handlepopupvoucherclose(notification: Notification){
//        let voucherVC = notification.object as! GetVouchersVC
//        if voucherVC.getProductCode == voucherDetails.ProductCode ?? ""{
//            self.amountselected = Int(voucherVC.amountselected)
//            self.amountButton.setTitle("\(voucherVC.amountselected)", for: .normal)
//            if self.amountselected <= Int(pointsBalance)!{
//                           self.redeemButton.isHidden = false
//                           self.wishlistbutton.isHidden = true
//                       }else{
//                           self.redeemButton.isHidden = true
//                           self.wishlistbutton.isHidden = false
//                       }
//        }
//
//    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    @IBAction func amountTextfield(_ sender: Any) {
        if amountTextfield.text != ""{
                      let points = Int(pointsBalance)
                            let pointsEntered = Int(amountTextfield.text!)
                            if points! < pointsEntered ?? 0 {
                                self.redeemButton.isHidden = true
                                self.wishlistbutton.isHidden = false
                            }else{
                            self.redeemButton.isHidden = false
                            self.wishlistbutton.isHidden = true
                            }
    }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if amountTextfield.text != ""{
        let points = Int(pointsBalance)
        let pointsEntered = Int(amountTextfield.text!)
        if points! < pointsEntered! {
            self.redeemButton.isHidden = true
            self.wishlistbutton.isHidden = false
        }else{
        self.redeemButton.isHidden = false
        self.wishlistbutton.isHidden = true
        }
    }
    }
    @IBAction func wishlistButton(_ sender: Any) {
        delegate?.wishlistTableViewCellDidTap(self)

    }
    @IBAction func amountButton(_ sender: Any) {
        delegate?.selectamountTableViewCellDidTap(self)

    }
    
    @IBAction func redeemButton(_ sender: Any) {
        delegate?.redemptionTableViewCellDidTap(self)

    }
    
    
}
