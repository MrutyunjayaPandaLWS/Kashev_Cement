//
//  KC_DashBoardVM.swift
//  KeshavCement
//
//  Created by ADMIN on 17/02/2023.
//

import UIKit
import Kingfisher
import LanguageManager_iOS
class KC_DashBoardVM: SendNewPasswordDelegate{
    func sendNewPassword(_ vc: KC_SetPasswordVC) {
        self.VC?.newPassword = vc.newPassword
        self.VC?.customerMobileNumber = vc.mobileNumber
        if self.VC?.newPassword != "" && self.VC?.customerMobileNumber != ""{
            self.VC?.passwordUpdateApi(newPassword: self.VC!.newPassword, mobilenumber: self.VC!.customerMobileNumber)
        }else{
            print(self.VC!.newPassword)
            print(self.VC!.customerMobileNumber)
        }
    }
    

    weak var VC:KC_DashBoardVC?
    var requestAPIs = RestAPI_Requests()
    var bannerArray = [ObjImageGalleryList]()
    
    func forgetPasswordSubmissionApi(parameter: JSON){

        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        self.requestAPIs.forgetPasswordApi(parameters: parameter) { (result, error) in
            
            if result == nil{
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
            }else{
                if error == nil{
                    let loginResponse = result?.userList ?? []
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        if loginResponse.count != 0{
                            print(loginResponse[0].result ?? -1, "PasswordUpdate")
                            if loginResponse[0].result ?? -1 == 1{
                                UserDefaults.standard.set(false, forKey: "UpdatePassword")
                                UserDefaults.standard.synchronize()
                                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_ForgetPwdSuccessVC") as! KC_ForgetPwdSuccessVC
                                vc.modalTransitionStyle = .coverVertical
                                vc.modalPresentationStyle = .overFullScreen
                                self.VC!.present(vc, animated: true)
                            }else if loginResponse[0].result ?? -1 == -1{
                                self.VC!.view.makeToast("InvalidUserName".localiz(), duration: 2.0, position: .bottom)
                            }
                            
                        }else{
                            self.VC!.view.makeToast("SomethingwentwrongTryagainlater".localiz(), duration: 2.0, position: .bottom)
                        }
                    
                    }
                }else{
                    print(error)
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                    }
                }
            }
        }
    }
    func dashboardBannerApi(parameter: JSON){
        self.VC?.startLoading()
        self.VC?.sourceArray.removeAll()
        self.VC?.offerimgArray.removeAll()
        
        self.requestAPIs.dashboardBanner_API(parameters: parameter) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.offerimgArray = result?.objImageGalleryList ?? []
                        self.bannerArray = result?.objImageGalleryList ?? []
                        print(self.bannerArray.count, "Banner Image")
                        if self.VC?.offerimgArray.count == 0{
                            self.VC?.ImageSetups()
                            let gestureRecognizer = UITapGestureRecognizer(target: self.VC.self, action: #selector(self.VC!.didTap))
                            self.VC!.bannerImage.addGestureRecognizer(gestureRecognizer)
                        }else{
                            self.VC?.ImageSetups()
                            let gestureRecognizer = UITapGestureRecognizer(target: self.VC.self, action: #selector(self.VC!.didTap))
                            self.VC!.bannerImage.addGestureRecognizer(gestureRecognizer)
                         
                        }
                    }
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                    }
                    
                }else{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                    }
                }
            }else{
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
            }
        }
    }
    func dashboardApi(parameter: JSON){
        
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        
        self.requestAPIs.dashboard_API(parameters: parameter) { (result, error) in
            if error == nil{
                if result != nil{
                DispatchQueue.main.async {
                   let dashboardDetails = result?.objCustomerDashboardList ?? []
                    if dashboardDetails.count != 0 {
                        if result?.objCustomerDashboardList?[0].notificationCount ?? 0 != 0{
                            self.VC?.countLbl.isHidden = false
                            self.VC?.countLbl.text = "\(result?.objCustomerDashboardList?[0].notificationCount ?? 0)"
                        }else{
                            self.VC?.countLbl.isHidden = true
                        }
                        UserDefaults.standard.setValue(result?.objCustomerDashboardList?[0].memberSince, forKey: "MemberSince")
                        print(result?.objCustomerDashboardList?[0].memberSince ?? "", "Membersince")
                        print(result?.objCustomerDashboardList?[0].notificationCount ?? "", "NotificationCount")
                        print(result?.objCustomerDashboardList?[0].redeemablePointsBalance ?? "", "totalpoints")
                        UserDefaults.standard.setValue(Int(result?.objCustomerDashboardList?[0].redeemablePointsBalance ?? 0.0) , forKey: "RedeemablePointBalance")
                        
                        UserDefaults.standard.setValue(Int(result?.objCustomerDashboardList?[0].overAllPoints ?? 0) , forKey: "OverallPoints")
                        UserDefaults.standard.synchronize()
                        self.VC?.pointBalanceLbl.text = "\(Int(result?.objCustomerDashboardList?[0].redeemablePointsBalance ?? 0.0) )"
                    }
                    
                    let customerFeedbakcJSON = result?.lstCustomerFeedBackJsonApi ?? []
                    if customerFeedbakcJSON.count != 0 || customerFeedbakcJSON.isEmpty == false{
                        
                        if result?.lstCustomerFeedBackJsonApi?[0].customerStatus ?? 0 != 1{
                            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_ForgetPwdSuccessVC") as! KC_ForgetPwdSuccessVC
                            vc.itsComeFrom = "ACCOUNTDEACTIVATE"
                            vc.modalTransitionStyle = .coverVertical
                            vc.modalPresentationStyle = .overFullScreen
                            self.VC!.present(vc, animated: true)
                        }
                        
                        UserDefaults.standard.setValue(result?.lstCustomerFeedBackJsonApi?[0].customerType ?? "", forKey: "customerType")
                        UserDefaults.standard.setValue(result?.lstCustomerFeedBackJsonApi?[0].customerTypeId ?? -1, forKey: "customerTypeId")
                        print(result?.lstCustomerFeedBackJsonApi?[0].customerTypeId ?? -1)
                        self.VC?.customerTypeId = "\(result?.lstCustomerFeedBackJsonApi?[0].customerTypeId ?? -1)"
                        UserDefaults.standard.setValue(result?.lstCustomerFeedBackJsonApi?[0].customerGrade ?? "", forKey: "CustomerGrade")
                        self.VC?.categoryCollectionView.reloadData()

                        if result?.lstCustomerFeedBackJsonApi?[0].customerGrade ?? "" == "Gold"{
                            self.VC!.gradeIcon.image = UIImage(named: "Gold")
                        }else if result?.lstCustomerFeedBackJsonApi?[0].customerGrade ?? "" == "Silver"{
                            self.VC!.gradeIcon.image = UIImage(named: "Silver")
                        }else if result?.lstCustomerFeedBackJsonApi?[0].customerGrade ?? "" == "Platinum"{
                            self.VC!.gradeIcon.image = UIImage(named: "Platinum")
                        }else if result?.lstCustomerFeedBackJsonApi?[0].customerGrade ?? "" == "Bronze"{
                            self.VC!.gradeIcon.image = UIImage(named: "Bronze")
                        }else{
                            self.VC!.gradeIcon.image = UIImage(named: "")
                        }
                        UserDefaults.standard.synchronize()
                            
                        
                        self.VC?.customerTypeIds = result?.lstCustomerFeedBackJsonApi?[0].customerTypeId ?? -1
                        print(self.VC?.customerTypeIds, "")
                        if result?.lstCustomerFeedBackJsonApi?[0].customerTypeId ?? -1 == 1 || result?.lstCustomerFeedBackJsonApi?[0].customerTypeId ?? -1 == 2{
                            self.VC?.whenPurchaseLbl.text = "EarnPointsWhenPurchase".localiz()
                            self.VC?.claimPurchaseLbl.text = "ClaimPurchase".localiz()
                        }else if result?.lstCustomerFeedBackJsonApi?[0].customerTypeId ?? -1 == 3 || result?.lstCustomerFeedBackJsonApi?[0].customerTypeId ?? -1 == 4{
//                            if result?.lstCustomerFeedBackJsonApi?[0].customerTypeId ?? -1 == 3{
//                                self.VC?.helpButton.isHidden = false
//                            }else{
//                                self.VC?.helpButton.isHidden = true
//                            }
                            self.VC?.helpButton.isHidden = false
                            self.VC?.whenPurchaseLbl.text = "Sales&Earn".localiz()
                            self.VC?.claimPurchaseLbl.text = "StartEarning".localiz()
                        }else if result?.lstCustomerFeedBackJsonApi?[0].customerTypeId ?? -1 == 5{
                            DispatchQueue.main.async {
                                if result?.lstCustomerFeedBackJsonApi?[0].customerTypeId == 5{
                                    self.VC?.sideMenuBTN.isHidden = true
                                    self.VC?.supportImageView.isHidden = false
                                    self.VC?.raiseaTicketView.isHidden = true
                                    self.VC?.logoutBtn.isHidden = false
                                    self.VC?.languageTrailingSpace.constant = 62
                                    self.VC?.slideMenuController()?.removeLeftGestures()
                                    UserDefaults.standard.set(result?.lstCustomerFeedBackJsonApi?[0].mappedCustomerId ?? -1, forKey: "mappedCustomerId")
                                    let mappedData = (result?.lstCustomerFeedBackJsonApi?[0].mappedCustomerName ?? "").split(separator: "~")
                                    let mappedCustomerType = result?.lstCustomerFeedBackJsonApi?[0].mappedCustomerType ?? ""
                                    
                                    UserDefaults.standard.set(result?.lstCustomerFeedBackJsonApi?[0].mappedCustomerType ?? "", forKey: "mappedCustomerType")
                                    
                                    self.VC?.whenPurchaseLbl.text = "StartSelling".localiz()
                                    self.VC?.claimPurchaseLbl.text = "ClickHere".localiz()
                                    if mappedData.count > 1{
                                        self.VC?.pointBalanceLbl.text = "\(mappedCustomerType) "+"\(mappedData[1])"
                                    }else{
                                        self.VC?.pointBalanceLbl.text = "\(mappedCustomerType)"
                                    }
                                    self.VC?.pointBalanceTitle.text = "Created By"
                                    
                                    self.VC?.pointBalanceIcon.isHidden = true
                                    
                                }else{
                                    self.VC?.sideMenuBTN.isHidden = false
                                    self.VC?.supportImageView.isHidden = true
                                    self.VC?.raiseaTicketView.isHidden = false
                                    self.VC?.logoutBtn.isHidden = true
                                    self.VC?.languageTrailingSpace.constant = 16
                                }
                            }
                        }
                        UserDefaults.standard.setValue(result?.lstCustomerFeedBackJsonApi?[0].customerId, forKey: "customerId")
                            UserDefaults.standard.setValue(result?.lstCustomerFeedBackJsonApi?[0].firstName, forKey: "FirstName")
                           
                            UserDefaults.standard.setValue(result?.lstCustomerFeedBackJsonApi?[0].loyaltyId, forKey: "LoyaltyId")
                            UserDefaults.standard.set(result?.lstCustomerFeedBackJsonApi?[0].merchantEmail ?? "", forKey: "MerchantEmail")
                            print(result?.lstCustomerFeedBackJsonApi?[0].verifiedStatus ?? "")
                        UserDefaults.standard.set(result?.lstCustomerFeedBackJsonApi?[0].merchantMobile ?? "", forKey: "MerchantMobile")
                            UserDefaults.standard.set(result?.lstCustomerFeedBackJsonApi?[0].verifiedStatus ?? "4", forKey: "verificationStatus")

//                            UserDefaults.standard.set(result?.lstCustomerFeedBackJsonApi?[0].customerMobile ?? "", forKey: "Mobile")
                            UserDefaults.standard.set(result?.lstCustomerFeedBackJsonApi?[0].firstName ?? "", forKey: "FirstName")
                            UserDefaults.standard.set(result?.lstCustomerFeedBackJsonApi?[0].lastName ?? "", forKey: "LastName")
                            UserDefaults.standard.set(result?.lstCustomerFeedBackJsonApi?[0].customerEmail ?? "", forKey: "CustomerEmail")
                            UserDefaults.standard.set(result?.lstCustomerFeedBackJsonApi?[0].merchantId ?? "", forKey: "MerchantID")
                            UserDefaults.standard.set(result?.lstCustomerFeedBackJsonApi?[0].referralCode ?? "", forKey: "ReferralCode")
                            UserDefaults.standard.set(result?.lstCustomerFeedBackJsonApi?[0].company ?? "", forKey: "company")
                            UserDefaults.standard.set(result?.lstCustomerFeedBackJsonApi?[0].customerMobile ?? "", forKey: "CustomerMobileNumber")
                        self.VC?.customerMobileNumber = result?.lstCustomerFeedBackJsonApi?[0].loyaltyId ?? ""
                        let updatePassword: Bool = UserDefaults.standard.bool(forKey: "UpdatePassword")
                        print(updatePassword)
                        if updatePassword {
                            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_SetPasswordVC") as! KC_SetPasswordVC
                            vc.mobileNumber = self.VC!.customerMobileNumber
                            vc.delegate = self
                            vc.modalTransitionStyle = .coverVertical
                            vc.modalPresentationStyle = .overFullScreen
                            self.VC?.present(vc, animated: true, completion: nil)
                        }
                        
                        
                        UserDefaults.standard.set(result?.lstCustomerFeedBackJsonApi?[0].cityID ?? "", forKey: "cityID")
                        UserDefaults.standard.set(result?.lstCustomerFeedBackJsonApi?[0].cityName ?? "", forKey: "cityName")
                        UserDefaults.standard.synchronize()
                        let imageurl = "\(result?.lstCustomerFeedBackJsonApi?[0].customerImage ?? "")".dropFirst(1)
                        let imageData = imageurl.split(separator: "~")
                        if imageData.count >= 2 {
                            print(imageData[1],"jdsnjkdn")
                            let totalImgURL = PROMO_IMG1 + (imageData[1])
                            print(totalImgURL, "Total Image URL")
                            self.VC?.profileImage.kf.setImage(with: URL(string: totalImgURL),placeholder: UIImage(named: "ic_default_img"))
                        }else{
                            let totalImgURL = PROMO_IMG1 + imageurl
                            print(totalImgURL, "Total Image URL")
                            self.VC?.profileImage.kf.setImage(with: URL(string: totalImgURL),placeholder: UIImage(named: "ic_default_img"))
                        }
                            UserDefaults.standard.synchronize()
                        self.VC?.categoryLbl.text = result?.lstCustomerFeedBackJsonApi?[0].customerType ?? ""
                        self.VC!.customerType = result?.lstCustomerFeedBackJsonApi?[0].customerType ?? ""
                         self.VC?.memberNameLbl.text = result?.lstCustomerFeedBackJsonApi?[0].firstName ?? ""
                        self.VC?.memberShipIdLbl.text = result?.lstCustomerFeedBackJsonApi?[0].loyaltyId ?? ""
                    }else{
                        if result?.lstCustomerFeedBackJsonApi?[0].customerStatus ?? 0 != 1{
                            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_ForgetPwdSuccessVC") as! KC_ForgetPwdSuccessVC
                            vc.itsComeFrom = "ACCOUNTDEACTIVATE"
                            vc.modalTransitionStyle = .coverVertical
                            vc.modalPresentationStyle = .overFullScreen
                            self.VC!.present(vc, animated: true)
                        }
                    }
//                    self.VC?.engineerTopicArray.removeAll()
//                    self.VC?.dealerTopicArray.removeAll()
//                    self.VC?.subDealerTopicArray.removeAll()
//                    self.VC?.supportExecutive.removeAll()
//                    
//                    self.VC?.engineerTopicArray += self.VC!.engineerTopicArray1
//                    self.VC?.dealerTopicArray += self.VC!.dealerTopicArray1
//                    self.VC?.subDealerTopicArray += self.VC!.subDealerTopicArray1
//                    self.VC?.supportExecutive += self.VC!.supportExecutive1
                    self.VC?.categoryCollectionView.reloadData()
                    self.VC?.stopLoading()
                }
                }else{
                    DispatchQueue.main.async {
                    self.VC?.stopLoading()
                    }
                }
            }else{
                DispatchQueue.main.async {
                self.VC?.stopLoading()
                }
            }
        }
    }
    
}


