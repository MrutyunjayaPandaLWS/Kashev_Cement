//
//  KC_RegistrationReferralCodeVC.swift
//  KeshavCement
//
//  Created by ADMIN on 02/01/2023.
//

import UIKit

class KC_RegistrationReferralCodeVC: BaseViewController {

    @IBOutlet weak var referralCodeLbl: UILabel!
    @IBOutlet weak var infoLbl: UILabel!
    @IBOutlet weak var referralCodeTF: UITextField!
    @IBOutlet weak var skipLbl: UILabel!
    var referralCode = ""
    let token = UserDefaults.standard.string(forKey: "TOKEN") ?? ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.referralCodeTF.attributedPlaceholder = NSAttributedString(string: "Enter Referral Code", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        print(referralCode)
    }

    @IBAction func skipButton(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_SignUpVC") as! KC_SignUpVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func verifyingBtn(_ sender: Any) {
        if self.referralCodeTF.text!.count == 0 {
            self.view.makeToast("Enter Referral Code", duration: 2.0, position: .bottom)
        }else{
            let parameters = [
                "ActionType": 62,
                "Location": [
                    "UserName": "\(self.referralCodeTF.text ?? "")"
                ]
            ] as [String : Any]
            print(parameters)
            self.verifyReferralCode(parameters: parameters)
        }
        
    }
    
    func verifyReferralCode(parameters: JSON){
        self.startLoading()
        let referNumber = referralCodeTF.text ?? ""
        let url = URL(string: referralVerifyURL )!
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

            guard error == nil else {
                return
            }
            guard let data = data else {
                return
            }
            do{
                let str = String(decoding: data, as: UTF8.self) as String?
                 print(str, "Response")
                if str ?? "" == "true"{
                    DispatchQueue.main.async {
                        self.stopLoading()
                        self.view.makeToast("Invalid referral code", duration: 2.0, position: .bottom)
                    }
                }else{
                    DispatchQueue.main.async {
                        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_SignUpVC") as! KC_SignUpVC
                        vc.referralCode = self.referralCodeTF.text ?? ""
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
                 }catch{
                     print("parsing Error")
            }
        })
        task.resume()
    }
}
