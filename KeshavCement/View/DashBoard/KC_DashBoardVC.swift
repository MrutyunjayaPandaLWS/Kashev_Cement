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

class KC_DashBoardVC: BaseViewController{
    

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
    
    
   // var userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    var sourceArray = [AlamofireSource]()
    var offerimgArray = [ObjImageGalleryList]()
    var VM = KC_DashBoardVM()
    var selectedTitle = ""
    var newPassword = ""
    var engineerTopicArray = ["My Purchase Claim", "Redemption Catalogue", "My Redemption", "My Earning", "Offers and Promotions", "Worksite Details", "Refer and Earn"]
    var engineerImageArray = ["Group 359", "Group 355", "Group 355","Group 355","Group 355","Group 355","Group 355"]
    
    
    var dealerTopicArray = ["Enrollment", "Pending Claim Request","Cash Transfer Approval","Redemption Catalogue", "My Redemption", "My Earning", "Offers and Promotions"]
    
    var dealerImageArray = ["Group 359", "Group 355", "Group 355","Group 355","Group 355","Group 355","Group 355"]
//    var customerType = ""
    var customerTypeIds = -1
    var customerMobileNumber = ""
    var dashBoardId = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.dashBoardId = -1
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
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
        self.tokendata()
//        NotificationCenter.default.addObserver(self, selector: #selector(changePassword), name: Notification.Name.navigateToChangePassword, object: nil)
       
      
        NotificationCenter.default.addObserver(self, selector: #selector(navigateToNext), name: Notification.Name.navigateToSuccess, object: nil)
    }
    
  
    override func viewDidLayoutSubviews() {
        slideMenuController()?.changeLeftViewWidth(self.view.frame.size.width * 0.89)
        SlideMenuOptions.contentViewScale = 1
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.height / 2
    }

    @objc func navigateToNext(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    @objc func checkVerificationStatus(){
        self.view.makeToast("You are not allowled to redeem .Please contact your administrator", duration: 2.0, position: .bottom)
       
    }

    @IBAction func menuButton(_ sender: Any) {
        self.openLeft()
    }
    @IBAction func notificationButton(_ sender: Any) {
    }
    
    @IBAction func claimPurchaseBTn(_ sender: Any) {
        if self.customerTypeIds == 1 || self.customerTypeIds == 2{
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_ClaimPurchaseVC") as! KC_ClaimPurchaseVC
            vc.customerType = self.customerType
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_NewSaleVC") as! KC_NewSaleVC
            
            self.navigationController?.pushViewController(vc, animated: true)

        }
        
    }
    
    @IBAction func raiseTicketBtn(_ sender: Any) {
        
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_LodgeQueryVC") as! KC_LodgeQueryVC
        self.navigationController?.pushViewController(vc, animated: true)
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
                ImageSource(image: UIImage(named: "dashboardIMG222")!)
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
        if self.customerTypeIds == 1 || self.customerTypeIds == 2{
            return self.engineerTopicArray.count
        }else if self.customerTypeIds == 3 || self.customerTypeIds == 4{
            return self.dealerTopicArray.count
        }else{
            return 1
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KC_CategoryCVC", for: indexPath) as! KC_CategoryCVC
        if self.customerTypeIds == 1 || self.customerTypeIds == 2{
            cell.categoryTitleLbl.text = self.engineerTopicArray[indexPath.row]
            cell.categoryImage.image = UIImage(named: "\(self.engineerImageArray[indexPath.row])")
        }else if self.customerTypeIds == 3 || self.customerTypeIds == 4{
            cell.categoryTitleLbl.text = self.dealerTopicArray[indexPath.row]
            cell.categoryImage.image = UIImage(named: "\(self.dealerImageArray[indexPath.row])")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.customerTypeIds == 1 || self.customerTypeIds == 2{
            self.selectedTitle = self.engineerTopicArray[indexPath.row]
            if self.selectedTitle == "My Purchase Claim"{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_MyPurchaseClaimVC") as! KC_MyPurchaseClaimVC
                self.navigationController?.pushViewController(vc, animated: true)
            }else if self.selectedTitle == "Redemption Catalogue"{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_RedemptionCataloguesVC") as! KC_RedemptionCataloguesVC
                self.navigationController?.pushViewController(vc, animated: true)
            }else if self.selectedTitle == "My Redemption"{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_MyRedemptionVC") as! KC_MyRedemptionVC
                self.navigationController?.pushViewController(vc, animated: true)
            }else if self.selectedTitle == "My Earning"{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_MyEarningVC") as! KC_MyEarningVC
                self.navigationController?.pushViewController(vc, animated: true)
            }else if self.selectedTitle == "Offers and Promotions"{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_OffersandpromotionsVC") as! KC_OffersandpromotionsVC
                self.navigationController?.pushViewController(vc, animated: true)
            }else if self.selectedTitle == "Worksite Details"{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_WorksiteDetailsVC") as! KC_WorksiteDetailsVC
                self.navigationController?.pushViewController(vc, animated: true)
            }else if self.selectedTitle == "Refer and Earn"{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_ReferandEarnVC") as! KC_ReferandEarnVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }else if self.customerTypeIds == 3 || self.customerTypeIds == 4{
            self.selectedTitle = self.dealerTopicArray[indexPath.row]
//
//            var dealerTopicArray = ["Enrollment", "Pending Claim Request","Cash Transfer Approval","Redemption Catalogue", "My Redemption", "My Earning", "Offers and Promotions"]
            if self.selectedTitle == "Enrollment"{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_EnrollmentListVC") as! KC_EnrollmentListVC
                self.navigationController?.pushViewController(vc, animated: true)
            }else if self.selectedTitle == "Pending Claim Request"{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_PendingClaimVC") as! KC_PendingClaimVC
                self.navigationController?.pushViewController(vc, animated: true)
            }else if self.selectedTitle == "Cash Transfer Approval"{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_CashTranferApprovalVC") as! KC_CashTranferApprovalVC
                self.navigationController?.pushViewController(vc, animated: true)
            }else if self.selectedTitle == "Redemption Catalogue"{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_RedemptionCataloguesVC") as! KC_RedemptionCataloguesVC
                self.navigationController?.pushViewController(vc, animated: true)
            }else if self.selectedTitle == "My Redemption"{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_MyRedemptionVC") as! KC_MyRedemptionVC
                self.navigationController?.pushViewController(vc, animated: true)
            }else if self.selectedTitle == "My Earning"{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_MyEarningVC") as! KC_MyEarningVC
                self.navigationController?.pushViewController(vc, animated: true)
            }else if self.selectedTitle == "Offers and Promotions"{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_OffersandpromotionsVC") as! KC_OffersandpromotionsVC
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
