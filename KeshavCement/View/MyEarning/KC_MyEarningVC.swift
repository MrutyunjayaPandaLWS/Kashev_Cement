//
//  KC_MyEarningVC.swift
//  KeshavCement
//
//  Created by Arokia-M3 on 02/01/23.
//

import UIKit

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
    
    var VM = KC_MyEarningVM()
    var selectedFromDate = ""
    var selectedToDate = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.filterView.isHidden = true
        self.myEarningTV.delegate = self
        self.myEarningTV.dataSource = self
        self.myEarningTV.separatorStyle = .none
        self.myEarningTV.register(UINib(nibName: "KC_MyEarningTVC", bundle: nil), forCellReuseIdentifier: "KC_MyEarningTVC")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.VM.myEarningListArray.removeAll()
        self.myEarningListApi(fromDate: self.selectedFromDate, toDate: self.selectedToDate)
    }
    
    @IBAction func myEarningFilterBtn(_ sender: Any) {
        if self.filterView.isHidden == false{
            self.filterView.isHidden = true
        }else{
            self.filterView.isHidden = false
            self.VM.myEarningListArray.removeAll()
            self.myEarningListApi(fromDate: self.selectedFromDate, toDate: self.selectedToDate)
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
        self.selectFromDateLbl.text = "Select From date"
        self.selectToDateLbl.text = "Select To date"
        self.VM.myEarningListArray.removeAll()
        self.myEarningListApi(fromDate: self.selectedFromDate, toDate: self.selectedToDate)
    }
    @IBAction func applyFilterButton(_ sender: Any) {
        if self.selectedFromDate == "" && self.selectedToDate == ""{
            self.view.makeToast("Select date range", duration: 2.0, position: .bottom)
        }else if self.selectedFromDate != "" && self.selectedToDate == ""{
            self.view.makeToast("Select To date", duration: 2.0, position: .bottom)
        }else if self.selectedFromDate == "" && self.selectedToDate != ""{
            self.view.makeToast("Select From date", duration: 2.0, position: .bottom)
        }else if self.selectedFromDate != "" && self.selectedToDate != ""{
            if self.selectedFromDate > self.selectedToDate{
                self.view.makeToast("To date shouldn't greater than From date", duration: 2.0, position: .bottom)
            }else{
                self.filterView.isHidden = true
                self.VM.myEarningListArray.removeAll()
                self.myEarningListApi(fromDate: self.selectedFromDate, toDate: self.selectedToDate)
            }
        }
    }
    
    func myEarningListApi(fromDate: String, toDate: String){
        
        let parameter = [
            "ActorId": self.userID,
            "BehaviorId": 0,
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
        cell.pointsLbl.text = "\(self.VM.myEarningListArray[indexPath.row].rewardPoints ?? 0.0)"
        cell.remarksDetailsLbl.text = self.VM.myEarningListArray[indexPath.row].remarks ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
    }
    
}
