//
//  KC_TransferSubmissionVM.swift
//  KeshavCement
//
//  Created by ADMIN on 23/03/2023.
//

import Foundation
import UIKit

class KC_TransferSubmissionVM{
    
    weak var VC: KC_CashTransferSubmissionVC?
    var requestAPIs = RestAPI_Requests()
    var cashDetailsListArray = [LstCashTransfer]()
    func cashDetailsListApi(parameter: JSON){
            
            DispatchQueue.main.async {
                self.VC?.startLoading()
            }
            
            self.requestAPIs.cashSubmissionPointsListApi(parameters: parameter) { (result, error) in
                
                if result == nil{
                    
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                    }
                }else{
                    if error == nil{
                        DispatchQueue.main.async {
                            self.VC?.stopLoading()
                            if result?.redeemablePointBalance ?? 0 != 0{
                                self.VC!.totalPointsLbl.text = "\(result?.redeemablePointBalance ?? 0)"
                                self.VC!.totalRedeemablePoints = "\(result?.redeemablePointBalance ?? 0)"
                            }else{
                                self.VC!.totalPointsLbl.text = "0"
                                self.VC!.totalRedeemablePoints = "\(result?.redeemablePointBalance ?? 0)"
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
    func cashTransferSubmissionApi(parameter: JSON){
        
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        
        self.requestAPIs.cashTransferSubApi(parameters: parameter) { (result, error) in
            
            if result == nil{
                
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
            }else{
                if error == nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        print(result?.returnMessage ?? "", "Claim Purchase submission")
                        if result?.returnValue ?? -1 > 0{
                            self.VC!.swipeButton.reset()
                            self.VC!.swipeButton.backgroundColor = .white
                            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_ForgetPwdSuccessVC") as! KC_ForgetPwdSuccessVC
                            vc.itsComeFrom = "CASHTRANSFER"
                            vc.modalTransitionStyle = .coverVertical
                            vc.modalPresentationStyle = .overFullScreen
                            self.VC!.present(vc, animated: true)
                            self.VC!.swipeButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                        }else{
                            self.VC!.view.makeToast("Claim submission failed!", duration: 2.0, position: .bottom)
                            self.VC!.swipeButton.reset()
                            self.VC!.swipeButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
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
