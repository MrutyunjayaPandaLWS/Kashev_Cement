//
//  KC_DashBoardVC.swift
//  KeshavCement
//
//  Created by ADMIN on 02/01/2023.
//

import UIKit
import ImageSlideshow
import Lottie
import SlideMenuControllerSwift
import CoreData
import Alamofire
import LanguageManager_iOS
class KC_DashBoardVC: BaseViewController{
    

    @IBOutlet weak var redemptionTypeView: UIView!
    @IBOutlet weak var helpButton: UIButton!
    @IBOutlet weak var gradeIcon: UIImageView!
    @IBOutlet weak var defaultImage: UIImageView!
    @IBOutlet weak var bannerImage: ImageSlideshow!
    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var memberNameLbl: UILabel!
    @IBOutlet weak var memberShipIdTitle: UILabel!
    @IBOutlet weak var memberShipIdLbl: UILabel!
    @IBOutlet weak var pointBalanceTitle: UILabel!
    @IBOutlet weak var pointBalanceLbl: UILabel!
    @IBOutlet weak var earnPts: UILabel!
    @IBOutlet weak var whenPurchaseLbl: UILabel!
    @IBOutlet weak var claimPurchaseLbl: UILabel!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    @IBOutlet weak var askHelpLbl: UILabel!
    
    @IBOutlet weak var raiseTicketLbl: UILabel!
    
    @IBOutlet weak var raiseTicketBtnLbl: UILabel!
    
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var collectionView: UIView!
    @IBOutlet weak var raiseaTicketView: UIView!

    @IBOutlet weak var supportImage: UIImageView!
    @IBOutlet weak var logoutBtn: UIButton!
    
    @IBOutlet var pointBalanceIcon: UIImageView!
    
    @IBOutlet weak var languageTrailingSpace: NSLayoutConstraint!
    @IBOutlet weak var languagePopUpView: UIView!
    @IBOutlet var supportImageView: UIImageView!
    @IBOutlet weak var sideMenuBTN: UIButton!
    
    @IBOutlet weak var redemptionTitleLbl: UILabel!
    @IBOutlet weak var cashTransferLbl: UILabel!
    @IBOutlet weak var otherRedemptionsLbl: UILabel!
    
    
   // var userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    var sourceArray = [AlamofireSource]()
    var offerimgArray = [ObjImageGalleryList]()
    var VM = KC_DashBoardVM()
    var selectedTitle = ""
    var newPassword = ""
    var engineerTopicArray = ["My Purchase Claim", "Redemption Catalogue", "My Redemption", "My Earning", "Offers and Promotions", "Worksite Details", "Refer and Earn"]
    var engineerImageArray = ["Group 359", "Group 355", "Group 7794", "Group 7804", "Group 7760", "Group 7761", "Group 7762"]
    
    var dealerTopicArray = ["Enrollment", "Pending Claim Request","Cash Transfer Approval","Redemption Catalogue", "My Redemption", "My Earning", "Offers and Promotions"]
    
    var dealerImageArray = ["Group 8853", "Group 7797", "Group 7798","Group 355","Group 7794","Group 7804","Group 7760"]
    
    var subDealerTopicArray = ["Enrollment", "Pending Claim Request","Cash Transfer Approval", "Purchase Request","Redemption Catalogue", "My Redemption", "My Earning", "Offers and Promotions"]
    var subDealerImageArray = ["Group 8853", "Group 7797", "Group 7798","Group 7797","Group 355","Group 7794","Group 7804","Group 7760"]
    
    var supportExecutive = ["Enrollment","Pending Request","My Activity"]
    var supportExecutiveImage = ["Group 8853","Group 7797", "Group 7761"]
    
//    var customerType = ""
    var customerTypeIds = -1
    var customerMobileNumber = ""
    var dashBoardId = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        
        self.helpButton.isHidden = true
        self.languageTrailingSpace.constant = 16
        self.languagePopUpView.isHidden = true
        self.dashBoardId = -1
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        self.countLbl.isHidden = true
        self.supportImage.isHidden = true
        mainView.clipsToBounds = false
        mainView.layer.cornerRadius = 36
        mainView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        NotificationCenter.default.addObserver(self, selector: #selector(checkVerificationStatus), name: Notification.Name.verificationStatus, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deactivateAccount), name: Notification.Name.deactivatedAcc, object: nil)
        
    }
  
    @objc func deactivateAccount(){
        UserDefaults.standard.set(false, forKey: "IsloggedIn?")
        UserDefaults.standard.set(false, forKey: "UpdatePassword")
        
        
        if #available(iOS 13.0, *) {
            DispatchQueue.main.async {
                let pushID = UserDefaults.standard.string(forKey: "DEVICE_TOKEN") ?? ""
                let domain = Bundle.main.bundleIdentifier!
                UserDefaults.standard.removePersistentDomain(forName: domain)
                UserDefaults.standard.synchronize()
                UserDefaults.standard.setValue(pushID, forKey: "DEVICE_TOKEN")
                let sceneDelegate = self.view.window?.windowScene?.delegate as! SceneDelegate
                sceneDelegate.setInitialViewAsRootViewController()

            }
        } else {
            DispatchQueue.main.async {
                let pushID = UserDefaults.standard.string(forKey: "DEVICE_TOKEN") ?? ""
                let domain = Bundle.main.bundleIdentifier!
                UserDefaults.standard.removePersistentDomain(forName: domain)
                UserDefaults.standard.synchronize()
                UserDefaults.standard.setValue(pushID, forKey: "DEVICE_TOKEN")
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.setInitialViewAsRootViewController()
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.slideMenuController()?.closeLeft()
        self.redemptionTypeView.isHidden = true
        self.tokendata()
        self.localization()
        
//        NotificationCenter.default.addObserver(self, selector: #selector(changePassword), name: Notification.Name.navigateToChangePassword, object: nil)
       
      
        NotificationCenter.default.addObserver(self, selector: #selector(navigateToNext), name: Notification.Name.navigateToSuccess, object: nil)
    }
    
  
    override func viewDidLayoutSubviews() {
        slideMenuController()?.changeLeftViewWidth(self.view.frame.size.width * 0.89)
        SlideMenuOptions.contentViewScale = 1
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.height / 2
        self.countLbl.layer.cornerRadius = self.countLbl.frame.size.height / 2
    }

    @objc func navigateToNext(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    @objc func checkVerificationStatus(){
        self.view.makeToast("notAllowedRedeem".localiz(), duration: 2.0, position: .bottom)
       
    }

    @IBAction func menuButton(_ sender: Any) {
        self.openLeft()
    }
    @IBAction func notificationButton(_ sender: Any) {
        
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HistoryNotificationsViewController") as! HistoryNotificationsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func helpBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_DealerHelpPopUp") as! KC_DealerHelpPopUp
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    
    @IBAction func englishButton(_ sender: Any) {
        LanguageManager.shared.setLanguage(language: .en)
        UserDefaults.standard.set("1", forKey: "LanguageLocalizable")
        UserDefaults.standard.synchronize()
        self.languagePopUpView.isHidden = true
        self.localization()
    }
    @IBAction func hindiButton(_ sender: Any) {
        LanguageManager.shared.setLanguage(language: .hi)
            UserDefaults.standard.set("2", forKey: "LanguageLocalizable")
            UserDefaults.standard.synchronize()
        self.languagePopUpView.isHidden = true
        self.localization()
    }
    @IBAction func kannadaButton(_ sender: Any) {
        LanguageManager.shared.setLanguage(language: .knIn)
        UserDefaults.standard.set("3", forKey: "LanguageLocalizable")
        UserDefaults.standard.synchronize()
        self.languagePopUpView.isHidden = true
        self.localization()
    }
    
    
    
    @IBAction func logoutActionBTN(_ sender: Any) {

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
    
    @IBAction func claimPurchaseBTn(_ sender: Any) {
        if self.customerTypeId == "1" || self.customerTypeId == "2"{
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_ClaimPurchaseVC") as! KC_ClaimPurchaseVC
            vc.customerType = self.customerType
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_NewSaleVC") as! KC_NewSaleVC
            
            self.navigationController?.pushViewController(vc, animated: true)

        }
        
    }
    
    @IBAction func languageChangeBTN(_ sender: Any) {
        if self.languagePopUpView.isHidden == false{
            self.languagePopUpView.isHidden = true
        }else{
            self.languagePopUpView.isHidden = false
        }
        
    }
    @IBAction func raiseTicketBtn(_ sender: Any) {
        
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_LodgeQueryVC") as! KC_LodgeQueryVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func cashTransferButton(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_RedemptionTypeVC") as! KC_RedemptionTypeVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func otherRedemptionsButton(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_MyRedemptionVC") as! KC_MyRedemptionVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func localization() {
        self.memberShipIdTitle.text = "MembershipID".localiz()
        self.pointBalanceTitle.text = "PointBalance".localiz()
        self.askHelpLbl.text = "AskHelp".localiz()
        self.raiseTicketLbl.text = "Raiseconnectyousoon".localiz()
        self.raiseTicketBtnLbl.text = "RaiseaTicket".localiz()
    }
  
    
    func dashBoardApi(){
        let parameter = [
            "ActorId":"\(self.userID)"
        ] as [String: Any]
        print(parameter)
        self.VM.dashboardApi(parameter: parameter)
    }
    
    func dashBoardBannerApi(){
        let parameter = [
            "ObjImageGallery": [
                    "AlbumCategoryID": "1"
                ]
        ] as [String: Any]
        print(parameter)
        self.VM.dashboardBannerApi(parameter: parameter)
    }
    func passwordUpdateApi(newPassword: String, mobilenumber: String){
        let parameter = [
            "Password": newPassword,
            "UserName":mobilenumber,
            "UserActionType":"UpdateChangedPassword"
        ] as [String:Any]
        print(parameter)
        self.VM.forgetPasswordSubmissionApi(parameter: parameter)
    }
    
    

    func ImageSetups(){
        self.sourceArray.removeAll()
        if self.offerimgArray.count > 0 {
            for image in self.offerimgArray {
                print("\(PROMO_IMG1)\(image.imageGalleryUrl ?? ""), sdafasf")
                let imageURL = image.imageGalleryUrl ?? ""
                let filteredURLArray = imageURL.dropFirst(1)
                let replaceString = "\(PROMO_IMG1)\(filteredURLArray)".replacingOccurrences(of: " ", with: "%20")
                print(replaceString)
                self.sourceArray.append(AlamofireSource(urlString: "\(replaceString)", placeholder: UIImage(named: "ic_default_img"))!)
            }
            bannerImage.setImageInputs(self.sourceArray)
            bannerImage.slideshowInterval = 3.0
            bannerImage.zoomEnabled = true
            bannerImage.contentScaleMode = .scaleToFill
//            bannerImage.pageControl.currentPageIndicatorTintColor = UIColor(red: 230/255, green: 27/255, blue: 34/255, alpha: 1)
//            bannerImage.pageControl.pageIndicatorTintColor = UIColor.lightGray
        }else{
            bannerImage.setImageInputs([
                ImageSource(image: UIImage(named: "ic_default_img")!)
            ])
        }
    }
    @objc func didTap() {
        if self.offerimgArray.count > 0 {
            bannerImage.presentFullScreenController(from: self)
        }
    }
    func tokendata(){
            if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            }else{
                let parameters : Data = "username=\(username)&password=\(password)&grant_type=password".data(using: .utf8)!

            let url = URL(string: tokenURL)!
            let session = URLSession.shared
            var request = URLRequest(url: url)
            request.httpMethod = "POST"

            do {
                request.httpBody = parameters
            } catch let error {
                print(error.localizedDescription)
            }
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
           
            let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

                guard error == nil else {
                    return
                }
                guard let data = data else {
                    return
                }
                do{
                    let parseddata = try JSONDecoder().decode(TokenModels.self, from: data)
                    print(parseddata.access_token ?? "")
                    UserDefaults.standard.setValue(parseddata.access_token ?? "", forKey: "TOKEN")
                    self.dashBoardApi()
                    if self.dashBoardId == -1{
                        self.dashBoardBannerApi()
                        self.dashBoardId = 1
                    }
                     }catch let parsingError {
                    print("Error", parsingError)
                }
            })
            task.resume()
        }
        }
    
}
extension KC_DashBoardVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(self.customerTypeId, "Customer Type ID")
        if self.customerTypeId == "1" || self.customerTypeId == "2"{
            return self.engineerTopicArray.count
        }else if self.customerTypeId == "3"{
            return self.dealerTopicArray.count
        }else if  self.customerTypeId == "4"{
            return self.subDealerTopicArray.count
        }else if self.customerTypeId == "5"{
            return self.supportExecutive.count
        }else{
            return 1
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KC_CategoryCVC", for: indexPath) as! KC_CategoryCVC
        if self.customerTypeId == "1" || self.customerTypeId == "2"{
            cell.categoryTitleLbl.text = self.engineerTopicArray[indexPath.row]
            cell.categoryImage.image = UIImage(named: "\(self.engineerImageArray[indexPath.row])")
        }else if self.customerTypeId == "3"{
            cell.categoryTitleLbl.text = self.dealerTopicArray[indexPath.row]
            cell.categoryImage.image = UIImage(named: "\(self.dealerImageArray[indexPath.row])")
        }else if self.customerTypeId == "4"{
            cell.categoryTitleLbl.text = self.subDealerTopicArray[indexPath.row]
            cell.categoryImage.image = UIImage(named: "\(self.subDealerImageArray[indexPath.row])")
        }else if self.customerTypeId == "5"{
            cell.categoryTitleLbl.text = self.supportExecutive[indexPath.row]
            cell.categoryImage.image = UIImage(named: "\(self.supportExecutiveImage[indexPath.row])")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.customerTypeId == "1" || self.customerTypeId == "2"{
            self.selectedTitle = self.engineerTopicArray[indexPath.row]
//            if self.selectedTitle == "My Purchase Claim".localiz(){
//                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_MyPurchaseClaimVC") as! KC_MyPurchaseClaimVC
//                self.navigationController?.pushViewController(vc, animated: true)
//            }else if self.selectedTitle == "Redemption Catalogue".localiz(){
//                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_RedemptionCataloguesVC") as! KC_RedemptionCataloguesVC
//                self.navigationController?.pushViewController(vc, animated: true)
//            }else if self.selectedTitle == "My Redemption".localiz(){
//                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_MyRedemptionVC") as! KC_MyRedemptionVC
//                self.navigationController?.pushViewController(vc, animated: true)
//            }else if self.selectedTitle == "My Earning".localiz(){
//                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_MyEarningVC") as! KC_MyEarningVC
//                self.navigationController?.pushViewController(vc, animated: true)
//            }else if self.selectedTitle == "Offers and Promotions".localiz(){
//                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_OffersandpromotionsVC") as! KC_OffersandpromotionsVC
//                self.navigationController?.pushViewController(vc, animated: true)
//            }else if self.selectedTitle == "Worksite Details".localiz(){
//                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_WorksiteDetailsVC") as! KC_WorksiteDetailsVC
//                self.navigationController?.pushViewController(vc, animated: true)
//            }else if self.selectedTitle == "Refer and Earn".localiz(){
//                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_ReferandEarnVC") as! KC_ReferandEarnVC
//                self.navigationController?.pushViewController(vc, animated: true)
//            }
            if indexPath.row == 0{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_MyPurchaseClaimVC") as! KC_MyPurchaseClaimVC
                self.navigationController?.pushViewController(vc, animated: true)
            }else if indexPath.row == 1{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_RedemptionCataloguesVC") as! KC_RedemptionCataloguesVC
                self.navigationController?.pushViewController(vc, animated: true)
            }else if indexPath.row == 2{
//                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_MyRedemptionVC") as! KC_MyRedemptionVC
//
//                self.navigationController?.pushViewController(vc, animated: true)
                self.redemptionTypeView.isHidden = false
            }else if indexPath.row == 3{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_MyEarningVC") as! KC_MyEarningVC
                self.navigationController?.pushViewController(vc, animated: true)
            }else if indexPath.row == 4{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_OffersandpromotionsVC") as! KC_OffersandpromotionsVC
                self.navigationController?.pushViewController(vc, animated: true)
            }else if indexPath.row == 5{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_WorksiteDetailsVC") as! KC_WorksiteDetailsVC
                self.navigationController?.pushViewController(vc, animated: true)
            }else if indexPath.row == 6{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_ReferandEarnVC") as! KC_ReferandEarnVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }else if self.customerTypeId == "3"{
            self.selectedTitle = self.dealerTopicArray[indexPath.row]

//            if self.selectedTitle == "Enrollment".localiz(){
//                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_EnrollmentListVC") as! KC_EnrollmentListVC
//                self.navigationController?.pushViewController(vc, animated: true)
//            }else if self.selectedTitle == "Pending Claim Request".localiz(){
//                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_PendingClaimVC") as! KC_PendingClaimVC
//                self.navigationController?.pushViewController(vc, animated: true)
//            }else if self.selectedTitle == "Cash Transfer Approval".localiz(){
//                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_CashTranferApprovalVC") as! KC_CashTranferApprovalVC
//                self.navigationController?.pushViewController(vc, animated: true)
//            }else if self.selectedTitle == "Redemption Catalogue".localiz(){
//                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_RedemptionCataloguesVC") as! KC_RedemptionCataloguesVC
//                self.navigationController?.pushViewController(vc, animated: true)
//            }else if self.selectedTitle == "My Redemption".localiz(){
//                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_MyRedemptionVC") as! KC_MyRedemptionVC
//                self.navigationController?.pushViewController(vc, animated: true)
//            }else if self.selectedTitle == "My Earning".localiz(){
//                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_MyEarningVC") as! KC_MyEarningVC
//                self.navigationController?.pushViewController(vc, animated: true)
//            }else if self.selectedTitle == "Offers and Promotions".localiz(){
//                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_OffersandpromotionsVC") as! KC_OffersandpromotionsVC
//                self.navigationController?.pushViewController(vc, animated: true)
//            }
            if indexPath.row == 0{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_EnrollmentListVC") as! KC_EnrollmentListVC
                self.navigationController?.pushViewController(vc, animated: true)
            }else if indexPath.row == 1{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_PendingClaimVC") as! KC_PendingClaimVC
                self.navigationController?.pushViewController(vc, animated: true)
            }else if indexPath.row == 2{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_CashTranferApprovalVC") as! KC_CashTranferApprovalVC
                self.navigationController?.pushViewController(vc, animated: true)
            }else if indexPath.row == 3{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_RedemptionCataloguesVC") as! KC_RedemptionCataloguesVC
                self.navigationController?.pushViewController(vc, animated: true)
            }else if indexPath.row == 4{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_MyRedemptionVC") as! KC_MyRedemptionVC
                self.navigationController?.pushViewController(vc, animated: true)
            }else if indexPath.row == 5{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_MyEarningVC") as! KC_MyEarningVC
                self.navigationController?.pushViewController(vc, animated: true)
            }else if indexPath.row == 6{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_OffersandpromotionsVC") as! KC_OffersandpromotionsVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }else if self.customerTypeId == "4"{
            self.selectedTitle = self.subDealerTopicArray[indexPath.row]
//
//            var dealerTopicArray = ["Enrollment", "Pending Claim Request","Cash Transfer Approval","Redemption Catalogue", "My Redemption", "My Earning", "Offers and Promotions"]
            if indexPath.row == 0{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_EnrollmentListVC") as! KC_EnrollmentListVC
                self.navigationController?.pushViewController(vc, animated: true)
            }else if indexPath.row == 1{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_PendingClaimVC") as! KC_PendingClaimVC
                self.navigationController?.pushViewController(vc, animated: true)
            }else if indexPath.row == 2{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_CashTranferApprovalVC") as! KC_CashTranferApprovalVC
                self.navigationController?.pushViewController(vc, animated: true)
            }else if indexPath.row == 3{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_ClaimPurchaseVC") as! KC_ClaimPurchaseVC
                self.navigationController?.pushViewController(vc, animated: true)
            }else if indexPath.row == 4{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_RedemptionCataloguesVC") as! KC_RedemptionCataloguesVC
                self.navigationController?.pushViewController(vc, animated: true)
            }else if indexPath.row == 5{
//                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_MyRedemptionVC") as! KC_MyRedemptionVC
//                self.navigationController?.pushViewController(vc, animated: true)
                self.redemptionTypeView.isHidden = false
            }else if indexPath.row == 6{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_MyEarningVC") as! KC_MyEarningVC
                self.navigationController?.pushViewController(vc, animated: true)
            }else if indexPath.row == 7{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_OffersandpromotionsVC") as! KC_OffersandpromotionsVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }else if self.customerTypeId == "5"{
            self.selectedTitle = self.supportExecutive[indexPath.row]
            
//            if self.selectedTitle == "Enrollment".localiz(){
//                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_EnrollmentListVC") as! KC_EnrollmentListVC
//                self.navigationController?.pushViewController(vc, animated: true)
//
//            }else if self.selectedTitle == "Pending Request".localiz(){
//                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_PendingClaimVC") as! KC_PendingClaimVC
//                self.navigationController?.pushViewController(vc, animated: true)
//
//            }else if self.selectedTitle == "My Activity".localiz(){
//                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_MyActivityVC") as! KC_MyActivityVC
//                self.navigationController?.pushViewController(vc, animated: true)
//            }
            if indexPath.row == 0{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_EnrollmentListVC") as! KC_EnrollmentListVC
                self.navigationController?.pushViewController(vc, animated: true)
                
            }else if indexPath.row == 1{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_PendingClaimVC") as! KC_PendingClaimVC
                self.navigationController?.pushViewController(vc, animated: true)
                
            }else if indexPath.row == 2{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_MyActivityVC") as! KC_MyActivityVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            
        }
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let height = collectionView.frame.height
        let width  = collectionView.frame.width / 2.5
        return CGSize(width: width, height: height)
    }
    
}
