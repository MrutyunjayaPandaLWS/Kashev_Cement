//
//  KC_RedemptionTypeVC.swift
//  KeshavCement
//
//  Created by ADMIN on 06/05/2023.
//

import UIKit
import SDWebImage
import LanguageManager_iOS
class KC_RedemptionTypeVC: BaseViewController, DateSelectedDelegate, SelectedDataDelegate {
    
    func acceptDate(_ vc: KC_DOBVC) {
            if vc.isComeFrom == "1"{
        
                let convertFormatter = self.convertDateFormater(vc.selectedDate, fromDate: "yyyy-MM-dd", toDate: "dd/MM/yyyy")
                
                self.selectFromDate.text = "\(convertFormatter)"
                
                self.selectedFromDate = vc.selectedDate
                
    //            let convertFormatter1 = convertDateFormater(vc.selectedDate, fromDate: "dd/MM/yyyy", toDate: "MM/dd/yyyy")
                //self.selectedFromDate = "\(convertFormatter)"
                
                
            }else{
                let convertFormatter = self.convertDateFormater(vc.selectedDate, fromDate: "yyyy-MM-dd", toDate: "dd/MM/yyyy")
                self.selectToDate.text = "\(convertFormatter)"
                
               // let convertFormatter1 = convertDateFormater(vc.selectedDate, fromDate: "dd/MM/yyyy", toDate: "MM/dd/yyyy")
                self.selectedToDate = vc.selectedDate
            }
        }
    func didCashTransferType(_ vc:KC_DropDownVC) {
        selectedStatusName = vc.selectedCustomerType
        selectedStatusId = vc.selectedUserTypeId
        print(selectedStatusId,"dskjds")
        print(selectedFromDate,"skhds")
        print(selectedToDate,"skhds")
        self.selectStatusLbl.text  = vc.selectedCustomerType
    }
    

    @IBOutlet var myRedemptionHeaderLbl: UILabel!
    @IBOutlet var myRedemptionTV: UITableView!
    
    @IBOutlet weak var filterLbl: UILabel!
    
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var myRedemptionFilterLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var dateRangeLbl: UILabel!
    
    @IBOutlet weak var selectStatusLbl: UILabel!
    @IBOutlet weak var selectFromDate: UILabel!
    
    @IBOutlet weak var selectToDate: UILabel!
    
    @IBOutlet weak var applyFilterButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    
    var VM = KC_MyRedemptionCaseTypeVM()
    
        var noofelements = 0
        var startIndex = 1
        var selectedStatusId = -1
        var selectedStatusName = ""
        var selectedFromDate = ""
        var selectedToDate = ""
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.filterView.isHidden = true
        self.myRedemptionTV.delegate = self
        self.myRedemptionTV.dataSource = self
        self.myRedemptionTV.separatorStyle = .none
        
        self.myRedemptionTV.register(UINib(nibName: "KC_RedemptionTypCell", bundle: nil), forCellReuseIdentifier: "KC_RedemptionTypCell")
        self.myRedemptionListApi(startIndex: 1, fromDate: "", toDate: "", status: -1)
        self.myRedemptionHeaderLbl.text = "MyRdemeptionDetails".localiz()
        self.filterLbl.text = "Filter".localiz()
        self.myRedemptionFilterLbl.text = "MyRedemptionFilter".localiz()
        self.statusLbl.text = "Status".localiz()
//        self.approvedBtn.setTitle("Approved".localiz(), for: .normal)
//        self.pendingBtn.setTitle("Pending".localiz(), for: .normal)
//        self.rejectedBtn.setTitle("Rejected".localiz(), for: .normal)
        self.dateRangeLbl.text = "DateRange".localiz()
        self.selectFromDate.text = "SelectFromDate".localiz()
        self.selectToDate.text = "SelectToDate".localiz()
        self.clearButton.setTitle("Clear".localiz(), for: .normal)
        self.applyFilterButton.setTitle("ApplyFilter".localiz(), for: .normal)
    }

    @IBAction func filterActBtn(_ sender: Any) {
        if self.filterView.isHidden == false{
            self.filterView.isHidden = true
        }else{
            self.filterView.isHidden = false
        }
    }
    
    
    @IBAction func backActBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func closeBtn(_ sender: Any) {
        self.filterView.isHidden = true
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
//        self.approvedBtn.backgroundColor = UIColor(hexString: "565656")
//        self.pendingBtn.backgroundColor = UIColor(hexString: "565656")
//        self.rejectedBtn.backgroundColor = UIColor(hexString: "565656")
//        
//        self.pendingBtn.setTitleColor(.white, for: .normal)
//        self.approvedBtn.setTitleColor(.white, for: .normal)
//        self.rejectedBtn.setTitleColor(.white, for: .normal)
     
        self.selectedStatusId = -1
        self.selectFromDate.text = "SelectFromDate".localiz()
        self.selectToDate.text = "SelectToDate".localiz()
        self.filterView.isHidden = true
        self.myRedemptionListApi(startIndex: 1, fromDate: "", toDate: "", status: -1)
    }
    @IBAction func applyFilterBtn(_ sender: Any) {
        if self.selectedStatusId == -1 && self.selectedFromDate == "" && self.selectedToDate == ""{
            self.view.makeToast("Selectanyordaterange".localiz(), duration: 2.0, position: .bottom)
        }else if self.selectedFromDate == "" && self.selectedToDate == "" && self.selectedStatusId != -1{
            self.filterView.isHidden = true
            self.VM.myredemptionListArray.removeAll()
            self.myRedemptionListApi(startIndex: 1, fromDate: self.selectedFromDate, toDate: self.selectedToDate, status: self.selectedStatusId)
        }else if self.selectedFromDate != "" && self.selectedToDate == ""{
            self.view.makeToast("SelectToDate".localiz(), duration: 2.0, position: .bottom)
        }else if self.selectedFromDate == "" && self.selectedToDate != ""{
            self.view.makeToast("SelectFromDate".localiz(), duration: 2.0, position: .bottom)
        }else if self.selectedFromDate != "" && self.selectedToDate != ""{
            if self.selectedFromDate > self.selectedToDate{
                self.view.makeToast("TodateshouldntgreaterthanFromdate".localiz(), duration: 2.0, position: .bottom)
            }else{
                self.VM.myredemptionListArray.removeAll()
                self.myRedemptionListApi(startIndex: 1, fromDate: self.selectedFromDate, toDate: self.selectedToDate, status: self.selectedStatusId)
                    self.filterView.isHidden = true
            }
        }
    }
    @IBAction func selectStatusLbl(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_DropDownVC") as? KC_DropDownVC
        vc!.delegate = self
        vc!.itsFrom = "STATUSLISTS"
        vc!.modalPresentationStyle = .overFullScreen
        vc!.modalTransitionStyle = .crossDissolve
        self.present(vc!, animated: true, completion: nil)
    }
    //    @IBAction func approvedButton(_ sender: Any) {
//        self.approvedBtn.backgroundColor = UIColor(hexString: "FFFC9C")
//        self.pendingBtn.backgroundColor = UIColor(hexString: "565656")
//        self.rejectedBtn.backgroundColor = UIColor(hexString: "565656")
//
//        self.pendingBtn.setTitleColor(.white, for: .normal)
//        self.approvedBtn.setTitleColor(.darkGray, for: .normal)
//        self.rejectedBtn.setTitleColor(.white, for: .normal)
//        self.selectedStatus = 1
////        self.VM.myredemptionListArray.removeAll()
////        self.myRedemptionListApi(startIndex: 1, fromDate: self.selectedFromDate, toDate: self.selectedToDate, status: self.selectedStatus)
//    }
//
//    @IBAction func pendingButton(_ sender: Any) {
//        self.approvedBtn.backgroundColor = UIColor(hexString: "565656")
//        self.pendingBtn.backgroundColor = UIColor(hexString: "FFFC9C")
//
//        self.rejectedBtn.backgroundColor = UIColor(hexString: "565656")
//        self.approvedBtn.setTitleColor(.white, for: .normal)
//        self.pendingBtn.setTitleColor(.darkGray, for: .normal)
//        self.rejectedBtn.setTitleColor(.white, for: .normal)
//        self.selectedStatus = 0
////        self.VM.myredemptionListArray.removeAll()
////        self.myRedemptionListApi(startIndex: 1, fromDate: self.selectedFromDate, toDate: self.selectedToDate, status: self.selectedStatus)
//    }
//
//    @IBAction func rejectedButton(_ sender: Any) {
//        self.approvedBtn.backgroundColor = UIColor(hexString: "565656")
//        self.pendingBtn.backgroundColor = UIColor(hexString: "565656")
//        self.rejectedBtn.backgroundColor = UIColor(hexString: "FFFC9C")
//
//        self.approvedBtn.setTitleColor(.white, for: .normal)
//        self.rejectedBtn.setTitleColor(.darkGray, for: .normal)
//        self.pendingBtn.setTitleColor(.white, for: .normal)
//        self.selectedStatus = 2
////        self.VM.myredemptionListArray.removeAll()
////        self.myRedemptionListApi(startIndex: 1, fromDate: self.selectedFromDate, toDate: self.selectedToDate, status: self.selectedStatus)
//    }
    
    func myRedemptionListApi(startIndex: Int, fromDate: String, toDate: String, status: Int){
        let parameters = [
//                "ActionType": "277",
//                "ActorId": self.userID,
//                    "StartIndex": startIndex,
//                    "NoOfRows": 10,
//                    "FromDate": fromDate,
//                    "ToDate": toDate,
//                    "ObjCatalogueDetails": [
//                        "SelectedStatus": status,
//                        "RedemptionTypeId": -1
//                    ]
                
                
              //  [
                    "ActionType": "277",
                    "ActorId": self.userID,
                    "StartIndex": startIndex,
                    "NoOfRows": 10,
                    "ObjCatalogueDetails": [
                        "JFromDate": fromDate,
                        "JToDate": toDate,
                        "SelectedStatus": status,
                        "RedemptionTypeId": -1
                    ]
                
        ] as [String : Any]
        print(parameters)
        self.VM.myRedemptionListApi(parameter: parameters)
    }
    
}

@available(iOS 16.0, *)
extension KC_RedemptionTypeVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VM.myredemptionListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "KC_RedemptionTypCell") as! KC_RedemptionTypCell
        cell.selectionStyle = .none
        cell.cashPtsLbl.text = "\(self.VM.myredemptionListArray[indexPath.row].cashTransferedInAmount ?? 0)"
        cell.requestedToLbl.text = self.VM.myredemptionListArray[indexPath.row].cashTransferedTo ?? ""
        cell.valueLbl.text = "\(self.VM.myredemptionListArray[indexPath.row].cashTransferedPoints ?? 0)"
    
       
//        if  self.VM.myredemptionListArray.count != 0 {
            let redemptionDate = "\(self.VM.myredemptionListArray[indexPath.row].jRedemptionDate ?? "-")".split(separator: " ")
    
        //let convertedFormat = convertDateFormater(String(redemptionDate[0]), fromDate: "MM/dd/yyyy", toDate: "dd/MM/yyyy")
        
            if redemptionDate.count != 0 {
                cell.currentTransferDateLbl.text = "\(redemptionDate[0])"
            }else{
                cell.currentTransferDateLbl.text = "-"
            }

//            cell.referenceIdLbl.text = self.VM.myredemptionListArray[indexPath.row].redemptionRefno ?? ""
//
//            if self.VM.myredemptionListArray[indexPath.row].catalogueType ?? "" == "Cash voucher"{
//                cell.qtyLbl.isHidden = true
//                cell.quantityHeadingLbl.isHidden = true
//                cell.productHeaderLbl.isHidden = false
//                cell.productHeaderLbl.text = "Category: Cash Voucher"
//                cell.productTitle.text = "Cash Voucher"
//            }else if self.VM.myredemptionListArray[indexPath.row].catalogueType ?? "" == "Catalogue"{
//                cell.qtyLbl.isHidden = false
//                cell.quantityHeadingLbl.isHidden = false
//                cell.productHeaderLbl.isHidden = false
//                cell.productHeaderLbl.text = "Category: \(self.VM.myredemptionListArray[indexPath.row].categoryName ?? "")"
//                cell.productTitle.text = "Catalogue"
//            }else if self.VM.myredemptionListArray[indexPath.row].catalogueType ?? "" == "Voucher"{
//                cell.quantityHeadingLbl.isHidden = true
//                cell.qtyLbl.isHidden = true
//                cell.productHeaderLbl.isHidden = true
//                cell.productTitle.text = "Voucher"
//            }else if self.VM.myredemptionListArray[indexPath.row].catalogueType ?? "" == "Dream Gift"{
//                cell.quantityHeadingLbl.isHidden = true
//                cell.qtyLbl.isHidden = true
//                cell.productHeaderLbl.isHidden = true
//                cell.productTitle.text = "Dream Gift"
//            }else if self.VM.myredemptionListArray[indexPath.row].catalogueType ?? "" == "Gift Voucher"{
//                cell.quantityHeadingLbl.isHidden = true
//                cell.qtyLbl.isHidden = true
//                cell.productHeaderLbl.isHidden = true
//                cell.productTitle.text = "Gift Voucher"
//            }else{
//                cell.quantityHeadingLbl.isHidden = true
//                cell.qtyLbl.isHidden = true
//                cell.productHeaderLbl.isHidden = true
//                cell.productTitle.text = self.VM.myredemptionListArray[indexPath.row].catalogueType ?? ""
//            }
//
//
//            if self.VM.myredemptionListArray[indexPath.row].status ?? -1 == 0{
//                cell.statusLbl.text = "Pending"
//                cell.statusLbl.textColor = UIColor.black
//                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
//                cell.statusLbl.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
//            }
////            else if self.VM.myredemptionListArray[indexPath.row].status ?? -1 == 4{
////                cell.statusLbl.text = "Approved"
////
////                cell.statusLbl.textColor = UIColor.black
////                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
////                cell.statusLbl.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
////
////            }
////            }
            if self.VM.myredemptionListArray[indexPath.row].cashTransferedStatus ?? "" == "Rejected"{
                cell.statusLbl.text = "Rejected"
                cell.statusLbl.textColor = UIColor.white
                cell.statusLbl.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
                cell.statusWidthConstraint.constant = 110
            }else if self.VM.myredemptionListArray[indexPath.row].cashTransferedStatus ?? "" == "Processed"{
                cell.statusLbl.text = "Processed"
                cell.statusLbl.textColor = UIColor.black
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)
                cell.statusWidthConstraint.constant = 110
            }else if self.VM.myredemptionListArray[indexPath.row].cashTransferedStatus ?? "" == "Cancelled"{
                cell.statusLbl.text = "Cancelled"
                cell.statusLbl.textColor = UIColor.black
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
                cell.statusWidthConstraint.constant = 110
            }else if self.VM.myredemptionListArray[indexPath.row].cashTransferedStatus ?? "" == "Delivered"{
                cell.statusLbl.text = "Delivered"
                cell.statusLbl.textColor = UIColor.white
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                cell.statusWidthConstraint.constant = 110
            }else if self.VM.myredemptionListArray[indexPath.row].cashTransferedStatus ?? "" == "Returned"{
                cell.statusLbl.text = "Returned"
                cell.statusLbl.textColor = UIColor.black
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
                cell.statusWidthConstraint.constant = 110
            }else if self.VM.myredemptionListArray[indexPath.row].cashTransferedStatus ?? "" == "Redispatched"{
                cell.statusLbl.text = "Redispatched"
                cell.statusLbl.textColor = UIColor.black
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
                cell.statusWidthConstraint.constant = 120
            }else if self.VM.myredemptionListArray[indexPath.row].cashTransferedStatus ?? "" == "OnHold"{
                cell.statusLbl.text = "OnHold"
                cell.statusLbl.textColor = UIColor.black
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
            }else if self.VM.myredemptionListArray[indexPath.row].cashTransferedStatus ?? "" == "Dispatched"{
                cell.statusLbl.text = "Dispatched"
                cell.statusLbl.textColor = UIColor.black
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
                cell.statusWidthConstraint.constant = 100
            }else if self.VM.myredemptionListArray[indexPath.row].cashTransferedStatus ?? "" == "Out for Delivery"{
                cell.statusLbl.text = "Out for Delivery"
                cell.statusLbl.textColor = UIColor.black
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                cell.statusWidthConstraint.constant = 200
            }else if self.VM.myredemptionListArray[indexPath.row].cashTransferedStatus ?? "" == "Address Verified"{
                cell.statusLbl.text = "Address Verified"
                cell.statusLbl.textColor = UIColor.black
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
                cell.statusWidthConstraint.constant = 170
            }else if self.VM.myredemptionListArray[indexPath.row].cashTransferedStatus ?? "" == "Posted for approval"{
                cell.statusLbl.text = "Posted for approval"
                cell.statusLbl.textColor = UIColor.white
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
                cell.statusWidthConstraint.constant = 200
            }else if self.VM.myredemptionListArray[indexPath.row].cashTransferedStatus ?? "" == "Vendor Alloted"{
                cell.statusLbl.text = "Vendor Alloted"
                cell.statusLbl.textColor = UIColor.black
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
                cell.statusWidthConstraint.constant = 170
            }else if self.VM.myredemptionListArray[indexPath.row].cashTransferedStatus ?? "" == "Vendor Rejected"{
                cell.statusLbl.text = "Vendor Rejected"
                cell.statusLbl.textColor = UIColor.black
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
                cell.statusWidthConstraint.constant = 130
            }else if self.VM.myredemptionListArray[indexPath.row].cashTransferedStatus ?? "" == "Posted for approval 2"{
                cell.statusLbl.text = "Posted for approval 2"
                cell.statusLbl.textColor = #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
                cell.statusWidthConstraint.constant = 200
            }else if self.VM.myredemptionListArray[indexPath.row].cashTransferedStatus ?? "" == "Cancel Request"{
                cell.statusLbl.text = "Cancel Request"
                cell.statusLbl.textColor = UIColor.white
                cell.statusLbl.backgroundColor = #colorLiteral(red: 1, green: 0.2148990929, blue: 0.2913323045, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                cell.statusWidthConstraint.constant = 170
            }else if self.VM.myredemptionListArray[indexPath.row].cashTransferedStatus ?? "" == "Redemption Verified"{
                cell.statusLbl.text = "Redemption Verified"
                cell.statusLbl.textColor = #colorLiteral(red: 0.4956601262, green: 0.3664793372, blue: 0.4964143634, alpha: 1)
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.9674736857, green: 0.7168567181, blue: 0.9713200927, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
                cell.statusWidthConstraint.constant = 170
            }else if self.VM.myredemptionListArray[indexPath.row].cashTransferedStatus ?? "" == "Delivery Confirmed"{
                cell.statusLbl.text = "Delivery Confirmed"
                cell.statusLbl.textColor = UIColor.white
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
                cell.statusWidthConstraint.constant = 170
            }else if self.VM.myredemptionListArray[indexPath.row].cashTransferedStatus ?? "" == "Return Requested"{
                cell.statusLbl.text = "Return Requested"
                cell.statusLbl.textColor = UIColor.black
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
                cell.statusWidthConstraint.constant = 170
            }else if self.VM.myredemptionListArray[indexPath.row].cashTransferedStatus ?? "" == "Return Pick Up Schedule"{
                cell.statusLbl.text = "Return Pick Up Schedule"
                cell.statusLbl.textColor = UIColor.black
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
                cell.statusWidthConstraint.constant = 210
            }else if self.VM.myredemptionListArray[indexPath.row].cashTransferedStatus ?? "" == "Picked Up"{
                cell.statusLbl.text = "Picked Up"
                cell.statusLbl.textColor = UIColor.black
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
                cell.statusWidthConstraint.constant = 100
            }else if self.VM.myredemptionListArray[indexPath.row].cashTransferedStatus ?? "" == "Return Received"{
                cell.statusLbl.text = "Return Received"
                cell.statusLbl.textColor = UIColor.white
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
                cell.statusWidthConstraint.constant = 100
            }else if self.VM.myredemptionListArray[indexPath.row].cashTransferedStatus ?? "" == "In Transit"{
                cell.statusLbl.text = "In Transit"
                cell.statusLbl.textColor = UIColor.white
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                cell.statusWidthConstraint.constant = 100
            }else if self.VM.myredemptionListArray[indexPath.row].cashTransferedStatus ?? "" == "Pending"{
                cell.statusLbl.text = "Pending"
                cell.statusLbl.textColor = UIColor.white
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                cell.statusWidthConstraint.constant = 100
            }else if self.VM.myredemptionListArray[indexPath.row].cashTransferedStatus ?? "" == "Approved"{
                cell.statusLbl.text = "Approved"
                cell.statusLbl.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                cell.statusWidthConstraint.constant = 100
            }else{
                cell.statusLbl.text = self.VM.myredemptionListArray[indexPath.row].cashTransferedStatus ?? ""
                cell.statusLbl.textColor = UIColor.black
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                cell.statusWidthConstraint.constant = 180
            }
//
//
//            cell.productNameLbl.text = self.VM.myredemptionListArray[indexPath.row].productName ?? ""
//            cell.pointsPerUnitLbl.text = "\(Int(self.VM.myredemptionListArray[indexPath.row].redemptionPoints ?? 0.0) )"
//            cell.qtyLbl.text = "\(self.VM.myredemptionListArray[indexPath.row].quantity ?? 0)"
//
//            let imageURL = self.VM.myredemptionListArray[indexPath.row].productImage ?? ""
//            if imageURL != ""{
//                let urltoUse = String(productCatalogueImgURL + imageURL).replacingOccurrences(of: " ", with: "%20")
//                let urlt = URL(string: "\(urltoUse)")
//                cell.productImageView.sd_setImage(with: urlt!, placeholderImage: #imageLiteral(resourceName: "ic_default_img"))
//            }else{
//                cell.productImageView.image = UIImage(named: "ic_default_img")
//            }
//        }
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HRD_MyRedemptionDetailsVC") as! HRD_MyRedemptionDetailsVC
//        vc.categoryType = self.VM.myredemptionListArray[indexPath.row].catalogueType ?? ""
//        vc.categoryName = self.VM.myredemptionListArray[indexPath.item].categoryName ?? ""
//        vc.totalPoint = "\(Int(self.VM.myredemptionListArray[indexPath.item].redemptionPoints ?? 0.0) )"
//        vc.productName = self.VM.myredemptionListArray[indexPath.item].productName ?? ""
//        vc.quantity = "\(self.VM.myredemptionListArray[indexPath.item].quantity ?? 0)"
//        vc.productImage = self.VM.myredemptionListArray[indexPath.item].productImage ?? ""
//        vc.redemptionRefNo = self.VM.myredemptionListArray[indexPath.item].redemptionRefno ?? ""
//        vc.descDetails = self.VM.myredemptionListArray[indexPath.item].productDesc ?? ""
//        vc.termsandContions = self.VM.myredemptionListArray[indexPath.item].termsCondition ?? ""
//        vc.redemptionPoints = "\(self.VM.myredemptionListArray[indexPath.item].redemptionPoints ?? 0)"
//        vc.status = "\(self.VM.myredemptionListArray[indexPath.item].status ?? 0)"
//        vc.customerId = "\(self.userID)"
//        let strDate = self.VM.myredemptionListArray[indexPath.row].jRedemptionDate ?? "01/01/0001  00:00:00"
//        print(strDate)
//        let array = strDate.components(separatedBy: " ")
//        print(array[0])
//        //        let inputFormatter = DateFormatter()
//        //        inputFormatter.dateFormat = "MM/dd/yyyy"
//        //        let outputFormatter = DateFormatter()
//        //        outputFormatter.dateFormat = "dd/MM/yyyy"
//        //        let showDate = inputFormatter.date(from: array[0])!
//        //        let resultString = outputFormatter.string(from: showDate)
//        //vc.redemptionsDate = "\(resultString)"
//
//        vc.redemptionsDate = "\(array[0])"
//        vc.redemptionsstatus = String(self.VM.myredemptionListArray[indexPath.row].status ?? 0) ?? ""
//
//       // vc.cartCounts = self.cartCount.text!
//        vc.redemptionId = "\(self.VM.myredemptionListArray[indexPath.item].redemptionId ?? 0)"
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 230
//    }
        
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       
            if indexPath.row == self.VM.myredemptionListArray.count - 1{
                if self.noofelements == 10{
                    self.startIndex = self.startIndex + 1
                    self.myRedemptionListApi(startIndex: self.startIndex, fromDate: self.selectedFromDate, toDate: self.selectedToDate, status: self.selectedStatusId)
                }else if self.noofelements > 10{
                    self.startIndex = self.startIndex + 1
                    self.myRedemptionListApi(startIndex: self.startIndex, fromDate: self.selectedFromDate, toDate: self.selectedToDate, status: self.selectedStatusId)
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
