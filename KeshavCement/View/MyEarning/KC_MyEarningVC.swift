//
//  KC_MyEarningVC.swift
//  KeshavCement
//
//  Created by Arokia-M3 on 02/01/23.
//

import UIKit
import LanguageManager_iOS

class KC_MyEarningVC: BaseViewController, DateSelectedDelegate {
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
    
    @IBOutlet weak var dateRangeLbl: UILabel!
    @IBOutlet weak var myEarningFilter: UILabel!
    @IBOutlet var myEarningHeaderLbl: UILabel!
    @IBOutlet var filterHeadingLbl: UILabel!
    @IBOutlet var myEarningTV: UITableView!
    
    @IBOutlet weak var applyFilterBtn: UIButton!
    @IBOutlet weak var clearBtn: UIButton!
    @IBOutlet weak var selectToDateLbl: UILabel!
    @IBOutlet weak var selectFromDateLbl: UILabel!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var noDataFoundLbl: UILabel!
    
    
    
    var VM = KC_MyEarningVM()
    var selectedFromDate = ""
    var selectedToDate = ""
    var startIndex = 1
    var noofelements = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.noDataFoundLbl.isHidden = true
        self.filterView.isHidden = true
        self.myEarningTV.delegate = self
        self.myEarningTV.dataSource = self
        self.myEarningTV.separatorStyle = .none
        self.myEarningTV.register(UINib(nibName: "KC_MyEarningTVC", bundle: nil), forCellReuseIdentifier: "KC_MyEarningTVC")
        self.myEarningHeaderLbl.text = "MyEarning".localiz()
        self.filterHeadingLbl.text = "Filter".localiz()
        self.myEarningFilter.text = "MyEarningFilter".localiz()
        self.dateRangeLbl.text = "DateRange".localiz()
        self.selectFromDateLbl.text = "SelectFromDate".localiz()
        self.selectToDateLbl.text = "SelectToDate".localiz()
        self.clearBtn.setTitle("Clear".localiz(), for: .normal)
        self.applyFilterBtn.setTitle("ApplyFilter".localiz(), for: .normal)
        self.noDataFoundLbl.text = "NoDataFound".localiz()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.startIndex = 1
        self.VM.myEarningListArray.removeAll()
        self.myEarningListApi(StartIndex: self.startIndex, fromDate: self.selectedFromDate, toDate: self.selectedToDate)
    }
    
    @IBAction func myEarningFilterBtn(_ sender: Any) {
        if self.filterView.isHidden == false{
            self.filterView.isHidden = true
        }else{
            self.filterView.isHidden = false
            self.startIndex = 1
            self.VM.myEarningListArray.removeAll()
            self.myEarningListApi(StartIndex: self.startIndex, fromDate: self.selectedFromDate, toDate: self.selectedToDate)
        }
    }
    @IBAction func backActBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
    @IBAction func clearButton(_ sender: Any) {
        self.selectFromDateLbl.text = "SelectFromDate".localiz()
        self.selectToDateLbl.text = "SelectToDate".localiz()
        self.startIndex = 1
        self.VM.myEarningListArray.removeAll()
        self.myEarningListApi(StartIndex: self.startIndex, fromDate: self.selectedFromDate, toDate: self.selectedToDate)
    }
    @IBAction func applyFilterButton(_ sender: Any) {
        if self.selectedFromDate == "" && self.selectedToDate == ""{
            self.view.makeToast("SelectDateRange".localiz(), duration: 2.0, position: .bottom)
        }else if self.selectedFromDate != "" && self.selectedToDate == ""{
            self.view.makeToast("SelectToDate".localiz(), duration: 2.0, position: .bottom)
        }else if self.selectedFromDate == "" && self.selectedToDate != ""{
            self.view.makeToast("SelectFromDate".localiz(), duration: 2.0, position: .bottom)
        }else if self.selectedFromDate != "" && self.selectedToDate != ""{
            if self.selectedFromDate > self.selectedToDate{
                self.view.makeToast("TodateshouldntgreaterthanFromdate".localiz(), duration: 2.0, position: .bottom)
            }else{
                self.filterView.isHidden = true
                self.VM.myEarningListArray.removeAll()
                self.myEarningListApi(StartIndex: self.startIndex, fromDate: self.selectedFromDate, toDate: self.selectedToDate)
            }
        }
    }
    @IBAction func closeButton(_ sender: Any) {
        self.filterView.isHidden = true
    }
    
    func myEarningListApi(StartIndex: Int, fromDate: String, toDate: String){
        
        let parameter = [
            "ActorId": self.userID,
            "StartIndex": StartIndex,
            "PageSize": 10,
            "JFromDate": fromDate,
            "JToDate": toDate
        ] as [String: Any]
        print(parameter)
        self.VM.myEarningListApi(parameter: parameter)
    }
}
extension KC_MyEarningVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VM.myEarningListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "KC_MyEarningTVC") as! KC_MyEarningTVC
        cell.selectionStyle = .none
        let receivedDate = String(self.VM.myEarningListArray[indexPath.row].jTranDate ?? "-").split(separator: " ")
        if receivedDate.count != 0 {
            cell.dateHeaderLbl.text = "\(receivedDate[0])"
            cell.timeLbl.text = "\(receivedDate[1])"
        }else{
            cell.dateHeaderLbl.text = "-"
            cell.timeLbl.text = "-"
        }
        cell.pointsLbl.text = "\(Int(self.VM.myEarningListArray[indexPath.row].rewardPoints ?? 0.0))"
        cell.productNameLbl.text = self.VM.myEarningListArray[indexPath.row].prodName ?? "-"
        if self.VM.myEarningListArray[indexPath.row].transactionType ?? "" == "BONUS"{
            cell.remarksDetailsLbl.text = self.VM.myEarningListArray[indexPath.row].bonusName ?? "-"
        }else if self.VM.myEarningListArray[indexPath.row].transactionType ?? "" == "Referral"{
            cell.remarksDetailsLbl.text = "Referral Complimentary"
        }else if self.VM.myEarningListArray[indexPath.row].transactionType ?? "" == "Enrollment Complimentary"{
            cell.remarksDetailsLbl.text = "Enrollment Complimentary"
        }else if self.VM.myEarningListArray[indexPath.row].transactionType ?? "" == "WORKSITE"{
            cell.remarksDetailsLbl.text = "Worksite Program"
        }else{
            if self.VM.myEarningListArray[indexPath.row].invoiceNo ?? "" == "--"{
                cell.remarksDetailsLbl.text = "Reward Adjusted"
            }else{
                cell.remarksDetailsLbl.text = self.VM.myEarningListArray[indexPath.row].remarks ?? "-"
            }
        }
        
        if String(self.VM.myEarningListArray[indexPath.row].loyaltyId ?? "").contains("~"){
            let splitted = String(self.VM.myEarningListArray[indexPath.row].loyaltyId ?? "").split(separator: "~")
            print(splitted.count)
            if splitted.count != 0 {
                print(splitted[0])
                
                    print(splitted[1])
                    cell.customerTypeNameLbl.text = "\(splitted[1])"
                    print(splitted[2])
                    cell.dealerTypeLbl.text = "\(splitted[2])"
                }
            }else{
            cell.dealerTypeLbl.text = self.customerType
            cell.customerTypeNameLbl.text = self.userFullName
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       
            if indexPath.row == self.VM.myEarningListArray.count - 1{
                if self.noofelements == 10{
                    self.startIndex = self.startIndex + 1
                    self.myEarningListApi(StartIndex: self.startIndex, fromDate: self.selectedFromDate, toDate: self.selectedToDate)
                }else if self.noofelements > 10{
                    self.startIndex = self.startIndex + 1
                    self.myEarningListApi(StartIndex: self.startIndex, fromDate: self.selectedFromDate, toDate: self.selectedToDate)
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
