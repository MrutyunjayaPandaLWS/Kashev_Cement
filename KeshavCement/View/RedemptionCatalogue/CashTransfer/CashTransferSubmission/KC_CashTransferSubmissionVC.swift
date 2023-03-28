//
//  KC_CashTransferSubmissionVC.swift
//  KeshavCement
//
//  Created by ADMIN on 23/03/2023.
//

import UIKit
import Lottie
import Toast_Swift

class KC_CashTransferSubmissionVC: BaseViewController, SelectedDataDelegate{
    func didTapAmount(_ vc: KC_DropDownVC){
        self.selectedAmount = vc.selectedAmount
        self.selectedCashBack = vc.selectedCashBack
        self.pleaseSelectProductLbl.text = "\(vc.selectedAmount)"
        self.qtyTF.text = "\(vc.selectedCashBack)"
        self.quantity = vc.selectedCashBack
    }
    func didTapHelpTopic(_ vc: KC_DropDownVC) {}
    func didTapCustomerType(_ vc: KC_DropDownVC) {}
    func didTapWorkLevel(_ vc: KC_DropDownVC) {}
    func didTapCityName(_ vc: KC_DropDownVC){}
    func didTapMappedUserName(_ vc: KC_DropDownVC) {
        self.searchTF.text = vc.mappedUsername
        self.mappedName = vc.mappedUsername
        self.mappedUserId = vc.mappedUserId
        self.mappedLoyaltyId = vc.mappedLoyaltyId
        self.pleaseSelectProductLbl.text = "Please select points"
        self.selectedProductId = -1
    }
    func didTapProductName(_ vc: KC_DropDownVC){
        self.pleaseSelectProductLbl.text = vc.selectedProductName
        self.selectedProductName = vc.selectedProductName
        self.selectedProductId = vc.selectedProductId
        self.selectedProductCode = vc.selectedProductCode
        
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
        self.pleaseSelectProductLbl.text = "Please select points"
        self.mappedUserId = -1
        self.selectedProductId = -1
        self.selectedAmount = -1
        self.selectedCashBack = -1
        
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
    
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var instructionWebView: UIWebView!
    @IBOutlet weak var instructionLbl: UILabel!
    @IBOutlet weak var instructionView: UIView!
    @IBOutlet weak var totalPoinView: UIView!
    @IBOutlet weak var totalPtsLbl: UILabel!
    @IBOutlet weak var totalPointsLbl: UILabel!
    @IBOutlet weak var howToWorksBtn: UIButton!

    var totalRedeemablePoints = ""
    
    private var animationView: LottieAnimationView?
    
//    var customerType = ""
    var selectedUserTypeName = ""
    var selectedUserTypeId = -1
    
    var selectedAmount = -1
    var selectedCashBack = -1
    
    var mappedName = ""
    var mappedUserId = -1
    var mappedLoyaltyId = ""
    
    var selectedProductName = ""
    var selectedProductId = -1
    
    var quantity = 0
    var count = 0
    var selectedProductCode = ""
    
    
    var VM = KC_TransferSubmissionVM()
    
    let date = Date()
    let formatter = DateFormatter()
    var saveTodaysDates = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        
        formatter.dateFormat = "dd/MM/yyyy"
        let result = formatter.string(from: date)
        self.saveTodaysDates = result
        self.qtyTF.keyboardType = .asciiCapableNumberPad
        mainview.clipsToBounds = false
        mainview.layer.cornerRadius = 36
        mainview.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
       // lbl_progressState.text = "Swipe to claim"
        self.swipeButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        self.totalPointsLbl.text = "\(self.totalRedeemablePoints)"
        self.instructionView.isHidden = true
        self.totalPoinView.clipsToBounds = true
        self.totalPoinView.cornerRadius = 20
        self.totalPoinView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        self.searchTF.attributedPlaceholder = NSAttributedString(string: "Search Name", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
                NotificationCenter.default.addObserver(self, selector: #selector(afterQuerySubmitted), name: Notification.Name.navigateToDashBoard, object: nil)
        self.cashDetailsApi()
            }
  
        @objc func afterQuerySubmitted(notification: Notification){
        self.navigationController?.popViewController(animated: true)
        }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let url = Bundle.main.url(forResource: "cash_transfer_instruction", withExtension:"html")
        let request = NSURLRequest(url: url!)
        instructionWebView.loadRequest(request as URLRequest)
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
            vc.itsFrom = "CASHPOINTS"
            vc.selectedCustomerTypeIds = Int(self.customerTypeId)!
            vc.delegate = self
            vc.modalTransitionStyle = .coverVertical
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
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
    
    @IBAction func okButton(_ sender: Any) {
        self.instructionView.isHidden = true
    }
    @IBAction func closeBtn(_ sender: Any) {
        self.instructionView.isHidden = true
    }
    
    @IBAction func howToWorksButton(_ sender: Any) {
        if self.instructionView.isHidden == false{
            self.instructionView.isHidden = true
        }else{
            self.instructionView.isHidden = false
        }
    }
    
    func cashDetailsApi(){
            
        let parameter = [
            "ActionType": 1,
            "ActorId": userID,
            "CustomerTypeId": Int(self.customerTypeId)!
        ] as [String: Any]
        print(parameter)
        self.VM.cashDetailsListApi(parameter: parameter)
        }
//    @IBAction func quantityEditingChanged(_ sender: Any) {
//
//
//        self.quantity = Int(self.qtyTF.text ?? "") ?? 0
//        if self.selectedUserTypeId == -1{
//            self.qtyTF.text = "0"
//            self.view.makeToast("Please select user type", duration: 2.0, position: .bottom)
//            self.swipeButton.reset()
//            self.swipeButton.backgroundColor = .white
//        }else if self.mappedUserId == -1{
//            self.qtyTF.text = "0"
//            self.view.makeToast("Please select mapped user", duration: 2.0, position: .bottom)
//            self.swipeButton.reset()
//            self.swipeButton.backgroundColor = .white
//        }else if self.selectedProductId == -1{
//            self.qtyTF.text = "0"
//            self.view.makeToast("Please select product", duration: 2.0, position: .bottom)
//            self.swipeButton.reset()
//            self.swipeButton.backgroundColor = .white
//        }else if self.quantity == 0{
//            self.view.makeToast("Qunantity shouldn't 0", duration: 2.0, position: .bottom)
//            self.count = 1
//            self.quantity = 1
//            self.qtyTF.text = "\(self.count)"
//        }else{
//             self.count = Int(self.qtyTF.text ?? "") ?? 0
//            self.quantity = self.count
//        }
//
//
//    }
    func claimSubmissionApi(){
        if self.selectedUserTypeId == -1{
            self.view.makeToast("Please select user type", duration: 2.0, position: .bottom)
            self.swipeButton.reset()
            self.swipeButton.backgroundColor = .white
        }else if self.mappedUserId == -1{
            self.view.makeToast("Please select mapped user", duration: 2.0, position: .bottom)
            self.swipeButton.reset()
            self.swipeButton.backgroundColor = .white
        }else if self.selectedAmount == -1{
            self.view.makeToast("Please select amount", duration: 2.0, position: .bottom)
            self.swipeButton.reset()
            self.swipeButton.backgroundColor = .white
        }else if self.quantity == 0{
            self.view.makeToast("Quantity shouln't be 0", duration: 2.0, position: .bottom)
            self.swipeButton.reset()
            self.swipeButton.backgroundColor = .white
        }else{
            
            if self.selectedAmount <= Int(totalRedeemablePoints)!{
                self.swipeButton.backgroundColor = #colorLiteral(red: 1, green: 0.9882352941, blue: 0.6117647059, alpha: 1)
                let parameter = [
                    "ActionType": 2,
                    "ActorId": self.userID,
                    "PartyLoyaltyId":self.mappedLoyaltyId,
                    "Points":self.selectedAmount,
                    "CustomerTypeId": Int(self.customerTypeId)!
                ] as [String: Any]
                print(parameter)
                self.VM.cashTransferSubmissionApi(parameter: parameter)
            }else{
                self.view.makeToast("Insufficient point balance", duration: 2.0, position: .bottom)
                self.swipeButton.reset()
                self.swipeButton.backgroundColor = .white
            }
            
            
        }
    }
    
    
    @IBAction func filterByNameBtn(_ sender: Any) {
        if self.selectedUserTypeId == -1{
            self.view.makeToast("Please select user type", duration: 2.0, position: .bottom)
        }else{
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_DropDownVC") as! KC_DropDownVC
            vc.itsFrom = "MAPPEDUSERS"
            vc.isComeFrom = "CASHTRANSFERSUBMISSION"
            vc.delegate = self
            vc.selectedUserTypeId = self.selectedUserTypeId
            vc.modalTransitionStyle = .coverVertical
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }
    }
}

