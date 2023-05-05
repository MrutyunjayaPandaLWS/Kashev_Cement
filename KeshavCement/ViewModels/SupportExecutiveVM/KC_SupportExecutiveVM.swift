//
//  KC_SupportExecutiveVM.swift
//  KeshavCement
//
//  Created by ADMIN on 28/02/2023.
//


import UIKit
import LanguageManager_iOS

class KC_SupportExecutiveVM{
    
    weak var VC: KC_SupportExecutiveVC?
    var requestAPIs = RestAPI_Requests()
    var count = 0
    var redemptionRefId = 0
    var timer = Timer()
    var OTPforVerification = ""

    var supportExecutiveListArray = [LstCustParentChildMapping4]()
    
    func supportExecutiveListApi(parameter: JSON){
        
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }

        self.requestAPIs.supportExecutiveListApi(parameters: parameter) { (result, error) in
            if result == nil{
                
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
            }else{
                if error == nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        let enrollmenteLists = result?.lstCustParentChildMapping ?? []
                        
                        if enrollmenteLists.isEmpty == false{
                            self.supportExecutiveListArray += enrollmenteLists
                            self.VC?.noofelements = self.supportExecutiveListArray.count
                            print(self.supportExecutiveListArray.count, "mappedCustomerListArray Count")
                            self.VC?.stopLoading()
                            if self.supportExecutiveListArray.count != 0 {
                                self.VC?.supportExecutiveTableView.isHidden = false
                                self.VC?.noDataFoundLbl.isHidden = true
                                self.VC?.supportExecutiveTableView.reloadData()
                            }else{
                                self.VC?.supportExecutiveTableView.isHidden = true
                                self.VC?.noDataFoundLbl.isHidden = false
                                self.VC?.noDataFoundLbl.textColor = .white
                            }
                        }else{
                            if self.VC!.startIndex > 1{
                                self.VC?.startIndex = 1
                                self.VC?.noofelements = 9
                            }else{
                                self.VC?.supportExecutiveTableView.isHidden = true
                                self.VC?.noDataFoundLbl.isHidden = false
                                self.VC?.noDataFoundLbl.textColor = .white
                            }
                        }
                    }
                }else{
                    DispatchQueue.main.async {
                        print(error)
                        self.VC?.stopLoading()
                    }
                }
            }
        }
        
    }
    
    func deactivateExecutiveApi(parameter: JSON){
        
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }

        self.requestAPIs.deactivateSupportExecutiveApi(parameters: parameter) { (result, error) in
            if result == nil{
                
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
            }else{
                if error == nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        if result?.isActive ?? false == false || result?.returnMessage ?? "" == "1"{
                            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_ForgetPwdSuccessVC") as! KC_ForgetPwdSuccessVC
                            vc.itsComeFrom = "EXECUTIVE"
                            vc.modalTransitionStyle = .coverVertical
                            vc.modalPresentationStyle = .overFullScreen
                            self.VC!.present(vc, animated: true)
                        }else{
                            self.VC!.view.makeToast("SomethingwentwrongTryagainLater".localiz(), duration: 2.0, position: .bottom)
                        }
                    }
                }else{
                    DispatchQueue.main.async {
                        print(error)
                        self.VC?.stopLoading()
                    }
                }
            }
        }
        
    }
    
 }

