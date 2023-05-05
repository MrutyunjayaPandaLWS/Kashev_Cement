//
//  KC_ReferandEarnVC.swift
//  KeshavCement
//
//  Created by ADMIN on 03/01/2023.
//

import UIKit
import LanguageManager_iOS

class KC_ReferandEarnVC: BaseViewController, UITextFieldDelegate {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var referralCodeTF: UITextField!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var headerLbl: UILabel!
    
    @IBOutlet weak var getRewardsLbl: UILabel!
    @IBOutlet weak var referInfoLbl: UILabel!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var mobileLbl: UILabel!
    
    @IBOutlet weak var sendInviteBtn: UIButton!
    @IBOutlet weak var mobileTF: UITextField!
    
    var referralCode = UserDefaults.standard.string(forKey: "ReferralCode") ?? ""
    var customerMobile = UserDefaults.standard.string(forKey: "CustomerMobileNumber") ?? ""
    
    var VM = KC_ReferandEarnVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.mobileTF.delegate = self
        self.nameTF.setLeftPaddingPoints(13)
        self.mobileTF.setLeftPaddingPoints(13)
        self.nameTF.attributedPlaceholder = NSAttributedString(string: "Entername".localiz(), attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        self.mobileTF.attributedPlaceholder = NSAttributedString(string: "Entermobilenumber".localiz(), attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        
        subView.clipsToBounds = false
        subView.layer.cornerRadius = 36
        subView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        headerView.layer.masksToBounds = false
        headerView.layer.shadowRadius = 2
        headerView.layer.shadowOpacity = 0.2
        headerView.layer.shadowColor = UIColor.gray.cgColor
        headerView.layer.shadowOffset = CGSize(width: 0 , height:2)
        self.referralCodeTF.text = "\(self.referralCode)"
        self.headerLbl.text = "ReferandEarn".localiz()
        self.referInfoLbl.text = "Referyourfriendstoearnexcitingrewards".localiz()
        self.referralCodeTF.placeholder = "EnterReferralCode".localiz()
        self.getRewardsLbl.text = "Getexcitingrewardswhenyourfriendenrollstotheprogram".localiz()
        self.nameLbl.text = "Name".localiz()
        self.mobileLbl.text = "MobileNumber".localiz()
        self.sendInviteBtn.setTitle("SendInvite".localiz(), for: .normal)
        
    }

    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func shareBtn(_ sender: Any) {
        let text = "\(referralCode)"
            let textShare = [ text ]
            let activityViewController = UIActivityViewController(activityItems: textShare , applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)
    }
    @IBAction func copyReferralCodeBtn(_ sender: Any) {
        self.view.makeToast("TextCopied".localiz(), duration: 2.0,position: .bottom)
        UIPasteboard.general.string = "\(referralCode)"
    }
    
    @IBAction func sendInviteBtn(_ sender: Any) {
        if self.nameTF.text!.count == 0 {
            self.view.makeToast("Entername".localiz(), duration: 2.0,position: .bottom)
        }else if self.mobileTF.text!.count == 0 {
            self.view.makeToast("Entermobilenumber".localiz(), duration: 2.0,position: .bottom)
        }else if self.mobileTF.text!.count != 10 {
            self.view.makeToast("Entervalidmobilenumber".localiz(), duration: 2.0,position: .bottom)
        }else if self.mobileTF.text ?? "" == self.customerMobile {
            self.view.makeToast("Selfreferralisnotallowed".localiz(), duration: 2.0, position: .bottom)
        }else{
            let parameters = [
                "ActionType": "2",
                "ActorId": "\(self.userID)",
                "ObjContactCenterDetails": [
                    "RefereeMobileNo": "\(self.mobileTF.text ?? "")",
                    "RefereeName":"\(self.nameTF.text ?? "")"
                ]
            ] as [String: Any]
            print(parameters)
            self.VM.referandEarnSubmission(parameter: parameters)
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 10
        let currentString: NSString = (mobileTF.text ?? "") as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
}
