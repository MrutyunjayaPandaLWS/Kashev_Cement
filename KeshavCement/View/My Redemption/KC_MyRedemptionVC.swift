//
//  KC_MyRedemptionVC.swift
//  KeshavCement
//
//  Created by Arokia-M3 on 02/01/23.
//

import UIKit
import SDWebImage
class KC_MyRedemptionVC: BaseViewController, DateSelectedDelegate {
    func acceptDate(_ vc: KC_DOBVC) {
        if vc.isComeFrom == "1"{
            self.selectedFromDate = vc.selectedDate
            self.selectFromDate.text = vc.selectedDate
        }else{
            self.selectedToDate = vc.selectedDate
            self.selectToDate.text = vc.selectedDate
        }
    }
    
    func declineDate(_ vc: KC_DOBVC) {}

    @IBOutlet var myRedemptionHeaderLbl: UILabel!
    @IBOutlet var myRedemptionTV: UITableView!
    
    @IBOutlet weak var filterLbl: UILabel!
    
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var myRedemptionFilterLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var pendingBtn: UIButton!
    @IBOutlet weak var approvedBtn: UIButton!
    @IBOutlet weak var rejectedBtn: UIButton!
    @IBOutlet weak var dateRangeLbl: UILabel!
    
    @IBOutlet weak var selectFromDate: UILabel!
    
    @IBOutlet weak var selectToDate: UILabel!
    
    @IBOutlet weak var applyFilterButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    
    var VM = KC_MyRedemptionListVM()
    
        var noofelements = 0
        var startIndex = 1
        var selectedStatus = -1
        var selectedFromDate = ""
        var selectedToDate = ""
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.filterView.isHidden = true
        self.myRedemptionTV.delegate = self
        self.myRedemptionTV.dataSource = self
        self.myRedemptionTV.separatorStyle = .none
        
        self.myRedemptionTV.register(UINib(nibName: "KC_MyRedemptionTVC", bundle: nil), forCellReuseIdentifier: "KC_MyRedemptionTVC")
        self.myRedemptionListApi(startIndex: 1, fromDate: "", toDate: "", status: -1)
    }

    @IBAction func filterActBtn(_ sender: Any) {
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
            self.VM.myredemptionListArray.removeAll()
            self.myRedemptionListApi(startIndex: 1, fromDate: self.selectedFromDate, toDate: self.selectedToDate, status: -3)
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
        self.approvedBtn.backgroundColor = UIColor(hexString: "565656")
        self.pendingBtn.backgroundColor = UIColor(hexString: "565656")
        self.rejectedBtn.backgroundColor = UIColor(hexString: "565656")
        
        self.pendingBtn.setTitleColor(.white, for: .normal)
        self.approvedBtn.setTitleColor(.white, for: .normal)
        self.rejectedBtn.setTitleColor(.white, for: .normal)
     
        self.selectedStatus = -1
        self.selectFromDate.text = "Select From date"
        self.selectToDate.text = "Select To date"
        self.myRedemptionListApi(startIndex: 1, fromDate: "", toDate: "", status: -1)
    }
    @IBAction func applyFilterBtn(_ sender: Any) {
        if self.selectedStatus == -1 && self.selectedFromDate == "" && self.selectedToDate == ""{
            self.view.makeToast("Select any select or date range", duration: 2.0, position: .bottom)
        }else if self.selectedFromDate == "" && self.selectedToDate == "" && self.selectedStatus != -1{
            self.VM.myredemptionListArray.removeAll()
            self.myRedemptionListApi(startIndex: 1, fromDate: self.selectedFromDate, toDate: self.selectedToDate, status: self.selectedStatus)
        }else if self.selectedFromDate != "" && self.selectedToDate == ""{
            self.view.makeToast("Select To date", duration: 2.0, position: .bottom)
        }else if self.selectedFromDate == "" && self.selectedToDate != ""{
            self.view.makeToast("Select From date", duration: 2.0, position: .bottom)
        }else if self.selectedFromDate != "" && self.selectedToDate != ""{
            if self.selectedFromDate > self.selectedToDate{
                self.view.makeToast("To date shouldn't greater than From date", duration: 2.0, position: .bottom)
            }else{
                self.VM.myredemptionListArray.removeAll()
                self.myRedemptionListApi(startIndex: 1, fromDate: self.selectedFromDate, toDate: self.selectedToDate, status: self.selectedStatus)
                    self.filterView.isHidden = true
            }
        }
    }
    @IBAction func approvedButton(_ sender: Any) {
        self.approvedBtn.backgroundColor = UIColor(hexString: "FFFC9C")
        self.pendingBtn.backgroundColor = UIColor(hexString: "565656")
        self.rejectedBtn.backgroundColor = UIColor(hexString: "565656")
        
        self.pendingBtn.setTitleColor(.white, for: .normal)
        self.approvedBtn.setTitleColor(.darkGray, for: .normal)
        self.rejectedBtn.setTitleColor(.white, for: .normal)
        self.selectedStatus = 4
        self.VM.myredemptionListArray.removeAll()
        self.myRedemptionListApi(startIndex: 1, fromDate: self.selectedFromDate, toDate: self.selectedToDate, status: self.selectedStatus)
    }
    
    @IBAction func pendingButton(_ sender: Any) {
        self.approvedBtn.backgroundColor = UIColor(hexString: "565656")
        self.pendingBtn.backgroundColor = UIColor(hexString: "FFFC9C")
        
        self.rejectedBtn.backgroundColor = UIColor(hexString: "565656")
        self.approvedBtn.setTitleColor(.white, for: .normal)
        self.pendingBtn.setTitleColor(.darkGray, for: .normal)
        self.rejectedBtn.setTitleColor(.white, for: .normal)
        self.selectedStatus = 0
        self.VM.myredemptionListArray.removeAll()
        self.myRedemptionListApi(startIndex: 1, fromDate: self.selectedFromDate, toDate: self.selectedToDate, status: self.selectedStatus)
    }
    
    @IBAction func rejectedButton(_ sender: Any) {
        self.approvedBtn.backgroundColor = UIColor(hexString: "565656")
        self.pendingBtn.backgroundColor = UIColor(hexString: "565656")
        self.rejectedBtn.backgroundColor = UIColor(hexString: "FFFC9C")
        
        self.approvedBtn.setTitleColor(.white, for: .normal)
        self.rejectedBtn.setTitleColor(.darkGray, for: .normal)
        self.pendingBtn.setTitleColor(.white, for: .normal)
        self.selectedStatus = 5
        self.VM.myredemptionListArray.removeAll()
        self.myRedemptionListApi(startIndex: 1, fromDate: self.selectedFromDate, toDate: self.selectedToDate, status: self.selectedStatus)
    }
    
    func myRedemptionListApi(startIndex: Int, fromDate: String, toDate: String, status: Int){
        let parameters = [
            "ActionType": "52",
            "ActorId": self.userID,
            "StartIndex": startIndex,
            "NoOfRows": 10,
            "FromDate": fromDate,
            "ToDate": toDate,
            "ObjCatalogueDetails": [
                "SelectedStatus": status,
                "RedemptionTypeId": -1
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
                cell.redemptionDateLbl.text = "\(redemptionDate[0])"
            }else{
                cell.redemptionDateLbl.text = "-"
            }
            
            cell.toNameLbl.text = self.VM.myredemptionListArray[indexPath.row].fullName ?? ""
            if self.VM.myredemptionListArray[indexPath.row].status ?? -1 == 0{
                cell.statusLbl.text = "Pending"
                cell.statusLbl.textColor = UIColor.black
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
            }
//            else if self.VM.myredemptionListArray[indexPath.row].status ?? -1 == 4{
//                cell.statusLbl.text = "Approved"
//
//                cell.statusLbl.textColor = UIColor.black
//                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
//                cell.statusLbl.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
//
//            }
            else if self.VM.myredemptionListArray[indexPath.row].status ?? -1 == 5{
                cell.statusLbl.text = "Rejected"
                cell.statusLbl.textColor = UIColor.white
                cell.statusLbl.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            }else if self.VM.myredemptionListArray[indexPath.row].status ?? -1 == 2{
                cell.statusLbl.text = "Processed"
                cell.statusLbl.textColor = UIColor.black
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)
            }else if self.VM.myredemptionListArray[indexPath.row].status ?? -1 == 3{
                cell.statusLbl.text = "Cancelled"
                cell.statusLbl.textColor = UIColor.black
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
            }else if self.VM.myredemptionListArray[indexPath.row].status ?? -1 == 4{
                cell.statusLbl.text = "Delivered"
                cell.statusLbl.textColor = UIColor.white
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
            }else if self.VM.myredemptionListArray[indexPath.row].status ?? -1 == 7{
                cell.statusLbl.text = "Returned"
                cell.statusLbl.textColor = UIColor.black
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
            }else if self.VM.myredemptionListArray[indexPath.row].status ?? -1 == 8{
                cell.statusLbl.text = "Redispatched"
                cell.statusLbl.textColor = UIColor.black
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
            }else if self.VM.myredemptionListArray[indexPath.row].status ?? -1 == 9{
                cell.statusLbl.text = "OnHold"
                cell.statusLbl.textColor = UIColor.black
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
            }else if self.VM.myredemptionListArray[indexPath.row].status ?? -1 == 10{
                cell.statusLbl.text = "Dispatched"
                cell.statusLbl.textColor = UIColor.black
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
            }else if self.VM.myredemptionListArray[indexPath.row].status ?? -1 == 11{
                cell.statusLbl.text = "Out for Delivery"
                cell.statusLbl.textColor = UIColor.black
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
            }else if self.VM.myredemptionListArray[indexPath.row].status ?? -1 == 12{
                cell.statusLbl.text = "Address Verified"
                cell.statusLbl.textColor = UIColor.black
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            }else if self.VM.myredemptionListArray[indexPath.row].status ?? -1 == 13{
                cell.statusLbl.text = "Posted for approval"
                cell.statusLbl.textColor = UIColor.black
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
            }else if self.VM.myredemptionListArray[indexPath.row].status ?? -1 == 14{
                cell.statusLbl.text = "Vendor Alloted"
                cell.statusLbl.textColor = UIColor.black
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
            }else if self.VM.myredemptionListArray[indexPath.row].status ?? -1 == 15{
                cell.statusLbl.text = "Vendor Rejected"
                cell.statusLbl.textColor = UIColor.black
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
            }else if self.VM.myredemptionListArray[indexPath.row].status ?? -1 == 16{
                cell.statusLbl.text = "Posted for approval 2"
                cell.statusLbl.textColor = UIColor.black
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
            }else if self.VM.myredemptionListArray[indexPath.row].status ?? -1 == 17{
                cell.statusLbl.text = "Cancel Request"
                cell.statusLbl.textColor = UIColor.black
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
            }else if self.VM.myredemptionListArray[indexPath.row].status ?? -1 == 18{
                cell.statusLbl.text = "Redemption Verified"
                cell.statusLbl.textColor = UIColor.black
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
            }else if self.VM.myredemptionListArray[indexPath.row].status ?? -1 == 19{
                cell.statusLbl.text = "Delivery Confirmed"
                cell.statusLbl.textColor = UIColor.black
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
            }else if self.VM.myredemptionListArray[indexPath.row].status ?? -1 == 20{
                cell.statusLbl.text = "Return Requested"
                cell.statusLbl.textColor = UIColor.black
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
            }else if self.VM.myredemptionListArray[indexPath.row].status ?? -1 == 21{
                cell.statusLbl.text = "Return Pick Up Schedule"
                cell.statusLbl.textColor = UIColor.black
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
            }else if self.VM.myredemptionListArray[indexPath.row].status ?? -1 == 22{
                cell.statusLbl.text = "Picked Up"
                cell.statusLbl.textColor = UIColor.black
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
            }else if self.VM.myredemptionListArray[indexPath.row].status ?? -1 == 23{
                cell.statusLbl.text = "Return Received"
                cell.statusLbl.textColor = UIColor.black
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
            }else if self.VM.myredemptionListArray[indexPath.row].status ?? -1 == 24{
                cell.statusLbl.text = "In Transit"
                cell.statusLbl.textColor = UIColor.black
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
            }else{
                cell.statusLbl.text = "-"
                cell.statusLbl.textColor = UIColor.black
                cell.statusLbl.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
                cell.statusLbl.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
            }
            cell.productHeaderLbl.text = "Catalogue / \(self.VM.myredemptionListArray[indexPath.row].categoryName ?? "")"
            cell.productNameLbl.text = self.VM.myredemptionListArray[indexPath.row].productName ?? ""
            cell.pointsPerUnitLbl.text = "\(self.VM.myredemptionListArray[indexPath.row].pointsPerUnit ?? 0)"
            cell.qtyLbl.text = "\(self.VM.myredemptionListArray[indexPath.row].quantity ?? 0)"
            
            let imageURL = self.VM.myredemptionListArray[indexPath.row].productImage ?? ""
            if imageURL != ""{
                let urltoUse = String(productCatalogueImgURL + imageURL).replacingOccurrences(of: " ", with: "%20")
                let urlt = URL(string: "\(urltoUse)")
                cell.productImageView.sd_setImage(with: urlt!, placeholderImage: #imageLiteral(resourceName: "ic_default_img"))
            }else{
                cell.productImageView.image = UIImage(named: "ic_default_img")
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
        
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       
            if indexPath.row == self.VM.myredemptionListArray.count - 1{
                if self.noofelements == 10{
                    self.startIndex = self.startIndex + 1
                    self.myRedemptionListApi(startIndex: self.startIndex, fromDate: self.selectedFromDate, toDate: self.selectedToDate, status: self.selectedStatus)
                }else if self.noofelements > 10{
                    self.startIndex = self.startIndex + 1
                    self.myRedemptionListApi(startIndex: self.startIndex, fromDate: self.selectedFromDate, toDate: self.selectedToDate, status: self.selectedStatus)
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
