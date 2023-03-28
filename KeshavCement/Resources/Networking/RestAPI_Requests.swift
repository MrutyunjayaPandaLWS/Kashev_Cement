//
//  RestAPI_Requests.swift
//  Millers_Customer_App
//
//  Created by ArokiaIT on 10/30/20.
//

import UIKit

typealias JSON = [String: Any]

class RestAPI_Requests {
    private let client = WebClient(baseUrl: baseURl)
    
        func getCustomerTypeListApi(parameters: JSON, completion: @escaping (CustomerTypeModels?, Error?) -> ()) -> URLSessionDataTask? {
            return client.load(path: customerType_URLMethodName, method: .post, params: parameters) { data, error in
                do{
                    if data != nil{
                        let result1 =  try JSONDecoder().decode(CustomerTypeModels?.self, from: data as! Data)
                        completion(result1, nil)
                    }
                }catch{
                    completion(nil, error)
                }
            }
        }
    
        // MARK : - CUSTOMER LOGIN
        func login_API(parameters: JSON, completion: @escaping (LoginModels?, Error?) -> ()) -> URLSessionDataTask? {
            return client.load(path: loginSubmission_URLMethod, method: .post, params: parameters) { data, error in
                do{
                    if data != nil{
                        let result1 =  try JSONDecoder().decode(LoginModels?.self, from: data as! Data)
                        completion(result1, nil)
                    }
                }catch{
                    completion(nil, error)
                }
            }
        }
    
    func otp_Post_API(parameters: JSON, completion: @escaping (OTPModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: otp_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(OTPModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
//    // MARK : - STATE LISTING DETAILS
    func state_Post_API(parameters: JSON, completion: @escaping (StateListModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: stateList_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(StateListModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
//    // MARK : - taluk LISTING DETAILS
    func taluk_Post_API(parameters: JSON, completion: @escaping (TalukListModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: talukList_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(TalukListModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
//    // MARK : - DISTRICT LISTING DETAILS
    func district_Post_API(parameters: JSON, completion: @escaping (DistrictListModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: districtList_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(DistrictListModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    func registrationSubmissionApi(parameters: JSON, completion: @escaping (RegistrationModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: registrationSubmission_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(RegistrationModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    func forgetPasswordApi(parameters: JSON, completion: @escaping (ForgetPasswordModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: forgetPassword_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(ForgetPasswordModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
        func dashboard_API(parameters: JSON, completion: @escaping (DashBoardModel?, Error?) -> ()) -> URLSessionDataTask? {
            return client.load(path: dashboard_URLMethod, method: .post, params: parameters) { data, error in
                do{
                    if data != nil{
                        let result1 =  try JSONDecoder().decode(DashBoardModel?.self, from: data as! Data)
                        completion(result1, nil)
                    }
                }catch{
                    completion(nil, error)
                }
            }
        }
    
        func dashboardBanner_API(parameters: JSON, completion: @escaping (DashboardBannerModel?, Error?) -> ()) -> URLSessionDataTask? {
            return client.load(path: dashboardBanner_URLMethod, method: .post, params: parameters) { data, error in
                do{
                    if data != nil{
                        let result1 =  try JSONDecoder().decode(DashboardBannerModel?.self, from: data as! Data)
                        completion(result1, nil)
                    }
    
                }catch{
                    completion(nil, error)
                }
            }
        }
        
    func profileImageUpload_API(parameters: JSON, completion: @escaping (ProfileImageUploadModel? , Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: profileImageUpload_URLMethod, method: .post, params: parameters) { data, error in
            do {
                if data != nil{
                    
                    let result1 = try JSONDecoder().decode(ProfileImageUploadModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
                
            }catch{
                completion(nil, error)
            }
        }
    }
    
    func myProfile(parameters: JSON, completion: @escaping (MyProfileListModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: profileDetails_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(MyProfileListModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    func enrollmentApi(parameters: JSON, completion: @escaping (EnrollmentListModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: enrollmentList_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(EnrollmentListModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    func mappedDealerandSubdealerListApi(parameters: JSON, completion: @escaping (MappedDealerandSubDealerModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: enrollmentList_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(MappedDealerandSubDealerModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    func claimProductListApi(parameters: JSON, completion: @escaping (ClaimProductListModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: customerType_URLMethodName, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(ClaimProductListModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    func claimPurchaseSubmissionApi(parameters: JSON, completion: @escaping (ClaimPurchaseSubmissionModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: claimPurchaseSubmission_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(ClaimPurchaseSubmissionModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    func checkQuantityApi(parameters: JSON, completion: @escaping (StockDetailsModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: claimPurchaseSubmission_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(StockDetailsModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    func myClaimPurchaseListApi(parameters: JSON, completion: @escaping (MyPurchaseClaimListModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: myPurchaseClaimList_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(MyPurchaseClaimListModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    func getWorkSiteListApi(parameters: JSON, completion: @escaping (WorkSiteModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: getWorkSiteDetails_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(WorkSiteModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    func getWorkLevelApi(parameters: JSON, completion: @escaping (CustomerTypeModels?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: customerType_URLMethodName, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(CustomerTypeModels?.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    func saveWorkDetailsApi(parameters: JSON, completion: @escaping (WorksiteDetailsSubmissionModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: saveWorkSiteInfo_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(WorksiteDetailsSubmissionModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
 
    func productCategoryListApi(parameters: JSON, completion: @escaping (ProductCategoryModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: productCategory_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(ProductCategoryModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    func productCatalgoueListApi(parameters: JSON, completion: @escaping (ProductCatalogueListModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: productCatalogue_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(ProductCatalogueListModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    func productAddToCartApi(parameters: JSON, completion: @escaping (ProductAddToCartModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: productAddToCart_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(ProductAddToCartModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    func productMyCartListApi(parameters: JSON, completion: @escaping (ProductMyCartListModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: productMyCartList_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(ProductMyCartListModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    func productPlannerListApi(parameters: JSON, completion: @escaping (ProductPlannerListModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: productPlannerList_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(ProductPlannerListModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    func productAddToPlannerApi(parameters: JSON, completion: @escaping (ProductAddToPlannerModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: productAddToPlanner_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(ProductAddToPlannerModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    
    func updateCartApi(parameters: JSON, completion: @escaping (MyCartUpdateModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: myCartUpdate_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(MyCartUpdateModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    
    func plannerRemoveApi(parameters: JSON, completion: @escaping (PlannerRemoveModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: plannerRemove_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(PlannerRemoveModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    func redemptionSubmissionApi(parameters: JSON, completion: @escaping (RedemptionSubmissionModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: redemptionSubmissionURLmethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(RedemptionSubmissionModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    
    
    func userStatusApi(parameters: JSON, completion: @escaping (UserStatusModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: userStatusUrlMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(UserStatusModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    func myRedemptionListApi(parameters: JSON, completion: @escaping (MyRedemptionListModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: myRedemptionListURLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(MyRedemptionListModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
                print(data)
            }catch{
                completion(nil, error)
            }
        }
    }
    func myredemptionDetails(parameters: JSON, completion: @escaping (MyRedemptionDetailsModels?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: myredemptionDetails_URLMethodName, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(MyRedemptionDetailsModels.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    func mappedCustomerListApi(parameters: JSON, completion: @escaping (KC_MappedCustomerListModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: claimPurchaseNameList_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(KC_MappedCustomerListModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
                print(data)
            }catch{
                completion(nil, error)
            }
        }
    }
    
    func cashTransferListApi(parameters: JSON, completion: @escaping (CashTransferModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: myRedemptionListURLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(CashTransferModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
                print(data)
            }catch{
                completion(nil, error)
            }
        }
    }
    
    func cashTransferSubmissionApi(parameters: JSON, completion: @escaping (CashSubmissionModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: redemptionSubmissionURLmethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(CashSubmissionModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
                print(data)
            }catch{
                completion(nil, error)
            }
        }
    }
    
    func pendingClaimListApi(parameters: JSON, completion: @escaping (PendingClaimRequestModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: pendingClaimURLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(PendingClaimRequestModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
                print(data)
            }catch{
                completion(nil, error)
            }
        }
    }
    
    func pendingClaimSubmissionApi(parameters: JSON, completion: @escaping (PendingClaimSubmissionModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: pendingClaimSubmission, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(PendingClaimSubmissionModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
                print(data)
            }catch{
                completion(nil, error)
            }
        }
    }
    
    func cashSubmissionPointsListApi(parameters: JSON, completion: @escaping (CashDetailsModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: getCashTransferDenominations, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(CashDetailsModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
                print(data)
            }catch{
                completion(nil, error)
            }
        }
    }
    func cashTransferSubApi(parameters: JSON, completion: @escaping (CashTrasnSubmissionModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: saveCustomerCasTransferDEtails, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(CashTrasnSubmissionModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
                print(data)
            }catch{
                completion(nil, error)
            }
        }
    }
    
    
    
    func claimHistoryListApi(parameters: JSON, completion: @escaping (ClaimHistoryModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: claimHistoryURLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(ClaimHistoryModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
                print(data)
            }catch{
                completion(nil, error)
            }
        }
    }
    
    func supportExecutiveListApi(parameters: JSON, completion: @escaping (SupportExecutiveModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: supportExecutive, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(SupportExecutiveModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
                print(data)
            }catch{
                completion(nil, error)
            }
        }
    }
    
    func newExecutiveSubmissionApi(parameters: JSON, completion: @escaping (NewSupportExecutiveModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: newSupportExecutive, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(NewSupportExecutiveModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
                print(data)
            }catch{
                completion(nil, error)
            }
        }
    }
    
    func deactivateSupportExecutiveApi(parameters: JSON, completion: @escaping (SupportDeactivateStatusModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: deactivateSupportExecutive, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(SupportDeactivateStatusModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
                print(data)
            }catch{
                completion(nil, error)
            }
        }
    }
    
    func queryListApi(parameters: JSON, completion: @escaping (QueryListModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: queryListURLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(QueryListModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
                print(data)
            }catch{
                completion(nil, error)
            }
        }
    }
    
    func queryTopicListApi(parameters: JSON, completion: @escaping (QueryTopicModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: queryTopicURLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(QueryTopicModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
                print(data)
            }catch{
                completion(nil, error)
            }
        }
    }
    
        func newQuerySubmissionApi(parameters: JSON, completion: @escaping (NewQuerySubmissionModel?, Error?) -> ()) -> URLSessionDataTask? {
            return client.load(path: newQuerySubmissionURLMethod, method: .post, params: parameters) { data, error in
                do{
                    if data != nil{
                        let result1 =  try JSONDecoder().decode(NewQuerySubmissionModel?.self, from: data as! Data)
                        completion(result1, nil)
                    }
                    print(data)
                }catch{
                    completion(nil, error)
                }
            }
        }
    
    func chatDetailsApi(parameters: JSON, completion: @escaping (ChatDetailsModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: chatDetails_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(ChatDetailsModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
                print(data)
            }catch{
                completion(nil, error)
            }
        }
    }
    func newChatSubmiApi(parameters: JSON, completion: @escaping (NewChatSubmitModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: newChatSubmit_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(NewChatSubmitModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
                print(data)
            }catch{
                completion(nil, error)
            }
        }
    }
    
    func myEarningListApi(parameters: JSON, completion: @escaping (MyEarningListModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: myEarningList_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(MyEarningListModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
                print(data)
            }catch{
                completion(nil, error)
            }
        }
    }
    func TCDetails(parameters: JSON, completion: @escaping (TCModels?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: tcMethodname, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(TCModels.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    func profileUpdateApi(parameters: JSON, completion: @escaping (ProfileUpdateModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: profileUpdate_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(ProfileUpdateModel.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    //OFFERS AND PROMOTIONS LIST
    func offersandPromotions(parameters: JSON, completion: @escaping (OffersandPromotionsVM?, Error?) -> ()) -> URLSessionDataTask? {
       return client.load(path: offersandPromotions_URLMethod, method: .post, params: parameters) { data, error in
           do{
               if data != nil{
                   let result1 =  try JSONDecoder().decode(OffersandPromotionsVM?.self, from: data as! Data)
                   completion(result1, nil)
               }
           }catch{
               completion(nil, error)
           }
       }
    }
    
    // MARK : - MY DREAM GIFT LISTING
     func myDreamGiftList(parameters: JSON, completion: @escaping (MyDreamGiftModels?, Error?) -> ()) -> URLSessionDataTask? {
             return client.load(path: myDreamGiftList_URLMethod, method: .post, params: parameters) { data, error in
                 do{
                     if data != nil{
                         let result1 =  try JSONDecoder().decode(MyDreamGiftModels?.self, from: data as! Data)
                         completion(result1, nil)
                     }
                 }catch{
                     completion(nil, error)
                 }
             }
         }
    
    //REMOVE DREAM GIFT
    func removeDreamGifts(parameters: JSON, completion: @escaping (RemoveGiftModels?, Error?) -> ()) -> URLSessionDataTask? {
            return client.load(path: removeDreamGift_URLMethod, method: .post, params: parameters) { data, error in
                do{
                    if data != nil{
                        let result1 =  try JSONDecoder().decode(RemoveGiftModels?.self, from: data as! Data)
                        completion(result1, nil)
                    }
                }catch{
                    completion(nil, error)
                }
            }
        }
    
    //MY DREAM GIFT DETAILS
    func myDreamGiftDetails(parameters: JSON, completion: @escaping (DetailsGiftModels?, Error?) -> ()) -> URLSessionDataTask? {
            return client.load(path: myDreamGiftList_URLMethod, method: .post, params: parameters) { data, error in
                do{
                    if data != nil{
                        let result1 =  try JSONDecoder().decode(DetailsGiftModels?.self, from: data as! Data)
                        completion(result1, nil)
                    }
                }catch{
                    completion(nil, error)
                }
            }
        }
    
    func referralCodeSubmissionApi(parameters: JSON, completion: @escaping (ReferandEarnSubmissionModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: referandEarnURLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(ReferandEarnSubmissionModel.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    func activateAccountApi(parameters: JSON, completion: @escaping (AccountDeactivatedModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: deactivatedAccount_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(AccountDeactivatedModel.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    func getAccountDetailsForActivateApi(parameters: JSON, completion: @escaping (GetAccountDetailForActivateModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: getAccountDetails, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(GetAccountDetailForActivateModel.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    func activateAccountSubmissionApi(parameters: JSON, completion: @escaping (ActivateSubmissionModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: activateSubmission_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(ActivateSubmissionModel.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    func city_Post_API(parameters: JSON, completion: @escaping (CityListModels?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: city_URLMethod, method: .post, params: parameters) { data, error in
            do{
//                print(data)
                if data != nil{
                    let result1 =  try JSONDecoder().decode(CityListModels?.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    
    
    
//    func sendSMStoUserApi(parameters: JSON, completion: @escaping (SendS?, Error?) -> ()) -> URLSessionDataTask? {
//        return client.load(path: redemptionSubmissionURLmethod, method: .post, params: parameters) { data, error in
//            do{
//                if data != nil{
//                    let result1 =  try JSONDecoder().decode(RedemptionSubmissionModel?.self, from: data as! Data)
//                    completion(result1, nil)
//                }
//            }catch{
//                completion(nil, error)
//            }
//        }
//    }
//    
    
//
//    func preferredLanagueApi(parameters: JSON, completion: @escaping (PreferredLanguageModels?, Error?) -> ()) -> URLSessionDataTask? {
//        return client.load(path: preferredLanguage_URLMethod, method: .post, params: parameters) { data, error in
//            do{
//                print(data)
//                if data != nil{
//                    let result1 =  try JSONDecoder().decode(PreferredLanguageModels?.self, from: data as! Data)
//                    completion(result1, nil)
//                }
//            }catch{
//                completion(nil, error)
//            }
//        }
//    }
//    func registrationSubmissionApi(parameters: JSON, completion: @escaping (RegistrationSubmissionModels?, Error?) -> ()) -> URLSessionDataTask? {
//        return client.load(path: registrationSubmission, method: .post, params: parameters) { data, error in
//            do{
//                print(data)
//                if data != nil{
//                    let result1 =  try JSONDecoder().decode(RegistrationSubmissionModels?.self, from: data as! Data)
//                    completion(result1, nil)
//                }
//            }catch{
//                completion(nil, error)
//            }
//        }
//    }
//
//    // NOTIFICATION LISTING
//
//    func notificationList(parameters: JSON, completion: @escaping (NotificationModels?, Error?) -> ()) -> URLSessionDataTask? {
//       return client.load(path: historyNotification, method: .post, params: parameters) { data, error in
//           do{
//               if data != nil{
//                   let result1 =  try JSONDecoder().decode(NotificationModels?.self, from: data as! Data)
//                   completion(result1, nil)
//               }
//           }catch{
//               completion(nil, error)
//           }
//       }
//    }
//
//    //QUERY LISTING
//    func queryListingApi(parameters: JSON, completion: @escaping (QueryListingModels?, Error?) -> ()) -> URLSessionDataTask? {
//       return client.load(path: queryListing_URLMethod, method: .post, params: parameters) { data, error in
//           do{
//               if data != nil{
//                   let result1 =  try JSONDecoder().decode(QueryListingModels?.self, from: data as! Data)
//                   completion(result1, nil)
//               }
//           }catch{
//               completion(nil, error)
//           }
//       }
//   }
//
//    //HELP TOPIC LISING
//
//      func helpTopicListingApi(parameters: JSON, completion: @escaping (HelpTopicModel?, Error?) -> ()) -> URLSessionDataTask? {
//         return client.load(path: helpTopic_URLMethod, method: .post, params: parameters) { data, error in
//             do{
//                 if data != nil{
//                     let result1 =  try JSONDecoder().decode(HelpTopicModel?.self, from: data as! Data)
//                     completion(result1, nil)
//                 }
//             }catch{
//                 completion(nil, error)
//             }
//         }
//     }
//
//    //NEW QUERY SUBMISSION
//
//    func newQuerySubmissionApi(parameters: JSON, completion: @escaping (NewQuerySubmission?, Error?) -> ()) -> URLSessionDataTask? {
//       return client.load(path: newQuerySubmission_URLMethod, method: .post, params: parameters) { data, error in
//           do{
//               if data != nil{
//                   let result1 =  try JSONDecoder().decode(NewQuerySubmission?.self, from: data as! Data)
//                   completion(result1, nil)
//               }
//           }catch{
//               completion(nil, error)
//           }
//       }
//    }
//    // CHAT DETAILS LISTING
//
//    func chatDetailsApi(parameters: JSON, completion: @escaping (ChatDetailsModels?, Error?) -> ()) -> URLSessionDataTask? {
//       return client.load(path: chatDetails_URLMethod, method: .post, params: parameters) { data, error in
//           do{
//               if data != nil{
//                   let result1 =  try JSONDecoder().decode(ChatDetailsModels?.self, from: data as! Data)
//                   completion(result1, nil)
//               }
//           }catch{
//               completion(nil, error)
//           }
//       }
//   }
//    //NEW CHAT SUBMISSION
//
//    func newChatSubmissio(parameters: JSON, completion: @escaping (NewChatSubmission?, Error?) -> ()) -> URLSessionDataTask? {
//       return client.load(path: chatSubmission_URLMethod, method: .post, params: parameters) { data, error in
//           do{
//               if data != nil{
//                   let result1 =  try JSONDecoder().decode(NewChatSubmission?.self, from: data as! Data)
//                   completion(result1, nil)
//               }
//           }catch{
//               completion(nil, error)
//           }
//       }
//    }
//
//
//    //REDEMPTION CATEGORY LISTING
//    func redemptionCateogryListing(parameters: JSON, completion: @escaping (RedemptionCategoryModels?, Error?) -> ()) -> URLSessionDataTask? {
//        return client.load(path: productCategory_URLMethod, method: .post, params: parameters) { data, error in
//            do{
//                if data != nil{
//                    let result1 =  try JSONDecoder().decode(RedemptionCategoryModels?.self, from: data as! Data)
//                    completion(result1, nil)
//                }
//                print(data)
//            }catch{
//                completion(nil, error)
//            }
//        }
//    }
//
//
//
//
//    // MARK : - MY REDEMPTION LISTING
//    func redemptionListing_Post_API(parameters: JSON, completion: @escaping (MyRedemptionModels?, Error?) -> ()) -> URLSessionDataTask? {
//            return client.load(path: myRedemptionList_URLMethod, method: .post, params: parameters) { data, error in
//                do{
//                    if data != nil{
//                        let result1 =  try JSONDecoder().decode(MyRedemptionModels?.self, from: data as! Data)
//                        completion(result1, nil)
//                    }
//                }catch{
//                    completion(nil, error)
//                }
//            }
//        }
//
//
//    // MARK : - MY EARNING LISTING
//    func myEarningListApi(parameters: JSON, completion: @escaping (MyEarningModels?, Error?) -> ()) -> URLSessionDataTask? {
//            return client.load(path: myEarningList_URLMethod, method: .post, params: parameters) { data, error in
//                do{
//                    if data != nil{
//                        let result1 =  try JSONDecoder().decode(MyEarningModels?.self, from: data as! Data)
//                        completion(result1, nil)
//                    }
//                    print(data, "My Earning Data")
//                }catch{
//                    completion(nil, error)
//                }
//            }
//        }
//
//
//    //OFFERS AND PROMOTIONS LIST
//    func offersandPromotions(parameters: JSON, completion: @escaping (OffersandPromotionsVM?, Error?) -> ()) -> URLSessionDataTask? {
//       return client.load(path: offersandPromotions_URLMethod, method: .post, params: parameters) { data, error in
//           do{
//               if data != nil{
//                   let result1 =  try JSONDecoder().decode(OffersandPromotionsVM?.self, from: data as! Data)
//                   completion(result1, nil)
//               }
//           }catch{
//               completion(nil, error)
//           }
//       }
//    }
//
//    // MARK : - MY DREAM GIFT LISTING
//     func myDreamGiftList(parameters: JSON, completion: @escaping (MyDreamGiftModels?, Error?) -> ()) -> URLSessionDataTask? {
//             return client.load(path: myDreamGiftList_URLMethod, method: .post, params: parameters) { data, error in
//                 do{
//                     if data != nil{
//                         let result1 =  try JSONDecoder().decode(MyDreamGiftModels?.self, from: data as! Data)
//                         completion(result1, nil)
//                     }
//                 }catch{
//                     completion(nil, error)
//                 }
//             }
//         }
//
//    //REMOVE DREAM GIFT
//    func removeDreamGifts(parameters: JSON, completion: @escaping (RemoveGiftModels?, Error?) -> ()) -> URLSessionDataTask? {
//            return client.load(path: removeDreamGift_URLMethod, method: .post, params: parameters) { data, error in
//                do{
//                    if data != nil{
//                        let result1 =  try JSONDecoder().decode(RemoveGiftModels?.self, from: data as! Data)
//                        completion(result1, nil)
//                    }
//                }catch{
//                    completion(nil, error)
//                }
//            }
//        }
//
//    //MY DREAM GIFT DETAILS
//    func myDreamGiftDetails(parameters: JSON, completion: @escaping (DetailsGiftModels?, Error?) -> ()) -> URLSessionDataTask? {
//            return client.load(path: myDreamGiftList_URLMethod, method: .post, params: parameters) { data, error in
//                do{
//                    if data != nil{
//                        let result1 =  try JSONDecoder().decode(DetailsGiftModels?.self, from: data as! Data)
//                        completion(result1, nil)
//                    }
//                }catch{
//                    completion(nil, error)
//                }
//            }
//        }
//
//
//    //Pan get details
//    func getpaneApi(parameters: JSON, completion: @escaping (GetpanDetails?, Error?) -> ()) -> URLSessionDataTask? {
//       return client.load(path: GetPanDetails, method: .post, params: parameters) { data, error in
//           do{
//               if data != nil{
//                   let result1 =  try JSONDecoder().decode(GetpanDetails?.self, from: data as! Data)
//                   completion(result1, nil)
//               }
//               print(data)
//           }catch{
//               completion(nil, error)
//           }
//       }
//    }

//
//    // MARK : - FORGOT PASSWORD
//    func forgotPassword_API(parameters: JSON, completion: @escaping (ForgotPasswordModels?, Error?) -> ()) -> URLSessionDataTask? {
//        return client.load(path: forgotPassword_URLMethod, method: .post, params: parameters) { data, error in
//            do{
//                if data != nil{
//                    let result1 =  try JSONDecoder().decode(ForgotPasswordModels?.self, from: data as! Data)
//                    completion(result1, nil)
//                }
//            }catch{
//                completion(nil, error)
//            }
//        }
//    }
//
//    // MARK : - MEMBERSHIP ID VERIFICATION
//    func membershipIDVerification_API(parameters: JSON, completion: @escaping (MemberVerificationModels?, Error?) -> ()) -> URLSessionDataTask? {
//        return client.load(path: memberVerification_URLMethod, method: .post, params: parameters) { data, error in
//            do{
//                if data != nil{
//                    let result1 =  try JSONDecoder().decode(MemberVerificationModels?.self, from: data as! Data)
//                    print(result1)
//                    completion(result1, nil)
//                }
//            }catch{
//                print(error)
//                completion(nil, error)
//            }
//        }
//    }
//

//
//    // MARK : - DASHBOARDN BANNER IMAGES

//
//    // USER ISACTIVE
//    func userIsActive(parameters: JSON, completion: @escaping (UserStatusModels?, Error?) -> ()) -> URLSessionDataTask? {
//            return client.load(path: userStatus_URLMethod, method: .post, params: parameters) { data, error in
//                do{
//                    if data != nil{
//                        let result1 =  try JSONDecoder().decode(UserStatusModels?.self, from: data as! Data)
//                        completion(result1, nil)
//                    }
//                }catch{
//                    completion(nil, error)
//                }
//            }
//        }
//
//
//    //REDEMPTION CATALOGUE LISTING
//
//    func redemptionCatalogueListing(parameters: JSON, completion: @escaping (RedemptionCatalogueModels?, Error?) -> ()) -> URLSessionDataTask? {
//            return client.load(path: productCatalogue_URLMethod, method: .post, params: parameters) { data, error in
//                do{
//                    if data != nil{
//                        let result1 =  try JSONDecoder().decode(RedemptionCatalogueModels?.self, from: data as! Data)
//                        completion(result1, nil)
//                    }
//                }catch{
//                    completion(nil, error)
//                }
//            }
//        }
//
//    //ADD TO CART
//    func addToCartApi(parameters: JSON, completion: @escaping (AddToCartModels?, Error?) -> ()) -> URLSessionDataTask? {
//            return client.load(path: addToCart_URLMethod, method: .post, params: parameters) { data, error in
//                do{
//                    if data != nil{
//                        let result1 =  try JSONDecoder().decode(AddToCartModels?.self, from: data as! Data)
//                        completion(result1, nil)
//                    }
//                }catch{
//                    completion(nil, error)
//                }
//            }
//        }
//
//    // REMOVE PRODUCT IN PLANNER LIST
//    func removePlannedProduct(parameters: JSON, completion: @escaping (RemovePlannedProduct?, Error?) -> ()) -> URLSessionDataTask? {
//        return client.load(path: removePlannerURL, method: .post, params: parameters) { data, error in
//            do{
//                if data != nil{
//                    let result1 =  try JSONDecoder().decode(RemovePlannedProduct?.self, from: data as! Data)
//                    completion(result1, nil)
//                }
//            }catch{
//                completion(nil, error)
//            }
//        }
//    }
//
//    //ADD TO PLANNER
//    func addToPlannerApi(parameters: JSON, completion: @escaping (AddToPlannerModel?, Error?) -> ()) -> URLSessionDataTask? {
//            return client.load(path: addToPlanner_URLMethod, method: .post, params: parameters) { data, error in
//                do{
//                    if data != nil{
//                        let result1 =  try JSONDecoder().decode(AddToPlannerModel?.self, from: data as! Data)
//                        completion(result1, nil)
//                    }
//                }catch{
//                    completion(nil, error)
//                }
//            }
//        }
//
//
//    //MY CART LIST
//    func myCartList(parameters: JSON, completion: @escaping (MyCartModels?, Error?) -> ()) -> URLSessionDataTask? {
//            return client.load(path: myCartList_URLMethod, method: .post, params: parameters) { data, error in
//                do{
//                    if data != nil{
//                        let result1 =  try JSONDecoder().decode(MyCartModels?.self, from: data as! Data)
//                        completion(result1, nil)
//                    }
//                }catch{
//                    completion(nil, error)
//                }
//            }
//        }
//
//    // INCREASE CART COUNT
//    func increaseCartCount(parameters: JSON, completion: @escaping (IncreaseProductModels?, Error?) -> ()) -> URLSessionDataTask? {
//            return client.load(path: updateMyCart_URLMethod, method: .post, params: parameters) { data, error in
//                do{
//                    if data != nil{
//                        let result1 =  try JSONDecoder().decode(IncreaseProductModels?.self, from: data as! Data)
//                        completion(result1, nil)
//                    }
//                }catch{
//                    completion(nil, error)
//                }
//            }
//        }
//
//    // REMOVE CART COUNT
//    func removeProduct(parameters: JSON, completion: @escaping (RemoveCartModel?, Error?) -> ()) -> URLSessionDataTask? {
//            return client.load(path: updateMyCart_URLMethod, method: .post, params: parameters) { data, error in
//                do{
//                    if data != nil{
//                        let result1 =  try JSONDecoder().decode(RemoveCartModel?.self, from: data as! Data)
//                        completion(result1, nil)
//                    }
//                }catch{
//                    completion(nil, error)
//                }
//            }
//        }
//
//
//    // PLANNER LISTING
//    func plannerListApi(parameters: JSON, completion: @escaping (PlannerListModels?, Error?) -> ()) -> URLSessionDataTask? {
//            return client.load(path: plannerList_URLMethod, method: .post, params: parameters) { data, error in
//                do{
//                    if data != nil{
//                        let result1 =  try JSONDecoder().decode(PlannerListModels?.self, from: data as! Data)
//                        completion(result1, nil)
//                    }
//                }catch{
//                    completion(nil, error)
//                }
//            }
//        }
//
//    // Claim Status
//    func claimStatusApi(parameters: JSON, completion: @escaping (ClaimStatusModels?, Error?) -> ()) -> URLSessionDataTask? {
//            return client.load(path: BindAssessmentRequestDetails_MethodeName, method: .post, params: parameters) { data, error in
//                do{
//                    if data != nil{
//                        let result1 =  try JSONDecoder().decode(ClaimStatusModels?.self, from: data as! Data)
//                        completion(result1, nil)
//                    }
//                    print(data)
//                }catch{
//                    completion(nil, error)
//                }
//            }
//        }
//
//    //Delete Account
//
//    func deleteAccountApi(parameters: JSON, completion: @escaping (DeleteAccountModels?, Error?) -> ()) -> URLSessionDataTask? {
//       return client.load(path: deleteAccountMethodName, method: .post, params: parameters) { data, error in
//           do{
//               if data != nil{
//                   let result1 =  try JSONDecoder().decode(DeleteAccountModels?.self, from: data as! Data)
//                   completion(result1, nil)
//               }
//           }catch{
//               completion(nil, error)
//           }
//       }
//    }
//

//    // ClaimPoints LISTING
//
//    func claimPointsAPI(parameters: JSON, completion: @escaping (ClaimPointsModelView?, Error?) -> ()) -> URLSessionDataTask? {
//            return client.load(path: BindProductDetails, method: .post, params: parameters) { data, error in
//                do{
//                    if data != nil{
//                        let result1 =  try JSONDecoder().decode(ClaimPointsModelView?.self, from: data as! Data)
//                        completion(result1, nil)
//                    }
//                }catch{
//                    completion(nil, error)
//                }
//            }
//        }
//
//
//    // ClaimPoints Delar list
//
//    func claimPointsDelarAPI(parameters: JSON, completion: @escaping (DealerListModels?, Error?) -> ()) -> URLSessionDataTask? {
//            return client.load(path: GetAttributeDetailsMobileApp, method: .post, params: parameters) { data, error in
//                do{
//                    if data != nil{
//                        let result1 =  try JSONDecoder().decode(DealerListModels?.self, from: data as! Data)
//                        completion(result1, nil)
//                    }
//                }catch{
//                    completion(nil, error)
//                }
//            }
//        }
//
//
//    func claimPointsSubmission(parameters: JSON, completion: @escaping (ClaimPointsSubmissionModels?, Error?) -> ()) -> URLSessionDataTask? {
//            return client.load(path: claimPointsSubmission_URLMethod, method: .post, params: parameters) { data, error in
//                do{
//                    if data != nil{
//                        let result1 =  try JSONDecoder().decode(ClaimPointsSubmissionModels?.self, from: data as! Data)
//                        completion(result1, nil)
//                    }
//                }catch{
//                    completion(nil, error)
//                }
//            }
//        }
//    func pointStatementAPI(parameters: JSON, completion: @escaping (PointStatementModels?, Error?) -> ()) -> URLSessionDataTask? {
//            return client.load(path: GetPointStatements_URLMethod, method: .post, params: parameters) { data, error in
//                do{
//                    if data != nil{
//                        let result1 =  try JSONDecoder().decode(PointStatementModels?.self, from: data as! Data)
//                        completion(result1, nil)
//                    }
//                }catch{
//                    completion(nil, error)
//                }
//            }
//        }
//    //MySummeryAPI
//    func mySummeryAPI(parameters: JSON, completion: @escaping (MySummeryViewModels?, Error?) -> ()) -> URLSessionDataTask? {
//            return client.load(path: influencerSummary_URLMethode, method: .post, params: parameters) { data, error in
//                do{
//                    if data != nil{
//                        let result1 =  try JSONDecoder().decode(MySummeryViewModels?.self, from: data as! Data)
//                        completion(result1, nil)
//                    }
//                }catch{
//                    completion(nil, error)
//                }
//            }
//        }
//    // Redemption OTP
//
//    func redemptionOTP(parameters: JSON, completion: @escaping (RedemptionOTPModels?, Error?) -> ()) -> URLSessionDataTask? {
//            return client.load(path: getOTP_URLMethod, method: .post, params: parameters) { data, error in
//                do{
//                    if data != nil{
//                        let result1 =  try JSONDecoder().decode(RedemptionOTPModels?.self, from: data as! Data)
//                        completion(result1, nil)
//                    }
//                }catch{
//                    completion(nil, error)
//                }
//            }
//        }
//
//    // USER ISACTIVE
//
////    func userIsActive(parameters: JSON, completion: @escaping (UserStatusModels?, Error?) -> ()) -> URLSessionDataTask? {
////            return client.load(path: userStatus_URLMethod, method: .post, params: parameters) { data, error in
////                do{
////                    if data != nil{
////                        let result1 =  try JSONDecoder().decode(UserStatusModels?.self, from: data as! Data)
////                        completion(result1, nil)
////                    }
////                }catch{
////                    completion(nil, error)
////                }
////            }
////        }
//
//    // REDEMPTION SUBMISSION
//
//    func redemptionSubmission(parameters: JSON, completion: @escaping (RedemptionSubmission?, Error?) -> ()) -> URLSessionDataTask? {
//            return client.load(path: redemptionSubmission_URLMethod, method: .post, params: parameters) { data, error in
//                do{
//                    if data != nil{
//                        let result1 =  try JSONDecoder().decode(RedemptionSubmission?.self, from: data as! Data)
//                        completion(result1, nil)
//                    }
//                }catch{
//                    completion(nil, error)
//                }
//            }
//        }
//
//    //SEND SMS
//
//    func sendSMSApi(parameters: JSON, completion: @escaping (SendSMSModel?, Error?) -> ()) -> URLSessionDataTask? {
//            return client.load(path: sendSMS_URL, method: .post, params: parameters) { data, error in
//                do{
//                    if data != nil{
//                        let result1 =  try JSONDecoder().decode(SendSMSModel?.self, from: data as! Data)
//                        completion(result1, nil)
//                    }
//                }catch{
//                    completion(nil, error)
//                }
//            }
//        }
//
//    //SEND SUCCESS MESSAGE
//
//    func sendSuccessMessage(parameters: JSON, completion: @escaping (SendSuccessModels?, Error?) -> ()) -> URLSessionDataTask? {
//            return client.load(path: sendSuccessURL, method: .post, params: parameters) { data, error in
//                do{
//                    if data != nil{
//                        let result1 =  try JSONDecoder().decode(SendSuccessModels?.self, from: data as! Data)
//                        completion(result1, nil)
//                    }
//                }catch{
//                    completion(nil, error)
//                }
//            }
//        }
//func myRedemptionStausListApi(parameters: JSON, completion: @escaping (MyRedemptionStatusModels?, Error?) -> ()) -> URLSessionDataTask? {
//        return client.load(path: preferredLanguage_URLMethod, method: .post, params: parameters) { data, error in
//            do{
//                if data != nil{
//                    let result1 =  try JSONDecoder().decode(MyRedemptionStatusModels?.self, from: data as! Data)
//                    completion(result1, nil)
//                }
//            }catch{
//                completion(nil, error)
//            }
//        }
//    }
//
//    //ImageSavingAPI
//    func imageSavingAPI(parameters: JSON, completion: @escaping (SideMenuModelClass?, Error?) -> ()) -> URLSessionDataTask? {
//            return client.load(path: UpdateCustomerProfileMobileApp, method: .post, params: parameters) { data, error in
//                do{
//                    if data != nil{
//                        let result1 =  try JSONDecoder().decode(SideMenuModelClass?.self, from: data as! Data)
//                        completion(result1, nil)
//                    }
//                }catch{
//                    completion(nil, error)
//                }
//            }
//        }
//
//    func TCDetails(parameters: JSON, completion: @escaping (TCModels?, Error?) -> ()) -> URLSessionDataTask? {
//        return client.load(path: tcMethodname, method: .post, params: parameters) { data, error in
//            do{
//                if data != nil{
//                    let result1 =  try JSONDecoder().decode(TCModels.self, from: data as! Data)
//                    completion(result1, nil)
//                }
//            }catch{
//                completion(nil, error)
//            }
//        }
//    }
    func adhaarCardExistApi(parameters: JSON, completion: @escaping (AdhaarCardExistsModels?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: preferredLanguage_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(AdhaarCardExistsModels.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    func redeemVoucher(parameters: JSON, completion: @escaping (VoucherRedemptionModels?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: voucherRedeem_URLMethodName, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(VoucherRedemptionModels.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    func evoucherListApi(parameters: JSON, completion: @escaping (EvoucherListModels?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: evoucherList_MethodName, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(EvoucherListModels.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    // MARK : - VOUCHER SUBMISSION
    func voucherSubmission_Post_API(parameters: JSON, completion: @escaping (SubmitVoucherModels?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: voucherSubmit_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(SubmitVoucherModels?.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    func cashTransferListsApi(parameters: JSON, completion: @escaping (CashTransferHistoryListModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: cashTransferHistoryList, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(CashTransferHistoryListModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    func cashTransferApproveOrRejectionSubmissionApi(parameters: JSON, completion: @escaping (CashTransferApproveOrRejectionSubmissionModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: cashTransferApproveOrRejectionSubmission, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(CashTransferApproveOrRejectionSubmissionModel?.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
}
