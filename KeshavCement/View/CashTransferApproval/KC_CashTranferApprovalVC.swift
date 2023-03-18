//
//  KC_CashTranferApprovalVC.swift
//  KeshavCement
//
//  Created by ADMIN on 13/01/2023.
//

import UIKit
import Toast_Swift

class KC_CashTranferApprovalVC: BaseViewController {

    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var headerText: UILabel!
    @IBOutlet weak var cashTransferApprovalTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.cashTransferApprovalTableView.delegate = self
        self.cashTransferApprovalTableView.dataSource = self
        self.cashTransferApprovalTableView.isHidden = true
        self.view.makeToast("No Data Found!!", duration: 5.0, position: .bottom)
    }
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func searchEditingDidEnd(_ sender: Any) {
        //
    }
    
}
extension KC_CashTranferApprovalVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "KC_CashTransferApprovalTVC", for: indexPath) as! KC_CashTransferApprovalTVC
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
    }
}
