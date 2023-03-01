//
//  KC_WorkDetailsVC.swift
//  KeshavCement
//
//  Created by ADMIN on 09/01/2023.
//

import UIKit

class KC_WorkDetailsVC: BaseViewController, DateSelectedDelegate, SelectedDataDelegate{
    func didTapWorkLevel(_ vc: KC_DropDownVC) {
        self.selectedWorkLevel = vc.selectedWorkLevelTitle
        self.selectedWordId = vc.selectedWorkLevelId
        self.selectLevelLbl.text = vc.selectedWorkLevelTitle
        self.selectLevelLbl.textColor = .darkGray
    }
    func didTapHelpTopic(_ vc: KC_DropDownVC) {}
    func didTapCustomerType(_ vc: KC_DropDownVC) {}
    func didTapMappedUserName(_ vc: KC_DropDownVC) {}
    func didTapProductName(_ vc: KC_DropDownVC){}
    func didTapState(_ vc: KC_DropDownVC) {}
    func didTapDistrict(_ vc: KC_DropDownVC) {}
    func didTapTaluk(_ vc: KC_DropDownVC) {}
    func didTapUserType(_ vc: KC_DropDownVC) {}
    
    func acceptDate(_ vc: KC_DOBVC) {
        if vc.isComeFrom == "1"{
            self.selectedDate = vc.selectedDate
            self.selectedDateLbl.text = vc.selectedDate
            self.selectedDateLbl.textColor = .darkGray
        }
    }
    
    func declineDate(_ vc: KC_DOBVC) {}
    @IBOutlet weak var workDetailsHeaderLbl: UILabel!
   
    @IBOutlet weak var workLevelLbl: UILabel!
    
    @IBOutlet weak var workLevelButton: UIButton!
    @IBOutlet weak var selectLevelLbl: UILabel!

    @IBOutlet weak var tentativeLbl: UILabel!
    
    @IBOutlet weak var selectedDateLbl: UILabel!
    
    @IBOutlet weak var remarksLbl: UILabel!
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var remarksTextView: UITextView!
    
    var selectedWorkLevel = ""
    var selectedWordId = -1
    var selectedDate = ""
    
    var strdata1 = ""
    var currentLatitude = ""
    var currentLongitude = ""
    var ownerName = ""
    var ownerMobile = ""
    var ownerResidentialDetails = ""
    var engineerName = ""
    var engineerNumber = ""
    var siteName = ""

    
    
    var VM = WorkSiteDetailsVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        NotificationCenter.default.addObserver(self, selector: #selector(handleNavigation), name: Notification.Name.navigateToMain, object: nil)
    }
    @objc func handleNavigation(notification: Notification){
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func workLevelBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_DropDownVC") as! KC_DropDownVC
        vc.itsFrom = "WORKLEVEL"
        vc.delegate = self
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    
    @IBAction func calenderButton(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_DOBVC") as! KC_DOBVC
        vc.isComeFrom = "1"
        vc.delegate = self
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
        
    }
    
    @IBAction func submitBtn(_ sender: Any) {
        if self.strdata1 == ""{
            self.view.makeToast("Please select site image", duration: 2.0, position: .bottom)
        }else if self.currentLatitude == "" || self.currentLongitude == ""{
            self.view.makeToast("Select current location...", duration: 2.0, position: .bottom)
        }else if self.ownerName == ""{
            self.view.makeToast("Enter owner name", duration: 2.0, position: .bottom)
        }else if self.ownerMobile == ""{
            self.view.makeToast("Enter owner mobile number", duration: 2.0, position: .bottom)
        }else if self.ownerResidentialDetails == ""{
            self.view.makeToast("Enter owner residential details", duration: 2.0, position: .bottom)
        }else if self.engineerName == ""{
            self.view.makeToast("Enter engineer name", duration: 2.0, position: .bottom)
        }else if self.engineerNumber == ""{
            self.view.makeToast("Enter engineer mobile number", duration: 2.0, position: .bottom)
        }else if self.selectedWordId == -1{
            self.view.makeToast("Enter owner name", duration: 2.0, position: .bottom)
        }else if self.selectedDate == ""{
            self.view.makeToast("Select tentative date", duration: 2.0, position: .bottom)
        }else if self.remarksTextView.text == ""{
            self.view.makeToast("Enter remarks", duration: 2.0, position: .bottom)
        }else{
            print(self.currentLatitude)
            print(self.currentLongitude)
            print(self.ownerName)
            print(self.ownerMobile)
            print(self.ownerResidentialDetails)
            print(self.engineerName)
            print(self.engineerNumber)
            print(self.siteName)
            let parameter = [
                "SiteName":self.siteName,
                "CustomerID":self.userID,
                "ContactNumber":self.ownerMobile,
                "ContactNumber1":self.engineerNumber,
                "SiteImageURl":self.strdata1,
                "ActorId":self.userID,
                "ActionType":"1",
                "Verification":"1",
                "Address":self.ownerResidentialDetails,
                "TentativeDate": self.selectedDate,
                "Worklevel": self.selectedWordId,
                "AddressLongitude":self.currentLongitude,
                "AddressLatitude":self.currentLatitude,
                "ContactPersonName":self.ownerName,
                "ContactPersonName1":self.engineerName,
                "Remarks":self.remarksTextView.text ?? ""
            ] as [String: Any]
            print(parameter)
            self.VM.workSiteDetailsSubmission(parameter: parameter)

        }
        
        
        
    }
}
