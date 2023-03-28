//
//  KC_MyCartVC.swift
//  KeshavCement
//
//  Created by ADMIN on 07/01/2023.
//

import UIKit

class KC_MyCartVC: BaseViewController, MyCartDelegate {

    @IBOutlet weak var placeOrderBtn: UIButton!
    @IBOutlet weak var totalPoints: UILabel!
    @IBOutlet weak var totalPts: UILabel!
    @IBOutlet weak var subview: UIView!
    @IBOutlet weak var myCartListTableView: UITableView!
    @IBOutlet weak var cartCountLbl: UILabel!
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var noDataFoundLbl: UILabel!
    
    var VM = KC_MyCartVM()
    var pointBalance = UserDefaults.standard.double(forKey: "RedeemablePointBalance")
    var customerCartId = 0
    var quantity = 1
    var productValue = ""
    var finalPoints = 0
    var partyLoyaltyId = ""
    let verifiedStatus = UserDefaults.standard.integer(forKey: "VerifiedStatus")
    var checkAccountStatus = UserDefaults.standard.string(forKey: "SemiActiveAccount") ?? ""
    var isRedeemable = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.myCartListTableView.delegate = self
        self.myCartListTableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.noDataFoundLbl.isHidden = true
        if self.customerTypeId == "3" && self.partyLoyaltyId != "" || self.customerTypeId == "4" && self.partyLoyaltyId != ""{
            self.VM.getMycartList(PartyLoyaltyID: self.loyaltyId, LoyaltyID: self.partyLoyaltyId)
        }else if self.customerTypeId == "3" && self.partyLoyaltyId == "" || self.customerTypeId == "4" && self.partyLoyaltyId == ""{
            self.VM.getMycartList(PartyLoyaltyID: "", LoyaltyID: self.loyaltyId)
        }else{
            self.VM.getMycartList(PartyLoyaltyID: "", LoyaltyID: self.loyaltyId)
         }
    }

    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

    @IBAction func placeOrderBtn(_ sender: Any) {
        
//        if self.isRedeemable == 1{
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_OrderConfirmationVC") as! KC_OrderConfirmationVC
        vc.totalRedemmablePts = Int(self.finalPoints)
        vc.partyLoyaltyId = self.partyLoyaltyId
            self.navigationController?.pushViewController(vc, animated: true)
//        }else{
//            self.view.makeToast("You are not allowled to redeem .Please contact your administrator", duration: 2.0, position: .bottom)
//        }

    }
    
    
    //Delegate:-
 
    func increaseCount(_ cell: KC_MyCartTVC) {
        guard let tappedIndexPath = self.myCartListTableView.indexPath(for: cell) else{return}
        if cell.plusButton.tag == tappedIndexPath.row{
            if Int(self.VM.myCartListArray[tappedIndexPath.row].sumOfTotalPointsRequired ?? 0.0) <= Int(self.pointBalance) ?? 0{
                let calcValue = Int(self.VM.myCartListArray[tappedIndexPath.row].sumOfTotalPointsRequired ?? 0.0) + Int(self.VM.myCartListArray[tappedIndexPath.row].pointsPerUnit ?? 0)
                print(calcValue, "Calculated Values")
                if calcValue <= Int(self.pointBalance) ?? 0{
                    let totalQTY = Int(self.VM.myCartListArray[tappedIndexPath.row].noOfQuantity ?? 0) + 1
                    self.quantity = totalQTY
                    cell.countTF.text = "\(quantity)"
                    self.customerCartId = self.VM.myCartListArray[tappedIndexPath.row].customerCartId ?? 0
                   
                    
                    if self.customerTypeId ?? "" == "3" && self.partyLoyaltyId != "" || self.customerTypeId ?? "" == "4" && self.partyLoyaltyId != ""{
                      
                            self.increaseProduct(PartyLoyaltyID: self.partyLoyaltyId)
                       
                    }else if self.customerTypeId ?? "" == "3" && self.partyLoyaltyId == "" || self.customerTypeId ?? "" == "4" && self.partyLoyaltyId == ""{
                        self.increaseProduct(PartyLoyaltyID: "")
                    }else{
                        self.increaseProduct(PartyLoyaltyID: "")
                    }
                    
                }else{
                    DispatchQueue.main.async{
                        self.view.makeToast("Insufficient Point Balance", duration: 2.0, position: .bottom)
                    }
                }
                
            }else{
                DispatchQueue.main.async{
                    self.view.makeToast("Insufficient Point Balance", duration: 2.0, position: .bottom)
                }
            }
        }
        self.myCartListTableView.reloadData()
        
    }
    
    func decreaseCount(_ cell: KC_MyCartTVC) {
        guard let tappedIndexPath = self.myCartListTableView.indexPath(for: cell) else{return}
        if self.VM.myCartListArray[tappedIndexPath.row].noOfQuantity ?? 0 >= 1{
            cell.minusButton.isEnabled = true
            if cell.minusButton.tag == tappedIndexPath.row{
                if Int(self.VM.myCartListArray[tappedIndexPath.row].sumOfTotalPointsRequired ?? 0.0) <= Int(self.pointBalance) ?? 0{
                    let calcValue = Int(self.VM.myCartListArray[tappedIndexPath.row].sumOfTotalPointsRequired ?? 0.0) - Int(self.VM.myCartListArray[tappedIndexPath.row].pointsPerUnit ?? 0)
                    print(calcValue, "reduceValues")
                    if calcValue <= Int(self.pointBalance) ?? 0 {
                        if calcValue != 0  && calcValue >= Int(self.VM.myCartListArray[tappedIndexPath.row].pointsPerUnit ?? 0){
                            let totalQuantity = Int(self.VM.myCartListArray[tappedIndexPath.row].noOfQuantity ?? 0) - 1
                            self.quantity = totalQuantity
                            self.customerCartId = self.VM.myCartListArray[tappedIndexPath.row].customerCartId ?? 0
                            if self.quantity >= 1 {
                                cell.countTF.text = "\(quantity)"
                                if self.customerTypeId ?? "" == "3" && self.partyLoyaltyId != "" || self.customerTypeId ?? "" == "4" && self.partyLoyaltyId != ""{
                              
                                        self.increaseProduct(PartyLoyaltyID: self.partyLoyaltyId)
                                    
                                }else if self.customerTypeId ?? "" == "3" && self.partyLoyaltyId == "" || self.customerTypeId ?? "" == "4" && self.partyLoyaltyId == ""{
                                    self.increaseProduct(PartyLoyaltyID: "")
                                }else{
                                    self.increaseProduct(PartyLoyaltyID: "")
                                }
                            }else{
                                self.quantity = 1
                            }
                           
                        }
                        
                    }else{
                        DispatchQueue.main.async{
                            self.view.makeToast("Insufficient Point Balance", duration: 2.0, position: .bottom)
                        }
                    }
                }
                
            }
        }else{
//            if self.VM.myCartListArray[tappedIndexPath.row].noOfQuantity ?? 0 < 1{
//                cell.minusBTN.isEnabled = false
//                cell.countTF.text = "1"
//            }
          
        }
        
 
            self.myCartListTableView.reloadData()
    }
    
    func removeProduct(_ cell: KC_MyCartTVC) {
        guard let tappedIndexPath = self.myCartListTableView.indexPath(for: cell) else{return}
        if cell.removeBtn.tag == tappedIndexPath.row{
            self.customerCartId = self.VM.myCartListArray[tappedIndexPath.row].customerCartId ?? 0
         
            if self.customerTypeId == "3" && self.partyLoyaltyId != "" || self.customerTypeId == "4" && self.partyLoyaltyId != ""{
                self.removeProduct(PartyLoyaltyID: self.loyaltyId)
            }else if self.customerTypeId == "3" && self.partyLoyaltyId == "" || self.customerTypeId == "4" && self.partyLoyaltyId == ""{
                self.removeProduct(PartyLoyaltyID: "")
            }else{
                self.removeProduct(PartyLoyaltyID: "")
            }
            self.myCartListTableView.reloadData()
        }
    }
    func increaseProduct(PartyLoyaltyID: String){
        
        let parameters = [
            "ActionType": "3",
            "ActorId": "\(userID)",
            "PartyLoyaltyID": PartyLoyaltyID,
            "CustomerCartId": "\(customerCartId)",
            "CustomerCartList": [
                [
                    "CustomerCartId": "\(customerCartId)",
                    "Quantity": "\(quantity)"
                ]
            ]
        ] as [String: Any]
        print(parameters)
        self.VM.updateCartListApi(parameter: parameters)
    }
    
    
    func removeProduct(PartyLoyaltyID: String){
        let parameters = [
            "ActionType": "4",
            "ActorId": "\(userID)",
            "CustomerCartId": "\(customerCartId)",
            "PartyLoyaltyID": PartyLoyaltyID
        ] as [String: Any]
        print(parameters)
        self.VM.productRemoveApi(parameter: parameters)
    }
    
}
extension KC_MyCartVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VM.myCartListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "KC_MyCartTVC", for: indexPath) as! KC_MyCartTVC
        cell.delegate = self
        cell.selectionStyle = .none
 
        cell.productNameLbl.text = self.VM.myCartListArray[indexPath.row].productName ?? ""
        cell.totalPointsLbl.text = "\(Double(self.VM.myCartListArray[indexPath.row].pointsRequired ?? 0))"
        let receivedImage = self.VM.myCartListArray[indexPath.row].productImage ?? ""
        let totalImgURL = productCatalogueImgURL + receivedImage
        cell.productImage.sd_setImage(with: URL(string: totalImgURL), placeholderImage: UIImage(named: "ic_default_img"))
        
        if self.VM.myCartListArray[indexPath.row].noOfQuantity ?? 0 != 0 {
            cell.countTF.text = "\(self.VM.myCartListArray[indexPath.row].noOfQuantity ?? 0)"
        }else{
            cell.countTF.text = "\(self.quantity)"
        }
        cell.plusButton.tag = indexPath.row
        cell.minusButton.tag = indexPath.row
        cell.removeBtn.tag = indexPath.row
        
        print("\(self.VM.myCartListArray[indexPath.row].sumOfTotalPointsRequired ?? 0)")
        self.totalPoints.text = "\(Double(self.VM.myCartListArray[indexPath.row].sumOfTotalPointsRequired ?? 0.0))"
        self.finalPoints = Int(self.VM.myCartListArray[indexPath.row].sumOfTotalPointsRequired ?? 0.0)
        self.isRedeemable = self.VM.myCartListArray[indexPath.row].is_Redeemable ?? 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
}
