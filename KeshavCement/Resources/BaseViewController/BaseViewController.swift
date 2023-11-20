//
//  BaseViewController.swift
//  WalkKaro
//
//  Created by Arokia-M3 on 12/10/21.
//

import UIKit
import WebKit
import Lottie

class BaseViewController: UIViewController {
    let activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView();
    
//    var animationView1: AnimationView?
    var reachability1: ReachabilityAutoSync?
    var myView = UIView()
    var loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyId") ?? ""
    var userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    var customerTypeId = UserDefaults.standard.string(forKey: "customerTypeId") ?? ""
    var customerType = UserDefaults.standard.string(forKey: "customerType") ?? ""
    var userFullName = UserDefaults.standard.string(forKey: "FirstName") ?? ""
    var totalPtss = UserDefaults.standard.string(forKey: "RedeemablePointBalance") ?? ""
    var overAllPts = UserDefaults.standard.string(forKey: "OverallPoints") ?? ""
    
    
    var mappedCustomerType = UserDefaults.standard.string(forKey: "mappedCustomerType") ?? ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reachability1 = try? ReachabilityAutoSync()
        startMonitoringReachability()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let changeFontFamilyScript = "document.getElementsByTagName(\'body\')[0].style.fontFamily = \"Impact,Charcoal,sans-serif\";"
        webView.evaluateJavaScript(changeFontFamilyScript) { (response, error) in
            debugPrint("Am here")
        }
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
//                self.view.window?.rootViewController?.dismiss(animated: true)
                Token.shared.tokendata()
            } else {
                print("Network is unreachable")
                let vc = UIStoryboard(name: "NoInternet", bundle: nil).instantiateViewController(withIdentifier: "iOS_KC_Cus_NoInternetVC") as? iOS_KC_Cus_NoInternetVC
                vc?.modalTransitionStyle = .crossDissolve
                vc?.modalPresentationStyle = .overFullScreen
                self.present(vc!, animated: true)
            }
        }
    
    deinit{
        reachability1?.stopNotifier()
    }
    
    func convertDateFormater(_ date: String, fromDate: String, toDate: String) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = fromDate
            let date1 = dateFormatter.date(from: date)
            dateFormatter.dateFormat = toDate
        if let date1 = date1{
            return dateFormatter.string(from: date1)
        }else{
            return date
        }
        
 
        }
    
       func startLoading(){
           DispatchQueue.main.async {
               self.activityIndicator.transform = CGAffineTransform(scaleX: 2, y: 2)
               self.activityIndicator.center = self.view.center;
               self.activityIndicator.hidesWhenStopped = true;
               self.activityIndicator.color = #colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 1)
               self.view.addSubview(self.activityIndicator);
               self.activityIndicator.startAnimating();
               self.view.isUserInteractionEnabled = false
           }
       }
       func stopLoading(){
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating();
            self.view.isUserInteractionEnabled = true
        }
          
       }

    func alertmsg(alertmsg:String, buttonalert:String){
        let alert = UIAlertController(title: "", message: alertmsg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "\(buttonalert)", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

}
