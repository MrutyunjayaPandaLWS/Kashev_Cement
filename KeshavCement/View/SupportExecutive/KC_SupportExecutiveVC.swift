//
//  KC_SupportExecutiveVC.swift
//  KeshavCement
//
//  Created by ADMIN on 13/01/2023.
//

import UIKit

class KC_SupportExecutiveVC: BaseViewController, ChangeStatusDelegate {
    func didTapChangeStatus(_ cell: KC_SupporteExecutiveTVC) {
        guard let tappedIndexPath = self.supportExecutiveTableView.indexPath(for: cell) else{return}
        if cell.statusBtn.tag == tappedIndexPath.row{
            
            if self.VM.supportExecutiveListArray[tappedIndexPath.row].isActive ?? -1 == 1{
                self.changeStatusApi(customerId: self.VM.supportExecutiveListArray[tappedIndexPath.row].userID ?? -1, active: "false")
            }else{
                self.changeStatusApi(customerId: self.VM.supportExecutiveListArray[tappedIndexPath.row].userID ?? -1, active: "true")
            }
            
        }
    }
    

    @IBOutlet weak var createNewLbl: UILabel!
    
    @IBOutlet weak var supportExecutiveLbl: UILabel!
    @IBOutlet weak var supportExecutiveTableView: UITableView!
    
    @IBOutlet weak var noDataFoundLbl: UILabel!
    
    var startIndex = 1
    var noofelements = 0
    
    var VM = KC_SupportExecutiveVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.supportExecutiveTableView.delegate = self
        self.supportExecutiveTableView.dataSource = self
        self.noDataFoundLbl.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(navigateToPrevious), name: Notification.Name.callApi, object: nil)
        
    }
    
    @objc func navigateToPrevious(){
        self.VM.supportExecutiveListArray.removeAll()
        self.supportExecutiveListApi(startIndex: 1)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.VM.supportExecutiveListArray.removeAll()
        self.supportExecutiveListApi(startIndex: 1)
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func createNewBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_CreateNewSupportExecutiveVC") as! KC_CreateNewSupportExecutiveVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func supportExecutiveListApi(startIndex: Int){
        let parameter = [
            "ActionType": 17,
            "ActorId": self.userID,
              "StartIndex": startIndex,
              "PageSize": 10
        ] as [String: Any]
        self.VM.supportExecutiveListApi(parameter: parameter)
    }
    
    func changeStatusApi(customerId: Int, active: String){
        let parameter = [
            "ActionType": "5",
            "userid": "\(self.userID)",
            "CustomerId": customerId,
            "IsActive": active
        ] as [String: Any]
        self.VM.deactivateExecutiveApi(parameter: parameter)
    }
    
    
}
extension KC_SupportExecutiveVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VM.supportExecutiveListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "KC_SupporteExecutiveTVC", for: indexPath) as! KC_SupporteExecutiveTVC
        cell.selectionStyle = .none
        cell.delegate = self
        cell.titleLbl.text = self.VM.supportExecutiveListArray[indexPath.row].firstName ?? ""
        cell.mobileNumber.text = self.VM.supportExecutiveListArray[indexPath.row].mobile ?? ""
        cell.memberShipId.text = self.VM.supportExecutiveListArray[indexPath.row].loyaltyID ?? ""
        if self.VM.supportExecutiveListArray[indexPath.row].isActive ?? -1 == 1{
            cell.queryStatusLbl.text = "Deactivate"
            cell.statusLbl.text = "Active"
            cell.statusImage.image = UIImage(named: "Group-11")
            cell.queryStatusLbl.textColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
            cell.queryStatusLbl.backgroundColor = #colorLiteral(red: 0.9895376563, green: 0.935413897, blue: 0.936383009, alpha: 1)
        }else{
            cell.queryStatusLbl.text = "Activate"
            cell.statusLbl.text = "In-Active"
            cell.statusImage.image = UIImage(named: "promotions")
            cell.queryStatusLbl.textColor = #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)
            cell.queryStatusLbl.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        }
        cell.statusBtn.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            if indexPath.row == self.VM.supportExecutiveListArray.count - 1{
                if self.noofelements == 10{
                    self.startIndex = self.startIndex + 1
                    self.supportExecutiveListApi(startIndex: self.startIndex)
                }else if self.noofelements > 10{
                    self.startIndex = self.startIndex + 1
                    self.supportExecutiveListApi(startIndex: self.startIndex)
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
