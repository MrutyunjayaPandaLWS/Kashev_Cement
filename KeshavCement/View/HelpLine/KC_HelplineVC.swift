//
//  KC_HelplineVC.swift
//  KeshavCement
//
//  Created by ADMIN on 09/01/2023.
//

import UIKit
import Lottie
class KC_HelplineVC: BaseViewController {

   
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var numberBtn: UIButton!
    @IBOutlet weak var giveamissedCallLbl: UIButton!
    @IBOutlet weak var infoLbl2: UILabel!
    @IBOutlet weak var infoLbl1: UILabel!
    @IBOutlet weak var animatedLottieView: LottieAnimationView!
    @IBOutlet weak var headerText: UILabel!
//    private var animationView: AnimationView?
    override func viewDidLoad() {
        super.viewDidLoad()
        lottieAnimation(animationView: animatedLottieView)
       
        headerView.layer.masksToBounds = false
        headerView.layer.shadowRadius = 2
        headerView.layer.shadowOpacity = 0.2
        headerView.layer.shadowColor = UIColor.gray.cgColor
        headerView.layer.shadowOffset = CGSize(width: 0 , height:2)
    }
    override func viewDidLayoutSubviews() {
        subView.clipsToBounds = true
        subView.layer.cornerRadius = 36
        subView.layer.masksToBounds = true
        subView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    @IBAction func numberButton(_ sender: Any) {
        if let phoneCallURL = URL(string: "tel://\(+918875509444)") {
            
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
                
            }
        }
    }
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func lottieAnimation( animationView: LottieAnimationView){
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 1
        animationView.play()

    }
}
