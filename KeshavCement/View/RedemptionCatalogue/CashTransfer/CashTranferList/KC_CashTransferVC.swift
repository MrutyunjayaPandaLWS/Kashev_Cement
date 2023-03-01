//
//  KC_CashTransferVC.swift
//  KeshavCement
//
//  Created by ADMIN on 06/01/2023.
//

import UIKit
import WebKit
class KC_CashTransferVC: BaseViewController, CashTranferDelegate{
    func didTapRedeemBtn(_ cell: KC_CashTransferTVC) {
        guard let tappedIndexPath = self.cashTransferTableView.indexPath(for: cell) else{return}
        
        if cell.redeemButton.tag == tappedIndexPath.row{
            if self.VM.cashTransferListArray[tappedIndexPath.row].pointsRequired ?? -1 <= Int(self.totalRedeemablePoints)!{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_CashTranferPopUpVC") as! KC_CashTranferPopUpVC
                vc.noOfPointsRequired = "\(self.VM.cashTransferListArray[tappedIndexPath.row].pointsRequired ?? -1)"
                vc.productCode = self.VM.cashTransferListArray[tappedIndexPath.row].productCode ?? ""
                vc.productImage = self.VM.cashTransferListArray[tappedIndexPath.row].productImage ?? ""
                vc.productName = self.VM.cashTransferListArray[tappedIndexPath.row].productName ?? ""
                vc.termsandCondition = self.VM.cashTransferListArray[tappedIndexPath.row].termsCondition ?? ""
                vc.vendorId = "\(self.VM.cashTransferListArray[tappedIndexPath.row].vendorId ?? -2)"
                vc.vendorName = self.VM.cashTransferListArray[tappedIndexPath.row].vendorName ?? ""
                if self.customerTypeId == "3"{
                    vc.categoryId = "9"
                }else{
                    vc.categoryId = "8"
                }
                vc.modalTransitionStyle = .coverVertical
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true, completion: nil)
            }
          
        }
    }
    
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var instructionWebView: UIWebView!
    @IBOutlet weak var instructionLbl: UILabel!
    @IBOutlet weak var instructionView: UIView!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var totalPoinView: UIView!
    @IBOutlet weak var totalPtsLbl: UILabel!
    @IBOutlet weak var totalPointsLbl: UILabel!
    @IBOutlet weak var howToWorksBtn: UIButton!
    @IBOutlet weak var cashTransferTableView: UITableView!
    @IBOutlet weak var noDataFoundLbl: UILabel!
    
    var VM = KC_CashTransferVM()
    var noofelements = 0
    var startIndex = 1
    var itsFrom = ""
    var totalRedeemablePoints = UserDefaults.standard.string(forKey: "RedeemablePointBalance") ?? ""
    var categoryId = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.totalPointsLbl.text = "\(self.totalRedeemablePoints)"
        self.instructionView.isHidden = true
        self.totalPoinView.clipsToBounds = true
        self.totalPoinView.cornerRadius = 20
        self.totalPoinView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        self.cashTransferTableView.delegate = self
        self.cashTransferTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.VM.cashTransferListArray.removeAll()
        if self.customerTypeId == "3"{
            self.headerLbl.text = "Cash Voucher"
            self.categoryId = 9
            self.cashTranferApi(categoryId: self.categoryId, startIndex: 1)
        }else{
            self.categoryId = 8
            self.headerLbl.text = "Cash Transfer"
            self.cashTranferApi(categoryId: self.categoryId, startIndex: 1)
        }
        let url = Bundle.main.url(forResource: "cash_transfer_instruction", withExtension:"html")
        let request = NSURLRequest(url: url!)
        instructionWebView.loadRequest(request as URLRequest)
        
    }
    
    @IBAction func okButton(_ sender: Any) {
        self.instructionView.isHidden = true
    }
    @IBAction func closeBtn(_ sender: Any) {
        self.instructionView.isHidden = true
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func howToWorksButton(_ sender: Any) {
        if self.instructionView.isHidden == false{
            self.instructionView.isHidden = true
        }else{
            self.instructionView.isHidden = false
        }
    }
    
    func cashTranferApi(categoryId: Int, startIndex: Int){
        let parameter = [
            "ActionType": "6",
            "ActorId": self.userID,
            "ObjCatalogueDetails": [
                "MerchantId": 1,
                "CatogoryId": categoryId,
                "CatalogueType": 1
            ],
            "StartIndex": startIndex,
            "NoOfRows": 10,
            "Domain": "KESHAV_CEMENT"
        ] as [String: Any]
       print(parameter)
        self.VM.cashTransferListApi(parameter: parameter)
    }
    

    
}
extension KC_CashTransferVC: UITableViewDelegate, UITableViewDataSource, WKNavigationDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VM.cashTransferListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "KC_CashTransferTVC", for: indexPath) as! KC_CashTransferTVC
        cell.selectionStyle = .none
        cell.delegate = self
        cell.redeemButton.tag = indexPath.row
        cell.pointsValueLbl.text = "\(self.VM.cashTransferListArray[indexPath.row].pointsRequired ?? -1)"
        cell.infoLbl.text = self.VM.cashTransferListArray[indexPath.row].productDesc ?? ""
        cell.offerInfoLbl.text = self.VM.cashTransferListArray[indexPath.row].productName ?? ""
        if self.VM.cashTransferListArray[indexPath.row].pointsRequired ?? -1 <= Int(self.totalRedeemablePoints)!{
            cell.redeemButton.backgroundColor = .black
            cell.redeemButton.setTitleColor(.systemYellow, for: .normal)
        }else{

            cell.redeemButton.backgroundColor = .lightGray
            cell.redeemButton.setTitleColor(.systemYellow, for: .normal)
        }
        let imageURL = self.VM.cashTransferListArray[indexPath.row].productImage ?? ""
        if imageURL != ""{
            let urltoUse = String(productCatalogueImgURL + imageURL).replacingOccurrences(of: " ", with: "%20")
            let urlt = URL(string: "\(urltoUse)")
            cell.productImage.sd_setImage(with: urlt!, placeholderImage: #imageLiteral(resourceName: "ic_default_img"))
        }else{
            cell.productImage.image = UIImage(named: "ic_default_img")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_CashTransferDetailsVC") as! KC_CashTransferDetailsVC
        vc.categoryTitle = self.VM.cashTransferListArray[indexPath.row].catogoryName ?? ""
        vc.productName = self.VM.cashTransferListArray[indexPath.row].productName ?? ""
        vc.descriptions = self.VM.cashTransferListArray[indexPath.row].productDesc ?? ""
        vc.termsandCondition = self.VM.cashTransferListArray[indexPath.row].termsCondition ?? ""
        vc.totalPoints = "\(self.VM.cashTransferListArray[indexPath.row].pointsRequired ?? -1)"
        vc.productImageURL = self.VM.cashTransferListArray[indexPath.row].productImage ?? ""
        vc.noOfPointsRequired = "\(self.VM.cashTransferListArray[indexPath.row].pointsRequired ?? -1)"
        vc.productCode = self.VM.cashTransferListArray[indexPath.row].productCode ?? ""
        vc.vendorId =  "\(self.VM.cashTransferListArray[indexPath.row].vendorId ?? -1)"
        vc.vendorName = self.VM.cashTransferListArray[indexPath.row].vendorName ?? ""
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       
            if indexPath.row == self.VM.cashTransferListArray.count - 1{
                if self.noofelements == 10{
                    self.startIndex = self.startIndex + 1
                    self.cashTranferApi(categoryId: self.categoryId, startIndex: 1)
                }else if self.noofelements > 10{
                    self.startIndex = self.startIndex + 1
                    self.cashTranferApi(categoryId: self.categoryId, startIndex: 1)
                }else if self.noofelements < 10{
                    print("no need to hit API")
                    return
                }else{
                    print("n0 more elements")
                    return
                }
            }
       }
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        let changeFontFamilyScript = "document.getElementsByTagName(\'body\')[0].style.fontFamily = \"Impact,Charcoal,sans-serif\";"
////        let changeFontFamilyScript = "<font face='PingFangSC-Light' size='3'>%@"
//
//        self.instructionWebView.evaluateJavaScript(changeFontFamilyScript) { (response, error) in
//            debugPrint("Am here")
//        }
//    }
}

