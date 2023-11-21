//
//  HRD_MyRedemptionDetailsVC.swift
//  H&RJohnson Dealer
//
//  Created by ADMIN on 08/09/2022.
//

import UIKit
import SDWebImage
class HRD_MyRedemptionDetailsVC: BaseViewController {

    @IBOutlet weak var screenTitle: UILabel!
    
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var qtyLbl: UILabel!
    @IBOutlet weak var qtyCount: UILabel!
   
    @IBOutlet weak var redemptionID: UILabel!
    @IBOutlet weak var descriptionTitle: UILabel!
    @IBOutlet weak var descriptionDetails: UILabel!
    @IBOutlet weak var termsandConditionLbl: UILabel!
    @IBOutlet weak var termsandConditionDes: UILabel!

    @IBOutlet weak var productPts: UILabel!
    @IBOutlet weak var myRedemptionDetailsTableView: UITableView!
//    @IBOutlet weak var dateLbl: UILabel!
//    @IBOutlet weak var redemptionStatus: UILabel!
    @IBOutlet weak var noDataFound: UILabel!
    @IBOutlet weak var orderStatusTitle: UILabel!
    
    @IBOutlet weak var categoryTitleLbl: UILabel!
    @IBOutlet weak var headerView: UIView!
    let VM = HR_MyRedemptionDetailsVM()
    var productImage = ""
    var productName = ""
    var quantity = ""
    var redemptionRefNo = ""
    var descDetails = ""
    var termsandContions = ""
    var redemptionPoints = ""
    var status = ""
    var redemptionsDate = ""
    var redemptionId = ""
    var totalPoint = ""
    var cartCounts = ""
    var categoryName = ""
    var redemptionsstatus = ""
    var customerId = ""
    var categoryType = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
       // localization()
        
//        if UserDefaults.standard.string(forKey: "CustomerType") ?? "" == "1"{
//            self.headerView.backgroundColor = #colorLiteral(red: 0.7437494397, green: 0.08922102302, blue: 0.1178346947, alpha: 1)
//
//        }else{
//
//            self.headerView.backgroundColor  = #colorLiteral(red: 0.1643253267, green: 0.3061718345, blue: 0.7360334992, alpha: 1)
//        }
//
        if self.categoryType == "Cash voucher"{
            self.qtyLbl.isHidden = true
            self.qtyCount.isHidden = true
            self.categoryTitleLbl.isHidden = true
//            self.categoryTitleLbl.text = "Category: Cash Voucher"

        }else if self.categoryType == "Catalogue"{
            self.qtyLbl.isHidden = false
            self.qtyCount.isHidden = false
            self.categoryTitleLbl.isHidden = false
            self.categoryTitleLbl.text = "Category: \(self.categoryName)"
        }else{
            self.qtyLbl.isHidden = true
            self.qtyCount.isHidden = true
            self.categoryTitleLbl.isHidden = true
        }
        
        self.productNameLbl.text! = self.productName
        self.qtyCount.text! = self.quantity
        self.productPts.text = self.totalPoint
        print(self.totalPoint)
        self.redemptionID.text! = self.redemptionRefNo
        self.descriptionDetails.text! = self.descDetails
        self.termsandConditionDes.text! = self.termsandContions
        myRedemptionDetailsTableView.delegate = self
        myRedemptionDetailsTableView.dataSource = self
        let urltoUse = String(productCatalogueImgURL + productImage).replacingOccurrences(of: " ", with: "%20")
        let urlt = URL(string: "\(urltoUse)")
        productImg.sd_setImage(with: urlt!, placeholderImage: #imageLiteral(resourceName: "ic_default_img"))
        //self.dateLbl.text = self.redemptionsDate
        self.noDataFound.isHidden = true
    //    if self.customerId == ""{
            self.VM.redemptionDetailsApi(customerId: self.userID)
           // self.receviedStatus()
//        }else{
//            self.VM.redemptionDetailsApi(customerId: self.customerId)
//          //  self.receviedStatus()
//        }
        
    }
//    func localization(){
//        self.screenTitle.text = "My Redemption"
//        self.qtyLbl.text = "QTY"
//        self.descriptionTitle.text = "Descriptions"
//        self.termsandConditionLbl.text = "Terms and Conditions"
//
//    }
    
//    func receviedStatus(){
//
//        if self.redemptionsstatus == "0"{
//            self.redemptionStatus.text = "  Pending  "
//            self.redemptionStatus.textColor = UIColor.black
//            self.redemptionStatus.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
//            self.redemptionStatus.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
//        }else if self.redemptionsstatus == "2" {
//            self.redemptionStatus.text = "  Processed  "
//            self.redemptionStatus.textColor = UIColor.black
//            self.redemptionStatus.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
//            self.redemptionStatus.borderColor = #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)
//        }else if self.redemptionsstatus == "3" {
//            self.redemptionStatus.text = "  Cancelled  "
//            self.redemptionStatus.textColor = UIColor.white
//            self.redemptionStatus.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
//            self.redemptionStatus.borderColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
//        }else if self.redemptionsstatus == "4" {
//            self.redemptionStatus.text = "  Delivered  "
//            self.redemptionStatus.textColor = UIColor.white
//            self.redemptionStatus.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
//            self.redemptionStatus.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
//        }else if self.redemptionsstatus == "7" {
//            self.redemptionStatus.text = "  Returned  "
//            self.redemptionStatus.textColor = UIColor.white
//            self.redemptionStatus.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
//            self.redemptionStatus.borderColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
//        }else if self.redemptionsstatus == "8" {
//            self.redemptionStatus.text = "  Redispatched  "
//            self.redemptionStatus.textColor = UIColor.white
//            self.redemptionStatus.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
//            self.redemptionStatus.borderColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
//        }else if self.redemptionsstatus == "9" {
//            self.redemptionStatus.text = "  OnHold "
//            self.redemptionStatus.textColor = UIColor.black
//            self.redemptionStatus.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
//            self.redemptionStatus.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
//        }else if self.redemptionsstatus == "10" {
//            self.redemptionStatus.text = "  Dispatched  "
//            self.redemptionStatus.textColor = UIColor.white
//            self.redemptionStatus.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
//            self.redemptionStatus.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
//        }else if self.redemptionsstatus == "11" {
//            self.redemptionStatus.text = "  Out for Delivery  "
//            self.redemptionStatus.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
//            self.redemptionStatus.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
//            self.redemptionStatus.textColor = UIColor.white
//        }else if self.redemptionsstatus == "12" {
//            self.redemptionStatus.text = "  Address Verified  "
//            self.redemptionStatus.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
//            self.redemptionStatus.textColor = UIColor.black
//            self.redemptionStatus.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
//        }else if self.redemptionsstatus == "13" {
//            self.redemptionStatus.text = "  Posted for approval  "
//            self.redemptionStatus.textColor = UIColor.white
//            self.redemptionStatus.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
//            self.redemptionStatus.borderColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
//        }else if self.redemptionsstatus == "14" {
//            self.redemptionStatus.text = "  Vendor Alloted  "
//            self.redemptionStatus.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
//            self.redemptionStatus.textColor = UIColor.black
//            self.redemptionStatus.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
//        }else if self.redemptionsstatus == "15" {
//            self.redemptionStatus.text = "  Vendor Rejected  "
//            self.redemptionStatus.textColor = UIColor.white
//            self.redemptionStatus.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
//            self.redemptionStatus.borderColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
//        }else if self.redemptionsstatus == "16" {
//            self.redemptionStatus.text = "  Posted for approval 2  "
//            self.redemptionStatus.textColor = UIColor.white
//            self.redemptionStatus.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
//            self.redemptionStatus.borderColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
//        }else if self.redemptionsstatus == "17" {
//            self.redemptionStatus.text = "  Cancel Request  "
//            self.redemptionStatus.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
//            self.redemptionStatus.textColor = UIColor.black
//            self.redemptionStatus.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
//        }else if self.redemptionsstatus == "18" {
//            self.redemptionStatus.text = "  Redemption Verified  "
//            self.redemptionStatus.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
//            self.redemptionStatus.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
//            self.redemptionStatus.textColor = UIColor.white
//        }else if self.redemptionsstatus == "19" {
//            self.redemptionStatus.text = "  Delivery Confirmed  "
//            self.redemptionStatus.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
//            self.redemptionStatus.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
//            self.redemptionStatus.textColor = UIColor.white
//        }else if self.redemptionsstatus == "20" {
//            self.redemptionStatus.text = "  Return Requested  "
//            self.redemptionStatus.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
//            self.redemptionStatus.textColor = UIColor.black
//            self.redemptionStatus.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
//        }else if self.redemptionsstatus == "21" {
//            self.redemptionStatus.text = "  Return Pick Up Schedule  "
//            self.redemptionStatus.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
//            self.redemptionStatus.textColor = UIColor.black
//            self.redemptionStatus.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
//        }else if self.redemptionsstatus == "22" {
//            self.redemptionStatus.text = "  Picked Up "
//            self.redemptionStatus.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
//            self.redemptionStatus.textColor = UIColor.black
//            self.redemptionStatus.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
//        }else if self.redemptionsstatus == "23" {
//            self.redemptionStatus.text = "  Return Received  "
//            self.redemptionStatus.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
//            self.redemptionStatus.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
//            self.redemptionStatus.textColor = UIColor.white
//        }else if self.redemptionsstatus == "24" {
//            self.redemptionStatus.text = "  In Transit  "
//            self.redemptionStatus.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
//            self.redemptionStatus.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
//            self.redemptionStatus.textColor = UIColor.white
//        }else{
//            self.redemptionStatus.text = "  -  "
//            self.redemptionStatus.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
//            self.redemptionStatus.textColor = UIColor.white
//            self.redemptionStatus.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
//        }
//    }
    
    

    @IBAction func backBTN(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}
extension HRD_MyRedemptionDetailsVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VM.myredemptionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HR_MyRedemptionStatusTVC") as! HR_MyRedemptionStatusTVC
//        if self.VM.myredemptionArray[indexPath.row].status == 0 || self.VM.myredemptionArray[indexPath.row].status == 1{
//            cell.status.text = "Pending"
//        }else if self.VM.myredemptionArray[indexPath.row].status == 2{
//            cell.status.text = "Processed"
//        }else if self.VM.myredemptionArray[indexPath.row].status == 3{
//            cell.status.text = "Cancelled"
//        }else if self.VM.myredemptionArray[indexPath.row].status == 4{
//            cell.status.text = "Delivered"
//        }else if self.VM.myredemptionArray[indexPath.row].status == 7{
//            cell.status.text = "Returned"
//        }else if self.VM.myredemptionArray[indexPath.row].status == 8{
//            cell.status.text = "Redispatched"
//        }else if self.VM.myredemptionArray[indexPath.row].status == 9{
//            cell.status.text = "On Hold"
//        }else if self.VM.myredemptionArray[indexPath.row].status == 10{
//            cell.status.text = "Dispatched"
//        }else if self.VM.myredemptionArray[indexPath.row].status == 11{
//            cell.status.text = "Out of Delivery"
//        }else if self.VM.myredemptionArray[indexPath.row].status == 13{
//            cell.status.text = "Address Verified"
//        }
        
        if self.VM.myredemptionArray[indexPath.row].status ?? 0 == 0{
            cell.status.text = "  Pending  "
//            cell.status.textColor = UIColor.black
//            cell.status.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
//            cell.status.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
        }else if self.VM.myredemptionArray[indexPath.row].status ?? 0 == 2 {
            cell.status.text = "  Processed  "
//            cell.status.textColor = UIColor.black
//            cell.status.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
//            cell.status.borderColor = #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)
        }else if self.VM.myredemptionArray[indexPath.row].status ?? 0 == 3 {
            cell.status.text = "  Cancelled  "
//            cell.status.textColor = UIColor.white
//            cell.status.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
//            cell.status.borderColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
        }else if self.VM.myredemptionArray[indexPath.row].status ?? 0 == 4 {
            cell.status.text = "  Delivered  "
//            cell.status.textColor = UIColor.white
//            cell.status.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
//            cell.status.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        }else if self.VM.myredemptionArray[indexPath.row].status ?? 0 == 7 {
            cell.status.text = "  Returned  "
//            cell.status.textColor = UIColor.white
//            cell.status.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
//            cell.status.borderColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }else if self.VM.myredemptionArray[indexPath.row].status ?? 0 == 8 {
            cell.status.text = "  Redispatched  "
//            cell.status.textColor = UIColor.white
//            cell.status.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
//            cell.status.borderColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }else if self.VM.myredemptionArray[indexPath.row].status ?? 0 == 9 {
            cell.status.text = "  OnHold "
//            cell.status.textColor = UIColor.black
//            cell.status.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
//            cell.status.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
        }else if self.VM.myredemptionArray[indexPath.row].status ?? 0 == 10 {
            cell.status.text = "  Dispatched  "
//            cell.status.textColor = UIColor.white
//            cell.status.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
//            cell.status.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        }else if self.VM.myredemptionArray[indexPath.row].status ?? 0 == 11 {
            cell.status.text = "  Out for Delivery  "
//            cell.status.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
//            cell.status.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
//            cell.status.textColor = UIColor.white
        }else if self.VM.myredemptionArray[indexPath.row].status ?? 0 == 12 {
            cell.status.text = "  Address Verified  "
//            cell.status.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
//            cell.status.textColor = UIColor.black
//            cell.status.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
        }else if self.VM.myredemptionArray[indexPath.row].status ?? 0 == 13 {
            cell.status.text = "  Posted for approval  "
//            cell.status.textColor = UIColor.white
//            cell.status.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
//            cell.status.borderColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }else if self.VM.myredemptionArray[indexPath.row].status ?? 0 == 14 {
            cell.status.text = "  Vendor Alloted  "
//            cell.status.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
//            cell.status.textColor = UIColor.black
//            cell.status.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
        }else if self.VM.myredemptionArray[indexPath.row].status ?? 0 == 15 {
            cell.status.text = "  Vendor Rejected  "
//            cell.status.textColor = UIColor.white
//            cell.status.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
//            cell.status.borderColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }else if self.VM.myredemptionArray[indexPath.row].status ?? 0 == 16 {
            cell.status.text = "  Posted for approval 2  "
//            cell.status.textColor = UIColor.white
//            cell.status.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
//            cell.status.borderColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }else if self.VM.myredemptionArray[indexPath.row].status ?? 0 == 17 {
            cell.status.text = "  Cancel Request  "
//            cell.status.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
//            cell.status.textColor = UIColor.black
//            cell.status.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
        }else if self.VM.myredemptionArray[indexPath.row].status ?? 0 == 18 {
            cell.status.text = "  Redemption Verified  "
//            cell.status.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
//            cell.status.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
//            cell.status.textColor = UIColor.white
        }else if self.VM.myredemptionArray[indexPath.row].status ?? 0 == 19 {
            cell.status.text = "  Delivery Confirmed  "
//            cell.status.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
//            cell.status.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
//            cell.status.textColor = UIColor.white
        }else if self.VM.myredemptionArray[indexPath.row].status ?? 0 == 20 {
            cell.status.text = "  Return Requested  "
//            cell.status.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
//            cell.status.textColor = UIColor.black
//            cell.status.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
        }else if self.VM.myredemptionArray[indexPath.row].status ?? 0 == 21 {
            cell.status.text = "  Return Pick Up Schedule  "
//            cell.status.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
//            cell.status.textColor = UIColor.black
//            cell.status.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
        }else if self.VM.myredemptionArray[indexPath.row].status ?? 0 == 22 {
            cell.status.text = "  Picked Up "
//            cell.status.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
//            cell.status.textColor = UIColor.black
//            cell.status.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
        }else if self.VM.myredemptionArray[indexPath.row].status ?? 0 == 23 {
            cell.status.text = "  Return Received  "
//            cell.status.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
//            cell.status.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
//            cell.status.textColor = UIColor.white
        }else if self.VM.myredemptionArray[indexPath.row].status ?? 0 == 24 {
            cell.status.text = "  In Transit  "
//            cell.status.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
//            cell.status.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
//            cell.status.textColor = UIColor.white
        }else{
            cell.status.text = "  -  "
//            cell.status.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
//            cell.status.textColor = UIColor.white
//            cell.status.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        }
        
        let receivedDate = "\(self.VM.myredemptionArray[indexPath.row].createdDate ?? "")".components(separatedBy: " ")
        
        if receivedDate.count > 0{
            let dateFormatted = convertDateFormater(String(receivedDate[0]), fromDate: "MM/dd/yyyy", toDate: "dd/MM/yyyy")
            cell.createdDate.text = "  \(dateFormatted)"
        }else{cell.createdDate.text = "-"}
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    
}
