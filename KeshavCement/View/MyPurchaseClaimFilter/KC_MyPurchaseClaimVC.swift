//
//  KC_MyPurchaseClaimVC.swift
//  KeshavCement
//
//  Created by ADMIN on 03/01/2023.
//

import UIKit

class KC_MyPurchaseClaimVC: BaseViewController, DateSelectedDelegate, DialPadsDelegate {
    func dialPadDidTap(_ cell: KC_MyPurchaseClaimTVC) {
        guard let tappedIndexpath = self.purchaseClaimTableView.indexPath(for: cell) else{return}
        
        if cell.dialPadButton.tag == tappedIndexpath.row{
            if let phoneCallURL = URL(string: "tel://\(self.VM.myPurchaseListArray[tappedIndexpath.row].mobile ?? "")") {
                
                let application:UIApplication = UIApplication.shared
                if (application.canOpenURL(phoneCallURL)) {
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                    
                }
            }
        }
        
    }
    
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
        self.purchaseClaimTableView.estimatedRowHeight = 220
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
        cell.delegate = self
        let trxnDate = String(self.VM.myPurchaseListArray[indexPath.row].trxnDate ?? "-").split(separator: " ")
        if trxnDate.count != 0{
            cell.createdDateLbl.text = "\(trxnDate[0])"
        }else{
            cell.createdDateLbl.text = "-"
        }
        cell.categoryLbl.text = self.VM.myPurchaseListArray[indexPath.row].customer_Type ?? ""
        cell.requestedToLbl.text = self.VM.myPurchaseListArray[indexPath.row].requestTo ?? ""
        cell.productNameLbl.text = self.VM.myPurchaseListArray[indexPath.row].productName ?? ""
        cell.orderQtyLbl.text = String(Int(self.VM.myPurchaseListArray[indexPath.row].quantity ?? 0.0) ?? 0)
        let convertFormat = String(self.VM.myPurchaseListArray[indexPath.row].approvedQuantity ?? "0.0")
        print(self.VM.myPurchaseListArray[indexPath.row].approvedQuantity ?? "0.0")
        print(convertFormat)
        let formatChange: Float = Float(Double(convertFormat) ?? 0.0)
        print(formatChange)
        cell.approvedQTYLbl.text = "\(Int(formatChange))"
        cell.remarks.text = "  \(self.VM.myPurchaseListArray[indexPath.row].remarks ?? "-")"
        cell.mobileNumberLbl.text = self.VM.myPurchaseListArray[indexPath.row].mobile ?? "-"
        cell.dialPadButton.tag = indexPath.row
        
        
        if self.VM.myPurchaseListArray[indexPath.row].status ?? "" == "Approved"{
            cell.approvedQTYHeightConstraint.constant = CGFloat(50)
            cell.approvedQTYView.isHidden = false
            
            cell.statusLbl.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
            cell.statusLbl.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
            cell.statusLbl.setTitle("Approved", for: .normal)
            cell.statusLbl.setTitleColor(#colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1), for: .normal)
        }else if self.VM.myPurchaseListArray[indexPath.row].status ?? "" == "Pending"{
            cell.approvedQTYHeightConstraint.constant = CGFloat(0)
            cell.approvedQTYView.isHidden = true
            
            cell.statusLbl.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
            cell.statusLbl.borderColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
            cell.statusLbl.setTitle("Pending", for: .normal)
            cell.statusLbl.setTitleColor(#colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1), for: .normal)
            
        }else if self.VM.myPurchaseListArray[indexPath.row].status ?? "" == "Rejected"{
            cell.approvedQTYHeightConstraint.constant = CGFloat(0)
            cell.approvedQTYView.isHidden = true
            cell.statusLbl.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
            cell.statusLbl.borderColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
            
            cell.statusLbl.setTitle("Rejected", for: .normal)
            cell.statusLbl.setTitleColor(#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1), for: .normal)
            
            
        }else{
            cell.approvedQTYHeightConstraint.constant = CGFloat(0)
            cell.approvedQTYView.isHidden = true
            cell.statusLbl.setTitle("Pending", for: .normal)
            cell.statusLbl.setTitleColor(#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1), for: .normal)
            cell.statusLbl.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
            cell.statusLbl.borderColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        }
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
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

