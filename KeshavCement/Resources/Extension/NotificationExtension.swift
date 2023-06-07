//
//  NotificationExtension.swift
//  Quba Safalta
//
//  Created by Arkmacbook on 31/03/21.
//

import Foundation

extension Notification.Name{
    static let navigateToSuccess = Notification.Name(rawValue: "navigateToSuccess")
    
    static let navigateToUserDetails = Notification.Name(rawValue: "navigateToUserDetails")
    static let navigateToWorkDetails = Notification.Name(rawValue: "navigateToWorkDetails")
    
    static let navigateToLogin = Notification.Name(rawValue: "navigateToLogin")
    static let navigateToPrevious = Notification.Name(rawValue: "navigateToPrevious")
    static let navigateToChangePassword = Notification.Name(rawValue: "navigateToChangePassword")
    static let navigateToDashBoard = Notification.Name(rawValue: "navigateToDashBoard")
    static let dismissToPrevious = Notification.Name(rawValue: "dismissToPrevious")
    static let navigateToMain = Notification.Name(rawValue: "navigateToMain")
    static let verificationStatus = Notification.Name(rawValue: "verificationStatus")
    static let navigateToOrderConfirmation = Notification.Name(rawValue: "navigateToOrderConfirmation")
    static let navigateToMyRedemption = Notification.Name(rawValue: "navigateToMyRedemption")
    
    static let navigateToSupport = Notification.Name(rawValue: "navigateToSupport")
    static let callApi = Notification.Name(rawValue: "callApi")
    static let querySubmission = Notification.Name(rawValue: "querySubmission")
    
    static let deactivatedAcc = Notification.Name(rawValue: "deactivatedAcc")
    static let removeDreamGiftDetails = Notification.Name(rawValue: "removeDreamGiftDetails")
    
    static let dreamGiftRemoved = Notification.Name(rawValue: "dreamGiftRemoved")
    static let showPopUp = Notification.Name(rawValue: "showPopUp")
    static let deleteAccount = Notification.Name(rawValue: "deleteAccount")
    
    static let SHOWDATA23 = Notification.Name(rawValue: "SHOWDATA23")
    
}
