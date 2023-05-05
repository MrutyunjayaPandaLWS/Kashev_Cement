//
//  HR_AddLodgeQueryVC.swift
//  HR_Johnson
//
//  Created by ArokiaIT on 2/10/22.
//

import UIKit
import Photos
import AVFoundation
import LanguageManager_iOS
class KC_AddLodgeQueryVC: BaseViewController, SelectedDataDelegate{
    func didTapHelpTopic(_ vc: KC_DropDownVC) {
        self.selectedItem = vc.helpTopicName
        self.selectedQueryID = vc.helpTopicId
        print(self.selectedItem,"Selected Query")
        print(self.selectedQueryID,"Selected ID")
        self.topicNameLbl.text = self.selectedItem
    }
    

    @IBOutlet weak var screenTitle: UILabel!
    @IBOutlet weak var viewTitle: UILabel!
    @IBOutlet weak var selectTopicTitle: UILabel!
    @IBOutlet weak var topicNameLbl: UILabel!
    @IBOutlet weak var querySummary: UILabel!
    @IBOutlet weak var querySummaryTF: UITextField!
    @IBOutlet weak var queryDetails: UILabel!
    @IBOutlet weak var queryDetailsTF: UITextField!
    @IBOutlet weak var attachedImg: UIImageView!
    @IBOutlet weak var browseLbl: UILabel!
    @IBOutlet weak var submitLbl: UILabel!
    @IBOutlet weak var attachedImgHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var mainViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var querySummaryLbl: UILabel!
    
   
    var selectedQueryID = 0
    let picker = UIImagePickerController()
    var selectedItem = "", strBase64 = "", selectedQueryTopic = ""
    
    var VM = KC_NewQuerySubmissionVM()
    
   // var requestAPIs = RestAPI_Requests()
    var loyaltyID = UserDefaults.standard.string(forKey: "LoyaltyId") ?? ""
    var mobilenumber = UserDefaults.standard.string(forKey: "CustomerMobileNumber") ?? ""
    let emailID = UserDefaults.standard.string(forKey: "CustomerEmail") ?? ""
    let firstname = UserDefaults.standard.string(forKey: "FirstName") ?? ""
    let merchantUserName = UserDefaults.standard.string(forKey: "MerchantEmail") ?? ""
    var merchanMobile = UserDefaults.standard.string(forKey: "MerchantMobile") ?? ""
    var pointBalance = UserDefaults.standard.string(forKey: "RedeemablePointBalance") ?? ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.selectTopicTitle.text = self.selectedQueryTopic
      //  localization()
      //  self.attachedImgHeightConstraint.constant = 0
        self.picker.delegate = self
     //   self.mainViewHeightConstraint.constant = 380
        
        self.viewTitle.text = "PleaseSubmitYour".localiz()
        self.selectTopicTitle.text = "SelectYourTopic".localiz()
        self.topicNameLbl.text = "SelectHelpTopic".localiz()
        self.querySummaryLbl.text = "QuerySummary".localiz()
        self.querySummaryTF.placeholder = "Writeyourquery".localiz()
        self.queryDetails.text = "QueryDetails".localiz()
        self.queryDetailsTF.placeholder = "Writeyourquerydetails..".localiz()
        self.browseLbl.text = "BrowseImage".localiz()
        self.submitLbl.text = "SubmitQuery".localiz()
        
        
     }




    @IBAction func backBTN(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
        }
    @IBAction func selectTopicBTN(_ sender: Any) {
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            self.view.makeToast("No internet connection !!", duration: 2.0, position: .bottom)
        }else{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_DropDownVC") as? KC_DropDownVC
            vc!.delegate = self
            vc!.itsFrom = "NEWQUERY"
            vc!.modalPresentationStyle = .overFullScreen
            vc!.modalTransitionStyle = .crossDissolve
            self.present(vc!, animated: true, completion: nil)
        }
    }
    @IBAction func browseImg(_ sender: Any) {
        let alert = UIAlertController(title: "ChooseAnyOption", message: "", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default , handler:{ (UIAlertAction)in
            self.openCamera()
        }))
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler:{ (UIAlertAction)in
            self.openGallery()
        }))

        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
        }))
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
        
    }
    @IBAction func submitBTN(_ sender: Any) {
        
        if self.topicNameLbl.text == "SelectTopic".localiz(){
            self.view.makeToast("SelectTopic".localiz(),duration: 2.0,position: .bottom)
        }else if self.querySummaryTF.text?.count == 0{
            self.view.makeToast("EnterQuerySummary".localiz(),duration: 2.0,position: .bottom)
        }else if self.queryDetailsTF.text?.count == 0{
            self.view.makeToast("EnterQueryDetails".localiz(),duration: 2.0,position: .bottom)
        }else{
            var parameterJSON = [
                "ActionType":"0",
                "ActorId":"\(self.userID)",
                "HelpTopicID":"\(selectedQueryID)",
                "IsQueryFromMobile":"true",
                "ImageUrl":"\(strBase64)",
                "LoyaltyID":"\(loyaltyId)",
                "Mobile":"\(mobilenumber)",
                "QueryDetails":"\(self.queryDetailsTF.text ?? "")",
                "QuerySummary":"\(self.querySummaryTF.text ?? "")",
                "QuerySummaryMultipleQuery":"\(self.querySummaryTF.text ?? "")",
                "SourceType":"3"
            ]
            self.VM.submitHelptopic(parameters: parameterJSON)
        }
    }
    
    
    
}
extension KC_AddLodgeQueryVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func openGallery() {
        PHPhotoLibrary.requestAuthorization({
            (newStatus) in
            if newStatus ==  PHAuthorizationStatus.authorized {
                DispatchQueue.main.async {
                    self.picker.allowsEditing = false
                    self.picker.sourceType = .savedPhotosAlbum
                    self.picker.mediaTypes = ["public.image"]
                    self.present(self.picker, animated: true, completion: nil)
                }
            }else{
                DispatchQueue.main.async {
                    let alertVC = UIAlertController(title: "Need Gallary access", message: "Allow Gallery access", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Allow", style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        DispatchQueue.main.async {
                            UIApplication.shared.open(URL.init(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                        }
                    }
                    let cancelAction = UIAlertAction(title: "DisAllow", style: UIAlertAction.Style.cancel) {
                        UIAlertAction in
                        
                    }
                    alertVC.addAction(okAction)
                    alertVC.addAction(cancelAction)
                    self.present(alertVC, animated: true, completion: nil)
                    
                }
            }
        })
    }
    
    func openCamera(){
        DispatchQueue.main.async {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
                    if response {
                        if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.authorized {
                            DispatchQueue.main.async {
                                
                                self.picker.allowsEditing = false
                                self.picker.sourceType = .camera
                                self.picker.mediaTypes = ["public.image"]
                                self.present(self.picker,animated: true,completion: nil)
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            let alertVC = UIAlertController(title: "Need Camera Access", message: "Allow", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "Allow", style: UIAlertAction.Style.default) {
                                UIAlertAction in
                                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                            }
                            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
                                UIAlertAction in
                            }
                            alertVC.addAction(okAction)
                            alertVC.addAction(cancelAction)
                            self.present(alertVC, animated: true, completion: nil)
                            
                        }
                    }
                }} else {
                    DispatchQueue.main.async {
                        self.noCamera()
                    }
                }
        }
        
    }
    
    
    func opencamera() {
        DispatchQueue.main.async {
            if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.authorized {
                DispatchQueue.main.async {
                    self.picker.allowsEditing = false
                    self.picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: self.picker.sourceType)!
                    self.picker.sourceType = UIImagePickerController.SourceType.camera
                    self.picker.cameraCaptureMode = .photo
                    self.present(self.picker,animated: true,completion: nil)
                }
            }else{
                DispatchQueue.main.async {
                    let alertVC = UIAlertController(title: "Keshav need to access camera Gallery", message: "", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Allow", style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                    }
                    let cancelAction = UIAlertAction(title: "Disallow", style: UIAlertAction.Style.cancel) {
                        UIAlertAction in
                    }
                    alertVC.addAction(okAction)
                    alertVC.addAction(cancelAction)
                    self.present(alertVC, animated: true, completion: nil)
                }
            }
        }
    }
    func noCamera(){
        let alertVC = UIAlertController(title: "No Camera", message: "Sorry no device", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style:.default, handler: nil)
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }
    //MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        DispatchQueue.main.async { [self] in
            guard let selectedImage = info[.originalImage] as? UIImage else {
                return
            }
            let imageData = selectedImage.resized(withPercentage: 0.1)
            let imageData1: NSData = imageData!.pngData()! as NSData
            self.attachedImg.image = selectedImage
            self.strBase64 = imageData1.base64EncodedString(options: .lineLength64Characters)
//            self.attachedImgHeightConstraint.constant = 150
//            self.mainViewHeightConstraint.constant = 540
            picker.dismiss(animated: true, completion: nil)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
