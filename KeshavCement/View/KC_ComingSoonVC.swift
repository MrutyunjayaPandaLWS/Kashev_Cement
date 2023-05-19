//
//  EBC_ComingSoonVC.swift
//  EuroBond_Customer
//
//  Created by ADMIN on 17/04/2023.
//

import UIKit
import Lottie
import LanguageManager_iOS
class KC_ComingSoonVC: BaseViewController {
    
    @IBOutlet var headerTitleLbl: UILabel!
    
    @IBOutlet weak var comingSoonAnimation: LottieAnimationView!
    
    var iscomingFrom = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.headerTitleLbl.text = "Game Zone".localiz()
        self.lottieAnimation(animationView: comingSoonAnimation)
    }

    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func lottieAnimation(animationView: LottieAnimationView){
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 1
        animationView.play()

    }
    
    
}
