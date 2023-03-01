//
//  KC_EnrollmentListVC.swift
//  KeshavCement
//
//  Created by ADMIN on 13/01/2023.
//

import UIKit
import Kingfisher
class KC_EnrollmentListVC: BaseViewController {

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
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.VM.enrollmentListArray.removeAll()
        self.enrollmentListApi(startIndex: self.startIndex, SearchText: self.searchTF.text ?? "")
    }
    
    @IBAction func backBTn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func searchByEditingDidEnd(_ sender: Any) {
        self.VM.enrollmentListArray.removeAll()
        self.startIndex = 1
        self.enrollmentListApi(startIndex: self.startIndex, SearchText: self.searchTF.text ?? "")
    }
    @IBAction func addCustomerBtn(_ sender: Any) {
        
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_NewEnrollementVC") as! KC_NewEnrollementVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func enrollmentListApi(startIndex: Int, SearchText: String){
        let parameter = [
            "ActionType": 15,
            "ActorId": "\(self.userID)",
            "SearchText": "\(self.searchTF.text ?? "")",
            "StartIndex": self.startIndex,
            "PageSize": 10
        ] as [String: Any]
        print(parameter)
        self.VM.enrollmentListApi(parameter: parameter)
        
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
//        cell.userImage.image = ""
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
                    self.enrollmentListApi(startIndex: self.startIndex, SearchText: self.searchTF.text ?? "")
                }else if self.noofelements > 10{
                    self.startIndex = self.startIndex + 1
                    self.enrollmentListApi(startIndex: self.startIndex, SearchText: self.searchTF.text ?? "")
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
