//
//  KC_ProductCatalogueListVM.swift
//  KeshavCement
//
//  Created by ADMIN on 23/02/2023.
//

import UIKit
import LanguageManager_iOS
class KC_ProductCatalogueListVM{
//:  popUpAlertDelegate {
//    func popupAlertDidTap(_ vc: HR_PopUpVC) {}
    
    weak var VC: KC_ProductCatalogueVC?
    var requestAPIs = RestAPI_Requests()
    var loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyId") ?? ""
    var userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    
    var categoryListArray = [ObjCatalogueCategoryListJson]()
    var productCategoryList = [ObjCatalogueCategoryListJson]()
    var brandArray = [ObjCatalogueList]()
    var catalgoueListArray = [ObjCatalogueList]()
    var filteredArray = [ObjCatalogueList]()
    var myCartListArray = [CatalogueSaveCartDetailListResponse]()
    var sumOfProductsCount = 0
    var plannerListArray = [ObjCatalogueList1]()
    var productCategoryListArray = [ProductCateogryModels]()
    var parameters : JSON?
    
    deinit{
        
    }
    
    func getMycartList(PartyLoyaltyID: String, LoyaltyID: String){
        self.VC?.startLoading()
        let parameters = [
            "ActionType": "2",
            "LoyaltyID": LoyaltyID,
             "Domain": "KESHAV_CEMENT",
            "PartyLoyaltyID": PartyLoyaltyID
        ] as [String : Any]
        print(parameters)
        self.requestAPIs.productMyCartListApi(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        self.myCartListArray = result?.catalogueSaveCartDetailListResponse ?? []
                        self.sumOfProductsCount = Int(result?.catalogueSaveCartDetailListResponse?[0].sumOfTotalPointsRequired ?? 0)
                        print(self.myCartListArray.count, "My cart Count")
                        self.VC?.cartCount.text = "\(self.myCartListArray.count)"
                       // self.VC?.productsDetailCollectionView.reloadData()
                      //  self.productCategoryApi()

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
    
    
    func productCategoryApi(userId: Int){
        self.VC?.startLoading()
        let parameters = [
               "ActionType": "1",
               "ActorId": userId,
                "IsActive": 1
        ] as [String : Any]
        print(parameters)
        self.requestAPIs.productCategoryListApi(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        self.productCategoryListArray.removeAll()
                        self.categoryListArray = result?.objCatalogueCategoryListJson ?? []
                        print(self.categoryListArray.count,"Product Category Count")
                        
                        if self.categoryListArray.count != 0{
                            self.productCategoryListArray.append((ProductCateogryModels(productCategoryId: "-1", productCategorName: "ALL", isSelected: 0)))
                            for item in self.categoryListArray{
                                self.productCategoryListArray.append(ProductCateogryModels(productCategoryId: "\(item.catogoryId ?? 0)", productCategorName: item.catogoryName ?? "", isSelected: 0))
                            }
                            self.VC?.productCategoryCollectionView.isHidden = false
                            
//                            self.VC?.noDataFoundCategoryList.isHidden = true
                            self.VC?.productCategoryCollectionView.reloadData()
                            if self.VC!.mappedUserId == -1{
                                self.catalogueListApi(searchText: self.VC?.searchProductTF.text ?? "", startIndex: self.VC!.startIndex, userId: Int(self.VC!.userID)!)
                            }else{
                                self.catalogueListApi(searchText: self.VC?.searchProductTF.text ?? "", startIndex: self.VC!.startIndex, userId: self.VC!.mappedUserId)
                            }
                        }else{
                            self.VC?.productCategoryCollectionView.isHidden = true
                            
//                            self.VC?.noDataFoundCategoryList.isHidden = false
                        }
                        
                    }
                }else{
                    DispatchQueue.main.async {
                        //self.VC?.noDataFoundCategoryList.isHidden = false
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
    func catalogueListApi(searchText: String, startIndex: Int, userId: Int){
        self.VC?.startLoading()
        self.parameters?.removeAll()
        if self.VC?.itsFrom == "Search"{
            self.parameters = [
                "ActionType": "6",
                "Domain": "KESHAV_CEMENT",
                "ActorId": userId,
                  "ObjCatalogueDetails": [
                      "MerchantId": 1,
                      "CatogoryId": -1,
                      "CatalogueType": 1,
                      "MultipleRedIds": ""
                  ],
                "SearchText": "\(self.VC?.searchProductTF.text ?? "")",
                "StartIndex": "\(self.VC?.startIndex ?? -1)",
                  "NoOfRows": 10,
                "Sort": ""
            ] as [String : Any]
            print(self.parameters!)
        }else{
            self.parameters = [
                "ActionType": "6",
                "Domain": "KESHAV_CEMENT",
                "ActorId": userId,
                  "ObjCatalogueDetails": [
                      "MerchantId": 1,
                      "CatogoryId": "\(self.VC?.categoryId ?? -1)",
                      "CatalogueType": 1,
                      "MultipleRedIds": "\(self.VC?.selectedPtsRange ?? "")"
                  ],
                "SearchText": "\(self.VC?.searchProductTF.text ?? "")",
                "StartIndex": "\(self.VC?.startIndex ?? -1)",
                "NoOfRows": 10,
                "Sort": "\(self.VC?.sortedBy ?? -1)"
            ] as [String : Any]
            print(self.parameters!)
        }
        self.requestAPIs.productCatalgoueListApi(parameters: self.parameters!) { (result, error) in

                if error == nil{
                    if result != nil{
                        DispatchQueue.main.async {
                            self.VC?.stopLoading()
                            let catalogueProductsList = result?.objCatalogueList ?? []
                            print(catalogueProductsList.count, "catalogueProductsList List Count")
                            if catalogueProductsList.isEmpty == false || catalogueProductsList.count != 0{
                                self.catalgoueListArray = self.catalgoueListArray + catalogueProductsList
                                self.VC?.noofelements = self.catalgoueListArray.count
                                self.brandArray = self.catalgoueListArray
                                print(self.catalgoueListArray.count, "Catalogue List Count")
                                if self.catalgoueListArray.count != 0{
                                    self.VC?.productsDetailCollectionView.isHidden = false
                                    self.VC?.noDataFound.isHidden = true
                                    self.VC?.productsDetailCollectionView.reloadData()
                                    print("Catalgoue Count is not equal to 10")
                                }
//                                else{
//                                    //self.VC?.startIndex = 1
//                                    self.VC?.productsDetailCollectionView.isHidden = true
//                                    self.VC?.noDataFound.isHidden = false
//                                    print("Catalgoue Count is equal to 10")
//                                }
                                if self.VC?.customerTypeId ?? "" == "3" && self.VC?.partyLoyaltyId != "" || self.VC?.customerTypeId ?? "" == "4" && self.VC?.partyLoyaltyId != ""{
                                    
                                        self.getMycartList(PartyLoyaltyID: self.loyaltyId, LoyaltyID: self.VC!.partyLoyaltyId)
                                   
                                    if self.VC!.mappedUserId != -1{
                                        self.redemptionPlannerList(PartyLoyaltyID: self.VC!.partyLoyaltyId, userId: self.VC!.mappedUserId)
                                    }else{
                                        self.redemptionPlannerList(PartyLoyaltyID: self.VC!.partyLoyaltyId, userId: Int(self.userID)!)
                                    }
                                    
                                    
                                    
                                }else if self.VC?.customerTypeId ?? "" == "3" && self.VC?.partyLoyaltyId == "" || self.VC?.customerTypeId ?? "" == "4" && self.VC?.partyLoyaltyId == ""{
                                    self.getMycartList(PartyLoyaltyID: "", LoyaltyID: self.loyaltyId)
                                    
                                    if self.VC!.mappedUserId == -1{
                                        self.redemptionPlannerList(PartyLoyaltyID: "", userId: Int(self.userID)!)
                                    }else{
                                        self.redemptionPlannerList(PartyLoyaltyID: "", userId: self.VC!.mappedUserId)
                                    }
                                }else{
                                        self.getMycartList(PartyLoyaltyID: "", LoyaltyID: self.loyaltyId)
                                    if self.VC!.mappedUserId == -1{
                                        self.redemptionPlannerList(PartyLoyaltyID: "", userId: Int(self.userID)!)
                                    }else{
                                        self.redemptionPlannerList(PartyLoyaltyID: "", userId: self.VC!.mappedUserId)
                                    }
                                    }
                                    
                                
                                
                            }else{
                                if self.VC?.itsFrom == "Search" && self.VC!.startIndex > 1 || self.VC?.itsFrom == "Category" && self.VC!.startIndex > 1 || self.VC?.itsFrom == "PtsRange" && self.VC!.startIndex > 1{
                                    print(self.VC!.itsFrom, "shdfjlsadk;fgdlgkjfkldsglfsf")
//                                    self.VC?.startIndex = 1
//                                    self.VC?.noofelements = 9
                                    print("Catalgoue Count is 10")
                                }else{
                                    self.VC?.productsDetailCollectionView.isHidden = true
                                    self.VC?.noDataFound.isHidden = false
                                    print("sadfasdfjasdklfsadkljfsdakljfsdaflasdflj")
                                }

                            }
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
//    func cartCountApi(){
//        self.VC?.startLoading()
//        let parameters = [
//            "ActionType":"1",
//            "LoyaltyID":"\(loyaltyId)"
//        ] as [String : Any]
//        print(parameters)
//        self.requestAPIs.cartCountApi(parameters: parameters) { (result, error) in
//            if error == nil{
//                if result != nil{
//                    DispatchQueue.main.async{
//                        self.VC?.stopLoading()
//                        self.redemptionPlannerList()
//
//                    }
//                }else{
//                    DispatchQueue.main.async{
//                        self.VC?.stopLoading()
//                    }
//                }
//            }else{
//                DispatchQueue.main.async{
//                    self.VC?.stopLoading()
//                }
//            }
//        }
//    }
    func redemptionPlannerList(PartyLoyaltyID: String, userId: Int){
        self.VC?.startLoading()
        let parameters = [
            "ActionType": "6",
            "ActorId": userId,
             "StartIndex": 1,
             "PageSize": 10,
             "PartyLoyaltyID": PartyLoyaltyID
        ] as [String : Any]
        print(parameters)
        self.requestAPIs.productPlannerListApi(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        self.plannerListArray = result?.objCatalogueList ?? []
                        print(self.plannerListArray.count, "Planner List Count")
                        
                        self.VC?.productsDetailCollectionView.reloadData()
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
    
//    func filteredCategoryListApi(){
//        self.VC?.startLoading()
//        let parameters = [
//            "ActionType":"6",
//            "ActorId":"\(self.userID)",
//            "ObjCatalogueDetails":[
//                "CatalogueType":"1",
//                "CatogoryId": self.VC?.categoryId ?? -1,
//                "MerchantId":"1"
//        ]
//        ] as [String :Any]
//        print(parameters)
//        self.requestAPIs.filteredCatalogueListApi(parameters: parameters) { (result, error) in
//            if error == nil{
//                print(result ?? "", "Result")
//                if result != nil{
//                    DispatchQueue.main.async {
//                        self.catalgoueListArray = result?.objCatalogueList ?? []
//                        print(self.catalgoueListArray.count, "Catalogue List Count")
//                        if self.catalgoueListArray.count != 0{
//                            self.VC?.productsDetailCollectionView.isHidden = false
//                            self.VC?.noDataFound.isHidden = true
//                            self.VC?.productsDetailCollectionView.reloadData()
//                        }else{
//                            self.VC?.productsDetailCollectionView.isHidden = true
//                            self.VC?.noDataFound.isHidden = false
//                        }
//
//                    }
//                    DispatchQueue.main.async {
//                        self.VC?.stopLoading()
//                    }
//                }else{
//                    DispatchQueue.main.async {
//                        self.VC?.stopLoading()
//                    }
//                }
//            }else{
//                DispatchQueue.main.async {
//                    self.VC?.stopLoading()
//                }
//            }
//
//        }
//
//    }
//
    //Add to Cart Api
    
    func addToCartApi(PartyLoyaltyID: String, LoyaltyID: String, userId: Int){
        self.VC?.startLoading()
        let parameters = [
                "ActionType": "1",
                "ActorId": userId,
                "CatalogueSaveCartDetailListRequest": [
                    [
                        "CatalogueId": "\(self.VC?.selectedCatalogueID ?? 0)",
                        "DeliveryType": "1",
                        "NoOfQuantity": "1"
                    ]
                ],
                "LoyaltyID": LoyaltyID,
                "MerchantId": "1",
                "PartyLoyaltyID": PartyLoyaltyID
        ] as [String :Any]
        print(parameters)
        self.requestAPIs.productAddToCartApi(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        print(result?.returnValue ?? "", "ReturnValue")
                        if result?.returnValue == 1{
                            
//                            NotificationCenter.default.post(name: .cartCount, object: nil)
                            self.catalgoueListArray.removeAll()
                            if self.VC?.customerTypeId ?? "" == "3" && self.VC?.partyLoyaltyId != "" || self.VC?.customerTypeId ?? "" == "4" && self.VC?.partyLoyaltyId != ""{
                               self.getMycartList(PartyLoyaltyID: self.loyaltyId, LoyaltyID: self.VC!.partyLoyaltyId)
                                    
                            }else if self.VC?.customerTypeId ?? "" == "3" && self.VC?.partyLoyaltyId == "" || self.VC?.customerTypeId ?? "" == "4" && self.VC?.partyLoyaltyId == ""{
                                self.getMycartList(PartyLoyaltyID: "", LoyaltyID: self.loyaltyId)
                            }else{
                                self.getMycartList(PartyLoyaltyID: "", LoyaltyID: self.loyaltyId)
                                
                            }
                            self.VC?.startIndex = 1
                            if self.VC!.mappedUserId == -1{
                                self.productCategoryApi(userId: Int(self.userID)!)
                            }else{
                                self.productCategoryApi(userId: self.VC!.mappedUserId)
                            }
                            
                            let alert = UIAlertController(title: "", message: "AddedToCart".localiz(), preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "OK".localiz(), style: .default, handler: nil))
                            self.VC?.present(alert, animated: true, completion: nil)
                            self.VC?.productsDetailCollectionView.reloadData()
                            return
                        }else{
                            //PopUp Message
                            DispatchQueue.main.async{
                                self.VC!.view.makeToast("InsufficientPointBalance".localiz(), duration: 2.0, position: .bottom)
                            }
                        }
                        
                           
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
    
    func addedToPlanner(PartyLoyaltyID: String, userId: Int){
        self.VC?.startLoading()
        let parameters = [
            "ActionType": 0,
            "PartyLoyaltyID": PartyLoyaltyID,
              "ActorId": userId,
              "ObjCatalogueDetails": [
                  "CatalogueId": self.VC?.plannerProductId ?? 0
              ]
        ] as [String :Any]
        print(parameters)
        self.requestAPIs.productAddToPlannerApi(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        print(result?.returnValue ?? "", "Add To Planner Return Value")
                        if result?.returnValue ?? 0 >= 1{
                           DispatchQueue.main.async{
                               let alert = UIAlertController(title: "", message: "ProductisaddedintothePlanner".localiz(), preferredStyle: UIAlertController.Style.alert)
                               alert.addAction(UIAlertAction(title: "OK".localiz(), style: .default, handler: nil))
                               self.VC?.present(alert, animated: true, completion: nil)
                            }
                            self.catalgoueListArray.removeAll()
                            if self.VC?.customerTypeId ?? "" == "3" && self.VC?.partyLoyaltyId != "" || self.VC?.customerTypeId ?? "" == "4" && self.VC?.partyLoyaltyId != ""{
                                self.getMycartList(PartyLoyaltyID: self.loyaltyId, LoyaltyID: self.VC!.partyLoyaltyId)
                            }else if self.VC?.customerTypeId ?? "" == "3" && self.VC?.partyLoyaltyId == "" || self.VC?.customerTypeId ?? "" == "4" && self.VC?.partyLoyaltyId == ""{
                                self.getMycartList(PartyLoyaltyID: "", LoyaltyID: self.loyaltyId)
                            }else{
                                self.getMycartList(PartyLoyaltyID: "", LoyaltyID: self.loyaltyId)
                                
                            }
                            self.VC?.startIndex = 1
                            if self.VC!.mappedUserId != -1{
                                self.productCategoryApi(userId: self.VC!.mappedUserId)
                            }else{
                                self.productCategoryApi(userId: Int(self.userID)!)
                            }
                            
                        }else{
                            DispatchQueue.main.async{
                                let alert = UIAlertController(title: "", message: "YoucanaddthisproductsintoyourplannerList".localiz(), preferredStyle: UIAlertController.Style.alert)
                                alert.addAction(UIAlertAction(title: "OK".localiz(), style: .default, handler: nil))
                                self.VC?.present(alert, animated: true, completion: nil)
                            }
                        }
                        self.VC?.productsDetailCollectionView.reloadData()
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
class ProductCateogryModels : NSObject{
    var productCategoryId:String!
    var productCategorName:String!
    var isSelected: Int!
    init(productCategoryId: String, productCategorName: String, isSelected: Int!){
        self.productCategoryId = productCategoryId
        self.productCategorName = productCategorName
        self.isSelected = isSelected
    }
}
