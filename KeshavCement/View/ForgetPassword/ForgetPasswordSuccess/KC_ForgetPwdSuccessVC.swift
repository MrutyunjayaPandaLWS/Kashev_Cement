//
//  KC_ForgetPwdSuccessVC.swift
//  KeshavCement
//
//  Created by ADMIN on 02/01/2023.
//

import UIKit

class KC_ForgetPwdSuccessVC: BaseViewController {

    @IBOutlet weak var newPwdInfo: UILabel!
    @IBOutlet weak var infoLbl: UILabel!
    
    var itsComeFrom = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.itsComeFrom == "CLAIMPURCHASE"{
            self.newPwdInfo.text = "Submitted your purchase request"
        }else if self.itsComeFrom == "SAVEWORKSITEINFO"{
            self.newPwdInfo.text = "Submitted your work details request"
        }else if self.itsComeFrom == "SUPPORTEXECUTIVE"{
            self.newPwdInfo.text = "Support executive created"
        }else if self.itsComeFrom == "EXECUTIVE"{
            self.newPwdInfo.text = "Status updated"
        }else if self.itsComeFrom == "ACCOUNTDEACTIVATE"{
            self.newPwdInfo.text = "Your account is deactivated please check with the administrator"
            self.infoLbl.text = "Account Deactivated!!"
        }
//        else if self.itsComeFrom == "REDEMPTIONSUBMISSION"{
//            self.newPwdInfo.text = "You have successfully redeemed a products"
//        }
        
    }

    @IBAction func okBtn(_ sender: Any) {
        if self.itsComeFrom == "CLAIMPURCHASE"{
            NotificationCenter.default.post(name: .navigateToDashBoard, object: nil)
        }else if self.itsComeFrom == "SAVEWORKSITEINFO"{
            NotificationCenter.default.post(name: .navigateToMain, object: nil)
        }else if self.itsComeFrom == "SUPPORTEXECUTIVE"{
            NotificationCenter.default.post(name: .navigateToSupport, object: nil)
        }else if self.itsComeFrom == "EXECUTIVE"{
            NotificationCenter.default.post(name: .callApi, object: nil)
        }else if self.itsComeFrom == "ACCOUNTDEACTIVATE"{
            NotificationCenter.default.post(name: .deactivatedAcc, object: nil)
        }else{
            NotificationCenter.default.post(name: .navigateToSuccess, object: nil)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}
