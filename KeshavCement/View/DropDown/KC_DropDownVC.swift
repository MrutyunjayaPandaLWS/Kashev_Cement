//
//  KC_DropDownVC.swift
//  KeshavCement
//
//  Created by ADMIN on 14/02/2023.
//

import UIKit


protocol SelectedDataDelegate: AnyObject{
    
    func didTapCustomerType(_ vc: KC_DropDownVC)
    func didTapState(_ vc: KC_DropDownVC)
    func didTapDistrict(_ vc: KC_DropDownVC)
    func didTapTaluk(_ vc: KC_DropDownVC)
    func didTapUserType(_ vc: KC_DropDownVC)
    func didTapMappedUserName(_ vc: KC_DropDownVC)
    func didTapProductName(_ vc: KC_DropDownVC)
    func didTapWorkLevel(_ vc: KC_DropDownVC)
    func didTapHelpTopic(_ vc: KC_DropDownVC)
    func didTapCityName(_ vc: KC_DropDownVC)
    func didTapAmount(_ vc: KC_DropDownVC)
}


class KC_DropDownVC: BaseViewController,UISearchBarDelegate {

    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var dropDownTableView: UITableView!
    
    @IBOutlet weak var noDataFoundLbl: UILabel!
    var itsFrom = ""
    var isComeFrom = ""
    var selectedCustomerType = ""
    var selectedCustomerTypeId = -1
    var selectedStateName = ""
    var selectedStateId = -1
    var selectedDistrictName = ""
    var selectedDistrictId = -1
    var selectedTalukName = ""
    var selectedTalukId = -1
    
    var helpTopicId = -1
    var helpTopicName = ""
 
    var VM = KC_DropDownVM()
    var delegate: SelectedDataDelegate?
    
//    Dealer & Support Executive Created By Dealer: Sub dealer, Engineer & Mason will be displayed in Claim page, customer type dropdown.
//    Sub Dealer & Support Executive By Sub Dealer: Engineer & Mason will be displayed in Claim page, customer type dropdown.
    
    var engineerandMasonArray = ["Dealer", "Sub Dealer"]
    var subdealerArray = ["Dealer"]
    var dealerEnrollmentArray = ["Engineer", "Mason", "Sub Dealer"]
    var subDealerEnrollmentArray = ["Engineer", "Mason"]
//    var customerType = ""
    var selectedUserTypeName = ""
    var selectedUserTypeId = -1
    
    var mappedUsername = ""
    var mappedUserId = -1
    var mappedMobileNumber = ""
    var mappedLoyaltyId = ""

    
    var selectedCustomerTypeIds = -1
    
    
    
    var selectedProductId = -1
    var selectedProductName = ""
    var selectedProductCode = ""
    
    var selectedWorkLevelTitle = ""
    var selectedWorkLevelId = -1
    
    var selectedCityId = -1
    var selectedCityName = ""
    
    var selectedAmount = 0
    var selectedCashBack = 0
    
//    Engineer - 1
//    Mason - 2
//    Dealer - 3
//    Sub Dealer - 4
//    Support Executive - 5
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.searchBar.isHidden = true
        self.searchBar.delegate = self
        self.noDataFoundLbl.isHidden = true
        self.dropDownTableView.delegate = self
        self.dropDownTableView.dataSource = self
        self.noDataFoundLbl.isHidden = true
        if self.itsFrom == "CUSTOMERTYPE"{
            self.customerTypeApi()
        }else if self.itsFrom == "STATE"{
            self.stateListApi()
        }else if self.itsFrom == "DISTRICT"{
            self.districtListApi()
        }else if self.itsFrom == "TALUK"{
            self.talukListApi()
        }else if self.itsFrom == "MAPPEDUSERS"{
            self.mappedUserNameList(UserTypeId: self.selectedUserTypeId)
            self.searchBar.isHidden = false
        }else if self.itsFrom == "CLAIMPRODUCTLIST"{
            self.claimProductList()
        }else if self.itsFrom == "WORKLEVEL"{
            self.workLevelApi()
        }else if self.itsFrom == "NEWQUERY"{
            self.queryTopicListApi()
        }else if self.itsFrom == "CITY"{
            cityListingAPI(stateID: self.selectedStateId)
        }else if self.itsFrom == "CASHPOINTS"{
            self.cashDetailsApi(customerTypeId: self.selectedCustomerTypeIds)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let touch = touches.first
        if touch?.view != self.dropDownTableView {
            self.dismiss(animated: true, completion: nil)
            self.searchBar.resignFirstResponder()
        } else {
            self.searchBar.resignFirstResponder()
        }
    }
    override func viewWillLayoutSubviews() {
        
    }
    
    func cashDetailsApi(customerTypeId: Int){
        
    let parameter = [
        "ActionType": 1,
        "ActorId": userID,
        "CustomerTypeId": customerTypeId
    ] as [String: Any]
    print(parameter)
        self.VM.cashDetailsListApi(parameter: parameter)
    }
    
    
    func customerTypeApi(){
        let parameter = [
            "ActionType":"33"
        ] as [String: Any]
        print(parameter)
        self.VM.customerTypeListApi(parameter: parameter)
    }
    func stateListApi(){
        let parameter = [
            "ActionType":"2",
            "CountryID":15,
            "IsActive":"true",
            "SortColumn":"STATE_NAME",
            "SortOrder":"ASC",
            "StartIndex":"1"
        ] as [String: Any]
        print(parameter)
        self.VM.stateListApi(parameter: parameter)
    }
    func districtListApi(){
        let parameter = [
            "StateID": self.selectedStateId
        ] as [String: Any]
        print(parameter)
        self.VM.districtListApi(parameter: parameter)
    }
    func talukListApi(){
        let parameter = [
            "ActionType":"1",
            "DistrictId":"\(self.selectedDistrictId)"
        ] as [String: Any]
        print(parameter)
        self.VM.talukListApi(parameter: parameter)
    }
    func mappedUserNameList(UserTypeId: Int){
        let parameter = [
            "ActionType":16,
            "ActorId":self.userID,
            "SearchText":UserTypeId
        ] as [String: Any]
        print(parameter)
        self.VM.mappedUserTypeListApi(parameter: parameter)
        
    }
    func claimProductList(){
        let parameter = [
            "ActionType":"105"
        ] as [String: Any]
        print(parameter)
        self.VM.claimProductListApi(parameter: parameter)
    }
    func workLevelApi(){
        let parameter = [
            "ActionType":"164"
        ] as [String: Any]
        print(parameter)
        self.VM.workLevelListApi(parameter: parameter)
    }
    func queryTopicListApi(){
        
        let parameter = [
            "ActorId": "\(self.userID)",
            "IsActive": "true",
            "ActionType": "4"
        ] as [String: Any]
        self.VM.queryTopicListAPI(parameter: parameter)
    }
    
    func cityListingAPI(stateID: Int){
        let parameterJSON = [
                "ActionType": "2",
                "IsActive": "true",
                "SortColumn": "CITY_NAME",
                "SortOrder": "ASC",
                "StartIndex": "1",
                "StateId": stateID
            ] as  [String:Any]
            self.VM.citylisting(parameters: parameterJSON)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
            if self.VM.mappedListArray.count > 0 {
                let arr = self.VM.mappedListArray.filter{ ($0.firstName!.localizedCaseInsensitiveContains(searchBar.text!))}
                if self.searchBar.text != ""{
                    
                    if arr.count > 0 {
                        self.VM.mappedListArray.removeAll(keepingCapacity: true)
                        self.VM.mappedListArray = arr
                        self.dropDownTableView.reloadData()
                        dropDownTableView.isHidden = false
                    }else {
                        self.VM.mappedListArray = self.VM.mappedListFilterArray
                        self.dropDownTableView.reloadData()
                        dropDownTableView.isHidden = true
                    }
                }else{
                    self.VM.mappedListArray = self.VM.mappedListFilterArray
                    self.dropDownTableView.reloadData()
                    dropDownTableView.isHidden = false
                }
                let searchText = searchBar.text!
                if searchText.count > 0 || self.VM.mappedListFilterArray.count == self.VM.mappedListArray.count {
                    self.dropDownTableView.reloadData()
                }
            }
        }

}
extension KC_DropDownVC: UITableViewDelegate, UITableViewDataSource{
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.itsFrom == "CUSTOMERTYPE"{
            return self.VM.customerTypeArray.count
        }else if self.itsFrom == "STATE"{
            return self.VM.stateListArray.count
        }else if self.itsFrom == "DISTRICT"{
            return self.VM.districtListArray.count
        }else if self.itsFrom == "TALUK"{
            return self.VM.talukListArray.count
        }else if self.itsFrom == "CUSTOMERTYPE3"{
            return self.dealerEnrollmentArray.count
        }else if self.itsFrom == "CUSTOMERTYPE4"{
            return self.subDealerEnrollmentArray.count
        }else if self.itsFrom == "MAPPEDUSERS"{
            return self.VM.mappedListArray.count
        }else if self.itsFrom == "CLAIMPRODUCTLIST"{
            return self.VM.claimProductListArray.count
        }else if self.itsFrom == "WORKLEVEL"{
            return self.VM.workLevelListArray.count
        }else if self.itsFrom == "NEWQUERY"{
            return self.VM.queryTopicListArray.count
        }else if self.itsFrom == "CITY"{
            return self.VM.cityArray.count
        }else if self.itsFrom == "CASHPOINTS"{
            return self.VM.cashDetailsListArray.count
        }else if self.itsFrom == "USERTYPE"{
            if self.customerType == "Engineer" || self.customerType == "Mason"{
                return self.engineerandMasonArray.count
            }else if self.customerType == "Sub Dealer"{
                return self.subdealerArray.count
            }else{
                return 1
            }
        }else{
            return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "KC_DropDownTVC", for: indexPath) as! KC_DropDownTVC
        if self.itsFrom == "CUSTOMERTYPE"{
            cell.selectedTitleLbl.text = self.VM.customerTypeArray[indexPath.row].attributeValue ?? ""
        }else if self.itsFrom == "STATE"{
            cell.selectedTitleLbl.text = self.VM.stateListArray[indexPath.row].stateName ?? ""
        }else if self.itsFrom == "CITY"{
            cell.selectedTitleLbl.text = self.VM.cityArray[indexPath.row].cityName ?? ""
        }else if self.itsFrom == "DISTRICT"{
            cell.selectedTitleLbl.text = self.VM.districtListArray[indexPath.row].districtName ?? ""
        }else if self.itsFrom == "TALUK"{
            cell.selectedTitleLbl.text = self.VM.talukListArray[indexPath.row].talukName ?? ""
        }else if self.itsFrom == "USERTYPE"{
            if self.customerType == "Engineer" || self.customerType == "Mason"{
                if self.engineerandMasonArray.count <= 20{
                    self.tableViewHeightConstraint.constant = CGFloat(self.engineerandMasonArray.count * 40)
                }else{
                    self.tableViewHeightConstraint.constant = CGFloat(500)
                }
                cell.selectedTitleLbl.text = self.engineerandMasonArray[indexPath.row]
            }else if self.customerType == "Sub Dealer"{
                cell.selectedTitleLbl.text = self.subdealerArray[indexPath.row]
                if self.subdealerArray.count <= 20{
                    self.tableViewHeightConstraint.constant = CGFloat(self.subdealerArray.count * 40)
                }else{
                    self.tableViewHeightConstraint.constant = CGFloat(500)
                }
            }
        }else if self.itsFrom == "CUSTOMERTYPE3"{
            cell.selectedTitleLbl.text = self.dealerEnrollmentArray[indexPath.row]
            if self.dealerEnrollmentArray.count <= 20{
                self.tableViewHeightConstraint.constant = CGFloat(self.dealerEnrollmentArray.count * 40)
            }else{
                self.tableViewHeightConstraint.constant = CGFloat(500)
            }
        }else if self.itsFrom == "CUSTOMERTYPE4"{
            cell.selectedTitleLbl.text = self.subDealerEnrollmentArray[indexPath.row]
            if self.subDealerEnrollmentArray.count <= 20{
                self.tableViewHeightConstraint.constant = CGFloat(self.subDealerEnrollmentArray.count * 40)
            }else{
                self.tableViewHeightConstraint.constant = CGFloat(500)
            }
        }else if self.itsFrom == "MAPPEDUSERS"{
            if isComeFrom == "CASHTRANSFERSUBMISSION"{
                let firstName = "\(self.VM.mappedListArray[indexPath.row].firstName ?? "")"
                cell.selectedTitleLbl.text = "\(firstName) (\(self.VM.mappedListArray[indexPath.row].loyaltyID ?? ""))"
            }else{
                let firstName = "\(self.VM.mappedListArray[indexPath.row].firstName ?? "")"
                cell.selectedTitleLbl.text = "\(firstName) (\(self.VM.mappedListArray[indexPath.row].mobile ?? ""))"
            }
            
        }else if self.itsFrom == "CLAIMPRODUCTLIST"{
            cell.selectedTitleLbl.text = self.VM.claimProductListArray[indexPath.row].attributeValue ?? ""
        }else if self.itsFrom == "WORKLEVEL"{
            cell.selectedTitleLbl.text = self.VM.workLevelListArray[indexPath.row].attributeValue ?? ""
        }else if self.itsFrom == "NEWQUERY"{
            cell.selectedTitleLbl.text = self.VM.queryTopicListArray[indexPath.row].helpTopicName ?? ""
        }else if self.itsFrom == "CASHPOINTS"{
            cell.selectedTitleLbl.text = "\(self.VM.cashDetailsListArray[indexPath.row].amount ?? -1)"
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(self.itsFrom)
        if self.itsFrom == "CUSTOMERTYPE"{
            self.selectedCustomerType = self.VM.customerTypeArray[indexPath.row].attributeValue ?? ""
            self.selectedCustomerTypeId = self.VM.customerTypeArray[indexPath.row].attributeId ?? -1
            self.delegate?.didTapCustomerType(self)
            self.dismiss(animated: true)
        }else if self.itsFrom == "STATE"{
            self.selectedStateName = self.VM.stateListArray[indexPath.row].stateName ?? ""
            self.selectedStateId = self.VM.stateListArray[indexPath.row].stateId ?? -1
            self.delegate?.didTapState(self)
            self.dismiss(animated: true)
        }else if self.itsFrom == "DISTRICT"{
            self.selectedDistrictName = self.VM.districtListArray[indexPath.row].districtName ?? ""
            self.selectedDistrictId = self.VM.districtListArray[indexPath.row].districtId ?? -1
            self.delegate?.didTapDistrict(self)
            self.dismiss(animated: true)
        }else if self.itsFrom == "TALUK"{
            self.selectedTalukName = self.VM.talukListArray[indexPath.row].talukName ?? ""
            self.selectedTalukId = self.VM.talukListArray[indexPath.row].talukId ?? -1
            self.delegate?.didTapTaluk(self)
            self.dismiss(animated: true)
        }else if self.itsFrom == "USERTYPE"{
            if self.customerType == "Engineer" || self.customerType == "Mason"{
                 self.selectedUserTypeName = self.engineerandMasonArray[indexPath.row]
                if self.selectedUserTypeName == "Dealer"{
                    self.selectedUserTypeId = 3
                }else if self.selectedUserTypeName == "Sub Dealer"{
                    self.selectedUserTypeId = 4
                }
            }else if self.customerType == "Sub Dealer"{
                self.selectedUserTypeName = self.subdealerArray[indexPath.row]
                self.selectedUserTypeId = 4
            }
            self.delegate?.didTapUserType(self)
            self.dismiss(animated: true)
        }else if self.itsFrom == "CUSTOMERTYPE3"{
            self.selectedCustomerType = self.dealerEnrollmentArray[indexPath.row]
            if self.selectedCustomerType == "Engineer"{
                self.selectedUserTypeId = 1
            }else if self.selectedCustomerType == "Mason"{
                self.selectedUserTypeId = 2
            }else if self.selectedCustomerType == "Sub Dealer"{
                self.selectedUserTypeId = 4
            }
            self.delegate?.didTapCustomerType(self)
            self.dismiss(animated: true)
            
        }else if self.itsFrom == "CUSTOMERTYPE4"{
            self.selectedCustomerType = self.subDealerEnrollmentArray[indexPath.row]
            if self.selectedCustomerType == "Engineer"{
                self.selectedUserTypeId = 1
            }else if self.selectedCustomerType == "Mason"{
                self.selectedUserTypeId = 2
            }
            self.delegate?.didTapCustomerType(self)
            self.dismiss(animated: true)
            
            
        }else if self.itsFrom == "MAPPEDUSERS"{
            self.mappedUsername = self.VM.mappedListArray[indexPath.row].firstName ?? ""
            self.mappedUserId = self.VM.mappedListArray[indexPath.row].userID ?? -1
            self.mappedMobileNumber = self.VM.mappedListArray[indexPath.row].mobile ?? ""
            self.mappedLoyaltyId = self.VM.mappedListArray[indexPath.row].loyaltyID ?? ""
            self.delegate?.didTapMappedUserName(self)
            self.dismiss(animated: true)
        }else if self.itsFrom == "CLAIMPRODUCTLIST"{
            self.selectedProductId = self.VM.claimProductListArray[indexPath.row].attributeId ?? -1
            self.selectedProductName = self.VM.claimProductListArray[indexPath.row].attributeValue ?? ""
            self.selectedProductCode = self.VM.claimProductListArray[indexPath.row].attributeContents ?? ""
            self.delegate?.didTapProductName(self)
            self.dismiss(animated: true)
        }else if self.itsFrom == "WORKLEVEL"{
            self.selectedWorkLevelId = self.VM.workLevelListArray[indexPath.row].attributeId ?? -1
            self.selectedWorkLevelTitle = self.VM.workLevelListArray[indexPath.row].attributeValue ?? ""
            self.delegate?.didTapWorkLevel(self)
            self.dismiss(animated: true)
        }else if self.itsFrom == "NEWQUERY"{
            self.helpTopicId = self.VM.queryTopicListArray[indexPath.row].helpTopicId ?? -1
            self.helpTopicName = self.VM.queryTopicListArray[indexPath.row].helpTopicName ?? ""
            self.delegate?.didTapHelpTopic(self)
            self.dismiss(animated: true)
        }else if self.itsFrom == "CITY"{
            self.selectedCityId = self.VM.cityArray[indexPath.row].cityId ?? 0
            self.selectedCityName = self.VM.cityArray[indexPath.row].cityName ?? ""
            self.delegate?.didTapCityName(self)
            self.dismiss(animated: true)
        }else if self.itsFrom == "CASHPOINTS"{
            self.selectedAmount = self.VM.cashDetailsListArray[indexPath.row].amount ?? 0
            self.selectedCashBack = self.VM.cashDetailsListArray[indexPath.row].cashBackValue ?? 0
            self.delegate?.didTapAmount(self)
            self.dismiss(animated: true)
        }
        
    }
    
    
}
