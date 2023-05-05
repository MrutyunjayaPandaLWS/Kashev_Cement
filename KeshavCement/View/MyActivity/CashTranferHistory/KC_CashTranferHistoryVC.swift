//
//  KC_CashTranferHistoryVC.swift
//  KeshavCement
//
//  Created by ADMIN on 13/01/2023.
//

import UIKit
import LanguageManager_iOS

class KC_CashTranferHistoryVC: BaseViewController, DateSelectedDelegate {
    func acceptDate(_ vc: KC_DOBVC) {
        if vc.isComeFrom == "1"{
            self.selectedFromDate = vc.selectedDate
            self.selectFromDateLbl.text = vc.selectedDate
        }else{
            self.selectedToDate = vc.selectedDate
            self.selectToDateLbl.text = vc.selectedDate
        }
    }
    
    func declineDate(_ vc: KC_DOBVC) {}
    
    @IBOutlet weak var cashHistoryTableView: UITableView!
    @IBOutlet weak var statusLbl: UILabel!
    
    @IBOutlet weak var approvedBtn: UIButton!
    
    @IBOutlet weak var pendingBtn: UIButton!
    
    @IBOutlet weak var rejectButton: UIButton!
    
    @IBOutlet weak var applyFilterButton: UIButton!
    @IBOutlet weak var dateRangeLbl: UILabel!
    @IBOutlet weak var customerTypeLbl: UILabel!
    @IBOutlet weak var cashTransferFilterLbl: UILabel!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var filterLbl: UILabel!
    @IBOutlet weak var headerTextLbl: UILabel!
    
    @IBOutlet weak var filterButtonView: UIView!
    @IBOutlet weak var selectFromDateLbl: UILabel!
    
    @IBOutlet weak var selectToDateLbl: UILabel!
    @IBOutlet weak var noDataFoundLbl: UILabel!
    
    @IBOutlet weak var subDealerBtn: UIButton!
    
    @IBOutlet weak var clearButton: UIButton!
    
    @IBOutlet weak var masonBtn: UIButton!
    @IBOutlet weak var engineerButton: UIButton!
    
    
    var noofelements = 0
    var startIndex = 1
    var selectedStatus = ""
    var selectedFromDate = ""
    var selectedToDate = ""
    var VM = KC_CashTransferHistoryVM()
    var selectedCustomerTypeID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.noDataFoundLbl.isHidden = true
        self.VM.VC = self
        
        self.filterView.isHidden = true
        self.cashHistoryTableView.delegate = self
        self.cashHistoryTableView.dataSource = self
        self.cashHistoryTableView.isHidden = true
        self.selectFromDateLbl.text = "SelectFromDate".localiz()
        self.selectToDateLbl.text = "SelectToDate".localiz()
        self.headerTextLbl.text = "CashHistory".localiz()
        self.filterLbl.text = "Filter".localiz()
        self.cashTransferFilterLbl.text = "CashTransferFilter".localiz()
        self.customerTypeLbl.text = "CustomerType".localiz()
        self.engineerButton.setTitle("Engineer".localiz(), for: .normal)
        self.masonBtn.setTitle("Mason".localiz(), for: .normal)
        self.statusLbl.text = "Status".localiz()
        self.approvedBtn.setTitle("Approved".localiz(), for: .normal)
        self.rejectButton.setTitle("Rejected".localiz(), for: .normal)
        self.dateRangeLbl.text = "DateRange".localiz()
        self.selectFromDateLbl.text = "SelectFromDate".localiz()
        self.selectToDateLbl.text = "SelectToDate".localiz()
        self.clearButton.setTitle("Clear".localiz(), for: .normal)
        self.applyFilterButton.setTitle("ApplyFilter".localiz(), for: .normal)
        self.cashTransferListApi(startIndex: 1, status: "", fromDate: "", toDate: "", customerTypeId: "")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.customerTypeId == "4"{
            self.subDealerBtn.isHidden = true
        }else{
            self.subDealerBtn.isHidden = false
        }
    }

    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func filterBtn(_ sender: Any) {
        if self.filterView.isHidden == false{
            self.filterView.isHidden = true
        }else{
            self.filterView.isHidden = false
//            self.filterView.isHidden = false
//            self.approvedBtn.backgroundColor = UIColor(hexString: "565656")
//            self.pendingBtn.backgroundColor = UIColor(hexString: "565656")
//            self.rejectButton.backgroundColor = UIColor(hexString: "565656")
            
//            self.pendingBtn.setTitleColor(.white, for: .normal)
//            self.approvedBtn.setTitleColor(.white, for: .normal)
//            self.rejectButton.setTitleColor(.white, for: .normal)
            self.VM.cashTransferApprovalListingArray.removeAll()
            self.cashTransferListApi(startIndex: 1, status: "", fromDate: "", toDate: "", customerTypeId: self.selectedCustomerTypeID)
        }
    }
    
    @IBAction func closeBtn(_ sender: Any) {
        self.filterView.isHidden = true
    }
    
    @IBAction func apprveBtn(_ sender: Any) {
        self.approvedBtn.backgroundColor = UIColor(hexString: "FFFC9C")
        self.pendingBtn.backgroundColor = UIColor(hexString: "565656")
        self.rejectButton.backgroundColor = UIColor(hexString: "565656")
        
        self.pendingBtn.setTitleColor(.white, for: .normal)
        self.approvedBtn.setTitleColor(.darkGray, for: .normal)
        self.rejectButton.setTitleColor(.white, for: .normal)
        self.selectedStatus = "1"
        self.VM.cashTransferApprovalListingArray.removeAll()
//        self.cashTransferListApi(startIndex: 1, status: self.selectedStatus, fromDate: self.selectedFromDate, toDate: self.selectedToDate, customerTypeId: self.selectedCustomerTypeID)
    }
    
    @IBAction func pendinButton(_ sender: Any) {
//        self.approvedBtn.backgroundColor = UIColor(hexString: "565656")
//        self.pendingBtn.backgroundColor = UIColor(hexString: "FFFC9C")
//
//        self.rejectButton.backgroundColor = UIColor(hexString: "565656")
//        self.approvedBtn.setTitleColor(.white, for: .normal)
//        self.pendingBtn.setTitleColor(.darkGray, for: .normal)
//        self.rejectButton.setTitleColor(.white, for: .normal)
//        self.selectedStatus = "0"

    }
    @IBAction func rejeectBtn(_ sender: Any) {
        self.approvedBtn.backgroundColor = UIColor(hexString: "565656")
        self.pendingBtn.backgroundColor = UIColor(hexString: "565656")
        self.rejectButton.backgroundColor = UIColor(hexString: "FFFC9C")
        
        self.approvedBtn.setTitleColor(.white, for: .normal)
        self.rejectButton.setTitleColor(.darkGray, for: .normal)
        self.pendingBtn.setTitleColor(.white, for: .normal)
        self.selectedStatus = "-1"
//        self.VM.cashTransferApprovalListingArray.removeAll()
//        self.cashTransferListApi(startIndex: 1, status: self.selectedStatus, fromDate: self.selectedFromDate, toDate: self.selectedToDate, customerTypeId: self.selectedCustomerTypeID)
    }
    
    
    @IBAction func selectFromDateBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_DOBVC") as! KC_DOBVC
        vc.isComeFrom = "1"
        vc.delegate = self
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
        
    }
    @IBAction func selectToDateBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_DOBVC") as! KC_DOBVC
        vc.isComeFrom = "2"
        vc.delegate = self
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    
    
    @IBAction func clearBtn(_ sender: Any) {
        self.approvedBtn.backgroundColor = UIColor(hexString: "565656")
        self.pendingBtn.backgroundColor = UIColor(hexString: "565656")
        self.rejectButton.backgroundColor = UIColor(hexString: "565656")
        
        self.subDealerBtn.backgroundColor = UIColor(hexString: "565656")
        self.engineerButton.backgroundColor = UIColor(hexString: "565656")
        self.masonBtn.backgroundColor = UIColor(hexString: "565656")
        
        self.subDealerBtn.setTitleColor(.white, for: .normal)
        self.engineerButton.setTitleColor(.white, for: .normal)
        self.masonBtn.setTitleColor(.white, for: .normal)
        
        self.pendingBtn.setTitleColor(.white, for: .normal)
        self.approvedBtn.setTitleColor(.white, for: .normal)
        self.rejectButton.setTitleColor(.white, for: .normal)
        self.selectedStatus = ""
        self.selectFromDateLbl.text = "SelectFromDate".localiz()
        self.selectToDateLbl.text = "SelectToDate".localiz()
        self.VM.cashTransferApprovalListingArray.removeAll()
        self.selectedCustomerTypeID = ""
        self.cashTransferListApi(startIndex: 1, status: self.selectedStatus, fromDate: self.selectedFromDate, toDate: self.selectedToDate, customerTypeId: self.selectedCustomerTypeID)
            self.filterView.isHidden = true
    }
    
    @IBAction func applyFilterBtn(_ sender: Any) {
        print(self.selectedCustomerTypeID)
        print(self.selectedStatus)
        print(self.selectedFromDate)
        print(self.selectedToDate)
        if self.selectedStatus == "" && self.selectedFromDate == "" && self.selectedToDate == "" && self.selectedCustomerTypeID == ""{
            self.view.makeToast("Selectanyselectordaterange".localiz(), duration: 2.0, position: .center)
        }else if self.selectedFromDate == "" && self.selectedToDate == "" && self.selectedStatus != "" || self.selectedCustomerTypeID != ""{
            self.VM.cashTransferApprovalListingArray.removeAll()
            self.filterView.isHidden = true
            self.cashTransferListApi(startIndex: 1, status: self.selectedStatus, fromDate: self.selectedFromDate, toDate: self.selectedToDate, customerTypeId: self.selectedCustomerTypeID)
            
        }else if self.selectedFromDate != "" && self.selectedToDate == ""{
            self.view.makeToast("SelectToDate".localiz(), duration: 2.0, position: .center)
        }else if self.selectedFromDate == "" && self.selectedToDate != ""{
            self.view.makeToast("SelectFromDate".localiz(), duration: 2.0, position: .center)
        }else if self.selectedFromDate != "" && self.selectedToDate != ""{
            if self.selectedFromDate > self.selectedToDate{
                self.view.makeToast("TodateshouldntgreaterthanFromdate".localiz(), duration: 2.0, position: .center)
            }else{
                self.VM.cashTransferApprovalListingArray.removeAll()
                self.cashTransferListApi(startIndex: 1, status: self.selectedStatus, fromDate: self.selectedFromDate, toDate: self.selectedToDate, customerTypeId: self.selectedCustomerTypeID)
                    self.filterView.isHidden = true
            }
        }
    }
    
    @IBAction func subDealerBtn(_ sender: Any) {
        self.subDealerBtn.backgroundColor = UIColor(hexString: "FFFC9C")
        self.engineerButton.backgroundColor = UIColor(hexString: "565656")
        self.masonBtn.backgroundColor = UIColor(hexString: "565656")
        
        self.subDealerBtn.setTitleColor(.darkGray, for: .normal)
        self.engineerButton.setTitleColor(.white, for: .normal)
        self.masonBtn.setTitleColor(.white, for: .normal)
        
        self.selectedStatus = ""
        self.selectFromDateLbl.text = "SelectFromDate".localiz()
        self.selectToDateLbl.text = "SelectToDate".localiz()
        self.selectedCustomerTypeID = "4" 
    }
    
    @IBAction func engineerBtn(_ sender: Any) {
        self.subDealerBtn.backgroundColor = UIColor(hexString: "565656")
        self.engineerButton.backgroundColor = UIColor(hexString: "FFFC9C")
        self.masonBtn.backgroundColor = UIColor(hexString: "565656")
        
        self.subDealerBtn.setTitleColor(.white, for: .normal)
        self.engineerButton.setTitleColor(.darkGray, for: .normal)
        self.masonBtn.setTitleColor(.white, for: .normal)
        
        self.selectedStatus = ""
        self.selectFromDateLbl.text = "SelectFromDate".localiz()
        self.selectToDateLbl.text = "SelectToDate".localiz()
        self.selectedCustomerTypeID = "1"
        
//        self.VM.cashTransferApprovalListingArray.removeAll()
//        self.cashTransferListApi(startIndex: 1, status: self.selectedStatus, fromDate: self.selectedFromDate, toDate: self.selectedToDate, customerTypeId: self.selectedCustomerTypeID)
    }
    
    @IBAction func masonButton(_ sender: Any) {
        self.subDealerBtn.backgroundColor = UIColor(hexString: "565656")
        self.engineerButton.backgroundColor = UIColor(hexString: "565656")
        self.masonBtn.backgroundColor = UIColor(hexString: "FFFC9C")
        
        self.subDealerBtn.setTitleColor(.white, for: .normal)
        self.engineerButton.setTitleColor(.white, for: .normal)
        self.masonBtn.setTitleColor(.darkGray, for: .normal)
        
        self.selectedCustomerTypeID = "2"
        self.selectedStatus = ""
        self.selectFromDateLbl.text = "SelectFromDate".localiz()
        self.selectToDateLbl.text = "SelectToDate".localiz()
       
//        self.VM.cashTransferApprovalListingArray.removeAll()
//        self.cashTransferListApi(startIndex: 1, status: self.selectedStatus, fromDate: self.selectedFromDate, toDate: self.selectedToDate, customerTypeId: self.selectedCustomerTypeID)
    }
    
    func cashTransferListApi(startIndex: Int, status: String, fromDate: String, toDate: String, customerTypeId: String){
        let parameter = [
            "ActionType": 3,
            "ActorId": self.userID,
            "StartIndex":startIndex,
            "PageSize":10,
            "SearchText": "",
            "IsTranHistory": "1",
            "Status": status,
            "FromDate":fromDate,
            "Todate": toDate,
            "CustomerTypeId":customerTypeId
        ] as [String: Any]
        print(parameter)
        self.VM.cashTransferApprovalHistoryApi(parameter: parameter)
        
    }
}
extension KC_CashTranferHistoryVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VM.cashTransferApprovalListingArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "KC_CashTranferHistoryTVC", for: indexPath) as! KC_CashTranferHistoryTVC
        cell.selectionStyle = .none
        let receivedDate = String(self.VM.cashTransferApprovalListingArray[indexPath.row].createdDate ?? "").split(separator: " ")
        if receivedDate.count != 0 {
            cell.dateLbl.text = "\(receivedDate[0])"
        }else{
            cell.dateLbl.text = "-"
        }
        
        cell.categoryLbl.text = self.VM.cashTransferApprovalListingArray[indexPath.row].customerType ?? ""
        cell.productNameLbl.text = "\(self.VM.cashTransferApprovalListingArray[indexPath.row].transferedPointsinAmount ?? 0)"
        cell.orderedQty.text = "\(self.VM.cashTransferApprovalListingArray[indexPath.row].points ?? 0)"
        cell.remarks.text = "  \(self.VM.cashTransferApprovalListingArray[indexPath.row].remarks ?? "-")"
        cell.remarks.textColor = .darkGray
        cell.userNameLbl.text = self.VM.cashTransferApprovalListingArray[indexPath.row].customerName ?? ""
        if self.VM.cashTransferApprovalListingArray[indexPath.row].cashTransferedStatus ?? "" == "Rejected"{
            cell.statusLbl.text = "Rejected"
            cell.statusLbl.textColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
            cell.statusLbl.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
            cell.statusLbl.borderColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }else if self.VM.cashTransferApprovalListingArray[indexPath.row].cashTransferedStatus ?? "" == "Approved"{
            cell.statusLbl.text = "Approved"
            cell.statusLbl.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            cell.statusLbl.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
            cell.statusLbl.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        }else{
            cell.statusLbl.text = "Pending"
            cell.statusLbl.textColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
            cell.statusLbl.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
            cell.statusLbl.borderColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            if indexPath.row == self.VM.cashTransferApprovalListingArray.count - 1{
                if self.noofelements == 10{
                    self.startIndex = self.startIndex + 1
                    self.cashTransferListApi(startIndex: self.startIndex, status: self.selectedStatus, fromDate: self.selectedFromDate, toDate: self.selectedToDate, customerTypeId: self.selectedCustomerTypeID)
                }else if self.noofelements > 10{
                    self.startIndex = self.startIndex + 1
                    self.cashTransferListApi(startIndex: self.startIndex, status: self.selectedStatus, fromDate: self.selectedFromDate, toDate: self.selectedToDate, customerTypeId: self.selectedCustomerTypeID)
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
