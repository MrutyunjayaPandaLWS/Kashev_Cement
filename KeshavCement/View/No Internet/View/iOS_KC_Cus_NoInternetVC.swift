//
//  iOS_KC_Cus_NoInternetVC.swift
//  KeshavCement
//
//  Created by admin on 09/11/23.
//

import UIKit
import Lottie

class iOS_KC_Cus_NoInternetVC: UIViewController {

    @IBOutlet weak var noInternetLbl: UILabel!
    @IBOutlet weak var oopsLbl: UILabel!
    @IBOutlet weak var lottieAnimationView: LottieAnimationView!
    private var loaderAnimationView : LottieAnimationView?
    var reachability1: ReachabilityAutoSync?
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async{
            self.lottieAnimationView.clipsToBounds = true
            self.lottieAnimationView.layer.cornerRadius = 16
            self.lottieAnimationView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            self.playAnimation2()
            
            self.reachability1 = try? ReachabilityAutoSync()
            self.startMonitoringReachability()
        }
    }
    
    func playAnimation2(){
           loaderAnimationView = .init(name: "no_internet_lottie")
           loaderAnimationView!.frame = lottieAnimationView.bounds
             // 3. Set animation content mode
           loaderAnimationView!.contentMode = .scaleAspectFill
             // 4. Set animation loop mode
           loaderAnimationView!.loopMode = .loop
             // 5. Adjust animation speed
           loaderAnimationView!.animationSpeed = 0.5
        lottieAnimationView.addSubview(loaderAnimationView!)
             // 6. Play animation
           loaderAnimationView!.play()
       }
    
    func startMonitoringReachability() {
        guard let reachability = reachability1 else { return }
        reachability1?.whenReachable = { [weak self] reachability in
            self?.updateReachabilityStatus(reachable: true)
        }
        reachability1?.whenUnreachable = { [weak self] _ in
            self?.updateReachabilityStatus(reachable: false)
        }
        do {
            try reachability1?.startNotifier()
        } catch {
            print("Failed to start reachability notifier")
        }
    }
    
    func updateReachabilityStatus(reachable: Bool) {
            if reachable {
                print("Network is reachable")
                dismiss(animated: true)
            } else {
                print("Network is unreachable")
            }
        }
    
    deinit{
        reachability1?.stopNotifier()
    }
    
}
