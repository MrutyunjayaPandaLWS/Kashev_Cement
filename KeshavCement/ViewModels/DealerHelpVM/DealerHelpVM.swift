//
//  DealerHelpVM.swift
//  KeshavCement
//
//  Created by ADMIN on 22/04/2023.
//

import Foundation
import UIKit

class DealerHelpVM{
    
    weak var VC: KC_DealerHelpPopUp?
    var requestAPIs = RestAPI_Requests()
    var productDetailsArray = [LstProductListDetails]()
    
    func dealerPopUpList(parameter: JSON){
        DispatchQueue.main.async {
            self.VC?.startLoading()
        }
        
        self.requestAPIs.dealerHelpPopUpApi(parameters: parameter) { (result, error) in
           
            if error == nil{
                
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        self.productDetailsArray = result?.lstProductListDetails ?? []
                        print(self.productDetailsArray.count)
                        if self.productDetailsArray.count != 0 {
                            self.VC?.popUpDetailsTableView.isHidden = false
                            if self.productDetailsArray.count > 20{
                                self.VC?.tableHeightConstratin.constant = 450
                            }else{
                                self.VC?.tableHeightConstratin.constant = CGFloat(40 * self.productDetailsArray.count)
                            }
                            self.VC?.popUpDetailsTableView.reloadData()
                        }else{
                            self.VC?.popUpDetailsTableView.isHidden = true
                            self.VC?.view.makeToast("No data found !!", duration: 2.0, position: .center)
                        }
                        
                    }
                }else{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                    }
                }
            }else{
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
            }
            
        }
    }
}
