//
//  KC_EnrollmentListVC.swift
//  KeshavCement
//
//  Created by ADMIN on 13/01/2023.
//

import UIKit
import Kingfisher
import LanguageManager_iOS
class KC_EnrollmentListVC: BaseViewController, DialPadDelegate {
  
    

    @IBOutlet weak var addCustomerLbl: UILabel!
    @IBOutlet weak var noDataFoundLbl: UILabel!
    @IBOutlet weak var enrollmentListTableView: UITableView!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var headerTextLbl: UILabel!
    var VM = KC_EnrollmentVM()
    var noofelements = 0
    var startIndex = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.enrollmentListTableView.delegate = self
        self.enrollmentListTableView.dataSource = self
        self.headerTextLbl.text = "Enrollment".localiz()
        self.searchTF.placeholder = "Searchbyname/mobilenumber".localiz()
        self.addCustomerLbl.text = "AddCustomer".localiz()
        self.noDataFoundLbl.text = "NoDataFound".localiz()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.VM.enrollmentListArray.removeAll()
        if self.customerTypeId == "5"{
            self.enrollmentListApi(startIndex: self.startIndex, SearchText: self.searchTF.text ?? "", userID: String(UserDefaults.standard.string(forKey: "mappedCustomerId") ?? ""))
        }else{
            self.enrollmentListApi(startIndex: self.startIndex, SearchText: self.searchTF.text ?? "", userID: self.userID)
        }
        
    }
    
    @IBAction func backBTn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func searchByEditingDidEnd(_ sender: Any) {
        self.VM.enrollmentListArray.removeAll()
        self.startIndex = 1
        if self.customerTypeId == "5"{
            self.enrollmentListApi(startIndex: self.startIndex, SearchText: self.searchTF.text ?? "", userID: String(UserDefaults.standard.string(forKey: "mappedCustomerId") ?? ""))
        }else{
            self.enrollmentListApi(startIndex: self.startIndex, SearchText: self.searchTF.text ?? "", userID: self.userID)
        }
    }
    @IBAction func addCustomerBtn(_ sender: Any) {
        
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_NewEnrollementVC") as! KC_NewEnrollementVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func enrollmentListApi(startIndex: Int, SearchText: String, userID: String){
        let parameter = [
            "ActionType": 15,
            "ActorId": userID,
            "SearchText": "\(self.searchTF.text ?? "")",
            "StartIndex": self.startIndex,
            "PageSize": 10
        ] as [String: Any]
        print(parameter)
        self.VM.enrollmentListApi(parameter: parameter)
        
    }
    
    // Delegate: -
    func didTapDialPad(_ cell: KC_NewEnrollmentTVC) {
        guard let tappedIndexpath = self.enrollmentListTableView.indexPath(for: cell) else{return}
        
        if cell.dialPadBtn.tag == tappedIndexpath.row{
            if let phoneCallURL = URL(string: "tel://\(self.VM.enrollmentListArray[tappedIndexpath.row].mobile ?? "")") {
                
                let application:UIApplication = UIApplication.shared
                if (application.canOpenURL(phoneCallURL)) {
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                    
                }
            }
        }
        
    }
}
extension KC_EnrollmentListVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VM.enrollmentListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "KC_NewEnrollmentTVC", for: indexPath) as! KC_NewEnrollmentTVC
        cell.selectionStyle = .none
        cell.categoryLbl.text = self.VM.enrollmentListArray[indexPath.row].customerType ?? ""
        cell.delegate = self
        cell.dialPadBtn.tag = indexPath.row
        if self.VM.enrollmentListArray[indexPath.row].customerImage ?? "" != ""{
            
            let receivedImage = String(self.VM.enrollmentListArray[indexPath.row].customerImage ?? "").dropFirst(1)
            let userImage = URL(string: "\(PROMO_IMG1)\(receivedImage)")
            cell.userImage.kf.setImage(with: userImage, placeholder: UIImage(named: "ic_default_img"))
            
        }else{
            cell.userImage.image = UIImage(named: "ic_default_img")
        }
        
        
        cell.ptslbl.text = "\(self.VM.enrollmentListArray[indexPath.row].totalPointsBalance ?? 0)"
        cell.userNameLbl.text = self.VM.enrollmentListArray[indexPath.row].firstName ?? ""
        cell.mobileLbl.text = self.VM.enrollmentListArray[indexPath.row].mobile ?? ""
        cell.membershipIdLbl.text = self.VM.enrollmentListArray[indexPath.row].loyaltyID ?? ""
        cell.lastPurchaseDateLbl.text = self.VM.enrollmentListArray[indexPath.row].lastPurchaseDate ?? ""
        cell.lastRedemptionDateLbl.text = self.VM.enrollmentListArray[indexPath.row].lastRedemptionDate ?? ""
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView == enrollmentListTableView{
            if indexPath.row == self.VM.enrollmentListArray.count - 1{
                if self.noofelements == 10{
                    self.startIndex = self.startIndex + 1
                    if self.customerTypeId == "5"{
                        self.enrollmentListApi(startIndex: self.startIndex, SearchText: self.searchTF.text ?? "", userID: String(UserDefaults.standard.string(forKey: "mappedCustomerId") ?? ""))
                    }else{
                        self.enrollmentListApi(startIndex: self.startIndex, SearchText: self.searchTF.text ?? "", userID: self.userID)
                    }
                }else if self.noofelements > 10{
                    self.startIndex = self.startIndex + 1
                    if self.customerTypeId == "5"{
                        self.enrollmentListApi(startIndex: self.startIndex, SearchText: self.searchTF.text ?? "", userID: String(UserDefaults.standard.string(forKey: "mappedCustomerId") ?? ""))
                    }else{
                        self.enrollmentListApi(startIndex: self.startIndex, SearchText: self.searchTF.text ?? "", userID: self.userID)
                    }
                }else if self.noofelements < 10{
                    print("no need to hit API")
                    return
                }else{
                    print("n0 more elements")
                    return
                }
            }
        }
    }
    
    
    
}
