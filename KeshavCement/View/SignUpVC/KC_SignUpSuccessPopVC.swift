//
//  KC_SignUpSuccessPopVC.swift
//  KeshavCement
//
//  Created by ADMIN on 16/02/2023.
//

import UIKit

class KC_SignUpSuccessPopVC: BaseViewController {

    @IBOutlet weak var infoLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    var itsFrom = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.itsFrom != "ENROLLMENT"{
            self.titleLbl.text = "Successfully!"
            self.infoLbl.text = "Your account has been activated successfully. Login to the app for more benefits"
        }
       
    }

    @IBAction func okBtn(_ sender: Any) {
        if self.itsFrom == "ENROLLMENT"{
            NotificationCenter.default.post(name: .navigateToPrevious, object: nil)
        }else{
            NotificationCenter.default.post(name: .navigateToLogin, object: nil)
        }
        self.dismiss(animated: true)
    }
}
