//
//  RGT_popupAlertOne_VC.swift
//  Quba Safalta
//
//  Created by Arokia-M3 on 12/03/21.
//

import UIKit
//import LanguageManager_iOS

protocol popUpAlertDelegate : class {
    func popupAlertDidTap(_ vc: RGT_popupAlertOne_VC)
}
class RGT_popupAlertOne_VC: BaseViewController {

   
    @IBOutlet var ok: GradientButton!
    @IBOutlet var descriptionn: UILabel!
    var titleInfo = ""
    var descriptionInfo = ""
    var delegate:popUpAlertDelegate?
    var itsComeFrom = ""
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.descriptionn.text = descriptionInfo
        self.ok.setTitle("OK", for: .normal)
    }
    
    @IBAction func OK(_ sender: Any) {
        if itsComeFrom == "AccounthasbeenDeleted"{
            self.dismiss(animated: true){
               // NotificationCenter.default.post(name: .deleteAccount, object: nil)
            }
        }else{
            delegate?.popupAlertDidTap(self)
            self.dismiss(animated: true, completion: nil)
        }
        
      
    }
  
    

}
