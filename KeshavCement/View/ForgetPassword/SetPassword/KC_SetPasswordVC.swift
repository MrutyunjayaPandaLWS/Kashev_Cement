//
//  DD_SetPasswordVC.swift
//  KeshavCement
//
//  Created by ADMIN on 30/12/2022.
//

import UIKit
import Toast_Swift
protocol SendNewPasswordDelegate: class{
    
    func sendNewPassword(_ vc: KC_SetPasswordVC)
}

class KC_SetPasswordVC: BaseViewController {

    @IBOutlet weak var newPasswordTF: UITextField!
    
    @IBOutlet weak var confirmPassworTF: UITextField!
    
    var delegate: SendNewPasswordDelegate!
    var newPassword = ""
    var mobileNumber = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.newPasswordTF.setLeftPaddingPoints(13)
        self.confirmPassworTF.setLeftPaddingPoints(13)
    }
    
    @IBAction func setPasswordBtn(_ sender: Any) {
        if self.newPasswordTF.text?.count == 0{
            self.view.makeToast("Enter new password", duration: 2.0, position: .bottom)
        }else if self.confirmPassworTF.text?.count == 0{
            self.view.makeToast("Enter confirm password", duration: 2.0, position: .bottom)
        }else if self.newPasswordTF.text ?? "" != self.confirmPassworTF.text ?? ""{
            self.view.makeToast("Both new and confirm password should be same", duration: 2.0, position: .bottom)
        }else{
            self.newPassword = self.confirmPassworTF.text ?? ""
            self.delegate.sendNewPassword(self)
            self.dismiss(animated: true)
        }
        
     
    }
    
    
}
