//
//  EnrollmentPopupMessageVC.swift
//  KeshavCement
//
//  Created by Arokia-M3 on 12/05/23.
//

import UIKit
@objc protocol sendMappedData {
    @objc optional func enrollmentPopup(_ vc: EnrollmentPopupMessageVC)
}

class EnrollmentPopupMessageVC: BaseViewController {
    var requestAPIs = RestAPI_Requests()
    
    @IBOutlet weak var titleLbl: UILabel!
    
    var contactNumbert =  ""
    var descriptionInfo = ""
    var delegate: sendMappedData?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLbl.text = "\(descriptionInfo )"
    }
    
    override func touchesBegan(_ touchscreen: Set<UITouch>, with event: UIEvent?)
    {
        let touch = touchscreen.first
        if touch?.view != self.presentingViewController
        {
            self.dismiss(animated: true, completion: nil)

        }
    }
    
    
    @IBAction func okayBTN(_ sender: Any) {
        let parameter = [
            "ActionType": "8",
            "ActorId": "\(self.userID)",
            "MobileNumber": "\(self.contactNumbert)"
        ]as [String: Any]
        print(parameter)
        self.mappingDetailsAPI(parameters: parameter)
    }
    @IBAction func cancelBTN(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    func mappingDetailsAPI(parameters: JSON){
        
        DispatchQueue.main.async {
            self.startLoading()
        }
        self.requestAPIs.mappingDetailsAPI(parameters: parameters) { (result, error) in
            
            if result == nil{
                DispatchQueue.main.async {
                    self.stopLoading()
                }
            }else{
                if error == nil{
                    
                    let response = String(result?.returnMessage ?? "").split(separator: "~")
                    print(result?.returnMessage ?? "", "Registration Response")
                    DispatchQueue.main.async {
                        self.stopLoading()
                       
                        if response.count != 0 {
                            if response[0] == "1"{
                                self.view.makeToast("Successfully Mapped".localiz(), duration: 2.0, position: .center)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                                    self.delegate?.enrollmentPopup!(self)
                                    self.dismiss(animated: true)
                                    
                                }
                            }else if response[0] == "2"{
                                self.view.makeToast("Already Mapped".localiz(), duration: 2.0, position: .center)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                                    self.delegate?.enrollmentPopup!(self)
                                    self.dismiss(animated: true)
                                }
                            }else{
                                self.view.makeToast("Cannnot be Mapped".localiz(), duration: 2.0, position: .center)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                                //DispatchQueue.main.asyncAfter(deadline: .now()+0.9, execute: {
                                    self.delegate?.enrollmentPopup!(self)
                                    self.dismiss(animated: true)
                                }
                            }
                        }
                    }
                }else{
                    DispatchQueue.main.async {
                        print(error)
                        print(result)
                        self.stopLoading()
                    }
                }
            }
        }
    }
    
 

}
