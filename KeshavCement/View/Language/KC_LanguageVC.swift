//
//  KC_Language.swift
//  KeshavCement
//
//  Created by ADMIN on 30/12/2022.
//

import UIKit

class KC_LanguageVC: BaseViewController {

    @IBOutlet weak var headerLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func englishBtn(_ sender: Any) {
        UserDefaults.standard.set("1", forKey: "LanguageLocalizable")
        UserDefaults.standard.synchronize()
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_WelcomeVC") as! KC_WelcomeVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func hindiBtn(_ sender: Any) {
        UserDefaults.standard.set("2", forKey: "LanguageLocalizable")
        UserDefaults.standard.synchronize()
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_WelcomeVC") as! KC_WelcomeVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func kanndaBtn(_ sender: Any) {
        UserDefaults.standard.set("3", forKey: "LanguageLocalizable")
        UserDefaults.standard.synchronize()
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_WelcomeVC") as! KC_WelcomeVC
        self.navigationController?.pushViewController(vc, animated: true)
    }


}
