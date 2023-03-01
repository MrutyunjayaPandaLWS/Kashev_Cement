//
//  KC_MyPurchaseClaimVC.swift
//  KeshavCement
//
//  Created by ADMIN on 03/01/2023.
//

import UIKit

class KC_MyPurchaseClaimVC: BaseViewController, DateSelectedDelegate {
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
    

    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var filterLbl: UILabel!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var purchaseClaimTableView: UITableView!
    @IBOutlet weak var myPurchaseFilterLbl: UILabel!
    @IBOutlet weak var approvedBtn: UIButton!
    @IBOutlet weak var pendingBtn: UIButton!
    @IBOutlet weak var rejectedBtn: UIButton!
    @IBOutlet weak var dateRangeLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    
    @IBOutlet weak var toDateLbl: UILabel!
    @IBOutlet weak var fromDateLbl: UILabel!
    
    @IBOutlet weak var clearBtn: UIButton!
    
    @IBOutlet weak var noDataFoundLbl: UILabel!
    @IBOutlet weak var applyFilter: UIButton!
    
    
    var VM = MyPurchaseClaimListVM()
    var noofelements = 0
    var startIndex = 1
    var selectedStatus = -3
    var selectedFromDate = ""
    var selectedToDate = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.filterView.isHidden = true
        self.purchaseClaimTableView.delegate = self
        self.purchaseClaimTableView.dataSource = self
        self.purchaseClaimTableView.register(UINib(nibName: "KC_MyPurchaseClaimTVC", bundle: nil), forCellReuseIdentifier: "KC_MyPurchaseClaimTVC")
        self.purchaseClaimTableView.separatorStyle = .none
        self.myClaimPurchaseListApi(startIndex: 1, fromDate: "", toDate: "", status: -3)
    }
    
    
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func filterBtn(_ sender: Any) {
        if self.filterView.isHidden == false{
            self.filterView.isHidden = true
        }else{
            self.filterView.isHidden = false
            self.approvedBtn.backgroundColor = UIColor(hexString: "565656")
            self.pendingBtn.backgroundColor = UIColor(hexString: "565656")
            self.rejectedBtn.backgroundColor = UIColor(hexString: "565656")
            
            self.pendingBtn.setTitleColor(.white, for: .normal)
            self.approvedBtn.setTitleColor(.white, for: .normal)
            self.rejectedBtn.setTitleColor(.white, for: .normal)
            self.VM.myPurchaseListArray.removeAll()
            self.myClaimPurchaseListApi(startIndex: 1, fromDate: self.selectedFromDate, toDate: self.selectedToDate, status: -3)
        }
    }
    
    @IBAction func fromDateBtn(_ sender: Any) {
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
    
    @IBAction func applyFilterBtn(_ sender: Any) {
        if self.selectedStatus == -3 && self.selectedFromDate == "" && self.selectedToDate == ""{
            self.view.makeToast("Select any select or date range", duration: 2.0, position: .bottom)
        }else if self.selectedFromDate == "" && self.selectedToDate == "" && self.selectedStatus != -3{
            self.VM.myPurchaseListArray.removeAll()
            self.myClaimPurchaseListApi(startIndex: 1, fromDate: self.selectedFromDate, toDate: self.selectedToDate, status: self.selectedStatus)
        }else if self.selectedFromDate != "" && self.selectedToDate == ""{
            self.view.makeToast("Select To date", duration: 2.0, position: .bottom)
        }else if self.selectedFromDate == "" && self.selectedToDate != ""{
            self.view.makeToast("Select From date", duration: 2.0, position: .bottom)
        }else if self.selectedFromDate != "" && self.selectedToDate != ""{
            if self.selectedFromDate > self.selectedToDate{
                self.view.makeToast("To date shouldn't greater than From date", duration: 2.0, position: .bottom)
            }else{
                self.VM.myPurchaseListArray.removeAll()
                self.myClaimPurchaseListApi(startIndex: 1, fromDate: self.selectedFromDate, toDate: self.selectedToDate, status: self.selectedStatus)
                //DispatchQueue.main.asyncAfter(deadline: .now()+0.9, execute: {
                    self.filterView.isHidden = true
                //}
           // )
            }
        }
    }
    
    @IBAction func clearBtn(_ sender: Any) {
        self.approvedBtn.backgroundColor = UIColor(hexString: "565656")
        self.pendingBtn.backgroundColor = UIColor(hexString: "565656")
        self.rejectedBtn.backgroundColor = UIColor(hexString: "565656")
        
        self.pendingBtn.setTitleColor(.white, for: .normal)
        self.approvedBtn.setTitleColor(.white, for: .normal)
        self.rejectedBtn.setTitleColor(.white, for: .normal)
        self.VM.myPurchaseListArray.removeAll()
        self.selectedStatus = -3
        self.fromDateLbl.text = "From Date"
        self.toDateLbl.text = "To Date"
        self.myClaimPurchaseListApi(startIndex: 1, fromDate: "", toDate: "", status: -3)
    }
    @IBAction func closeBtn(_ sender: Any) {
            self.filterView.isHidden = true
    }
    
    @IBAction func approvedButton(_ sender: Any) {
        self.approvedBtn.backgroundColor = UIColor(hexString: "FFFC9C")
        self.pendingBtn.backgroundColor = UIColor(hexString: "565656")
        self.rejectedBtn.backgroundColor = UIColor(hexString: "565656")
        
        self.pendingBtn.setTitleColor(.white, for: .normal)
        self.approvedBtn.setTitleColor(.darkGray, for: .normal)
        self.rejectedBtn.setTitleColor(.white, for: .normal)
        self.selectedStatus = 1
        self.VM.myPurchaseListArray.removeAll()
        self.myClaimPurchaseListApi(startIndex: 1, fromDate: self.selectedFromDate, toDate: self.selectedToDate, status: self.selectedStatus)
    }
    
    @IBAction func pendingButton(_ sender: Any) {
        self.approvedBtn.backgroundColor = UIColor(hexString: "565656")
        self.pendingBtn.backgroundColor = UIColor(hexString: "FFFC9C")
        
        self.rejectedBtn.backgroundColor = UIColor(hexString: "565656")
        self.approvedBtn.setTitleColor(.white, for: .normal)
        self.pendingBtn.setTitleColor(.darkGray, for: .normal)
        self.rejectedBtn.setTitleColor(.white, for: .normal)
        self.VM.myPurchaseListArray.removeAll()
        self.selectedStatus = 0
        self.myClaimPurchaseListApi(startIndex: 1, fromDate: self.selectedFromDate, toDate: self.selectedToDate, status: self.selectedStatus)
    }
    
    @IBAction func rejectedButton(_ sender: Any) {
        self.approvedBtn.backgroundColor = UIColor(hexString: "565656")
        self.pendingBtn.backgroundColor = UIColor(hexString: "565656")
        self.rejectedBtn.backgroundColor = UIColor(hexString: "FFFC9C")
        
        self.approvedBtn.setTitleColor(.white, for: .normal)
        self.rejectedBtn.setTitleColor(.darkGray, for: .normal)
        self.pendingBtn.setTitleColor(.white, for: .normal)
        self.selectedStatus = -1
        self.VM.myPurchaseListArray.removeAll()
        self.myClaimPurchaseListApi(startIndex: 1, fromDate: self.selectedFromDate, toDate: self.selectedToDate, status: self.selectedStatus)
    }
    
    func myClaimPurchaseListApi(startIndex: Int, fromDate: String, toDate: String, status: Int){
        let parameter = [
            "ActionType": 6,
            "ActiveStatus": status,
            "FromDate": fromDate,
            "PageSize": 20,
            "SalesPersonId": self.loyaltyId,
            "StartIndex": startIndex,
            "ToDate": toDate
        ] as [String: Any]
        print(parameter)
        self.VM.myPurchaseClaimListApi(parameter: parameter)
    }
    
}
extension KC_MyPurchaseClaimVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VM.myPurchaseListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "KC_MyPurchaseClaimTVC", for: indexPath) as! KC_MyPurchaseClaimTVC
        cell.selectionStyle = .none
        cell.createdDateLbl.text = self.VM.myPurchaseListArray[indexPath.row].createdDate ?? "-"
        cell.categoryLbl.text = self.VM.myPurchaseListArray[indexPath.row].customer_Type ?? ""
        cell.requestedToLbl.text = self.VM.myPurchaseListArray[indexPath.row].requestTo ?? ""
        cell.productNameLbl.text = self.VM.myPurchaseListArray[indexPath.row].productName ?? ""
        cell.orderQtyLbl.text = String(self.VM.myPurchaseListArray[indexPath.row].quantity ?? 0.0)
        cell.approvedQTYLbl.text = "\(self.VM.myPurchaseListArray[indexPath.row].approvedQuantity ?? "0.0")"
        cell.remarks.text = self.VM.myPurchaseListArray[indexPath.row].claimedRemarks ?? "-"
        
        let status = self.VM.myPurchaseListArray[indexPath.row].status ?? ""
        cell.statusLbl.setTitle(status, for: .normal)
        if self.VM.myPurchaseListArray[indexPath.row].status ?? "" == "Approved"{
            cell.approvedQTYHeightConstraint.constant = CGFloat(50)
            cell.approvedQTYView.isHidden = false
        }else if self.VM.myPurchaseListArray[indexPath.row].status ?? "" == "Pending"{
            cell.approvedQTYHeightConstraint.constant = CGFloat(0)
            cell.approvedQTYView.isHidden = true
        }else if self.VM.myPurchaseListArray[indexPath.row].status ?? "" == "Rejected"{
            cell.approvedQTYHeightConstraint.constant = CGFloat(0)
            cell.approvedQTYView.isHidden = true
        }else{
            cell.approvedQTYHeightConstraint.constant = CGFloat(0)
            cell.approvedQTYView.isHidden = true
        }
    
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       
            if indexPath.row == self.VM.myPurchaseListArray.count - 1{
                if self.noofelements == 10{
                    self.startIndex = self.startIndex + 1
                    self.myClaimPurchaseListApi(startIndex: self.startIndex, fromDate: self.selectedFromDate, toDate: self.selectedToDate, status: self.selectedStatus)
                }else if self.noofelements > 10{
                    self.startIndex = self.startIndex + 1
                    self.myClaimPurchaseListApi(startIndex: self.startIndex, fromDate: self.selectedFromDate, toDate: self.selectedToDate, status: self.selectedStatus)
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
