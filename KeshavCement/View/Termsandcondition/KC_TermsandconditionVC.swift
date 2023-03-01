//
//  KC_TermsandconditionVC.swift
//  KeshavCement
//
//  Created by ADMIN on 16/01/2023.
//

import UIKit
import WebKit

class KC_TermsandconditionVC: BaseViewController {

    @IBOutlet weak var termsandConditionWebview: WKWebView!
    @IBOutlet weak var headerText: UILabel!
    var requestAPIs = RestAPI_Requests()
    var tcListingArray = [LstTermsAndCondition]()
    override func viewDidLoad() {
            super.viewDidLoad()
            dashboardTCApi()
        }

    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    func dashboardTCApi(){
        DispatchQueue.main.async {
        self.startLoading()
        }
        let parameters = [
            "ActionType": 1,
             "ActorId": 2
        ] as [String: Any]
        print(parameters)
        self.requestAPIs.TCDetails(parameters: parameters) { (result, error) in
            DispatchQueue.main.async {
                self.stopLoading()
            }
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.tcListingArray = result?.lstTermsAndCondition ?? []
                        if self.tcListingArray.count == 0{
//                            DispatchQueue.main.async{
//                                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
//                                vc!.delegate = self
//                                vc!.titleInfo = ""
//                                vc!.descriptionInfo = "No terms and Conditions Found"
//                                vc!.modalPresentationStyle = .overCurrentContext
//                                vc!.modalTransitionStyle = .crossDissolve
//                                self.present(vc!, animated: true, completion: nil)
//                            }
                        }else{
                            if "Terms and Conditions" == "Terms and Conditions"{
                                for item in self.tcListingArray{
                                    if item.language == "English"{
                                        
                                        self.loadHTMLStringImage(htmlString: item.html ?? "")
                                        return
                                    }
                                }
                            }else{
                                for item in self.tcListingArray{
                                    if item.language == "Hindi"{
                                        
                                        self.loadHTMLStringImage(htmlString: item.html ?? "")
                                        return
                                    }
                                }
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.stopLoading()
                    }
                    
                }else{
                    DispatchQueue.main.async {
                        self.stopLoading()
                    }
                }
            }else{
                DispatchQueue.main.async {
                    self.stopLoading()
                }
            }
        }
    }

    func loadHTMLStringImage(htmlString:String) -> Void {
           let htmlString = "\(htmlString)"
        termsandConditionWebview.loadHTMLString(htmlString, baseURL: nil)
       }
}
