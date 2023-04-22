//
//  HistoryNotificationsViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit

class HistoryNotificationsViewModel{
    
    weak var VC:HistoryNotificationsViewController?
    var requestAPIs = RestAPI_Requests()
    var notificationListArray = [LstPushHistoryJson]()
    
    func notificationListApi(parameters: JSON){
        self.VC?.startLoading()
        self.requestAPIs.notificationList(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil {
                    DispatchQueue.main.async {
                        self.notificationListArray = result?.lstPushHistoryJson ?? []
                        print(self.notificationListArray.count)
                        if self.notificationListArray.count != 0 {
                            self.VC?.NotificationstableView.isHidden = false
                            self.VC?.noDataFound.isHidden = true
                            self.VC?.NotificationstableView.reloadData()
                        }else{
                            self.VC?.noDataFound.isHidden = false
                            self.VC?.NotificationstableView.isHidden = true
                            
                        }
                        self.VC?.stopLoading()
                    }
                } else {
                    print("No Response")
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                    }
                }
            }else{
                print("ERROR_Login \(error)")
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }

        }
    }
    
    }

}
