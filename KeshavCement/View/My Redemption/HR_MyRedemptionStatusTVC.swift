//
//  HR_MyRedemptionStatusTVC.swift
//  HR_Johnson
//
//  Created by ADMIN on 17/06/2022.
//

import UIKit

class HR_MyRedemptionStatusTVC: UITableViewCell {

//    @IBOutlet weak var categoryBlueImage: UIImageView!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var createdDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        self.categoryImage.isHidden = false
        //self.categoryBlueImage.isHidden = true
//        if UserDefaults.standard.string(forKey: "CustomerType") ?? "" == "1"{
////            self.categoryImage.isHidden = false
////            self.categoryBlueImage.isHidden = true
//            self.categoryImage.image = UIImage(named: "checked")
//            
//        }else{
////            self.categoryImage.isHidden = true
////            self.categoryBlueImage.isHidden = false
//            self.categoryImage.image = UIImage(named: "checkBlueB")
//        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
