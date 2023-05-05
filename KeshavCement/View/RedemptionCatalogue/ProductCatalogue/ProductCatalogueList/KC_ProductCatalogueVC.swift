//
//  KC_ProductCatalogueVC.swift
//  KeshavCement
//
//  Created by ADMIN on 05/01/2023.
//

import UIKit
import Toast_Swift
import LanguageManager_iOS
class KC_ProductCatalogueVC: BaseViewController, AddToCartDelegate, SelectedItemsDelegate, UITextFieldDelegate{
//    popUpAlertDelegate, ,
    func selectedItem(_ vc: KC_ProductCatalogueDetailsVC) {
        self.categoryId = vc.categoryId
        self.selectedPtsRange = vc.pointsRangePts
        self.selectedPtsRange1 = vc.pointsRangePts
        self.sortedBy = vc.sortedBy
        self.VM.catalgoueListArray.removeAll()
        self.startIndex = 1
        self.itsFrom = vc.itsFrom

    }
//    func popupAlertDidTap(_ vc: HR_PopUpVC) {}
    func addToPlanner(_ cell: KC_ProductsCatelogueCVC) {
        if UserDefaults.standard.string(forKey: "verificationStatus") == "1"{
        self.plannerProductId = 0
        if cell.addToPlannerBtn.isHidden == false{
            guard let tappedIndexPath = productsDetailCollectionView.indexPath(for: cell) else{return}
            if cell.addToPlannerBtn.tag == tappedIndexPath.row{
                let filterCategory1 = self.VM.plannerListArray.filter { $0.catalogueId == self.VM.catalgoueListArray[tappedIndexPath.row].catalogueId ?? 0 }
                if filterCategory1.count == 0{
                    self.plannerProductId = self.VM.catalgoueListArray[tappedIndexPath.row].catalogueId ?? 0
                    
                    if self.customerTypeId ?? "" == "3" && self.partyLoyaltyId != "" || self.customerTypeId ?? "" == "4" && self.partyLoyaltyId != ""{
                           self.VM.addedToPlanner(PartyLoyaltyID: self.partyLoyaltyId)
                    }else if self.customerTypeId ?? "" == "3" && self.partyLoyaltyId == "" || self.customerTypeId ?? "" == "4" && self.partyLoyaltyId == ""{
                        self.VM.addedToPlanner(PartyLoyaltyID: "")
                    }else{
                        self.VM.addedToPlanner(PartyLoyaltyID: "")
                    }
                }else{
                    DispatchQueue.main.async{
                        self.view.makeToast("Alreadyaddedtoplanner".localiz(), duration: 2.0, position: .bottom)
                }
                }

            }
        }
        self.productsDetailCollectionView.reloadData()
    }else{
        DispatchQueue.main.async{
            self.view.makeToast("unverifiedCatalgoue".localiz(), duration: 2.0, position: .bottom)
        }
    }

    }
    func addToCartProducts(_ cell: KC_ProductsCatelogueCVC){
        if UserDefaults.standard.string(forKey: "verificationStatus") == "1"{
        self.selectedCatalogueID = 0
        if cell.addToCartBtn.isHidden == false{
            guard let tappedIndexPath = productsDetailCollectionView.indexPath(for: cell) else{return}
            print(cell.addToCartBtn.tag)
            print(tappedIndexPath.row)
            if cell.addToCartBtn.tag == tappedIndexPath.row{
                print(self.redeemablePointsBalance , "Redeemable Point Balance")
                print(self.VM.sumOfProductsCount, "Sum of products Count")
                if self.VM.sumOfProductsCount <= Int(self.redeemablePointsBalance) ?? 0 && Int(self.VM.catalgoueListArray[tappedIndexPath.row].pointsRequired ?? 0) != 0 {
                    let calcValue = self.VM.sumOfProductsCount + Int(self.VM.catalgoueListArray[tappedIndexPath.row].pointsRequired ?? 0)
                    print(calcValue, "calcValues")
                    if calcValue <= Int(self.redeemablePointsBalance) ?? 0{
                        self.selectedCatalogueID = self.VM.catalgoueListArray[tappedIndexPath.row].catalogueId ?? 0
                        print(self.partyLoyaltyId)
                        print(self.customerTypeId)
                        
                        if self.customerTypeId ?? "" == "3" && self.partyLoyaltyId != "" || self.customerTypeId ?? "" == "4" && self.partyLoyaltyId != ""{
                            self.VM.addToCartApi(PartyLoyaltyID: self.loyaltyId, LoyaltyID: self.partyLoyaltyId)
                        }else if self.customerTypeId ?? "" == "3" && self.partyLoyaltyId == "" || self.customerTypeId ?? "" == "4" && self.partyLoyaltyId == ""{
                            self.VM.addToCartApi(PartyLoyaltyID: "", LoyaltyID: self.loyaltyId)
                        }else{
                            self.VM.addToCartApi(PartyLoyaltyID: "", LoyaltyID: self.loyaltyId)
                        }
                        
                        //NotificationCenter.default.post(name: .cartCount, object: nil)
                    }else{
                        DispatchQueue.main.async{
                            self.view.makeToast("NeedSufficientPointBalance".localiz(), duration: 2.0, position: .bottom)
                        }
                    }

                }else{
                    DispatchQueue.main.async{
                        self.view.makeToast("NeedSufficientPointBalance".localiz(), duration: 2.0, position: .bottom)
                     
                    }
                }
                self.productsDetailCollectionView.reloadData()
            }

        }
    }else{
        DispatchQueue.main.async{
            self.view.makeToast("unverifiedCatalgoue".localiz(), duration: 2.0, position: .bottom)
        }
    }
    }

    @IBOutlet weak var totalRedeemablePtsLbl: UILabel!
    @IBOutlet weak var cartCount: UILabel!
    @IBOutlet weak var noDataFound: UILabel!
    @IBOutlet weak var productCategoryCollectionView: UICollectionView!
    
    @IBOutlet weak var productsDetailCollectionView: UICollectionView!
    
    @IBOutlet weak var searchProductTF: UITextField!
    
    @IBOutlet var collectionViewTopSPace: NSLayoutConstraint!
    
    @IBOutlet weak var separatorLbl: UILabel!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var highToLowBtn: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var categoryButton: UIButton!
    
    @IBOutlet weak var pointsRangeButton: UIButton!
    
    @IBOutlet weak var searchView: UIView!
    
    @IBOutlet weak var searchViewHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var totalPoinView: UIView!
    
    
    @IBOutlet weak var headerTextLbl: UILabel!
    
    @IBOutlet weak var totalPts: UILabel!
    
    
    let VM = KC_ProductCatalogueListVM()
    var isComeFrom = ""
    var partyLoyaltyId = ""
    var selectedCategoryName = ""
    var selectedCatalogueID = 0
    var plannerProductId = 0
    var selectedId = 0
    var redeemablePointsBalance = UserDefaults.standard.string(forKey: "RedeemablePointBalance") ?? "0"
    var productsLIST:Array = [AddToCART]()
    var returnValue = 0
    var selectedCategoryID = "-1"
    var addedRedemablePointBalance = 0
    var productValues = 0
    var addedPoints = 0
    var categoryId = -1
    
    var noofelements = 0
    var startIndex = 1
    var searchTab = 1
    var categoriesId = 0
    var noOfRows = 0
    var itsComeFrom = ""
    
    var selectedPtsRange = ""
    var selectedPtsRange1 = ""
    var filterByRangeArray = ["All Points", "Under 1000 pts", "1000 - 4999 pts", "5000 - 24999 pts", "25000 & Above pts"]
    var sortedBy = 0
    var itsFrom = "Search"
    
    var productTotalPoints = 0
    var parameters : JSON?
   

    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
//        self.productCategoryCollectionView.reloadData()
        self.itsFrom = "Search"
        self.headerTextLbl.text = "ProductCatalgoue".localiz()
        self.totalPts.text = "TotalPoints".localiz()
        self.noDataFound.text = "NoDataFound".localiz()
        self.totalPoinView.clipsToBounds = true
        self.totalPoinView.cornerRadius = 20
        self.totalPoinView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        let collectionViewFLowLayout1 = UICollectionViewFlowLayout()
        collectionViewFLowLayout1.scrollDirection = .horizontal
        collectionViewFLowLayout1.minimumLineSpacing = 0
        collectionViewFLowLayout1.minimumInteritemSpacing = 0
        collectionViewFLowLayout1.estimatedItemSize = CGSize(width: 100, height: 30)
         self.productCategoryCollectionView.collectionViewLayout = collectionViewFLowLayout1
    
        let collectionViewFLowLayout2 = UICollectionViewFlowLayout()
        collectionViewFLowLayout2.itemSize = CGSize(width: CGFloat(((self.view.bounds.width - 18) - (self.productsDetailCollectionView.contentInset.left + self.productsDetailCollectionView.contentInset.right)) / 2), height: 230)
        collectionViewFLowLayout2.minimumLineSpacing = 2.5
        collectionViewFLowLayout2.minimumInteritemSpacing = 2.5
         self.productsDetailCollectionView.collectionViewLayout = collectionViewFLowLayout2
    }
 
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//        print("refresh")
//        self.productCategoryCollectionView.collectionViewLayout.invalidateLayout()
//    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                self.view.makeToast("No Internet Connection", duration: 2.0, position: .bottom)
            }
        }else{
            if self.partyLoyaltyId == ""{
                self.totalRedeemablePtsLbl.text = "\(self.redeemablePointsBalance)"
            }else{
                self.totalRedeemablePtsLbl.text = "\(self.productTotalPoints)"
            }
             self.noDataFound.isHidden = true
            self.noDataFound.textColor = #colorLiteral(red: 1, green: 0.9877298474, blue: 0.5554133654, alpha: 1)
            self.noDataFound.text = "NoDataFound".localiz()//
            self.searchProductTF.placeholder = "SearchProducts".localiz()
            self.searchProductTF.delegate = self
            self.productsDetailCollectionView.isHidden = true
            self.productCategoryCollectionView.delegate = self
            self.productCategoryCollectionView.dataSource = self
            self.productsDetailCollectionView.delegate = self
            self.productsDetailCollectionView.dataSource = self
            if self.itsFrom == "Search" || self.itsFrom == ""{
                self.startIndex = 1
                self.noofelements = 10
                self.VM.catalgoueListArray.removeAll()
                self.searchTab = 1
                self.collectionViewHeight.constant = 0
                self.tableViewTopConstraint.constant = 68
                self.searchView.isHidden = false
                self.searchViewHeight.constant = 45
                self.noDataFound.isHidden = true
                self.highToLowBtn.isHidden = true
                self.collectionViewTopSPace.constant = 55
                self.highToLowBtn.setTitle("Low To High", for: .normal)
                self.separatorLbl.isHidden = true
                self.categoryButton.backgroundColor = .white
                self.pointsRangeButton.backgroundColor = .white
                self.searchButton.backgroundColor = #colorLiteral(red: 1, green: 0.9877298474, blue: 0.5554133654, alpha: 1)
                self.categoryButton.setTitleColor(.black, for:.normal)
                self.searchButton.setTitleColor(.black, for:.normal)
                self.pointsRangeButton.setTitleColor(.black, for:.normal)
            }else if self.itsFrom == "Category"{
                self.VM.catalgoueListArray.removeAll()
                self.itsFrom = "Category"
                self.selectedPtsRange1 = ""
                self.selectedPtsRange = ""
                self.searchButton.backgroundColor = .white
                self.pointsRangeButton.backgroundColor = .white
                self.categoryButton.backgroundColor = #colorLiteral(red: 1, green: 0.9877298474, blue: 0.5554133654, alpha: 1)
                self.categoryButton.setTitleColor(.black, for:.normal)
                self.searchButton.setTitleColor(.black, for:.normal)
                self.pointsRangeButton.setTitleColor(.black, for:.normal)
                self.collectionViewTopSPace.constant = 10
                self.collectionViewHeight.constant = 50
                self.productCategoryCollectionView.isHidden = false
                self.tableViewTopConstraint.constant = 90
                self.highToLowBtn.isHidden = true
                self.searchView.isHidden = true
                self.searchViewHeight.constant = 0
                self.separatorLbl.isHidden = false
            }else if self.itsFrom == "PtsRange"{
                self.VM.catalgoueListArray.removeAll()
                self.searchButton.backgroundColor = .white
                self.categoryButton.backgroundColor = .white
                self.pointsRangeButton.backgroundColor = #colorLiteral(red: 1, green: 0.9877298474, blue: 0.5554133654, alpha: 1)
                self.pointsRangeButton.setTitleColor(.black, for:.normal)
                self.searchButton.setTitleColor(.black, for:.normal)
                self.categoryButton.setTitleColor(.black, for:.normal)
                self.collectionViewHeight.constant = 60
                self.productCategoryCollectionView.isHidden = false
                self.tableViewTopConstraint.constant = 90
                self.collectionViewTopSPace.constant = 10
                self.highToLowBtn.isHidden = false
                self.searchView.isHidden = true
                self.searchViewHeight.constant = 0
                self.separatorLbl.isHidden = false
                print(self.selectedPtsRange1)
                print(self.selectedPtsRange)
                self.itsFrom = "PtsRange"
                
          
                
                if self.selectedPtsRange == ""{
                    self.selectedPtsRange1 = "All Points"
                }else if self.selectedPtsRange == "0-999"{
                    self.selectedPtsRange1 = "Under 1000 pts"
                }else if self.selectedPtsRange1 == "1000-4999"{
                    self.selectedPtsRange1 = "1000 - 4999 pts"
                }else if self.selectedPtsRange == "5000-24999"{
                    self.selectedPtsRange1 = "5000 - 24999 pts"
                }else if self.selectedPtsRange == "25000 - 999999999"{
                    self.selectedPtsRange1 = "25000 & Above pts"
                }
                self.startIndex = 1
                self.categoriesId = 2
                self.searchTab = 0
                if self.sortedBy == 1{
                    self.sortedBy = 1
                    self.highToLowBtn.setTitle("Low To High", for: .normal)
                    
                }else{
                    self.sortedBy = 0
                    self.highToLowBtn.setTitle("High To Low", for: .normal)
                   
                }
            }
            if self.customerTypeId ?? "" == "3" && self.partyLoyaltyId != "" || self.customerTypeId ?? "" == "4" && self.partyLoyaltyId != ""{
                    self.VM.getMycartList(PartyLoyaltyID: self.loyaltyId, LoyaltyID: self.partyLoyaltyId)
            }else if self.customerTypeId ?? "" == "3" && self.partyLoyaltyId == "" || self.customerTypeId ?? "" == "4" && self.partyLoyaltyId == ""{
                self.VM.getMycartList(PartyLoyaltyID: "", LoyaltyID: self.loyaltyId)
            }else{
                self.VM.getMycartList(PartyLoyaltyID: "", LoyaltyID: self.loyaltyId)
             }
            self.VM.productCategoryApi()
            self.productsDetailCollectionView.reloadData()
          //  NotificationCenter.default.post(name: .cartCount, object: nil)
            
            
        }
    }

    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func searchProductEditingChanged(_ sender: Any) {
        self.VM.catalgoueListArray.removeAll()
        self.startIndex = 1
        self.itsFrom = "Search"
        self.VM.catalogueListApi(searchText: self.searchProductTF.text ?? "", startIndex: self.startIndex)
    }
    
    
    @IBAction func highToLowButton(_ sender: Any) {
        
        if self.sortedBy == 1{
            self.sortedBy = 0
            self.highToLowBtn.setTitle("High To Low", for: .normal)
        }else{
            self.sortedBy = 1
            self.highToLowBtn.setTitle("Low To High", for: .normal)
        }
        self.VM.catalgoueListArray.removeAll()
        self.startIndex = 1
        self.itsFrom = "PtsRange"
        self.VM.catalogueListApi(searchText: self.searchProductTF.text ?? "", startIndex: self.startIndex)
    }
    @IBAction func searchBtn(_ sender: Any) {
        self.VM.catalgoueListArray.removeAll()
        self.categoryButton.backgroundColor = .white
        self.pointsRangeButton.backgroundColor = .white
        self.searchButton.backgroundColor = #colorLiteral(red: 1, green: 0.9877298474, blue: 0.5554133654, alpha: 1)
        self.categoryButton.setTitleColor(.black, for:.normal)
        self.searchButton.setTitleColor(.black, for:.normal)
        self.pointsRangeButton.setTitleColor(.black, for:.normal)
                self.productCategoryCollectionView.isHidden = true
        self.startIndex = 1
        self.noofelements = 10
        self.VM.catalgoueListArray.removeAll()
        self.searchTab = 1
        self.categoriesId = 0
        self.collectionViewHeight.constant = 0
        self.tableViewTopConstraint.constant = 68
        self.searchView.isHidden = false
        self.searchViewHeight.constant = 45
        self.noDataFound.isHidden = true
        self.highToLowBtn.isHidden = true
        self.collectionViewTopSPace.constant = 55
        self.itsFrom = "Search"
        self.highToLowBtn.setTitle("Low To High", for: .normal)
        self.separatorLbl.isHidden = true
        self.VM.catalogueListApi(searchText: self.searchProductTF.text ?? "", startIndex: self.startIndex)
    }
    @IBAction func categoryBtn(_ sender: Any) {
        self.VM.catalgoueListArray.removeAll()
        self.highToLowBtn.setTitle("High To Low", for: .normal)
        self.itsFrom = "Category"
        self.selectedPtsRange1 = ""
        self.selectedPtsRange = ""
        self.searchButton.backgroundColor = .white
        self.pointsRangeButton.backgroundColor = .white
        self.categoryButton.backgroundColor = #colorLiteral(red: 1, green: 0.9877298474, blue: 0.5554133654, alpha: 1)
        self.categoryButton.setTitleColor(.black, for:.normal)
        self.searchButton.setTitleColor(.black, for:.normal)
        self.pointsRangeButton.setTitleColor(.black, for:.normal)
        self.collectionViewTopSPace.constant = 10
        self.collectionViewHeight.constant = 50
        self.productCategoryCollectionView.isHidden = false
        self.tableViewTopConstraint.constant = 90
        self.highToLowBtn.isHidden = true
        self.searchView.isHidden = true
        self.searchViewHeight.constant = 0
        self.separatorLbl.isHidden = false
        self.categoriesId = 1
        self.startIndex = 1
        self.searchTab = 0
        self.sortedBy = 0
        if self.customerTypeId ?? "" == "3" && self.partyLoyaltyId != "" || self.customerTypeId ?? "" == "4" && self.partyLoyaltyId != ""{
            
                self.VM.getMycartList(PartyLoyaltyID: self.loyaltyId, LoyaltyID: self.partyLoyaltyId)
            
        }else if self.customerTypeId ?? "" == "3" && self.partyLoyaltyId == "" || self.customerTypeId ?? "" == "4" && self.partyLoyaltyId == ""{
            self.VM.getMycartList(PartyLoyaltyID: "", LoyaltyID: self.loyaltyId)
        }else{
            self.VM.getMycartList(PartyLoyaltyID: "", LoyaltyID: self.loyaltyId)
         }
        self.VM.productCategoryApi()
       // self.VM.catalogueListApi(searchText: self.searchProductTF.text ?? "", startIndex: self.startIndex)
    }
    
    @IBAction func pointRangeBtn(_ sender: Any) {
      //  self.VM.productCategoryListArray.removeAll()
        self.VM.catalgoueListArray.removeAll()
        self.searchButton.backgroundColor = .white
        self.categoryButton.backgroundColor = .white
        self.pointsRangeButton.backgroundColor = #colorLiteral(red: 1, green: 0.9877298474, blue: 0.5554133654, alpha: 1)
        self.pointsRangeButton.setTitleColor(.black, for:.normal)
        self.searchButton.setTitleColor(.black, for:.normal)
        self.categoryButton.setTitleColor(.black, for:.normal)
        self.collectionViewHeight.constant = 60
        self.productCategoryCollectionView.isHidden = false
        self.tableViewTopConstraint.constant = 90
        self.collectionViewTopSPace.constant = 10
        self.highToLowBtn.isHidden = false
        self.searchView.isHidden = true
        self.searchViewHeight.constant = 0
        self.separatorLbl.isHidden = false
        self.itsFrom = "PtsRange"
        self.selectedPtsRange1 = "All Points"
        self.selectedPtsRange = ""
        self.startIndex = 1
        self.categoriesId = 2
        self.searchTab = 0
        if self.customerTypeId ?? "" == "3" && self.partyLoyaltyId != "" || self.customerTypeId ?? "" == "4" && self.partyLoyaltyId != ""{
                self.VM.getMycartList(PartyLoyaltyID: self.loyaltyId, LoyaltyID: self.partyLoyaltyId)
        }else if self.customerTypeId ?? "" == "3" && self.partyLoyaltyId == "" || self.customerTypeId ?? "" == "4" && self.partyLoyaltyId == ""{
            self.VM.getMycartList(PartyLoyaltyID: "", LoyaltyID: self.loyaltyId)
        }else{
            self.VM.getMycartList(PartyLoyaltyID: "", LoyaltyID: self.loyaltyId)
         }
        self.VM.productCategoryApi()
       // self.VM.catalogueListApi(searchText: self.searchProductTF.text ?? "", startIndex: self.startIndex)
        
    }
    
    
    @IBAction func navigateToMyCartButton(_ sender: Any) {
        
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_MyCartVC") as! KC_MyCartVC
        vc.partyLoyaltyId = self.partyLoyaltyId
        vc.productTotalPoints = self.productTotalPoints
        print(self.productTotalPoints)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
extension KC_ProductCatalogueVC: UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == productCategoryCollectionView{
            if self.itsFrom == "Category"{
                return self.VM.productCategoryListArray.count
            }else if self.itsFrom == "PtsRange"{
                return self.filterByRangeArray.count
            }else{
                return 1
            }
        }else if collectionView == productsDetailCollectionView{
            return self.VM.catalgoueListArray.count
        }else{
            return 1
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == productCategoryCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KC_ProductsCategoryCVC", for: indexPath) as! KC_ProductsCategoryCVC
            cell.categoryLbl.text = "\(self.VM.productCategoryListArray[indexPath.row].productCategorName ?? "")      ".capitalized
            if self.categoriesId == 1{
                if self.categoryId == Int(self.VM.productCategoryListArray[indexPath.item].productCategoryId!) ?? -1{
                     cell.categoryLbl.textColor = UIColor.black
                     cell.categoryLbl.backgroundColor = #colorLiteral(red: 1, green: 0.9877298474, blue: 0.5554133654, alpha: 1)
                }else{
                        cell.categoryLbl.textColor = UIColor.black
                        cell.categoryLbl.backgroundColor = .white
                  
                    }
            }else if self.categoriesId == 2{
                if self.filterByRangeArray.count != 0 {
                    cell.categoryLbl.textAlignment = .center
                    cell.categoryLbl.text = "  \(self.filterByRangeArray[indexPath.row])    "
            
                    if self.selectedPtsRange1 == "\(self.filterByRangeArray[indexPath.row])"{
                        cell.categoryLbl.textColor = UIColor.black
                        cell.categoryLbl.backgroundColor = #colorLiteral(red: 1, green: 0.9877298474, blue: 0.5554133654, alpha: 1)
                    }else{
                        cell.categoryLbl.textColor = UIColor.black
                        cell.categoryLbl.backgroundColor = .white
                    }
                }
                
            }
      
              
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KC_ProductsCatelogueCVC", for: indexPath) as! KC_ProductsCatelogueCVC

            cell.delegate = self
            cell.addToCartBtn.tag = indexPath.item
            cell.addToPlannerBtn.tag = indexPath.item
            if self.VM.catalgoueListArray.count != 0 {
//            cell.categoryNameLbl.text = "Category/\(self.VM.catalgoueListArray[indexPath.row].catogoryName ?? "")"
            cell.setCollectionData(redemptionDetailObj: self.VM.catalgoueListArray[indexPath.item], redeemedPointBalance: Int(self.redeemablePointsBalance) ?? 0, cartItems: productsLIST)
            let filterCategory = self.VM.myCartListArray.filter { $0.catalogueId == self.VM.catalgoueListArray[indexPath.item].catalogueId ?? 0 }
            let filterCategory1 = self.VM.plannerListArray.filter { $0.catalogueId == self.VM.catalgoueListArray[indexPath.item].catalogueId ?? 0 }
            let productPoints = self.VM.catalgoueListArray[indexPath.item].pointsRequired ?? 0
            print(self.redeemablePointsBalance, "RedeemablePointBalance")
                if self.VM.catalgoueListArray[indexPath.row].is_Redeemable ?? -3 == 1{
                    
                    if self.partyLoyaltyId == ""{
                        if productPoints < Int(self.redeemablePointsBalance) ?? 0{
                            cell.addedToCartBtn.isHidden = true
                            cell.addToPlannerBtn.isHidden = true
                            cell.addToCartBtn.isHidden = false
                            cell.addedToPlannerBtn.isHidden = true
                            if filterCategory.count > 0 {
                                cell.addedToCartBtn.isHidden = false
                                cell.addedToCartBtn.backgroundColor = .lightGray
                                //  cell.addedToCartBtn.backgroundColor = #colorLiteral(red: 1, green: 0.9877298474, blue: 0.5554133654, alpha: 1)
                                //cell.addedToCartBtn.setTitleColor(.darkGray, for: .normal)
                                cell.addToPlannerBtn.isHidden = true
                                cell.addToCartBtn.isHidden = true
                                cell.addedToPlannerBtn.isHidden = true
                            }
                        }else{
                            if self.VM.catalgoueListArray[indexPath.row].isPlanner! == true{
                                cell.addedToCartBtn.isHidden = true
                                cell.addToPlannerBtn.isHidden = false
                                
                                cell.addToCartBtn.isHidden = true
                                cell.addedToPlannerBtn.isHidden = true
                            }else{
                                cell.addedToCartBtn.isHidden = true
                                cell.addToPlannerBtn.isHidden = true
                                cell.addToCartBtn.isHidden = true
                                cell.addedToPlannerBtn.isHidden = true
                            }
                            if filterCategory1.count > 0 {
                                cell.addedToCartBtn.isHidden = true
                                cell.addToPlannerBtn.isHidden = false
                                cell.addToCartBtn.isHidden = true
                                cell.addedToPlannerBtn.isHidden = true
                            }
                        }
                    }else{
                        if productPoints < Int(self.productTotalPoints) ?? 0{
                            cell.addedToCartBtn.isHidden = true
                            cell.addToPlannerBtn.isHidden = true
                            cell.addToCartBtn.isHidden = false
                            cell.addedToPlannerBtn.isHidden = true
                            if filterCategory.count > 0 {
                                cell.addedToCartBtn.isHidden = false
                                cell.addedToCartBtn.backgroundColor = .lightGray
                                //  cell.addedToCartBtn.backgroundColor = #colorLiteral(red: 1, green: 0.9877298474, blue: 0.5554133654, alpha: 1)
                                //cell.addedToCartBtn.setTitleColor(.darkGray, for: .normal)
                                cell.addToPlannerBtn.isHidden = true
                                cell.addToCartBtn.isHidden = true
                                cell.addedToPlannerBtn.isHidden = true
                            }
                        }else{
                            if self.VM.catalgoueListArray[indexPath.row].isPlanner! == true{
                                cell.addedToCartBtn.isHidden = true
                                cell.addToPlannerBtn.isHidden = false
                                
                                cell.addToCartBtn.isHidden = true
                                cell.addedToPlannerBtn.isHidden = true
                            }else{
                                cell.addedToCartBtn.isHidden = true
                                cell.addToPlannerBtn.isHidden = true
                                cell.addToCartBtn.isHidden = true
                                cell.addedToPlannerBtn.isHidden = true
                            }
                            if filterCategory1.count > 0 {
                                cell.addedToCartBtn.isHidden = true
                                cell.addToPlannerBtn.isHidden = false
                                cell.addToCartBtn.isHidden = true
                                cell.addedToPlannerBtn.isHidden = true
                            }
                        }
                    }
                }else{
                    cell.addedToCartBtn.isHidden = true
                    cell.addToPlannerBtn.isHidden = true
                    cell.addToCartBtn.isHidden = true
                    cell.addedToPlannerBtn.isHidden = true
                }
        }
           
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == productCategoryCollectionView{
            
                if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
                    DispatchQueue.main.async{
                        self.view.makeToast("No Internet Connection", duration: 2.0, position: .bottom)
                    }
                }else{
                    if self.itsFrom != "PtsRange"{
                        self.categoryId = Int(self.VM.productCategoryListArray[indexPath.item].productCategoryId!) ?? -1
                        self.VM.productCategoryListArray[indexPath.item].isSelected = 1
                        self.VM.catalgoueListArray.removeAll()
                        self.itsFrom = "Category"
                        self.startIndex = 1
                        self.selectedPtsRange1 = ""
                        self.selectedPtsRange = ""
                        if self.customerTypeId ?? "" == "3" && self.partyLoyaltyId != "" || self.customerTypeId ?? "" == "4" && self.partyLoyaltyId != ""{
                                self.VM.getMycartList(PartyLoyaltyID: self.loyaltyId, LoyaltyID: self.partyLoyaltyId)
                        }else if self.customerTypeId ?? "" == "3" && self.partyLoyaltyId == "" || self.customerTypeId ?? "" == "4" && self.partyLoyaltyId == ""{
                            self.VM.getMycartList(PartyLoyaltyID: "", LoyaltyID: self.loyaltyId)
                        }else{
                            self.VM.getMycartList(PartyLoyaltyID: "", LoyaltyID: self.loyaltyId)
                         }
                        self.VM.productCategoryApi()
                    }else{
                        //self.categoryId = -1
                        self.categoriesId = 2
                        self.selectedPtsRange1 = "All Points"
                        self.selectedPtsRange1 = "\(self.filterByRangeArray[indexPath.row])"
                        print(self.selectedPtsRange1)
                        if self.selectedPtsRange1 == "All Points"{
                            self.selectedPtsRange = ""
                        }else if self.selectedPtsRange1 == "Under 1000 pts"{
                            self.selectedPtsRange = "0-999"
                        }else if self.selectedPtsRange1 == "1000 - 4999 pts"{
                            self.selectedPtsRange = "1000-4999"
                        }else if self.selectedPtsRange1 == "5000 - 24999 pts"{
                            self.selectedPtsRange = "5000-24999"
                        }else if self.selectedPtsRange1 == "25000 & Above pts"{
                            self.selectedPtsRange = "25000 - 999999999"
                        }
                        self.VM.catalgoueListArray.removeAll()
                        self.startIndex = 1
                        self.itsFrom = "PtsRange"
                        self.productCategoryCollectionView.reloadData()
                        self.VM.productCategoryApi()
                        self.VM.catalogueListApi(searchText: self.searchProductTF.text ?? "", startIndex: self.startIndex)
                        
                    }
                   
                    
                    
                }
          
        }else if collectionView == productsDetailCollectionView{
         
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_ProductCatalogueDetailsVC") as! KC_ProductCatalogueDetailsVC
            vc.delegate = self
            vc.productName = self.VM.catalgoueListArray[indexPath.row].productName ?? ""
            vc.productPts = self.VM.catalgoueListArray[indexPath.row].pointsRequired ?? 0
            vc.catalogueId = self.VM.catalgoueListArray[indexPath.row].catalogueId ?? 0
            print("\(self.VM.catalgoueListArray[indexPath.row].productImage ?? "") - Product Image")
            vc.productImage = self.VM.catalgoueListArray[indexPath.row].productImage ?? ""
            vc.productDescription = self.VM.catalgoueListArray[indexPath.row].productDesc ?? ""
            vc.termsandContions = self.VM.catalgoueListArray[indexPath.row].termsCondition ?? ""
            print("\(self.VM.catalgoueListArray[indexPath.row].isPlanner!) Planner is ")
            vc.isPlanner = self.VM.catalgoueListArray[indexPath.row].isPlanner ?? false
            vc.productCategory = self.VM.catalgoueListArray[indexPath.row].catogoryName ?? ""
            vc.is_Reedemable = self.VM.catalgoueListArray[indexPath.row].is_Redeemable ?? 0
            vc.plannerProductId = self.VM.catalgoueListArray[indexPath.row].redemptionPlannerId ?? 0
            vc.categoryId = self.categoryId
            vc.pointsRangePts = self.selectedPtsRange
            vc.sortedBy = self.sortedBy
            vc.itsFrom = self.itsFrom
            vc.partyLoyaltyId = self.partyLoyaltyId
            vc.productTotalPoints = self.productTotalPoints
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == productsDetailCollectionView{
            if indexPath.row == self.VM.catalgoueListArray.count - 1{
                if self.noofelements == 10{
                    self.startIndex = self.startIndex + 1
                    self.VM.catalogueListApi(searchText: self.searchProductTF.text ?? "", startIndex: self.startIndex)
                }else if self.noofelements > 10{
                    self.startIndex = self.startIndex + 1
                    self.VM.catalogueListApi(searchText: self.searchProductTF.text ?? "", startIndex: self.startIndex)
                }else if self.noofelements < 10{
                    print("no need to hit API")
                    return
                }else{
                    print("n0 more elements")
                    return
                }
            }
        }

    }

    
}
