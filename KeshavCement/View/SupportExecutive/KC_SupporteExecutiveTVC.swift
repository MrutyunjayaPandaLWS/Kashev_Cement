//
//  KC_SupporteExecutiveTVC.swift
//  KeshavCement
//
//  Created by ADMIN on 16/01/2023.
//

import UIKit

protocol ChangeStatusDelegate: class{
    
    func didTapChangeStatus(_ cell: KC_SupporteExecutiveTVC)
}

class KC_SupporteExecutiveTVC: UITableViewCell {

    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var queryStatusLbl: UILabel!
    @IBOutlet weak var queryImage: UIImageView!
    
    @IBOutlet weak var statusBtn: UIButton!
    @IBOutlet weak var mobileNumberLbl: UILabel!
    
    @IBOutlet weak var mobileNumber: UILabel!
    
    @IBOutlet weak var memberShipId: UILabel!
    @IBOutlet weak var memberShipIdLbl: UILabel!
    
    var delegate: ChangeStatusDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func statusChangeBtn(_ sender: Any) {
        self.delegate.didTapChangeStatus(self)
    }
}
