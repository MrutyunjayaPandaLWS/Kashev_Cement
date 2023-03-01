//
//  GetVouchersVC.swift
//  GogrejLocksMobileApplication
//
//  Created by Arokia IT on 2/14/20.
//  Copyright © 2020 Arokiait Pvt Ltd. All rights reserved.
//

import UIKit

class KC_EvoucherVC: BaseViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var subView: UIView!
    
    @IBOutlet weak var totalPts: UILabel!
    @IBOutlet weak var pointslabel: UILabel!
   // @IBOutlet weak var redemablepoints: UILabel!
    @IBOutlet weak var selectpointstoredeem: UILabel!
    @IBOutlet weak var getvouchersLabel1: UILabel!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var dropdownTableView: UITableView!
    @IBOutlet weak var dropdownView: UIView!
    @IBOutlet weak var getVouchersTableView: UITableView!
    var maxlimit:Int = 0
    var amountselected = 0
    var redemptiondate = ""
    var noofelements = 0
   // let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    var startindexint:Int = 1
    var reachability = Reach()
    let pointsBalance = UserDefaults.standard.string(forKey: "redeemablePointsBalance") ?? "0"
    let encashBalance = UserDefaults.standard.string(forKey: "redeemableEncashBalance") ?? "0"
//    var loyaltyID = UserDefaults.standard.string(forKey: "LOYALTYiD") ?? ""
    var username = UserDefaults.standard.string(forKey: "FIRSTnAME") ?? ""
    var redemptionDate = ""
//    var ManagedBalance_Array = [manageBalanceModels]()
//    var ManagedBalance_Arrayforstartindex = [manageBalanceModels]()
//
//    var dropdownArray1 = [ManageBalance_dropdown_models]()
//    var dropdownarray = [ManageBalance_dropdown_models]()
    var redeemVoucherLimit = ""
    var allowToReedem = 0
    var getProductCode = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.subView.clipsToBounds = true
        self.subView.cornerRadius = 20
        self.subView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
   //     localization()
        //self.DashBoardCustomerDetailsAPI(usedID: userID)
       // self.MerchantEmailDetailsAPI(userID: userID)
        self.getVouchersTableView.estimatedRowHeight = 133
        dropdownTableView.delegate = self
        dropdownTableView.dataSource = self
        getVouchersTableView.delegate = self
        getVouchersTableView.dataSource = self
           // ManageBalanceAPI(startindex: "1")
        let date = Date()
       // pointslabel.text = UserDefaults.standard.string(forKey: "redeemableEncashBalance") ?? "0"
        print(date.string(format: "yyyy-MM-dd"))
        self.redemptiondate = date.string(format: "yyyy-MM-dd")
    }
    override func viewWillAppear(_ animated: Bool) {
        self.amountselected = 0
    }
    
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == dropdownTableView{
//            return dropdownarray.count
            return 5
            
        }else{
//            return ManagedBalance_Array.count
            return 10
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == getVouchersTableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: "GetVouchersTVC", for: indexPath) as? GetVouchersTVC
           // cell?.voucherName.text =  ManagedBalance_Array[indexPath.row].ProductName ?? ""
//            cell?.voucherImage.sd_setImage(with: URL(string: ManagedBalance_Array[indexPath.row].ProductImage  ?? ""), placeholderImage: UIImage(named: "defaultImage"));
           // cell?.delegate = self
            cell?.amountButton.tag = indexPath.row
//            if ManagedBalance_Array[indexPath.row].max_points != ""{
//                cell?.amountButton.isHidden = true
//                cell?.amountTextfield.isHidden = false
//                    cell?.pleaseselectAmount.text = "INR \(ManagedBalance_Array[indexPath.row].min_points ?? "0") - INR \(ManagedBalance_Array[indexPath.row].max_points ?? "0")"
//                    cell?.amountButton.setTitle("Amount", for: .normal)
//                    cell?.amountTextfield.placeholder = "Amount"
//                    cell?.redeemButton.setTitle("Redeem", for: .normal)
//                    cell?.wishlistbutton.setTitle(" Add to  Dream Gift", for: .normal)
//                let points = Int(encashBalance)
//                let minpoints = Int(ManagedBalance_Array[indexPath.row].min_points ?? "0")
//                if points! < minpoints! {
//                    cell?.redeemButton.isHidden = true
//                    cell?.wishlistbutton.isHidden = false
//                }else{
//                    cell?.redeemButton.isHidden = false
//                    cell?.wishlistbutton.isHidden = true
//                }
//                cell?.voucherDetails = ManagedBalance_Array[indexPath.row]
//            }else if ManagedBalance_Array[indexPath.row].max_points == ""{
//                cell?.amountButton.isHidden = false
//                cell?.amountTextfield.isHidden = true
//                    cell?.amountButton.setTitle("Amount", for: .normal)
//                    cell?.pleaseselectAmount.text = "Select amount"
//                    cell?.amountTextfield.placeholder = "Amount"
//                    cell?.redeemButton.setTitle("Redeem", for: .normal)
//                    cell?.wishlistbutton.setTitle(" Add to  Dream Gift", for: .normal)
//                cell?.voucherDetails = ManagedBalance_Array[indexPath.row]
//            }
            return cell!
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "dropdownTableViewCell", for: indexPath) as? dropdownTableViewCell
           // cell?.dropdownvalue.text = dropdownarray[indexPath.row].fixedPoints ?? "0"
            return cell!
            
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == getVouchersTableView{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_VouchersDetailsVC") as? KC_VouchersDetailsVC
          //  vc!.manageBalanceDetails = ManagedBalance_Array[indexPath.row]
            self.navigationController?.pushViewController(vc!, animated: true)
        }else{
            
            self.shadowView.isHidden = true
            self.dropdownView.isHidden = true
          //  self.amountselected = Int(dropdownarray[indexPath.row].fixedPoints ?? "0")!
            //NotificationCenter.default.post(name: .selectdropdown , object: self)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
   
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if tableView == dropdownTableView{
//
//
//        }else{
//            if indexPath.row == ManagedBalance_Array.count-2{
//                if noofelements == 20{
//                    startindexint = startindexint+1
//                    print(startindexint)
//                    if self.reachability.connectionStatus() == .offline {
//                        if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "1"{
//                        let alert = UIAlertController(title: "", message: "no internet connection".localizableString(loc: "en"), preferredStyle: UIAlertController.Style.alert)
//                            alert.addAction(UIAlertAction(title: "Ok".localizableString(loc: "en"), style: UIAlertAction.Style.default, handler: nil))
//                        self.present(alert, animated: true, completion: nil)
//                        }else  if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "2"{
//                        let alert = UIAlertController(title: "", message: "no internet connection".localizableString(loc: "hi"), preferredStyle: UIAlertController.Style.alert)
//                            alert.addAction(UIAlertAction(title: "Ok".localizableString(loc: "hi"), style: UIAlertAction.Style.default, handler: nil))
//                        self.present(alert, animated: true, completion: nil)
//                        }else  if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "3"{
//                            let alert = UIAlertController(title: "", message: "no internet connection".localizableString(loc: "kn-IN"), preferredStyle: UIAlertController.Style.alert)
//                            alert.addAction(UIAlertAction(title: "Ok".localizableString(loc: "kn-IN"), style: UIAlertAction.Style.default, handler: nil))
//                            self.present(alert, animated: true, completion: nil)
//                        }else  if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "4"{
//                            let alert = UIAlertController(title: "", message: "no internet connection".localizableString(loc: "ta-IN"), preferredStyle: UIAlertController.Style.alert)
//                            alert.addAction(UIAlertAction(title: "Ok".localizableString(loc: "ta-IN"), style: UIAlertAction.Style.default, handler: nil))
//                            self.present(alert, animated: true, completion: nil)
//                        }else  if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "5"{
//                            let alert = UIAlertController(title: "", message: "no internet connection".localizableString(loc: "te-IN"), preferredStyle: UIAlertController.Style.alert)
//                            alert.addAction(UIAlertAction(title: "Ok".localizableString(loc: "te-IN"), style: UIAlertAction.Style.default, handler: nil))
//                            self.present(alert, animated: true, completion: nil)
//                        }else  if UserDefaults.standard.string(forKey: "LanguageLocalizationID") == "6"{
//                            let alert = UIAlertController(title: "", message: "no internet connection".localizableString(loc: "hi"), preferredStyle: UIAlertController.Style.alert)
//                            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
//                            self.present(alert, animated: true, completion: nil)
//                            }
//                    } else {
//                        ManageBalanceAPI(startindex: String(startindexint))
//                    }
//                }else if noofelements < 20{
//                    print("no need to hit API")
//                }else{
//                    print("n0 more elements")
//                }
//            }
//        }
    }
    @IBAction func backbutton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
}

extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
