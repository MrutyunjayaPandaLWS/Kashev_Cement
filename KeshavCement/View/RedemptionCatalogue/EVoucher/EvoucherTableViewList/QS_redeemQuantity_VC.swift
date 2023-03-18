//
//  QS_redeemQuantity_VC.swift
//  Quba Safalta
//
//  Created by Arokia-M3 on 24/03/21.
//

import UIKit
//import LanguageManager_iOS

protocol pointsDelegate : class {
    func selectPointsDidTap(_ VC: QS_redeemQuantity_VC)
}

class QS_redeemQuantity_VC: BaseViewController, UITableViewDelegate, UITableViewDataSource, popUpAlertDelegate {
    func popupAlertDidTap(_ vc: RGT_popupAlertOne_VC) {}
    
     let vm = QS_redeemQuantity_VM()
    @IBOutlet var pointsTableView: UITableView!
    @IBOutlet var selectAmountLabel: UILabel!
    var productCodefromPrevious = ""
    //let userID = UserDefaults.standard.string(forKey: "UserID") ?? "-1"
    var delegate:pointsDelegate?
    var selectedpoints = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vm.VC = self
        self.pointsTableView.delegate = self
        self.pointsTableView.dataSource = self
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RGT_popupAlertOne_VC") as? RGT_popupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "No Internet. Please check your internet connection"
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
        }else{
        self.vm.myVouchersAPI(userID: userID, productCode: productCodefromPrevious)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
        {
            let touch = touches.first
            if touch?.view == self.view {
                self.dismiss(animated: true, completion: nil) }
        }
    
}
extension QS_redeemQuantity_VC{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.vm.filteredpointsArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QS_PointsVoucher_TVC", for: indexPath) as? QS_PointsVoucher_TVC
        cell?.pointsLabel.text = String(self.vm.filteredpointsArray[indexPath.row].fixedPoints ?? 0)
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedpoints = self.vm.filteredpointsArray[indexPath.row].fixedPoints ?? 0
        self.delegate?.selectPointsDidTap(self)
        self.dismiss(animated: true, completion: nil)
    }
}
