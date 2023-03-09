//
//  KC_ClaimPurchaseVC.swift
//  KeshavCement
//
//  Created by ADMIN on 03/01/2023.
//

import UIKit
import Lottie
import Toast_Swift

class KC_ClaimPurchaseVC: BaseViewController, SelectedDataDelegate{
    func didTapHelpTopic(_ vc: KC_DropDownVC) {}
    func didTapCustomerType(_ vc: KC_DropDownVC) {}
    func didTapWorkLevel(_ vc: KC_DropDownVC) {}
    func didTapCityName(_ vc: KC_DropDownVC){}
    func didTapMappedUserName(_ vc: KC_DropDownVC) {
        self.searchTF.text = vc.mappedUsername
        self.mappedName = vc.mappedUsername
        self.mappedUserId = vc.mappedUserId
        self.pleaseSelectProductLbl.text = "Please select product name"
        self.selectedProductId = -1
    }
    func didTapProductName(_ vc: KC_DropDownVC){
        self.pleaseSelectProductLbl.text = vc.selectedProductName
        self.selectedProductName = vc.selectedProductName
        self.selectedProductId = vc.selectedProductId
        
    }
    func didTapState(_ vc: KC_DropDownVC) {}
    func didTapDistrict(_ vc: KC_DropDownVC) {}
    func didTapTaluk(_ vc: KC_DropDownVC) {}
    func didTapUserType(_ vc: KC_DropDownVC) {
        self.selectTypeLbl.text = vc.selectedUserTypeName
        self.selectedUserTypeName = vc.selectedUserTypeName
        self.selectedUserTypeId = vc.selectedUserTypeId
        self.searchTF.text = ""
        self.searchTF.placeholder = "Search ..."
        self.pleaseSelectProductLbl.text = "Please select product name"
        self.mappedUserId = -1
        self.selectedProductId = -1
        
    }
    

    @IBOutlet weak var mainview: UIView!
    @IBOutlet weak var claimHeaderLbl: UILabel!
    @IBOutlet weak var userTypeLbl: UILabel!
    @IBOutlet weak var selectTypeLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var selectProductLbl: UILabel!
    
    @IBOutlet weak var pleaseSelectProductLbl: UILabel!

    @IBOutlet weak var enterQty: UILabel!
    @IBOutlet weak var qtyTF: UITextField!

    @IBOutlet weak var swipeButton: TGFlingActionButton!
    
    private var animationView: LottieAnimationView?
    
//    var customerType = ""
    var selectedUserTypeName = ""
    var selectedUserTypeId = -1
    
    var mappedName = ""
    var mappedUserId = -1
    
    var selectedProductName = ""
    var selectedProductId = -1
    
    var quantity = 0
    var count = 0

    
    
    var VM = KC_ClaimPurchaseVM()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        
        mainview.clipsToBounds = false
        mainview.layer.cornerRadius = 36
        mainview.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
       // lbl_progressState.text = "Swipe to claim"
        self.swipeButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.searchTF.attributedPlaceholder = NSAttributedString(string: "Search Name", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
                NotificationCenter.default.addObserver(self, selector: #selector(afterQuerySubmitted), name: Notification.Name.navigateToDashBoard, object: nil)
              
            }
  
        @objc func afterQuerySubmitted(notification: Notification){
        self.navigationController?.popViewController(animated: true)
        }
   
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func selectTypeBtn(_ sender: Any) {
        
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_DropDownVC") as! KC_DropDownVC
        vc.itsFrom = "USERTYPE"
        vc.delegate = self
        vc.customerType = self.customerType
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    
    @IBAction func selectProductBtn(_ sender: Any) {
        if self.mappedUserId == -1{
            self.view.makeToast("Please select mapped user", duration: 2.0, position: .bottom)
        }else{
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_DropDownVC") as! KC_DropDownVC
            vc.itsFrom = "CLAIMPRODUCTLIST"
            vc.delegate = self
            vc.modalTransitionStyle = .coverVertical
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }
    }

    @IBAction func minusBtn(_ sender: Any) {
        if self.selectedUserTypeId == -1{
            self.view.makeToast("Please select user type", duration: 2.0, position: .bottom)
        }else if self.mappedUserId == -1{
            self.view.makeToast("Please select mapped user", duration: 2.0, position: .bottom)
        }else if self.selectedProductId == -1{
            self.view.makeToast("Please select product", duration: 2.0, position: .bottom)
        }else{
            self.count -= 1
            self.quantity = self.count
            if self.count != 0{
                self.qtyTF.text = "\(self.quantity)"
            }else{
                self.count = 1
                self.quantity = self.count
            }
        }
    }
    
    @IBAction func plus(_ sender: Any) {
        if self.selectedUserTypeId == -1{
            self.view.makeToast("Please select user type", duration: 2.0, position: .bottom)
        }else if self.mappedUserId == -1{
            self.view.makeToast("Please select mapped user", duration: 2.0, position: .bottom)
        }else if self.selectedProductId == -1{
            self.view.makeToast("Please select product", duration: 2.0, position: .bottom)
        }else{
            self.count += 1
            self.quantity = self.count
            self.qtyTF.text = "\(self.quantity)"
        }
        
    }
    @IBAction func claimSubmissionButton(_ sender: TGFlingActionButton) {
            print(sender.swipe_direction)
            if sender.swipe_direction == .right {
                DispatchQueue.main.asyncAfter(deadline: .now()+0.9, execute: {
                    self.claimSubmissionApi()
                    self.swipeButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                }
                    )
            }
    }
    
    @IBAction func quantityEditingChanged(_ sender: Any) {
        
        
        self.quantity = Int(self.qtyTF.text ?? "") ?? 0
        if self.selectedUserTypeId == -1{
            self.qtyTF.text = "0"
            self.view.makeToast("Please select user type", duration: 2.0, position: .bottom)
            self.swipeButton.reset()
            self.swipeButton.backgroundColor = .white
        }else if self.mappedUserId == -1{
            self.qtyTF.text = "0"
            self.view.makeToast("Please select mapped user", duration: 2.0, position: .bottom)
            self.swipeButton.reset()
            self.swipeButton.backgroundColor = .white
        }else if self.selectedProductId == -1{
            self.qtyTF.text = "0"
            self.view.makeToast("Please select product", duration: 2.0, position: .bottom)
            self.swipeButton.reset()
            self.swipeButton.backgroundColor = .white
        }else if self.quantity == 0{
            self.view.makeToast("Qunantity shouldn't 0", duration: 2.0, position: .bottom)
            self.count = 1
            self.quantity = 1
            self.qtyTF.text = "\(self.count)"
        }else{
             self.count = Int(self.qtyTF.text ?? "") ?? 0
            self.quantity = self.count
        }
        
        
    }
    func claimSubmissionApi(){
        if self.selectedUserTypeId == -1{
            self.view.makeToast("Please select user type", duration: 2.0, position: .bottom)
            self.swipeButton.reset()
            self.swipeButton.backgroundColor = .white
        }else if self.mappedUserId == -1{
            self.view.makeToast("Please select mapped user", duration: 2.0, position: .bottom)
            self.swipeButton.reset()
            self.swipeButton.backgroundColor = .white
        }else if self.selectedProductId == -1{
            self.view.makeToast("Please select product", duration: 2.0, position: .bottom)
            self.swipeButton.reset()
            self.swipeButton.backgroundColor = .white
        }else if self.quantity == 0{
            self.view.makeToast("Quantity shouln't be 0", duration: 2.0, position: .bottom)
            self.swipeButton.reset()
            self.swipeButton.backgroundColor = .white
        }else{
            
            self.swipeButton.backgroundColor = #colorLiteral(red: 1, green: 0.9882352941, blue: 0.6117647059, alpha: 1)
            let parameter = [
                "ActorId": self.userID,
                "ProductSaveDetailList": [
                    [
                        "ProductCode": self.selectedProductName,
                        "Quantity": self.quantity
                    ]
                ],
                "RitailerId": self.mappedUserId,
                "SourceDevice": 1
            ] as [String: Any]
            print(parameter)
            self.VM.claimPurchaseSubmissionApi(parameter: parameter)
        }
    }
    
    
    @IBAction func filterByNameBtn(_ sender: Any) {
        if self.selectedUserTypeId == -1{
            self.view.makeToast("Please select user type", duration: 2.0, position: .bottom)
        }else{
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_DropDownVC") as! KC_DropDownVC
            vc.itsFrom = "MAPPEDUSERS"
            vc.delegate = self
            vc.selectedUserTypeId = self.selectedUserTypeId
            vc.modalTransitionStyle = .coverVertical
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }
    }
}
