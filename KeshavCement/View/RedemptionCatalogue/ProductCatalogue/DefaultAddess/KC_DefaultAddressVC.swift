//
//  KC_DefaultAddressVC.swift
//  KeshavCement
//
//  Created by ADMIN on 07/01/2023.
//

import UIKit

class KC_DefaultAddressVC: BaseViewController, SendUpdatedAddressDelegate {
    func updatedAddressDetails(_ vc: KC_EditAddressVC) {
        DispatchQueue.main.async {
            self.customerNameLbl.text = vc.selectedname
            print(self.customerNameLbl.text ?? "")
            self.addressTextView.text = "\(vc.selectedaddress),\n\(vc.selectedState),\n\(vc.selectedDistrictName), \(vc.selectedpincode),\nMobile No: \(vc.selectedmobile)"
            self.pincode = vc.selectedpincode
            self.stateID = vc.selectedStateID
            self.stateName = vc.selectedState
            self.districtName = vc.selectedDistrictName
            self.districtID = vc.selectedDistrictId
            print(vc.selectedStateID)
            self.cityID = vc.selectedCityID
            print(vc.selectedCityID)
            self.address1 = vc.selectedaddress
            self.countryID = 15
            self.countryName = "India"
            self.mobile = vc.selectedmobile
        }
    }

    @IBOutlet weak var confirmOrderBtn: UIButton!
    @IBOutlet weak var addressTextView: UITextView!
    @IBOutlet weak var customerNameLbl: UILabel!
    @IBOutlet weak var editbtn: UIButton!
    @IBOutlet weak var deliveryToLbl: UILabel!
    @IBOutlet weak var headerLbl: UILabel!
    
    var VM = KC_DefaultAddressVM()
    var receiverName = ""
    var address = ""
    var stateID = -1
    var stateName = ""
    var districtID = -1
    var districtName = ""
    var cityID = -1
    var cityName = ""
    var pincode = ""
    var emailID = ""
    var address1 = ""
    var countryID = -1
    var countryName = ""
    var redemptionDate = ""
    var totalPoints = 0
    var mobile = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        self.VM.myAccountDetailsApi()
 //       NotificationCenter.default.addObserver(self, selector: #selector(afterDismissed), name: Notification.Name.dismissCurrentVC, object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            self.view.makeToast("No Internet connection!!", duration: 2.0, position: .bottom)
//            DispatchQueue.main.async{
//                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
//                vc!.delegate = self
//                vc!.titleInfo = ""
//                vc!.descriptionInfo = "NoInternet".localiz()
//                vc!.modalPresentationStyle = .overCurrentContext
//                vc!.modalTransitionStyle = .crossDissolve
//                self.present(vc!, animated: true, completion: nil)
//            }
        }else{
           // self.requiredPts.text = "\(self.totalPoints)"
            self.addressTextView.isUserInteractionEnabled = false
    }
    }
//    @objc func afterDismissed(){
//        self.VM.myAccountDetailsApi()
//    }
    

    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func editButton(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_EditAddressVC") as! KC_EditAddressVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func confirmOrderButton(_ sender: Any) {
          print(stateID)
            print(cityID)
            print(address1)
            print(pincode)
            print(mobile)
            print(UserDefaults.standard.string(forKey: "verificationStatus") ?? "")

            if UserDefaults.standard.string(forKey: "verificationStatus") == "1"{
                if stateID == -1 || cityID == -1 || address1 == "" || pincode == "" || mobile == ""{
                    DispatchQueue.main.async{
                        self.view.makeToast("Currently you are not mapped to any dealer. Kindly contact the administrator.", duration: 2.0, position: .bottom)
                    }
                }else{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_OrderConfirmationVC") as? KC_OrderConfirmationVC
//                    vc!.stateID = self.stateID
//                    vc!.cityID = self.cityID
//                    vc!.stateName = self.stateName
//                    vc!.cityName = self.cityName
//                    vc!.pincode = self.pincode
//                    vc!.address1 = self.address1
//                    vc!.customerName = self.custName.text ?? ""
//                    vc!.mobile = self.mobile
//                    vc!.emailId = self.emailID
//                    vc!.countryId = self.countryID
//                    vc!.countryName = self.countryName
//                    vc!.redeemedPoints = self.totalPoints
//                    self.navigationController?.pushViewController(vc!, animated: true)
                }
                
            }else{
                DispatchQueue.main.async{
                    self.view.makeToast("For Redemption, please complete the KYC verification process", duration: 2.0, position: .bottom)
                }
            }
    }
}
