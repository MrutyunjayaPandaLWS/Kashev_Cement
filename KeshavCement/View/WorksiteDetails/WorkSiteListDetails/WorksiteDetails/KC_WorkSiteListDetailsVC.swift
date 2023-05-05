//
//  KC_WorkSiteListDetailsVC.swift
//  KeshavCement
//
//  Created by ADMIN on 09/01/2023.
//

import UIKit
import LanguageManager_iOS

class KC_WorkSiteListDetailsVC: BaseViewController{
    @IBOutlet weak var workDetailsLbl: UILabel!
    @IBOutlet weak var workDetailsColorLbl: UILabel!
    @IBOutlet weak var userDetailsLbl: UILabel!
    @IBOutlet weak var userDetailsColorLbl: UILabel!
    @IBOutlet weak var siteLocationColorLbl: UILabel!
    @IBOutlet weak var siteLocationLbl: UILabel!
    @IBOutlet weak var headerTitleLbl: UILabel!
    
    var container: ContainerViewController!
    
    var strdata1 = ""
    var currentLatitude = ""
    var currentLongitude = ""
    var ownerName = ""
    var ownerMobile = ""
    var ownerResidentialDetails = ""
    var engineerName = ""
    var engineerNumber = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleNavigation), name: Notification.Name.navigateToUserDetails, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleNavigation1), name: Notification.Name.navigateToWorkDetails, object: nil)
        self.headerTitleLbl.text = "WorkSite".localiz()
        
        self.siteLocationLbl.textColor = #colorLiteral(red: 0.9686275125, green: 0.9686275125, blue: 0.9686276317, alpha: 1)
        self.siteLocationColorLbl.backgroundColor = #colorLiteral(red: 0.8931432366, green: 0.8535407186, blue: 0.1089305803, alpha: 1)
        self.userDetailsLbl.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        self.userDetailsColorLbl.backgroundColor = #colorLiteral(red: 0.9537999034, green: 0.9488571286, blue: 0.9489426017, alpha: 1)
        self.workDetailsLbl.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        self.workDetailsColorLbl.backgroundColor = #colorLiteral(red: 0.9537999034, green: 0.9488571286, blue: 0.9489426017, alpha: 1)
        
        container.segueIdentifierReceivedFromParent("siteDetails")
        siteLocationColorLbl.clipsToBounds = true
        siteLocationColorLbl.layer.cornerRadius = 4
        siteLocationColorLbl.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        workDetailsColorLbl.clipsToBounds = true
        workDetailsColorLbl.layer.cornerRadius = 4
        workDetailsColorLbl.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "regsitrationandbank"{
            self.container = segue.destination as? ContainerViewController
        }
    }
    @objc func handleNavigation(notification: Notification){
        
        self.siteLocationLbl.textColor = #colorLiteral(red: 0.9686275125, green: 0.9686275125, blue: 0.9686276317, alpha: 1)
        self.siteLocationColorLbl.backgroundColor = #colorLiteral(red: 0.8931432366, green: 0.8535407186, blue: 0.1089305803, alpha: 1)
        self.userDetailsLbl.textColor = #colorLiteral(red: 0.9686275125, green: 0.9686275125, blue: 0.9686276317, alpha: 1)
        self.userDetailsColorLbl.backgroundColor = #colorLiteral(red: 0.8931432366, green: 0.8535407186, blue: 0.1089305803, alpha: 1)
        self.workDetailsLbl.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        self.workDetailsColorLbl.backgroundColor = #colorLiteral(red: 0.9537999034, green: 0.9488571286, blue: 0.9489426017, alpha: 1)
        let getSiteDetailsVC = notification.object as! KC_SiteDetailsVC
        print(getSiteDetailsVC.currentLatitude)
        print(getSiteDetailsVC.currentLongitude, "kjsdfkljasdfkjlasdjfadsjfjasdkfjdasfjlasdjfladsjlfjladsfjldsaflj")
        container.currentLatitude = getSiteDetailsVC.currentLatitude
        container.strdata1 = getSiteDetailsVC.strdata1
        container.currentLongitude = getSiteDetailsVC.currentLongitude
        container.siteName = getSiteDetailsVC.siteName
        container.segueIdentifierReceivedFromParent("userDetails")
    }
    
    @objc func handleNavigation1(notification: Notification){
        self.siteLocationLbl.textColor = #colorLiteral(red: 0.9686275125, green: 0.9686275125, blue: 0.9686276317, alpha: 1)
        self.siteLocationColorLbl.backgroundColor = #colorLiteral(red: 0.8931432366, green: 0.8535407186, blue: 0.1089305803, alpha: 1)
        self.userDetailsLbl.textColor = #colorLiteral(red: 0.9686275125, green: 0.9686275125, blue: 0.9686276317, alpha: 1)
        self.userDetailsColorLbl.backgroundColor = #colorLiteral(red: 0.8931432366, green: 0.8535407186, blue: 0.1089305803, alpha: 1)
        self.workDetailsLbl.textColor = #colorLiteral(red: 0.9686275125, green: 0.9686275125, blue: 0.9686276317, alpha: 1)
        self.workDetailsColorLbl.backgroundColor = #colorLiteral(red: 0.8931432366, green: 0.8535407186, blue: 0.1089305803, alpha: 1)
        let getUserDetailsVC = notification.object as! KC_UserDetailsVC
        container.ownerName = getUserDetailsVC.ownerName
        container.ownerMobile = getUserDetailsVC.ownerMobile
        container.ownerResidentialDetails = getUserDetailsVC.ownerResidentialDetails
        container.engineerName = getUserDetailsVC.engineerName
        container.engineerNumber = getUserDetailsVC.engineerNumber
        container.segueIdentifierReceivedFromParent("workDetails")
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func siteLocationButton(_ sender: Any) {
    }
    @IBAction func userDetailsButton(_ sender: Any) {
     
    }
    
    @IBAction func workDetailsButton(_ sender: Any) {
     
    }
}
