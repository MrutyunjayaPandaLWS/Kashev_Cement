//
//  KC_CashTranferHistoryVC.swift
//  KeshavCement
//
//  Created by ADMIN on 13/01/2023.
//

import UIKit

class KC_CashTranferHistoryVC: BaseViewController {
    
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
    
    @IBOutlet weak var selectFromDateLbl: UILabel!
    
    @IBOutlet weak var selectToDateLbl: UILabel!
    
    @IBOutlet weak var subDealerBtn: UIButton!
    
    @IBOutlet weak var clearButton: UIButton!
    
    @IBOutlet weak var masonBtn: UIButton!
    @IBOutlet weak var engineerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.filterView.isHidden = true
        self.cashHistoryTableView.delegate = self
        self.cashHistoryTableView.dataSource = self
        self.cashHistoryTableView.isHidden = true
        self.view.makeToast("No Data Found!!", duration: 5.0, position: .bottom)
    }

    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func filterBtn(_ sender: Any) {
        if self.filterView.isHidden == false{
            self.filterView.isHidden = true
        }else{
            self.filterView.isHidden = false
        }
    }
    
    @IBAction func closeBtn(_ sender: Any) {
        self.filterView.isHidden = true
    }
    
    @IBAction func apprveBtn(_ sender: Any) {
    }
    
    @IBAction func pendinButton(_ sender: Any) {
    }
    @IBAction func rejeectBtn(_ sender: Any) {
    }
    
    
    @IBAction func selectFromDateBtn(_ sender: Any) {
    }
    @IBAction func selectToDateBtn(_ sender: Any) {
    }
    
    
    @IBAction func clearBtn(_ sender: Any) {
    }
    
    @IBAction func applyFilterBtn(_ sender: Any) {
    }
    
    @IBAction func subDealerBtn(_ sender: Any) {
    }
    
    @IBAction func engineerBtn(_ sender: Any) {
    }
    
    @IBAction func masonButton(_ sender: Any) {
    }
}
extension KC_CashTranferHistoryVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "KC_CashTranferHistoryTVC", for: indexPath) as! KC_CashTranferHistoryTVC
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}
