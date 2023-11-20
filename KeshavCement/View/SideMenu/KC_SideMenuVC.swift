//
//  KC_SideMenuVC.swift
//  KeshavCement
//
//  Created by ADMIN on 02/01/2023.
//

import UIKit
import SlideMenuControllerSwift
import LanguageManager_iOS
class KC_SideMenuVC: BaseViewController, popUpAlertDelegate {
    func popupAlertDidTap(_ vc: RGT_popupAlertOne_VC) {
    }
    

    @IBOutlet weak var ptsBalanceLBl: UILabel!
    @IBOutlet weak var memberShipIDLbl: UILabel!
    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint!
    @IBOutlet weak var sideMenuTableViewHeightConstratin: NSLayoutConstraint!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var editProfileBtn: UIButton!
    @IBOutlet weak var logoutLbl: UILabel!
   // @IBOutlet weak var sideMenuViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var sideMenuTableView: UITableView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var profileView: UIView!
    
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var ptsBalanceLbl: UILabel!
    @IBOutlet weak var memberShipIdLbl: UILabel!
    
    var sideMenuItems = [SideMenuModel]()
    var benefitsItem = [SecondMenuList]()
    var selectedTitle = ""
    var itsFrom = ""
    var parameters: JSON?
    var requestAPIs = RestAPI_Requests()
    var itsComeFrom = ""
//    var userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    var customerTypeIds = -1
    var engineerSideMenuListArray = ["Claim Purchase", "My Purchase Claim", "Redemption Catalogue", "My Redemption", "My Earning", "Worksite Details", "Refer and Earn", "Helpline", "Offers and Promotions", "Lodge Query", "Terms and Conditions"]
    var sideMenuImageArray = ["Claim Purchase", "My Purchase Claim", "Redemption Catalogue", "My Redemption", "My Earning", "Worksite Details", "Refer and Earn", "Helpline", "Offers and Promotions", "Lodge Query", "Lodge Query"]
    
    var dealerSideMenuListArray = ["Enrollment","Pending Claim Request", "Cash Transfer Approval", "Redemption Catalogue", "My Redemption", "My Earning", "My Activity", "Offers and Promotions", "Refer and Earn", "Helpline", "My Support Executive", "Lodge Query", "Terms and Conditions"]
    //Claim History, Cash Transfer History - Sub level of myActivity
    
    var dealerSideMenuImageArray = ["Claim Purchase", "My Purchase Claim", "Redemption Catalogue", "My Redemption", "My Earning", "Worksite Details", "Refer and Earn", "Helpline", "Offers and Promotions", "Lodge Query", "Lodge Query", "Lodge Query", "Lodge Query"]
    
    var subDealerSideMenuListArray = ["Enrollment","Pending Claim Request", "Cash Transfer Approval", "My Purchase Claim", "Claim Purchase","Redemption Catalogue", "My Redemption", "My Earning", "My Activity", "Offers and Promotions", "Refer and Earn", "Helpline", "My Support Executive", "Lodge Query", "Terms and Conditions"]
    //Claim History, Cash Transfer History - Sub level of myActivity
    
    var subDealerSideMenuImageArray = ["Claim Purchase", "My Purchase Claim", "Claim Purchase","Redemption Catalogue", "My Redemption", "My Earning", "Worksite Details", "Refer and Earn", "Helpline", "Offers and Promotions", "Lodge Query", "Lodge Query", "Lodge Query", "Lodge Query", "Lodge Query"]
    
    var VM = KC_SideMenuVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
      
        
        
        self.profileView.roundCorners(corners: [.topLeft, .topRight], radius: 50.0)
        self.profileView.clipsToBounds = true
        self.sideMenuTableView.delegate = self
        self.sideMenuTableView.dataSource = self
     //   self.sideMenuViewHeightConstraint.constant = CGFloat(550)
        NotificationCenter.default.addObserver(self, selector: #selector(deletedAccount), name: Notification.Name.deleteAccount, object: nil)
        
      
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.dashBoardApi()
        self.addItemsIntoArray()
     
        if self.customerTypeIds == 1 || self.customerTypeIds == 2{
            self.sideMenuTableViewHeightConstratin.constant = 650
            self.scrollViewHeight.constant = 650
        }else if self.customerTypeIds == 3{
            self.sideMenuTableViewHeightConstratin.constant = 780
            self.scrollViewHeight.constant = 780
        }else{
            self.sideMenuTableViewHeightConstratin.constant = 850
            self.scrollViewHeight.constant = 850
        }
        self.sideMenuTableView.reloadData()
        self.logoutLbl.text = "Logout".localiz()
        self.editProfileBtn.setTitle("EditProfile".localiz(), for: .normal)
        self.ptsBalanceLBl.text = "PointBalance".localiz()
        self.memberShipIDLbl.text = "MembershipID".localiz()
        self.sideMenuTableView.reloadData()
    }
    
    
                                               
                                               
    @objc func deletedAccount(){
        UserDefaults.standard.setValue(false, forKey: "IsloggedIn?")
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        if #available(iOS 13.0, *) {
            let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate
            sceneDelegate?.setInitialViewAsRootViewController()
            
        } else {
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            appDelegate?.setInitialViewAsRootViewController()
        }
    }

    @IBAction func logoutButton(_ sender: Any) {
        
        UserDefaults.standard.set(false, forKey: "IsloggedIn?")
        UserDefaults.standard.set(false, forKey: "UpdatePassword")
        
        if #available(iOS 13.0, *) {
            DispatchQueue.main.async {
                let pushID = UserDefaults.standard.string(forKey: "UD_DEVICE_TOKEN") ?? ""
                let domain = Bundle.main.bundleIdentifier!
                UserDefaults.standard.removePersistentDomain(forName: domain)
                UserDefaults.standard.synchronize()
                UserDefaults.standard.setValue(pushID, forKey: "UD_DEVICE_TOKEN")
                let sceneDelegate = self.view.window?.windowScene?.delegate as! SceneDelegate
                sceneDelegate.setInitialViewAsRootViewController()
             //   self.clearTable2()
            }
        } else {
            DispatchQueue.main.async {
                let pushID = UserDefaults.standard.string(forKey: "UD_DEVICE_TOKEN") ?? ""
                let domain = Bundle.main.bundleIdentifier!
                UserDefaults.standard.removePersistentDomain(forName: domain)
                UserDefaults.standard.synchronize()
                UserDefaults.standard.setValue(pushID, forKey: "UD_DEVICE_TOKEN")
                if #available(iOS 13.0, *) {
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.setInitialViewAsRootViewController()
                } else {
                    // Fallback on earlier versions
                }
                
              //  self.clearTable2()
            }
        }
    }
    
    @IBAction func deleteActBtn(_ sender: Any) {
        
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                self.view.makeToast("NoInternet".localiz(), duration: 2.0,position: .bottom)
            }
        }else{
            let alert = UIAlertController(title: "", message: "SureWantToDelete".localiz(), preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Yes".localiz(), style: .default, handler: { UIAlertAction in
                self.parameters = [
                    "ActionType": 1,
                    "userid":"\(self.userID)"
                ] as [String : Any]
                print(self.parameters!)
                self.deleteAccountAPI(paramters: self.parameters!)
            }))
            alert.addAction(UIAlertAction(title: "no".localiz(), style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        
        
        
        
    }
    
    func deleteAccountAPI(paramters: JSON){
        self.requestAPIs.deleteAccount(parameters: paramters) { (result, error) in
            if error == nil{
                if result != nil{
                DispatchQueue.main.async {
                    if result?.returnMessage ?? "-1" == "1"{
                        DispatchQueue.main.async{
                                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RGT_popupAlertOne_VC") as? RGT_popupAlertOne_VC
                                vc!.delegate = self
                                vc!.titleInfo = ""
                                vc!.itsComeFrom = "AccounthasbeenDeleted"
                                vc!.descriptionInfo = "AccDeleted".localiz()
                                vc!.modalPresentationStyle = .overCurrentContext
                                vc!.modalTransitionStyle = .crossDissolve
                                self.present(vc!, animated: true, completion: nil)
                            
                            }
                    }else{
                        DispatchQueue.main.async{
                            self.view.makeToast("SomethingWrong".localiz(), duration: 2.0,position: .bottom)
                            }
                    }
                  self.stopLoading()
                    }
                }else{
                    DispatchQueue.main.async {
                    self.stopLoading()
                    }
                }
            }else{
                DispatchQueue.main.async {
                self.stopLoading()
                }
            }
        }
        
    }
    
    
    @IBAction func editProfileBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_MyProfileVC") as! KC_MyProfileVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func dashBoardApi(){
        let parameter = [
            "ActorId":"\(self.userID)"
        ] as [String: Any]
        print(parameter)
        self.VM.dashboardApi(parameter: parameter)
    }
    func addItemsIntoArray(){
        DispatchQueue.main.async {
            self.sideMenuItems.removeAll()
            self.benefitsItem.removeAll()
            print(self.customerTypeId," - Customer Type Id")
            
            if self.customerTypeIds == 1 || self.customerTypeIds == 2{
                
                self.sideMenuItems.append(SideMenuModel(parentName: "Purchase Request", parentList:  [], parentID: 1, parentExpand: false, parentImage: "Claim Purchase"))
                self.sideMenuItems.append(SideMenuModel(parentName: "My Purchase Claim", parentList:  [], parentID: 2, parentExpand: false, parentImage: "My Purchase Claim"))
                self.sideMenuItems.append(SideMenuModel(parentName: "Redemption Catalogue", parentList:  [], parentID: 3, parentExpand: false, parentImage: "Redemption Catalogue"))
                self.sideMenuItems.append(SideMenuModel(parentName: "Dream Gift", parentList:  [], parentID: 4, parentExpand: false, parentImage: "Redemption Catalogue"))
                self.sideMenuItems.append(SideMenuModel(parentName: "My Redemption", parentList:  [], parentID: 5, parentExpand: false, parentImage: "My Redemption"))
                self.sideMenuItems.append(SideMenuModel(parentName: "My Earning", parentList:  [], parentID: 6, parentExpand: false, parentImage: "My Earning"))
                self.sideMenuItems.append(SideMenuModel(parentName: "Worksite Details", parentList:  [], parentID: 7, parentExpand: false, parentImage: "Worksite Details"))
                self.sideMenuItems.append(SideMenuModel(parentName: "Refer and Earn", parentList:  [], parentID: 8, parentExpand: false, parentImage: "Refer and Earn"))
                self.sideMenuItems.append(SideMenuModel(parentName: "Helpline", parentList:  [], parentID: 9, parentExpand: false, parentImage: "Helpline"))
                self.sideMenuItems.append(SideMenuModel(parentName: "Offers and Promotions", parentList:  [], parentID: 10, parentExpand: false, parentImage: "Offers and Promotions"))
                self.sideMenuItems.append(SideMenuModel(parentName: "Lodge Query", parentList:  [], parentID: 11, parentExpand: false, parentImage: "Lodge Query"))
                self.sideMenuItems.append(SideMenuModel(parentName: "Terms and Conditions", parentList:  [], parentID: 12, parentExpand: false, parentImage: "Lodge Query"))
                
            } else if self.customerTypeIds == 3{
                
                self.benefitsItem.append(SecondMenuList(sideMenuItem: "Claim History", sideMenuID: 21, sidemenuImage: "XMLID_91_"))
                self.benefitsItem.append(SecondMenuList(sideMenuItem: "Cash Transfer History", sideMenuID: 22, sidemenuImage: "XMLID_91_"))
                
                
                self.sideMenuItems.append(SideMenuModel(parentName: "Enrollment", parentList:  [], parentID: 1, parentExpand: false, parentImage: "checklist"))
                self.sideMenuItems.append(SideMenuModel(parentName: "Pending Claim Request", parentList:  [], parentID: 2, parentExpand: false, parentImage: "49 Invoice, Business, Finance"))
                self.sideMenuItems.append(SideMenuModel(parentName: "Cash Transfer Approval", parentList:  [], parentID: 3, parentExpand: false, parentImage: "Group 6530"))
                self.sideMenuItems.append(SideMenuModel(parentName: "Redemption Catalogue", parentList:  [], parentID: 4, parentExpand: false, parentImage: "Redemption Catalogue"))
                self.sideMenuItems.append(SideMenuModel(parentName: "Dream Gift", parentList:  [], parentID: 5, parentExpand: false, parentImage: "Redemption Catalogue"))
                self.sideMenuItems.append(SideMenuModel(parentName: "My Redemption", parentList:  [], parentID: 6, parentExpand: false, parentImage: "My Redemption"))
                self.sideMenuItems.append(SideMenuModel(parentName: "My Earning", parentList:  [], parentID: 7, parentExpand: false, parentImage: "My Earning"))
                self.sideMenuItems.append(SideMenuModel(parentName: "My Activity", parentList:    self.benefitsItem, parentID: 8, parentExpand: false, parentImage: "Layer 3", parentDropDownImage: "arrow-down"))
                self.sideMenuItems.append(SideMenuModel(parentName: "Refer and Earn", parentList:  [], parentID: 9, parentExpand: false, parentImage: "_x30_6_Recommendation_letter"))
                self.sideMenuItems.append(SideMenuModel(parentName: "Helpline", parentList:  [], parentID: 10, parentExpand: false, parentImage: "_x34_0__Customer_Care"))
                self.sideMenuItems.append(SideMenuModel(parentName: "Offers and Promotions", parentList:  [], parentID: 11, parentExpand: false, parentImage: "13 Price Tag, Discount, Label,"))
                self.sideMenuItems.append(SideMenuModel(parentName: "My Support Executive", parentList:  [], parentID: 12, parentExpand: false, parentImage: "_x32_2_Manager"))
                self.sideMenuItems.append(SideMenuModel(parentName: "Lodge Query", parentList:  [], parentID: 13, parentExpand: false, parentImage: "Lodge Query"))
                self.sideMenuItems.append(SideMenuModel(parentName: "Terms and Conditions", parentList:  [], parentID: 14, parentExpand: false, parentImage: "Lodge Query"))
                
            }else if self.customerTypeIds == 4{
                
                self.benefitsItem.append(SecondMenuList(sideMenuItem: "Claim History", sideMenuID: 21, sidemenuImage: "XMLID_91_"))
                self.benefitsItem.append(SecondMenuList(sideMenuItem: "Cash Transfer History", sideMenuID: 22, sidemenuImage: "XMLID_91_"))
                
                
                self.sideMenuItems.append(SideMenuModel(parentName: "Enrollment", parentList:  [], parentID: 1, parentExpand: false, parentImage: "checklist"))
                self.sideMenuItems.append(SideMenuModel(parentName: "Pending Claim Request", parentList:  [], parentID: 2, parentExpand: false, parentImage: "49 Invoice, Business, Finance"))
                self.sideMenuItems.append(SideMenuModel(parentName: "Cash Transfer Approval", parentList:  [], parentID: 3, parentExpand: false, parentImage: "Group 6530"))
                self.sideMenuItems.append(SideMenuModel(parentName: "Purchase Request", parentList:  [], parentID: 4, parentExpand: false, parentImage: "Claim Purchase"))
                self.sideMenuItems.append(SideMenuModel(parentName: "My Purchase Claim", parentList:  [], parentID: 5, parentExpand: false, parentImage: "49 Invoice, Business, Finance"))

                self.sideMenuItems.append(SideMenuModel(parentName: "Redemption Catalogue", parentList:  [], parentID: 6, parentExpand: false, parentImage: "Redemption Catalogue"))
                self.sideMenuItems.append(SideMenuModel(parentName: "Dream Gift", parentList:  [], parentID: 7, parentExpand: false, parentImage: "Redemption Catalogue"))
                self.sideMenuItems.append(SideMenuModel(parentName: "My Redemption", parentList:  [], parentID: 8, parentExpand: false, parentImage: "My Redemption"))
                self.sideMenuItems.append(SideMenuModel(parentName: "My Earning", parentList:  [], parentID: 9, parentExpand: false, parentImage: "My Earning"))
                self.sideMenuItems.append(SideMenuModel(parentName: "My Activity", parentList:    self.benefitsItem, parentID: 10, parentExpand: false, parentImage: "Layer 3", parentDropDownImage: "arrow-down"))
                
                self.sideMenuItems.append(SideMenuModel(parentName: "Refer and Earn", parentList:  [], parentID: 11, parentExpand: false, parentImage: "_x30_6_Recommendation_letter"))
                self.sideMenuItems.append(SideMenuModel(parentName: "Helpline", parentList:  [], parentID: 12, parentExpand: false, parentImage: "_x34_0__Customer_Care"))
                self.sideMenuItems.append(SideMenuModel(parentName: "Offers and Promotions", parentList:  [], parentID: 13, parentExpand: false, parentImage: "13 Price Tag, Discount, Label,"))
                self.sideMenuItems.append(SideMenuModel(parentName: "My Support Executive", parentList:  [], parentID: 14, parentExpand: false, parentImage: "_x32_2_Manager"))
                self.sideMenuItems.append(SideMenuModel(parentName: "Lodge Query", parentList:  [], parentID: 15, parentExpand: false, parentImage: "Lodge Query"))
                self.sideMenuItems.append(SideMenuModel(parentName: "Terms and Conditions", parentList:  [], parentID: 16, parentExpand: false, parentImage: "Lodge Query"))
                
            }
            self.sideMenuTableView.reloadData()
            self.stopLoading()
        }
    }
}
extension KC_SideMenuVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return sideMenuItems.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sideMenuItems[section].parentExpand == true{
            return sideMenuItems[section].parentList!.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "KC_SideMenuTVC", for: indexPath) as? KC_SideMenuTVC
        cell?.selectionStyle = .none
        
        if sideMenuItems[indexPath.section].parentExpand == true {
            if sideMenuItems[indexPath.section].parentList!.count != 0{
                cell?.categoryTitle.text = sideMenuItems[indexPath.section].parentList![indexPath.row].sideMenuItem ?? ""
               print(sideMenuItems[indexPath.section].parentList![indexPath.row].sideMenuItem ?? "", "Sidemenu title")
                cell?.categoryImage.image = UIImage(named: sideMenuItems[indexPath.section].parentList![indexPath.row].sidemenuImage ?? "")
                cell?.leadingSpaceConstraint.constant = 30
                cell?.dropDownImage.isHidden = true
            }
           
        }else{
            cell?.leadingSpaceConstraint.constant = 8
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(self.customerTypeId,"kjshdkhd")
        if self.customerTypeIds == 3 || self.customerTypeIds == 4{
            if sideMenuItems[indexPath.section].parentList![indexPath.row].sideMenuID == 21{
//              //  self.closeLeft()
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_ClaimHistoryVC") as? KC_ClaimHistoryVC
//                vc!.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc!, animated: true)
            }
            if sideMenuItems[indexPath.section].parentList![indexPath.row].sideMenuID == 22{
//              //  self.closeLeft()
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_CashTranferHistoryVC") as? KC_CashTranferHistoryVC
//                vc!.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc!, animated: true)
            }
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 30))
        headerView.backgroundColor = UIColor.clear
        let label = UILabel()
        label.frame = CGRect.init(x: 42, y: 0, width: headerView.frame.width, height: headerView.frame.height-1)
        label.textColor = UIColor.darkGray
        label.font = label.font.withSize(14)
        let labelimage = UIImageView()
        labelimage.frame = CGRect.init(x: 10, y: 5, width: 25, height: 25)
        let labelimage1 = UIImageView()
        labelimage1.frame = CGRect.init(x: 270, y: 12, width: 14, height: 9)
        let button = UIButton()
        button.frame = CGRect.init(x: 0, y: 0, width: headerView.frame.width, height: headerView.frame.height)
        button.backgroundColor = UIColor.clear
        label.text = sideMenuItems[section].parentName ?? ""
        print(label.text, "Sidemenu Title")

        
        headerView.addSubview(label)
        labelimage.image = UIImage(named: sideMenuItems[section].parentImage ?? "Lodge Query")
        headerView.addSubview(labelimage)
        if self.customerTypeIds == 3 || self.customerTypeIds == 4{
            if sideMenuItems[section].parentName ?? "" == "My Activity"{
                
                labelimage1.image = UIImage(named: sideMenuItems[section].parentDropDownImage ?? "Lodge Query")
                headerView.addSubview(labelimage1)
            }
        }
       
        
        headerView.addSubview(button)
        
        button.tag = sideMenuItems[section].parentID ?? -1
        button.addTarget(self, action: #selector(self.buttonTapped), for: .touchUpInside)
        return headerView
    }
    
    @objc func buttonTapped(sender:UIButton){
        if self.customerTypeIds == 1 || self.customerTypeIds == 2{
            if sender.tag == 1{
              //  self.closeLeft()
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_ClaimPurchaseVC") as! KC_ClaimPurchaseVC
                //vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
                
                
            }else if sender.tag == 2{
              //  self.closeLeft()
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_MyPurchaseClaimVC") as! KC_MyPurchaseClaimVC
                //            vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
            }else if sender.tag == 3{
              //  self.closeLeft()
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_RedemptionCataloguesVC") as! KC_RedemptionCataloguesVC
                //            vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
            }else if sender.tag == 4{
                //  self.closeLeft()
                  let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_MyDreamGiftVC") as! MSP_MyDreamGiftVC
                  //            vc.fromSideMenu = "SideMenu"
                  self.navigationController?.pushViewController(vc, animated: true)
              }else if sender.tag == 5{
              //  self.closeLeft()
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_MyRedemptionVC") as! KC_MyRedemptionVC
                //  vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
            }else if sender.tag == 6{
              //  self.closeLeft()
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_MyEarningVC") as! KC_MyEarningVC
                // vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
            }else if sender.tag == 7{
              //  self.closeLeft()
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_WorksiteDetailsVC") as! KC_WorksiteDetailsVC
                //            vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
            }else if sender.tag == 8{
                
              //  self.closeLeft()
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_ReferandEarnVC") as! KC_ReferandEarnVC
                //                vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
                
                
            }else if sender.tag == 9{
              //  self.closeLeft()
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_HelplineVC") as! KC_HelplineVC
                //            vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
            }else if sender.tag == 10{
              //  self.closeLeft()
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_OffersandpromotionsVC") as! KC_OffersandpromotionsVC
                //            vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
            }else if sender.tag == 11{
              //  self.closeLeft()
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_LodgeQueryVC") as! KC_LodgeQueryVC
                //            vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
            }else if sender.tag == 12{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_TermsandconditionVC") as! KC_TermsandconditionVC
                //vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }else if self.customerTypeIds == 3{
            if sender.tag == 1{
              //  self.closeLeft()
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_EnrollmentListVC") as! KC_EnrollmentListVC
                //vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
                
                
            }else if sender.tag == 2{
              //  self.closeLeft()
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_PendingClaimVC") as! KC_PendingClaimVC
                //            vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
            }else if sender.tag == 3{
              //  self.closeLeft()
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_CashTranferApprovalVC") as! KC_CashTranferApprovalVC
                //            vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
            }

            else if sender.tag == 4{
              //  self.closeLeft()
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_RedemptionCataloguesVC") as! KC_RedemptionCataloguesVC
                //            vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
            }else if sender.tag == 5{
                //  self.closeLeft()
                  let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_MyDreamGiftVC") as! MSP_MyDreamGiftVC
                  //            vc.fromSideMenu = "SideMenu"
                  self.navigationController?.pushViewController(vc, animated: true)
              }else if sender.tag == 6{
                
              //  self.closeLeft()
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_MyRedemptionVC") as! KC_MyRedemptionVC
                //                vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
                
                
            }else if sender.tag == 7{
              //  self.closeLeft()
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_MyEarningVC") as! KC_MyEarningVC
                //            vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
            }else if sender.tag == 8{
              //  self.closeLeft()
                if let index = sideMenuItems.firstIndex{$0.parentID == sender.tag}{
                    if sideMenuItems[index].parentExpand == false{
                        sideMenuItems[index].parentExpand = true
                        print("hide")
                        
                        
                        self.sideMenuTableView.reloadData()
                    }else{
                        sideMenuItems[index].parentExpand = false
                        print("Expanded")
                        self.sideMenuTableView.reloadData()
                    }
                  
                }
            }else if sender.tag == 11{
              //  self.closeLeft()
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_OffersandpromotionsVC") as! KC_OffersandpromotionsVC
                //            vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
            }else if sender.tag == 9{
              //  self.closeLeft()
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_ReferandEarnVC") as! KC_ReferandEarnVC
                //            vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
            }else if sender.tag == 10{
              //  self.closeLeft()
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_HelplineVC") as! KC_HelplineVC
                //            vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
            }else if sender.tag == 12{
              //  self.closeLeft()
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_SupportExecutiveVC") as! KC_SupportExecutiveVC
                //            vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
            }else if sender.tag == 13{
              //  self.closeLeft()
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_LodgeQueryVC") as! KC_LodgeQueryVC
                //            vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
            }else if sender.tag == 14{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_TermsandconditionVC") as! KC_TermsandconditionVC
                //vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }else if self.customerTypeIds == 4{
            if sender.tag == 1{
              //  self.closeLeft()
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_EnrollmentListVC") as! KC_EnrollmentListVC
                //vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
                
                
            }else if sender.tag == 2{
              //  self.closeLeft()
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_PendingClaimVC") as! KC_PendingClaimVC
                //            vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
            }else if sender.tag == 3{
              //  self.closeLeft()
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_CashTranferApprovalVC") as! KC_CashTranferApprovalVC
                //            vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
            }else if sender.tag == 4{
                //  self.closeLeft()
                  let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_ClaimPurchaseVC") as! KC_ClaimPurchaseVC
                  // vc.fromSideMenu = "SideMenu"
                  self.navigationController?.pushViewController(vc, animated: true)
              }
            else if sender.tag == 5{
              //  self.closeLeft()
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_MyPurchaseClaimVC") as! KC_MyPurchaseClaimVC
                //  vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if sender.tag == 6{
              //  self.closeLeft()
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_RedemptionCataloguesVC") as! KC_RedemptionCataloguesVC
                //            vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
            }else if sender.tag == 7{
                //  self.closeLeft()
                  let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MSP_MyDreamGiftVC") as! MSP_MyDreamGiftVC
                  //            vc.fromSideMenu = "SideMenu"
                  self.navigationController?.pushViewController(vc, animated: true)
              }else if sender.tag == 8{
                
              //  self.closeLeft()
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_MyRedemptionVC") as! KC_MyRedemptionVC
                //                vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
                
                
            }else if sender.tag == 9{
              //  self.closeLeft()
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_MyEarningVC") as! KC_MyEarningVC
                //            vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
            }else if sender.tag == 10{
              //  self.closeLeft()
                if let index = sideMenuItems.firstIndex{$0.parentID == sender.tag}{
                    if sideMenuItems[index].parentExpand == false{
                        sideMenuItems[index].parentExpand = true
                        print("hide")
                        
                        
                        self.sideMenuTableView.reloadData()
                    }else{
                        sideMenuItems[index].parentExpand = false
                        print("Expanded")
                        self.sideMenuTableView.reloadData()
                    }
                  
                }
            }else if sender.tag == 11{
                //  self.closeLeft()
                  let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_ReferandEarnVC") as! KC_ReferandEarnVC
                  //            vc.fromSideMenu = "SideMenu"
                  self.navigationController?.pushViewController(vc, animated: true)
              }else if sender.tag == 12{
                //  self.closeLeft()
                  let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_HelplineVC") as! KC_HelplineVC
                  //            vc.fromSideMenu = "SideMenu"
                  self.navigationController?.pushViewController(vc, animated: true)
              }else if sender.tag == 13{
              //  self.closeLeft()
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_OffersandpromotionsVC") as! KC_OffersandpromotionsVC
                //            vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
            }else if sender.tag == 14{
              //  self.closeLeft()
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_SupportExecutiveVC") as! KC_SupportExecutiveVC
                //            vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
            }else if sender.tag == 15{
              //  self.closeLeft()
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_LodgeQueryVC") as! KC_LodgeQueryVC
                //            vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
            }else if sender.tag == 16{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_TermsandconditionVC") as! KC_TermsandconditionVC
                //vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
}
