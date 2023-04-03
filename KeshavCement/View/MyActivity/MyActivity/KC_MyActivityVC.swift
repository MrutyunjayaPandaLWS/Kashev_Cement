//
//  KC_MyActivityVC.swift
//  KeshavCement
//
//  Created by ADMIN on 13/01/2023.
//

import UIKit

class KC_MyActivityVC: BaseViewController, DateSelectedDelegate {
    
//https://keshavdemoserv.loyltwo3ks.com/Mobile/BindAssessmentRequestDetails
//
//{"ActionType":6,"ActiveStatus":"-3","FromDate":"","PageSize":10,"SalesPersonId":"SE00010","StartIndex":1,"ToDate":""}
    
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
    

    @IBOutlet weak var subDealerButton: UIButton!
    @IBOutlet weak var engineerButton: UIButton!
    @IBOutlet weak var masonBtn: UIButton!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var claimHistoryTableView: UITableView!
    @IBOutlet weak var filterLbl: UILabel!
    @IBOutlet weak var headeerText: UILabel!
    
    @IBOutlet weak var claimHistoryFilterLbl: UILabel!
    
    @IBOutlet weak var statusLbl: UILabel!
    
    @IBOutlet weak var approvedBtn: UIButton!
    
    @IBOutlet weak var pendingBtn: UIButton!
    
    @IBOutlet weak var rejectedBtn: UIButton!
    
    @IBOutlet weak var dateRangeLbl: UILabel!
    
    @IBOutlet weak var selectFromDateLbl: UILabel!
    
    @IBOutlet weak var selectToDateLbl: UILabel!
    
    @IBOutlet weak var customerTypeLbl: UILabel!
    
    @IBOutlet weak var applyFilterBtn: UIButton!
    @IBOutlet weak var clearBtn: UIButton!
    @IBOutlet weak var noDataFoundLbl: UILabel!
    
    
    var noofelements = 0
    var startIndex = 1
    var selectedStatus = "-3"
    var selectedFromDate = ""
    var selectedToDate = ""
    var VM = KC_MyActivityVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.noDataFoundLbl.isHidden = true
        self.filterView.isHidden = true
        self.claimHistoryTableView.delegate = self
        self.claimHistoryTableView.dataSource = self
        self.claimHistoryListApi(status: "-3", startIndex: 1, fromDate: "", toDate: "", customerTypeId: "")
    }

    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func filterButton(_ sender: Any) {
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
            self.VM.claimHistoryListArray.removeAll()
            self.claimHistoryListApi(status: "-3", startIndex: 1, fromDate: "", toDate: "", customerTypeId: "")
        }
    }
    
    @IBAction func selectedFromDateBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_DOBVC") as! KC_DOBVC
        vc.isComeFrom = "1"
        vc.delegate = self
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
        
    }
    @IBAction func selectedToDatebtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_DOBVC") as! KC_DOBVC
        vc.isComeFrom = "2"
        vc.delegate = self
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    
    @IBAction func subDealerBtn(_ sender: Any) {
        self.subDealerButton.backgroundColor = UIColor(hexString: "FFFC9C")
        self.engineerButton.backgroundColor = UIColor(hexString: "565656")
        self.masonBtn.backgroundColor = UIColor(hexString: "565656")
        
        self.subDealerButton.setTitleColor(.darkGray, for: .normal)
        self.engineerButton.setTitleColor(.white, for: .normal)
        self.masonBtn.setTitleColor(.white, for: .normal)
        
        self.selectedStatus = "-3"
        self.selectFromDateLbl.text = "From Date"
        self.selectToDateLbl.text = "To Date"
        self.VM.claimHistoryListArray.removeAll()
        self.claimHistoryListApi(status: self.selectedStatus, startIndex: self.startIndex, fromDate: self.selectedFromDate, toDate: self.selectedToDate, customerTypeId: "4")
    }
    @IBAction func engineerBtn(_ sender: Any) {
        self.subDealerButton.backgroundColor = UIColor(hexString: "565656")
        self.engineerButton.backgroundColor = UIColor(hexString: "FFFC9C")
        self.masonBtn.backgroundColor = UIColor(hexString: "565656")
        
        self.subDealerButton.setTitleColor(.white, for: .normal)
        self.engineerButton.setTitleColor(.darkGray, for: .normal)
        self.masonBtn.setTitleColor(.white, for: .normal)
        
        self.selectedStatus = "-3"
        self.selectFromDateLbl.text = "From Date"
        self.selectToDateLbl.text = "To Date"
        self.VM.claimHistoryListArray.removeAll()
        self.VM.claimHistoryListArray.removeAll()
        self.claimHistoryListApi(status: self.selectedStatus, startIndex: self.startIndex, fromDate: self.selectedFromDate, toDate: self.selectedToDate, customerTypeId: "1")
    }
    @IBAction func masonBtn(_ sender: Any) {
        self.subDealerButton.backgroundColor = UIColor(hexString: "565656")
        self.engineerButton.backgroundColor = UIColor(hexString: "565656")
        self.masonBtn.backgroundColor = UIColor(hexString: "FFFC9C")
        
        self.subDealerButton.setTitleColor(.white, for: .normal)
        self.engineerButton.setTitleColor(.white, for: .normal)
        self.masonBtn.setTitleColor(.darkGray, for: .normal)
        
        
        self.selectedStatus = "-3"
        self.selectFromDateLbl.text = "From Date"
        self.selectToDateLbl.text = "To Date"
        self.VM.claimHistoryListArray.removeAll()
        self.VM.claimHistoryListArray.removeAll()
        self.claimHistoryListApi(status: self.selectedStatus, startIndex: self.startIndex, fromDate: self.selectedFromDate, toDate: self.selectedToDate, customerTypeId: "2")
    }
    
    @IBAction func clearButton(_ sender: Any) {
        self.approvedBtn.backgroundColor = UIColor(hexString: "565656")
        self.pendingBtn.backgroundColor = UIColor(hexString: "565656")
        self.rejectedBtn.backgroundColor = UIColor(hexString: "565656")
        
        self.subDealerButton.backgroundColor = UIColor(hexString: "565656")
        self.engineerButton.backgroundColor = UIColor(hexString: "565656")
        self.masonBtn.backgroundColor = UIColor(hexString: "565656")
        
        self.subDealerButton.setTitleColor(.white, for: .normal)
        self.engineerButton.setTitleColor(.white, for: .normal)
        self.masonBtn.setTitleColor(.white, for: .normal)
        
        self.pendingBtn.setTitleColor(.white, for: .normal)
        self.approvedBtn.setTitleColor(.white, for: .normal)
        self.rejectedBtn.setTitleColor(.white, for: .normal)
        self.selectedStatus = "-3"
        self.selectFromDateLbl.text = "From Date"
        self.selectToDateLbl.text = "To Date"
        self.VM.claimHistoryListArray.removeAll()
        self.claimHistoryListApi(status: self.selectedStatus, startIndex: self.startIndex, fromDate: self.selectedFromDate, toDate: self.selectedToDate, customerTypeId: "")
            self.filterView.isHidden = true
    }
    
    @IBAction func applyFilterButton(_ sender: Any) {
        if self.selectedStatus == "-3" && self.selectedFromDate == "" && self.selectedToDate == ""{
            self.view.makeToast("Select any select or date range", duration: 2.0, position: .bottom)
        }else if self.selectedFromDate == "" && self.selectedToDate == "" && self.selectedStatus != "-3"{
            self.VM.claimHistoryListArray.removeAll()
            self.claimHistoryListApi(status: self.selectedStatus, startIndex: self.startIndex, fromDate: self.selectedFromDate, toDate: self.selectedToDate, customerTypeId: "")
        }else if self.selectedFromDate != "" && self.selectedToDate == ""{
            self.view.makeToast("Select To date", duration: 2.0, position: .bottom)
        }else if self.selectedFromDate == "" && self.selectedToDate != ""{
            self.view.makeToast("Select From date", duration: 2.0, position: .bottom)
        }else if self.selectedFromDate != "" && self.selectedToDate != ""{
            if self.selectedFromDate > self.selectedToDate{
                self.view.makeToast("To date shouldn't greater than From date", duration: 2.0, position: .bottom)
            }else{
                self.VM.claimHistoryListArray.removeAll()
                self.claimHistoryListApi(status: self.selectedStatus, startIndex: self.startIndex, fromDate: self.selectedFromDate, toDate: self.selectedToDate, customerTypeId: "")
//                    self.filterView.isHidden = true
            }
        }
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
        self.selectedStatus = "1"
        self.VM.claimHistoryListArray.removeAll()
        self.claimHistoryListApi(status: self.selectedStatus, startIndex: self.startIndex, fromDate: self.selectedFromDate, toDate: self.selectedToDate, customerTypeId: "")
//            self.filterView.isHidden = true
        
    }
    
    @IBAction func pendingButton(_ sender: Any) {
        self.approvedBtn.backgroundColor = UIColor(hexString: "565656")
        self.pendingBtn.backgroundColor = UIColor(hexString: "FFFC9C")
        
        self.rejectedBtn.backgroundColor = UIColor(hexString: "565656")
        self.approvedBtn.setTitleColor(.white, for: .normal)
        self.pendingBtn.setTitleColor(.darkGray, for: .normal)
        self.rejectedBtn.setTitleColor(.white, for: .normal)
        self.selectedStatus = "0"
        self.VM.claimHistoryListArray.removeAll()
        self.claimHistoryListApi(status: self.selectedStatus, startIndex: self.startIndex, fromDate: self.selectedFromDate, toDate: self.selectedToDate, customerTypeId: "")
//            self.filterView.isHidden = true
    }
    
    @IBAction func rejectedButton(_ sender: Any) {
        self.approvedBtn.backgroundColor = UIColor(hexString: "565656")
        self.pendingBtn.backgroundColor = UIColor(hexString: "565656")
        self.rejectedBtn.backgroundColor = UIColor(hexString: "FFFC9C")
        
        self.approvedBtn.setTitleColor(.white, for: .normal)
        self.rejectedBtn.setTitleColor(.darkGray, for: .normal)
        self.pendingBtn.setTitleColor(.white, for: .normal)
        self.selectedStatus = "-1"
        self.VM.claimHistoryListArray.removeAll()
        self.claimHistoryListApi(status: self.selectedStatus, startIndex: self.startIndex, fromDate: self.selectedFromDate, toDate: self.selectedToDate, customerTypeId: "")
//            self.filterView.isHidden = true
    }
    

    func claimHistoryListApi(status: String, startIndex: Int, fromDate: String, toDate: String, customerTypeId: String){
        let parameter = [
            "ActionType": 6,
            "ActiveStatus": status,
            "FromDate": fromDate,
            "PageSize": 10,
            "SalesPersonId": "\(self.loyaltyId)",
            "StartIndex": startIndex,
            "ToDate": toDate
        ] as [String: Any]
        print(parameter)
        self.VM.claimHistoryListApi(parameter: parameter)
    }
    
}
extension KC_MyActivityVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VM.claimHistoryListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "KC_MyActivityTVC", for: indexPath) as! KC_MyActivityTVC
        
        let receivedDate = String(self.VM.claimHistoryListArray[indexPath.row].trxnDate ?? "").split(separator: " ")
        if receivedDate.count != 0 {
            cell.dateLbl.text = "\(receivedDate[0])"
        }else{
            cell.dateLbl.text = "-"
        }
        cell.categoryLbl.text = self.VM.claimHistoryListArray[indexPath.row].customer_Type ?? ""
        cell.userNameLbl.text = self.VM.claimHistoryListArray[indexPath.row].requestTo ?? ""
        if self.VM.claimHistoryListArray[indexPath.row].status ?? "" == "Pending"{
            cell.statusLbl.backgroundColor = #colorLiteral(red: 0.8848068118, green: 0.9562426209, blue: 0.8934361935, alpha: 1)
            cell.statusLbl.textColor = .green
        }else if self.self.VM.claimHistoryListArray[indexPath.row].status ?? "" == "Rejected"{
            cell.statusLbl.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
            cell.statusLbl.textColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)

        }else{
            cell.statusLbl.backgroundColor = #colorLiteral(red: 0.8848068118, green: 0.9562426209, blue: 0.8934361935, alpha: 1)
            cell.statusLbl.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        }
        cell.statusLbl.text = self.VM.claimHistoryListArray[indexPath.row].status ?? ""
        cell.productNameLbl.text =  self.VM.claimHistoryListArray[indexPath.row].productName ?? ""
        let quanty = Float(String(self.VM.claimHistoryListArray[indexPath.row].approvedQuantity ?? "0"))
        cell.orderedQty.text = "\(Int(self.VM.claimHistoryListArray[indexPath.row].quantity ?? 0.0))"
        cell.qtyLb.text = "\(Int(quanty!))"
        cell.remarks.text = "  \(self.VM.claimHistoryListArray[indexPath.row].remarks ?? "")"
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       
            if indexPath.row == self.VM.claimHistoryListArray.count - 1{
                if self.noofelements == 10{
                    self.startIndex = self.startIndex + 1
                    self.claimHistoryListApi(status: self.selectedStatus, startIndex: self.startIndex, fromDate: self.selectedFromDate, toDate: self.selectedToDate, customerTypeId: "")
                }else if self.noofelements > 10{
                    self.startIndex = self.startIndex + 1
                    self.claimHistoryListApi(status: self.selectedStatus, startIndex: self.startIndex, fromDate: self.selectedFromDate, toDate: self.selectedToDate, customerTypeId: "")
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
