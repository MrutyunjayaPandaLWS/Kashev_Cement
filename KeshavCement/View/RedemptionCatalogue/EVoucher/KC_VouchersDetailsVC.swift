//
//  GetVouchersDetailsVC.swift
//  GogrejLocksMobileApplication
//
//  Created by Arokia IT on 2/14/20.
//  Copyright © 2020 Arokiait Pvt Ltd. All rights reserved.
//

import UIKit
//import SDWebImage
class KC_VouchersDetailsVC: BaseViewController{
    
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var rangeLbl: UILabel!
    @IBOutlet weak var voucherTitle: UILabel!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var voucherimage: UIImageView!
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var redeemButton: UIButton!
    @IBOutlet weak var amounTF: UITextField!
    @IBOutlet weak var redeemButtonTopSpace: UILabel!
    
    @IBOutlet weak var descriptionInfoLbl: UILabel!
    @IBOutlet weak var DescriptionLbl: UILabel!
    
    @IBOutlet weak var termsandconditionLbl: UILabel!
    
    @IBOutlet weak var termandCondtionInfoLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        subView.clipsToBounds = false
        subView.layer.cornerRadius = 36
        subView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        headerView.layer.masksToBounds = false
        headerView.layer.shadowRadius = 2
        headerView.layer.shadowOpacity = 0.2
        headerView.layer.shadowColor = UIColor.gray.cgColor
        headerView.layer.shadowOffset = CGSize(width: 0 , height:2)
    }
    
    
    @IBAction func backbutton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func redeemBtn(_ sender: Any) {
    }
    @IBAction func selectAmountBtn(_ sender: Any) {
    }
}
