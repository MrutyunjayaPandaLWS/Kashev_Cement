//
//  DD_SetPasswordVC.swift
//  KeshavCement
//
//  Created by ADMIN on 30/12/2022.
//

import UIKit
import Toast_Swift
import LanguageManager_iOS
protocol SendNewPasswordDelegate: class{
    
    func sendNewPassword(_ vc: KC_SetPasswordVC)
}

class KC_SetPasswordVC: BaseViewController {

    @IBOutlet weak var setPasswordBtn: UIButton!
    @IBOutlet weak var enterConfirmPwd: UILabel!
    @IBOutlet weak var enterNewPwdLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var newPasswordTF: UITextField!
    
    @IBOutlet weak var confirmPassworTF: UITextField!
    
    var delegate: SendNewPasswordDelegate!
    var newPassword = ""
    var mobileNumber = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.newPasswordTF.setLeftPaddingPoints(13)
        self.confirmPassworTF.setLeftPaddingPoints(13)
        
        self.titleLbl.text = "SetNewPassword".localiz()
        self.enterNewPwdLbl.text = "Enternewpassword".localiz()
        self.newPasswordTF.placeholder = "Enternewpassword".localiz()
        self.enterConfirmPwd.text = "Enterconfirmpassword".localiz()
        self.confirmPassworTF.placeholder = "Enterconfirmpassword".localiz()
        self.setPasswordBtn.setTitle("SetPassword".localiz(), for: .normal)
        
    }
    
    @IBAction func setPasswordBtn(_ sender: Any) {
        if self.newPasswordTF.text?.count == 0{
            self.view.makeToast("Enternewpassword".localiz(), duration: 2.0, position: .bottom)
        }else if self.confirmPassworTF.text?.count == 0{
            self.view.makeToast("Enterconfirmpassword".localiz(), duration: 2.0, position: .bottom)
        }else if self.newPasswordTF.text ?? "" != self.confirmPassworTF.text ?? ""{
            self.view.makeToast("BothPasswordsame".localiz(), duration: 2.0, position: .bottom)
        }else{
            self.newPassword = self.confirmPassworTF.text ?? ""
            self.delegate.sendNewPassword(self)
            self.dismiss(animated: true)
        }
        
     
    }
    
    
}
