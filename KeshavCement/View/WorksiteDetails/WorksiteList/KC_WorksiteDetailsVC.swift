//
//  KC_WorksiteDetailsVC.swift
//  KeshavCement
//
//  Created by ADMIN on 03/01/2023.
//

import UIKit

class KC_WorksiteDetailsVC: BaseViewController , DateSelectedDelegate {
    func acceptDate(_ vc: KC_DOBVC) {
        if vc.isComeFrom == "1"{
            self.selectedFromDate = vc.selectedDate
            self.fromDateLbl.text = vc.selectedDate
        }else{
            self.selectedToDate = vc.selectedDate
            self.toDateLbl.text = vc.selectedDate
        }
    }
    
    func declineDate(_ vc: KC_DOBVC) {}
    
    
    @IBOutlet weak var noDataFoundLbl: UILabel!
    @IBOutlet weak var createNewView: UIView!
    @IBOutlet weak var toDateLbl: UILabel!
    @IBOutlet weak var fromDateLbl: UILabel!
    @IBOutlet weak var clearBtn: UIButton!
    @IBOutlet weak var applyFilterBtn: UIButton!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var createNewLbl: UILabel!
    @IBOutlet weak var worksiteDetailsTableView: UITableView!
    @IBOutlet weak var filterLbl: UILabel!
    @IBOutlet weak var headerLbl: UILabel!
    
    @IBOutlet weak var selectFromDateLbl: UILabel!
    @IBOutlet weak var rejectedBtn: UIButton!
    
    @IBOutlet weak var dateRangeLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var worksiteDetailsFilter: UILabel!
    
    @IBOutlet weak var selectToDateLbl: UILabel!
    @IBOutlet weak var PendingBtn: UIButton!
    @IBOutlet weak var approvedBtn: UIButton!
    
    var VM = WorksiteListVM()
    var noofelements = 0
    var startIndex = 1
    var selectedStatus = -3
    var selectedFromDate = ""
    var selectedToDate = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.noDataFoundLbl.isHidden = true
        self.filterView.isHidden = true
        self.worksiteDetailsTableView.delegate = self
        self.worksiteDetailsTableView.dataSource = self
        self.worksiteDetailsTableView.separatorStyle = .none
        self.worksiteDetailsTableView.register(UINib(nibName: "KC_WorksiteDetailsTVC", bundle: nil), forCellReuseIdentifier: "KC_WorksiteDetailsTVC")
     
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.startIndex = 1
        self.selectedStatus = -3
        self.worksitListApi(Status: self.selectedStatus, StartIndex: self.startIndex, FromDate: "", ToDate: "")
    }
    
    @IBAction func createNewBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_WorkSiteListDetailsVC") as! KC_WorkSiteListDetailsVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func filterBtn(_ sender: Any) {
        if self.filterView.isHidden == false{
            self.filterView.isHidden = true
            self.createNewView.isHidden = false
        }else{
            self.filterView.isHidden = false
            self.createNewView.isHidden = true
            self.approvedBtn.backgroundColor = UIColor(hexString: "565656")
            self.PendingBtn.backgroundColor = UIColor(hexString: "565656")
            self.rejectedBtn.backgroundColor = UIColor(hexString: "565656")
            
            self.PendingBtn.setTitleColor(.white, for: .normal)
            self.approvedBtn.setTitleColor(.white, for: .normal)
            self.rejectedBtn.setTitleColor(.white, for: .normal)
//            self.VM.myPurchaseListArray.removeAll()
//            self.myClaimPurchaseListApi(startIndex: 1, fromDate: self.selectedFromDate, toDate: self.selectedToDate, status: -3)
        }
    }
    @IBAction func backBTn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func closeBtn(_ sender: Any) {
        self.filterView.isHidden = true
        self.createNewView.isHidden = false
}
    @IBAction func applyFilter(_ sender: Any) {
        if self.selectedStatus == -3 && self.selectedFromDate == "" && self.selectedToDate == ""{
            self.view.makeToast("Select any select or date range", duration: 2.0, position: .bottom)
        }else if self.selectedFromDate == "" && self.selectedToDate == "" && self.selectedStatus != -3{
//            self.VM.myPurchaseListArray.removeAll()
//            self.myClaimPurchaseListApi(startIndex: 1, fromDate: self.selectedFromDate, toDate: self.selectedToDate, status: self.selectedStatus)
        }else if self.selectedFromDate != "" && self.selectedToDate == ""{
            self.view.makeToast("Select To date", duration: 2.0, position: .bottom)
        }else if self.selectedFromDate == "" && self.selectedToDate != ""{
            self.view.makeToast("Select From date", duration: 2.0, position: .bottom)
        }else if self.selectedFromDate != "" && self.selectedToDate != ""{
            if self.selectedFromDate > self.selectedToDate{
                self.view.makeToast("To date shouldn't greater than From date", duration: 2.0, position: .bottom)
            }else{
                self.VM.workSiteListArray.removeAll()
                self.startIndex = 1
                self.worksitListApi(Status: self.selectedStatus, StartIndex: self.startIndex, FromDate: self.selectedFromDate, ToDate: self.selectedToDate)
                self.filterView.isHidden = true
                self.createNewView.isHidden = false
                //}
           // )
            }
        }
    }
    
    @IBAction func clearBtn(_ sender: Any) {
        self.approvedBtn.backgroundColor = UIColor(hexString: "565656")
        self.PendingBtn.backgroundColor = UIColor(hexString: "565656")
        self.rejectedBtn.backgroundColor = UIColor(hexString: "565656")
        self.PendingBtn.setTitleColor(.white, for: .normal)
        self.approvedBtn.setTitleColor(.white, for: .normal)
        self.rejectedBtn.setTitleColor(.white, for: .normal)
       self.selectedStatus = -3
        self.fromDateLbl.text = "From Date"
        self.toDateLbl.text = "To Date"
        self.selectedFromDate = ""
        self.selectedToDate = ""
        self.startIndex = 1
        self.VM.workSiteListArray.removeAll()
        self.worksitListApi(Status: self.selectedStatus, StartIndex: self.startIndex, FromDate: self.selectedFromDate, ToDate: self.selectedToDate)
    }
    
    @IBAction func fromDatebtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_DOBVC") as! KC_DOBVC
        vc.isComeFrom = "1"
        vc.delegate = self
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
        
    }
    
    @IBAction func toDateBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_DOBVC") as! KC_DOBVC
        vc.isComeFrom = "2"
        vc.delegate = self
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    @IBAction func approvedButton(_ sender: Any) {
        self.approvedBtn.backgroundColor = UIColor(hexString: "FFFC9C")
        self.PendingBtn.backgroundColor = UIColor(hexString: "565656")
        self.rejectedBtn.backgroundColor = UIColor(hexString: "565656")
        
        self.PendingBtn.setTitleColor(.white, for: .normal)
        self.approvedBtn.setTitleColor(.darkGray, for: .normal)
        self.rejectedBtn.setTitleColor(.white, for: .normal)
        self.selectedStatus = 1
        self.startIndex = 1
        self.VM.workSiteListArray.removeAll()
        self.worksitListApi(Status: self.selectedStatus, StartIndex: self.startIndex, FromDate: self.selectedFromDate, ToDate: self.selectedToDate)
    }
    
    @IBAction func pendingButton(_ sender: Any) {
        self.approvedBtn.backgroundColor = UIColor(hexString: "565656")
        self.PendingBtn.backgroundColor = UIColor(hexString: "FFFC9C")
        
        self.rejectedBtn.backgroundColor = UIColor(hexString: "565656")
        self.approvedBtn.setTitleColor(.white, for: .normal)
        self.PendingBtn.setTitleColor(.darkGray, for: .normal)
        self.rejectedBtn.setTitleColor(.white, for: .normal)
        
        self.selectedStatus = 0
        self.startIndex = 1
        self.VM.workSiteListArray.removeAll()
        self.worksitListApi(Status: self.selectedStatus, StartIndex: self.startIndex, FromDate: self.selectedFromDate, ToDate: self.selectedToDate)
    }
    
    @IBAction func rejectedButton(_ sender: Any) {
        self.approvedBtn.backgroundColor = UIColor(hexString: "565656")
        self.PendingBtn.backgroundColor = UIColor(hexString: "565656")
        self.rejectedBtn.backgroundColor = UIColor(hexString: "FFFC9C")
        
        self.approvedBtn.setTitleColor(.white, for: .normal)
        self.rejectedBtn.setTitleColor(.darkGray, for: .normal)
        self.PendingBtn.setTitleColor(.white, for: .normal)
        self.selectedStatus = -1
        self.startIndex = 1
        self.VM.workSiteListArray.removeAll()
        self.worksitListApi(Status: self.selectedStatus, StartIndex: self.startIndex, FromDate: self.selectedFromDate, ToDate: self.selectedToDate)
    }
    
    
    func worksitListApi(Status: Int, StartIndex: Int, FromDate: String, ToDate: String){
        let parameter = [
            "ActionType":2,
            "CustomerID":self.userID,
            "ActiveStatus": Status,
            "PageSize": "10",
            "StartIndex": StartIndex,
            "FromDate": FromDate,
            "ToDate": ToDate
        ] as [String: Any]
        print(parameter)
        self.VM.worksiteListApi(parameter: parameter)
    }
}
extension KC_WorksiteDetailsVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VM.workSiteListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "KC_WorksiteDetailsTVC", for: indexPath) as! KC_WorksiteDetailsTVC
        cell.selectionStyle = .none
        cell.statusLbl.text = self.VM.workSiteListArray[indexPath.row].verificationStatus ?? ""
        cell.createdDateLbl.text = self.VM.workSiteListArray[indexPath.row].createdDate ?? ""
        cell.locationLbl.text = self.VM.workSiteListArray[indexPath.row].siteName ?? "-"
        if self.VM.workSiteListArray[indexPath.row].siteName ?? "-" == ""{
            cell.ownerNametopSpaceConstraint.constant = 35
        }
        cell.ownerName.text = self.VM.workSiteListArray[indexPath.row].contactPersonName ?? ""
        cell.ownerMobileLbl.text = self.VM.workSiteListArray[indexPath.row].contactNumber ?? ""
        cell.ownerResidentDetails.text = self.VM.workSiteListArray[indexPath.row].address ?? ""
        cell.engineerName.text = self.VM.workSiteListArray[indexPath.row].contactPersonName1 ?? ""
        cell.engineerMobileLbl.text = self.VM.workSiteListArray[indexPath.row].contactNumber1 ?? ""
        cell.workLevel.text = self.VM.workSiteListArray[indexPath.row].worklevel ?? ""
        cell.tentativeDate.text = self.VM.workSiteListArray[indexPath.row].tentativeDate ?? ""
        cell.remarks.text = self.VM.workSiteListArray[indexPath.row].remarks ?? ""
        return cell
        
    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 360
//    }
//
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       
            if indexPath.row == self.VM.workSiteListArray.count - 1{
                if self.noofelements == 10{
                    self.startIndex = self.startIndex + 1
                    self.worksitListApi(Status: self.selectedStatus, StartIndex: self.startIndex, FromDate: self.selectedFromDate, ToDate: self.selectedToDate)
                }else if self.noofelements > 10{
                    self.startIndex = self.startIndex + 1
                    self.worksitListApi(Status: self.selectedStatus, StartIndex: self.startIndex, FromDate: self.selectedFromDate, ToDate: self.selectedToDate)
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
