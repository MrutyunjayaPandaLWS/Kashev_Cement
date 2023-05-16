//
//  QS_Vouchers_TVC.swift
//  Quba Safalta
//
//  Created by Arokia-M3 on 11/03/21.
//

import UIKit
import LanguageManager_iOS
protocol vouchersDelegate : class {
    func redeemDidTap(_ cell: QS_Vouchers_TVC)
    func amountDidTap(_ cell: QS_Vouchers_TVC)
    func alertDidTap(_ cell: QS_Vouchers_TVC)
    func enteredAmount(_ cell: QS_Vouchers_TVC)
}

class QS_Vouchers_TVC: UITableViewCell, UITextFieldDelegate {
   
    @IBOutlet var filter: UIButton!
    @IBOutlet var amount: UIButton!
    @IBOutlet var amounttf: UITextField!
    @IBOutlet var inrbalance: UILabel!
    @IBOutlet var productname: UILabel!
    @IBOutlet var imageview: UIImageView!
    @IBOutlet var amounttfView: UIView!
    @IBOutlet var amountView: UIView!
    var vouchersdata = [ObjCatalogueList2]()
    var delegate:vouchersDelegate?
    var alertMsg = ""
    var selectedPoints = 0

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.amounttf.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("SHOWDATA23"), object: nil)
    }
    @objc func methodOfReceivedNotification(notification: Notification) {
        guard let yourPassedObject = notification.object as? QS_MyVouchers_VC else {return}
        if self.vouchersdata[0].productCode == yourPassedObject.productcodeselected{
        self.selectedPoints = yourPassedObject.selectedPoints
        self.amount.setTitle(String(self.selectedPoints), for: .normal)
        NotificationCenter.default.removeObserver(self)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == amounttf{
            guard let textFieldText = amounttf.text,
                   let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                       return false
               }
               let substringToReplace = textFieldText[rangeOfTextToReplace]
               let count = textFieldText.count - substringToReplace.count + string.count
               return count <= 6        }
        return true
    }
//    func setdata(redemablePoints:Int){
//        if self.vouchersdata[0].min_points ?? "" == "" || self.vouchersdata[0].max_points ?? "" == ""{
//
//        }else{
//            if redemablePoints < Int(self.vouchersdata[0].min_points!)!{
//                self.filter.backgroundColor = UIColor.gray
//                self.filter.isEnabled = false
//            }else{
//                self.filter.backgroundColor = UIColor(red: 1/255, green: 105/255, blue: 56/255, alpha: 1.0)
//                self.filter.isEnabled = true
//            }
//        }
//
//    }

    @IBAction func amountTFACT(_ sender: Any) {
        self.delegate!.enteredAmount(self)
    }
    @IBAction func amountTF(_ sender: Any) {
//        if amounttf.text?.count != 0{
//
//
//        }else{
//            self.filter.backgroundColor = UIColor(red: 0/255, green: 183/255, blue: 241/255, alpha: 1.0)
//            self.filter.isEnabled = true
//            self.amounttf.text = ""
//        }
        self.delegate!.enteredAmount(self)
    }
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        if amounttf.text?.count != 0{
//            let amt = Int(amounttf.text ?? "0")!
//            if amt < Int(vouchersdata[0].min_points!)! || amt > Int(vouchersdata[0].max_points!)!{
//                self.filter.backgroundColor = UIColor.gray
//                self.filter.isEnabled = false
//            }else{
//                self.filter.backgroundColor = UIColor(red: 1/255, green: 105/255, blue: 56/255, alpha: 1.0)
//                self.filter.isEnabled = true
//            }
//            self.delegate!.enteredAmount(self)
//        }else{
//            self.filter.backgroundColor = UIColor(red: 0/255, green: 183/255, blue: 241/255, alpha: 1.0)
//            self.filter.isEnabled = true
//        }
    //}
    
    
    @IBAction func amountbutton(_ sender: Any) {
        self.delegate?.amountDidTap(self)
    }
    
    @IBAction func filter(_ sender: Any) {
        if vouchersdata[0].min_points ?? "" != "" || vouchersdata[0].max_points ?? "" != ""{
            if self.amounttf.text?.count == 0{
                self.alertMsg = "Enter_amount_to_redeem".localiz()
                self.delegate?.alertDidTap(self)
            }else{
                self.delegate?.redeemDidTap(self)
            }
        }else{
            if self.amount.currentTitle == "Amount" || self.amount.currentTitle == "كمية"{
                self.alertMsg = "SelectAmount".localiz()
                self.delegate?.alertDidTap(self)
            }else{
                self.delegate?.redeemDidTap(self)
            }
        }
    }
}
