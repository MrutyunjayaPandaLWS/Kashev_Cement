//
//  KC_MyRedemptionVC.swift
//  KeshavCement
//
//  Created by Arokia-M3 on 02/01/23.
//

import UIKit
import SDWebImage
import LanguageManager_iOS
class KC_MyRedemptionVC: BaseViewController, DateSelectedDelegate, SelectedDataDelegate{
    func acceptDate(_ vc: KC_DOBVC) {
        if vc.isComeFrom == "1"{
    
            let convertFormatter = convertDateFormater(vc.selectedDate, fromDate: "yyyy-MM-dd", toDate: "dd/MM/yyyy")
            
            self.selectFromDate.text = "\(convertFormatter)"
            
//            let convertFormatter1 = convertDateFormater(vc.selectedDate, fromDate: "dd/MM/yyyy", toDate: "MM/dd/yyyy")
            self.selectedFromDate = "\(convertFormatter)"
            
            
        }else{
            let convertFormatter = convertDateFormater(vc.selectedDate, fromDate: "yyyy-MM-dd", toDate: "dd/MM/yyyy")
            self.selectToDate.text = "\(convertFormatter)"
            
           // let convertFormatter1 = convertDateFormater(vc.selectedDate, fromDate: "dd/MM/yyyy", toDate: "MM/dd/yyyy")
            self.selectedToDate = "\(convertFormatter)"
        }
    }

    func didTapCustomerType(_ vc: KC_DropDownVC) {
            selectedStatusName = vc.selectedCustomerType
            selectedStatusId = vc.selectedCustomerTypeId
            self.selectStatusLbl.text  = vc.selectedCustomerType
    }
    func didCatalogueType(_ vc: KC_DropDownVC) {
        selectedCatalogueTypeName = vc.selectedCatalogueType
         selectedCatalogueId = vc.selectedCatalogueTypeId
        self.selectCatalogueTypeLbl.text = vc.selectedCatalogueType
    }
    

    @IBOutlet var myRedemptionHeaderLbl: UILabel!
    @IBOutlet var myRedemptionTV: UITableView!
    
    @IBOutlet weak var filterLbl: UILabel!
    
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var myRedemptionFilterLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var dateRangeLbl: UILabel!
    @IBOutlet weak var selectFromDate: UILabel!
    @IBOutlet weak var selectToDate: UILabel!
    @IBOutlet weak var applyFilterButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    
    @IBOutlet weak var selectStatusLbl: UILabel!
    
    @IBOutlet weak var catalogueTypeLbl: UILabel!
    
    @IBOutlet weak var selectCatalogueTypeLbl: UILabel!
    
    var selectedStatusName = ""
    var selectedStatusId = -1
    var selectedCatalogueTypeName = ""
    var selectedCatalogueId = -1
    
    var VM = KC_MyRedemptionListVM()
    
        var noofelements = 0
        var startIndex = 1
        //var selectedStatus = -1
        var selectedFromDate = ""
        var selectedToDate = ""
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        
        self.myRedemptionTV.delegate = self
        self.myRedemptionTV.dataSource = self
        self.myRedemptionTV.separatorStyle = .none
        
        self.myRedemptionTV.register(UINib(nibName: "KC_MyRedemptionTVC", bundle: nil), forCellReuseIdentifier: "KC_MyRedemptionTVC")
        self.myRedemptionListApi(startIndex: 1, fromDate: "", toDate: "", status: -1, catalogueType: -1)
        self.myRedemptionHeaderLbl.text = "MyRdemeptionDetails".localiz()
        self.filterLbl.text = "Filter".localiz()
        self.myRedemptionFilterLbl.text = "MyRedemptionFilter".localiz()
        self.statusLbl.text = "Status".localiz()
        self.dateRangeLbl.text = "DateRange".localiz()
        self.selectFromDate.text = "SelectFromDate".localiz()
        self.selectToDate.text = "SelectToDate".localiz()
        self.clearButton.setTitle("Clear".localiz(), for: .normal)
        self.applyFilterButton.setTitle("ApplyFilter".localiz(), for: .normal)
        
//        self.approvedBtn.setTitle("Approved".localiz(), for: .normal)
//        self.pendingBtn.setTitle("Pending".localiz(), for: .normal)
//        self.rejectedBtn.setTitle("Rejected".localiz(), for: .normal)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.filterView.isHidden = true
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
     
        self.selectedStatusId = -1
        self.selectedStatusName = ""
        self.selectedCatalogueTypeName = ""
        self.selectStatusLbl.text = "Select Status"
        self.selectCatalogueTypeLbl.text = "Select Catalogue Type"
        self.selectedCatalogueId = -1
        
        self.selectFromDate.text = "SelectFromDate".localiz()
        self.selectToDate.text = "SelectToDate".localiz()
       // self.filterView.isHidden = true
        self.myRedemptionListApi(startIndex: 1, fromDate: "", toDate: "", status: -1, catalogueType: -1)
    }
    @IBAction func applyFilterBtn(_ sender: Any) {
        if self.selectedStatusId == -1 && self.selectedCatalogueId == -1 && self.selectedFromDate == "" && self.selectedToDate == ""{
            self.view.makeToast("Selectanyordaterange".localiz(), duration: 2.0, position: .bottom)
        }else if self.selectedFromDate == "" && self.selectedToDate == "" && self.selectedStatusId != -1 || self.selectedCatalogueId != -1{
            self.filterView.isHidden = true
            self.VM.myredemptionListArray.removeAll()
            self.myRedemptionListApi(startIndex: 1, fromDate: self.selectedFromDate, toDate: self.selectedToDate, status: self.selectedStatusId, catalogueType: self.selectedCatalogueId)
        }else if self.selectedFromDate != "" && self.selectedToDate == ""{
            self.view.makeToast("SelectToDate".localiz(), duration: 2.0, position: .bottom)
        }else if self.selectedFromDate == "" && self.selectedToDate != ""{
            self.view.makeToast("SelectFromDate".localiz(), duration: 2.0, position: .bottom)
        }else if self.selectedFromDate != "" && self.selectedToDate != ""{
            if self.selectedFromDate > self.selectedToDate{
                self.view.makeToast("TodateshouldntgreaterthanFromdate".localiz(), duration: 2.0, position: .bottom)
            }else{
                self.VM.myredemptionListArray.removeAll()
//                let convertFormatter1 = convertDateFormater(self.selectedFromDate, fromDate: "dd/MM/yyyy", toDate: "MM/dd/yyyy")
//                let convertFormatter2 = convertDateFormater(self.selectedToDate, fromDate: "dd/MM/yyyy", toDate: "MM/dd/yyyy")
                
                self.myRedemptionListApi(startIndex: 1, fromDate: self.selectedFromDate, toDate: self.selectedToDate, status: self.selectedStatusId, catalogueType: self.selectedCatalogueId)
                    self.filterView.isHidden = true
            }
        }
    }
    
    @IBAction func selectStatusButton(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_DropDownVC") as? KC_DropDownVC
        vc!.delegate = self
        vc!.itsFrom = "STATUSLIST"
        vc!.modalPresentationStyle = .overFullScreen
        vc!.modalTransitionStyle = .crossDissolve
        self.present(vc!, animated: true, completion: nil)
        
    }
    
    @IBAction func selectCatalogueTypeButton(_ sender: Any) {
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_DropDownVC") as? KC_DropDownVC
        vc!.delegate = self
        vc!.itsFrom = "CATALOGUELIST"
        vc!.modalPresentationStyle = .overFullScreen
        vc!.modalTransitionStyle = .crossDissolve
        self.present(vc!, animated: true, completion: nil)
    }
    
    func myRedemptionListApi(startIndex: Int, fromDate: String, toDate: String, status: Int, catalogueType: Int){
        
        //{"ActionType":"52","ActorId":"542","StartIndex":1,"NoOfRows":10,"ObjCatalogueDetails":{"SelectedStatus":"-1","RedemptionTypeId":-1}}
        let parameters = [
            "ActionType": "52",
            "ActorId": self.userID,
            "StartIndex": startIndex,
            "NoOfRows": 10,
            "ObjCatalogueDetails": [
                "SelectedStatus": status,
                "RedemptionTypeId":catalogueType,
                "JFromDate": fromDate,
                "JToDate": toDate,
            ]
        ] as [String : Any]
        print(parameters)
        self.VM.myRedemptionListApi(parameter: parameters)
    }
    
}

@available(iOS 16.0, *)
extension KC_MyRedemptionVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VM.myredemptionListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "KC_MyRedemptionTVC") as! KC_MyRedemptionTVC
        cell.selectionStyle = .none
       
        if  self.VM.myredemptionListArray.count != 0 {
            let redemptionDate = "\(self.VM.myredemptionListArray[indexPath.row].jRedemptionDate ?? "-")".split(separator: " ")
            
            if redemptionDate.count != 0 {
                
                let dateFormatted = convertDateFormater(String(redemptionDate[0]), fromDate: "MM/dd/yyyy", toDate: "dd/MM/yyyy")
                cell.redemptionDateLbl.text = "\(dateFormatted)"
            }else{
                cell.redemptionDateLbl.text = "-"
            }
            
            cell.referenceIdLbl.text = self.VM.myredemptionListArray[indexPath.row].redemptionRefno ?? ""
            
//            if self.VM.myredemptionListArray[indexPath.row].catalogueType ?? "" == "Cash voucher"{
//                cell.qtyLbl.isHidden = true
//                cell.quantityHeadingLbl.isHidden = true
//                cell.productHeaderLbl.isHidden = false
//                cell.productHeaderLbl.text = "Category: Cash Voucher"
//                cell.productTitle.text = "Cash Voucher"
//            }else
            if self.VM.myredemptionListArray[indexPath.row].catalogueType ?? "" == "Catalogue"{
                cell.qtyLbl.isHidden = false
                cell.quantityHeadingLbl.isHidden = false
                cell.productHeaderLbl.isHidden = false
                cell.productHeaderLbl.text = "Category: \(self.VM.myredemptionListArray[indexPath.row].categoryName ?? "")"
                cell.productTitle.text = "Catalogue"
            }else if self.VM.myredemptionListArray[indexPath.row].catalogueType ?? "" == "Voucher"{
                cell.quantityHeadingLbl.isHidden = true
                cell.qtyLbl.isHidden = true
                cell.productHeaderLbl.isHidden = true
                cell.productTitle.text = "Voucher"
            }else if self.VM.myredemptionListArray[indexPath.row].catalogueType ?? "" == "Dream Gift"{
                cell.quantityHeadingLbl.isHidden = true
                cell.qtyLbl.isHidden = true
                cell.productHeaderLbl.isHidden = true
                cell.productTitle.text = "Dream Gift"
            }else if self.VM.myredemptionListArray[indexPath.row].catalogueType ?? "" == "Gift Voucher"{
                cell.quantityHeadingLbl.isHidden = true
                cell.qtyLbl.isHidden = true
                cell.productHeaderLbl.isHidden = true
                cell.productTitle.text = "e-Voucher"
            }else{
                cell.quantityHeadingLbl.isHidden = true
                cell.qtyLbl.isHidden = true
                cell.productHeaderLbl.isHidden = true
                cell.productTitle.text = self.VM.myredemptionListArray[indexPath.row].catalogueType ?? ""
            }
            
            
            if self.VM.myredemptionListArray[indexPath.row].status ?? -1 == 0{
                cell.statusLbl.text = "Pending"
                cell.statusLbl.textColor = UIColor.white
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                cell.statusWidthConstraint.constant = 100
            }else if self.VM.myredemptionListArray[indexPath.row].status ?? -1 == 1{
                cell.statusLbl.text = "Approved"
                cell.statusLbl.textColor = UIColor.white
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0, green: 0.4039181173, blue: 0, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)

            }else if self.VM.myredemptionListArray[indexPath.row].status ?? -1 == 2{
                cell.statusLbl.text = "Processed"
                cell.statusLbl.textColor = UIColor.black
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)
                cell.statusWidthConstraint.constant = 100
            }else if self.VM.myredemptionListArray[indexPath.row].status ?? -1 == 3{
                cell.statusLbl.text = "Cancelled"
                cell.statusLbl.textColor = UIColor.black
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
                cell.statusWidthConstraint.constant = 100
            }else if self.VM.myredemptionListArray[indexPath.row].status ?? -1 == 4{
                cell.statusLbl.text = "Delivered"
                cell.statusLbl.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                cell.statusWidthConstraint.constant = 100
            }else if self.VM.myredemptionListArray[indexPath.row].status ?? -1 == 5{
                cell.statusLbl.text = "Rejected"
                cell.statusLbl.textColor = UIColor.white
                cell.statusLbl.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
                cell.statusWidthConstraint.constant = 100
            }else if self.VM.myredemptionListArray[indexPath.row].status ?? -1 == 7{
                cell.statusLbl.text = "Returned"
                cell.statusLbl.textColor = UIColor.black
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
                cell.statusWidthConstraint.constant = 100
            }else if self.VM.myredemptionListArray[indexPath.row].status ?? -1 == 8{
                cell.statusLbl.text = "Redispatched"
                cell.statusLbl.textColor = UIColor.black
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
                cell.statusWidthConstraint.constant = 100
            }else if self.VM.myredemptionListArray[indexPath.row].status ?? -1 == 9{
                cell.statusLbl.text = "OnHold"
                cell.statusLbl.textColor = UIColor.black
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
                cell.statusWidthConstraint.constant = 100
            }else if self.VM.myredemptionListArray[indexPath.row].status ?? -1 == 10{
                cell.statusLbl.text = "Dispatched"
                cell.statusLbl.textColor = UIColor.black
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
                cell.statusWidthConstraint.constant = 100
            }else if self.VM.myredemptionListArray[indexPath.row].status ?? -1 == 11{
                cell.statusLbl.text = "Out for Delivery"
                cell.statusLbl.textColor = UIColor.black
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                cell.statusWidthConstraint.constant = 150
            }else if self.VM.myredemptionListArray[indexPath.row].status ?? -1 == 12{
                cell.statusLbl.text = "Address Verified"
                cell.statusLbl.textColor = UIColor.black
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
                cell.statusWidthConstraint.constant = 140
            }else if self.VM.myredemptionListArray[indexPath.row].status ?? -1 == 13{
                cell.statusLbl.text = "Posted for approval"
                cell.statusLbl.textColor = UIColor.black
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
                cell.statusWidthConstraint.constant = 180
            }else if self.VM.myredemptionListArray[indexPath.row].status ?? -1 == 14{
                cell.statusLbl.text = "Vendor Alloted"
                cell.statusLbl.textColor = UIColor.black
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
                cell.statusWidthConstraint.constant = 140
            }else if self.VM.myredemptionListArray[indexPath.row].status ?? -1 == 15{
                cell.statusLbl.text = "Vendor Rejected"
                cell.statusLbl.textColor = UIColor.black
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
                cell.statusWidthConstraint.constant = 140
            }else if self.VM.myredemptionListArray[indexPath.row].status ?? -1 == 16{
                cell.statusLbl.text = "Posted for approval 2"
                cell.statusLbl.textColor = UIColor.black
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
                cell.statusWidthConstraint.constant = 200
            }else if self.VM.myredemptionListArray[indexPath.row].status ?? -1 == 17{
                cell.statusLbl.text = "Cancel Request"
                cell.statusLbl.textColor = UIColor.black
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
                cell.statusWidthConstraint.constant = 140
            }else if self.VM.myredemptionListArray[indexPath.row].status ?? -1 == 18{
                cell.statusLbl.text = "Redemption Verified"
                cell.statusLbl.textColor = UIColor.white
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
                cell.statusWidthConstraint.constant = 160
            }else if self.VM.myredemptionListArray[indexPath.row].status ?? -1 == 19{
                cell.statusLbl.text = "Delivery Confirmed"
                cell.statusLbl.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                cell.statusWidthConstraint.constant = 160
            }else if self.VM.myredemptionListArray[indexPath.row].status ?? -1 == 20{
                cell.statusLbl.text = "Return Requested"
                cell.statusLbl.textColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
                cell.statusWidthConstraint.constant = 160
            }else if self.VM.myredemptionListArray[indexPath.row].status ?? -1 == 21{
                cell.statusLbl.text = "Return Pick Up Schedule"
                cell.statusLbl.textColor = UIColor.black
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
                cell.statusWidthConstraint.constant = 200
            }else if self.VM.myredemptionListArray[indexPath.row].status ?? -1 == 22{
                cell.statusLbl.text = "Picked Up"
                cell.statusLbl.textColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
                cell.statusWidthConstraint.constant = 130
            }else if self.VM.myredemptionListArray[indexPath.row].status ?? -1 == 23{
                cell.statusLbl.text = "Return Received"
                cell.statusLbl.textColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
                cell.statusWidthConstraint.constant = 140
            }else if self.VM.myredemptionListArray[indexPath.row].status ?? -1 == 24{
                cell.statusLbl.text = "In Transit"
                cell.statusLbl.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                cell.statusWidthConstraint.constant = 140
            }else{
                cell.statusLbl.text = "-"
                cell.statusLbl.textColor = UIColor.white
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
            }
            
            
            cell.productNameLbl.text = self.VM.myredemptionListArray[indexPath.row].productName ?? ""
            cell.pointsPerUnitLbl.text = "\(Int(self.VM.myredemptionListArray[indexPath.row].redemptionPoints ?? 0.0) )"
            cell.qtyLbl.text = "\(self.VM.myredemptionListArray[indexPath.row].quantity ?? 0)"
            
            
            let imageURL = self.VM.myredemptionListArray[indexPath.row].productImage ?? ""
            if self.VM.myredemptionListArray[indexPath.row].catalogueType ?? "" == "Gift Voucher"{
                let urlt = URL(string: "\(imageURL)")
                cell.productImageView.sd_setImage(with: urlt, placeholderImage: #imageLiteral(resourceName: "ic_default_img"))
            }else{
                if imageURL != ""{
                    let urltoUse = String(productCatalogueImgURL + imageURL).replacingOccurrences(of: " ", with: "%20")
                    let urlt = URL(string: "\(urltoUse)")
                    cell.productImageView.sd_setImage(with: urlt!, placeholderImage: #imageLiteral(resourceName: "ic_default_img"))
                }else{
                    cell.productImageView.image = UIImage(named: "ic_default_img")
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HRD_MyRedemptionDetailsVC") as! HRD_MyRedemptionDetailsVC
        vc.categoryType = self.VM.myredemptionListArray[indexPath.row].catalogueType ?? ""
        vc.categoryName = self.VM.myredemptionListArray[indexPath.item].categoryName ?? ""
        vc.totalPoint = "\(Int(self.VM.myredemptionListArray[indexPath.item].redemptionPoints ?? 0.0) )"
        vc.productName = self.VM.myredemptionListArray[indexPath.item].productName ?? ""
        vc.quantity = "\(self.VM.myredemptionListArray[indexPath.item].quantity ?? 0)"
        vc.productImage = self.VM.myredemptionListArray[indexPath.item].productImage ?? ""
        vc.redemptionRefNo = self.VM.myredemptionListArray[indexPath.item].redemptionRefno ?? ""
        vc.descDetails = self.VM.myredemptionListArray[indexPath.item].productDesc ?? ""
        vc.termsandContions = self.VM.myredemptionListArray[indexPath.item].termsCondition ?? ""
        vc.redemptionPoints = "\(self.VM.myredemptionListArray[indexPath.item].redemptionPoints ?? 0)"
        vc.status = "\(self.VM.myredemptionListArray[indexPath.item].status ?? 0)"
        vc.customerId = "\(self.userID)"
        let strDate = self.VM.myredemptionListArray[indexPath.row].jRedemptionDate ?? "01/01/0001  00:00:00"
        let array = strDate.components(separatedBy: " ")
        if array.count != 0{
            let dateFormatted = convertDateFormater(String(array[0]), fromDate: "MM/dd/yyyy", toDate: "dd/MM/yyyy")
            vc.redemptionsDate = "\(dateFormatted)"
        }else{
            vc.redemptionsDate = "-"
        }
        vc.redemptionsstatus = String(self.VM.myredemptionListArray[indexPath.row].status ?? 0) 
        
       // vc.cartCounts = self.cartCount.text!
        vc.redemptionId = "\(self.VM.myredemptionListArray[indexPath.item].redemptionId ?? 0)"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 230
//    }
//
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       
            if indexPath.row == self.VM.myredemptionListArray.count - 1{
                if self.noofelements == 10{
                    self.startIndex = self.startIndex + 1
                    self.myRedemptionListApi(startIndex: self.startIndex, fromDate: self.selectedFromDate, toDate: self.selectedToDate, status: self.selectedStatusId, catalogueType: self.selectedCatalogueId)
                }else if self.noofelements > 10{
                    self.startIndex = self.startIndex + 1
                    self.myRedemptionListApi(startIndex: self.startIndex, fromDate: self.selectedFromDate, toDate: self.selectedToDate, status: self.selectedStatusId, catalogueType: self.selectedCatalogueId)
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
