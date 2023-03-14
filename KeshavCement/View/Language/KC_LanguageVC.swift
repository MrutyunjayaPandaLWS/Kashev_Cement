//
//  KC_Language.swift
//  KeshavCement
//
//  Created by ADMIN on 30/12/2022.
//

import UIKit

class KC_LanguageVC: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    

    @IBOutlet weak var languageTableView: UITableView!
    //    @IBOutlet weak var headerLbl: UILabel!
    
    var languageListArray = ["English", "हिंदी","ಕನ್ನಡ"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.languageTableView.delegate = self
        self.languageTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.languageListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "KC_LanguageTVC", for: indexPath) as! KC_LanguageTVC
        cell.selectionStyle = .none
        cell.titleLbl.text = self.languageListArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        switch String(self.languageListArray[indexPath.row]){
            
        case "English":
            UserDefaults.standard.set("1", forKey: "LanguageLocalizable")
            UserDefaults.standard.synchronize()
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_WelcomeVC") as! KC_WelcomeVC
            self.navigationController?.pushViewController(vc, animated: true)
        return
            
        case "हिंदी":
            UserDefaults.standard.set("2", forKey: "LanguageLocalizable")
            UserDefaults.standard.synchronize()
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_WelcomeVC") as! KC_WelcomeVC
            self.navigationController?.pushViewController(vc, animated: true)
            return
        case "ಕನ್ನಡ":
            UserDefaults.standard.set("3", forKey: "LanguageLocalizable")
            UserDefaults.standard.synchronize()
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_WelcomeVC") as! KC_WelcomeVC
            self.navigationController?.pushViewController(vc, animated: true)
            return
        default:
            print("Error")
            return
        }
        
        
    }
    
    
    
    
//    @IBAction func englishBtn(_ sender: Any) {
//        UserDefaults.standard.set("1", forKey: "LanguageLocalizable")
//        UserDefaults.standard.synchronize()
//        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_WelcomeVC") as! KC_WelcomeVC
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//
//    @IBAction func hindiBtn(_ sender: Any) {
//        UserDefaults.standard.set("2", forKey: "LanguageLocalizable")
//        UserDefaults.standard.synchronize()
//        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_WelcomeVC") as! KC_WelcomeVC
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//    @IBAction func kanndaBtn(_ sender: Any) {
//        UserDefaults.standard.set("3", forKey: "LanguageLocalizable")
//        UserDefaults.standard.synchronize()
//        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_WelcomeVC") as! KC_WelcomeVC
//        self.navigationController?.pushViewController(vc, animated: true)
//    }

    

}
