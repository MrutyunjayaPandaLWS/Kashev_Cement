//
//  KC_DealerHelpPopUp.swift
//  KeshavCement
//
//  Created by ADMIN on 22/04/2023.
//

import UIKit

class KC_DealerHelpPopUp: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var popUpDetailsTableView: UITableView!
    
    @IBOutlet weak var tableHeightConstratin: NSLayoutConstraint!
    
    var VM = DealerHelpVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.popUpDetailsTableView.dataSource = self
        self.popUpDetailsTableView.delegate = self
        let parameter = [
            "ActionType": 4,
            "ActorId": self.userID
        ] as [String: Any]
        print(parameter)
        self.VM.dealerPopUpList(parameter: parameter)
    }
    
    
    @IBAction func okButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VM.productDetailsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "KC_DealerHelpTVC", for: indexPath) as! KC_DealerHelpTVC
        cell.productNameLbl.text = self.VM.productDetailsArray[indexPath.row].productName ?? ""
        cell.quantityLbl.text = self.VM.productDetailsArray[indexPath.row].quantity ?? ""
        return cell
    }

    
}
