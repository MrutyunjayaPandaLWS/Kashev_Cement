//
//  KC_MyProfileVC.swift
//  KeshavCement
//
//  Created by ADMIN on 30/12/2022.
//

import UIKit
import Photos
import QCropper
class KC_MyProfileVC: BaseViewController,DateSelectedDelegate, UITextFieldDelegate, SelectedDataDelegate {
    func didTapMappedUserName(_ vc: KC_DropDownVC) {}
    func didTapCityName(_ vc: KC_DropDownVC){}
    func didTapHelpTopic(_ vc: KC_DropDownVC) {}
    func didTapWorkLevel(_ vc: KC_DropDownVC) {}
    func didTapUserType(_ vc: KC_DropDownVC) {}
    func didTapProductName(_ vc: KC_DropDownVC){}
    func acceptDate(_ vc: KC_DOBVC) {
        if vc.isComeFrom == "DOB"{
            self.dobTF.text = vc.selectedDate
            self.selectedDOB = vc.selectedDate
        }
    }
    
    func declineDate(_ vc: KC_DOBVC) {}
    
    func didTapCustomerType(_ vc: KC_DropDownVC) {
        self.customerTypeTF.text = vc.selectedCustomerType
        self.selectedCustomerTypeId = "\(vc.selectedCustomerTypeId)"
        self.selectedCustomerTypeName = vc.selectedCustomerType
        if self.selectedCustomerTypeId == "1" || self.selectedCustomerTypeId == "2"{
            self.aadharNumberLbl.text = "Aadhar Number"
            self.aadharNumberTF.placeholder = "Enter aadhar number"
        }else if self.selectedCustomerTypeId == "3" || self.selectedCustomerTypeId == "4"{
            self.aadharNumberLbl.text = "GST Number"
            self.aadharNumberTF.placeholder = "Enter GST number"
        }
    }
    
    func didTapState(_ vc: KC_DropDownVC) {
        self.stateTF.text = vc.selectedStateName
        self.stateId = "\(vc.selectedStateId)"
        self.districtTF.text = "Select District"
        self.districtId = "-1"
        self.talukTF.text = "Select Taluk"
        self.talukId = "-1"
    }
    
    func didTapDistrict(_ vc: KC_DropDownVC) {
        self.districtTF.text = vc.selectedDistrictName
        self.districtId = "\(vc.selectedDistrictId)"
        self.talukTF.text = "Select Taluk"
        self.talukId = "-1"
    }
    
    func didTapTaluk(_ vc: KC_DropDownVC) {
        self.talukTF.text = vc.selectedTalukName
        self.talukId = "\(vc.selectedTalukId)"
    }

    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var changeProfileButton: UIButton!
    @IBOutlet weak var customerTypeLbl: UILabel!
    @IBOutlet weak var fullNameLbl: UILabel!
    @IBOutlet weak var firmNameLbl: UILabel!
    @IBOutlet weak var mobileNumberLbl: UILabel!
    @IBOutlet weak var aadharNumberLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var pincodeLbl: UILabel!
    @IBOutlet weak var stateLbl: UILabel!
    @IBOutlet weak var districtLbl: UILabel!
    @IBOutlet weak var talukaLbl: UILabel!
    @IBOutlet weak var saveChangesBtn: UIButton!
    
    
    @IBOutlet weak var customerTypeTF: UITextField!
    @IBOutlet weak var fullNameTF: UITextField!
    @IBOutlet weak var firmTF: UITextField!
    @IBOutlet weak var mobileNumberTF: UITextField!
    @IBOutlet weak var aadharNumberTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var addressTextView: UITextView!
    @IBOutlet weak var pincodeTF: UITextField!
    @IBOutlet weak var stateTF: UITextField!
    @IBOutlet weak var districtTF: UITextField!
    @IBOutlet weak var talukTF: UITextField!
    
    @IBOutlet weak var dobTF: UITextField!
    
    
    var address = ""
    var selectedDOB = ""
    var addressId = ""
    var customerId = ""
    var districtId = ""
    var email = ""
    var firstName = ""
    var mobile = ""
    var stateId = ""
    var talukId = ""
    var zip = ""
    var aadharNumber = ""
    var dob = ""
    var companyName = ""
    var GSTNumber = ""
    var selectedCustomerTypeId = ""
    var selectedCustomerTypeName = ""
    
    
    let picker = UIImagePickerController()
    var strBase64 = ""
    var VM = KC_MyProfileVM()
//    var loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyId") ?? ""
//    var userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.customerTypeTF.isUserInteractionEnabled = false
        self.stateTF.isUserInteractionEnabled = false
        self.districtTF.isUserInteractionEnabled = false
        self.talukTF.isUserInteractionEnabled = false
        self.dobTF.isUserInteractionEnabled = false
        mobileNumberTF.delegate = self
        pincodeTF.delegate = self
        headerView.layer.masksToBounds = false
        headerView.layer.shadowRadius = 2
        headerView.layer.shadowOpacity = 0.2
        headerView.layer.shadowColor = UIColor.gray.cgColor
        headerView.layer.shadowOffset = CGSize(width: 0 , height:2)
        self.picker.delegate = self
        self.myProfileDetailsApi()
        if self.customerTypeId == "1" || self.customerTypeId == "2"{
            self.aadharNumberLbl.text = "Aadhar Number"
            self.aadharNumberTF.placeholder = "Enter aadhar number"
        }else if self.customerTypeId == "3" || self.customerTypeId == "4"{
            self.aadharNumberLbl.text = "GST Number"
            self.aadharNumberTF.placeholder = "Enter GST number"
        }
    }
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func changeProfileBtn(_ sender: Any) {
                
                let alert = UIAlertController(title: "Choose any option", message: "", preferredStyle: .actionSheet)
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
    @IBAction func customerTypeBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_DropDownVC") as! KC_DropDownVC
        vc.itsFrom = "CUSTOMERTYPE"
        vc.delegate = self
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    
    @IBAction func stateButton(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_DropDownVC") as! KC_DropDownVC
        vc.itsFrom = "STATE"
        vc.delegate = self
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    
    
    @IBAction func districtButton(_ sender: Any) {
        if self.stateId == "1"{
            self.view.makeToast("Select State", duration: 2.0, position: .bottom)
        }else{
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_DropDownVC") as! KC_DropDownVC
            vc.itsFrom = "DISTRICT"
            vc.delegate = self
            vc.selectedStateId = Int(self.stateId)!
            vc.modalTransitionStyle = .coverVertical
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }
    }
    
    
    @IBAction func talukButton(_ sender: Any) {
        if self.districtId == "-1"{
            self.view.makeToast("Select District", duration: 2.0, position: .bottom)
        }else{
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_DropDownVC") as! KC_DropDownVC
            vc.itsFrom = "TALUK"
            vc.delegate = self
            vc.selectedDistrictId = Int(self.districtId) ?? -1
            vc.modalTransitionStyle = .coverVertical
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }
    }
    
    @IBAction func dobButton(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_DOBVC") as! KC_DOBVC
        vc.isComeFrom = "DOB"
        vc.delegate = self
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    
    
    @IBAction func saveChangesBTN(_ sender: Any) {
        if self.customerTypeTF.text?.count == 0{
            self.view.makeToast("Enter customer type", duration: 2.0, position: .bottom)
        }else if self.fullNameTF.text?.count == 0{
            self.view.makeToast("Enter full name", duration: 2.0, position: .bottom)
        }else if self.firmTF.text?.count == 0{
            self.view.makeToast("Enter firm name", duration: 2.0, position: .bottom)
        }else if self.mobileNumberTF.text?.count == 0{
            self.view.makeToast("Enter mobile number", duration: 2.0, position: .bottom)
        }else if self.mobileNumberTF.text?.count != 10{
            self.view.makeToast("Enter valid mobile number", duration: 2.0, position: .bottom)
        }else if self.aadharNumberTF.text?.count == 0{
            self.view.makeToast("Enter aadhar / GST number", duration: 2.0, position: .bottom)
        }else if self.aadharNumberTF.text!.count > 16{
            self.view.makeToast("Enter valid aadhar / GST number", duration: 2.0, position: .bottom)
        }else if self.emailTF.text!.count == 0{
            self.view.makeToast("Enter email", duration: 2.0, position: .bottom)
        }else if self.addressTextView.text!.count == 0{
            self.view.makeToast("Enter address", duration: 2.0, position: .bottom)
        }else if self.pincodeTF.text!.count == 0{
            self.view.makeToast("Enter pin", duration: 2.0, position: .bottom)
        }else if self.pincodeTF.text!.count != 6{
            self.view.makeToast("Enter valid pin", duration: 2.0, position: .bottom)
        }else if self.stateTF.text?.count == 0 {
            self.view.makeToast("Select State", duration: 2.0, position: .bottom)
        }else if self.districtTF.text?.count == 0 {
            self.view.makeToast("Select District", duration: 2.0, position: .bottom)
        }else if self.talukTF.text?.count == 0 {
            self.view.makeToast("Select Taluk", duration: 2.0, position: .bottom)
        }else{
            let parameter = [
                "mailto:actiontype": "262",
                "actorid": "\(self.userID)",
                "objcustomerjson": [
                    "address1": "\(self.addressTextView.text ?? "")",
                    "addressid": self.addressId,
                    "customerid": self.customerId,
                    "districtid": self.districtId,
                    "email": self.emailTF.text ?? "",
                    "FirstName": self.fullNameTF.text ?? "",
                    "Mobile": self.mobileNumberTF.text ?? "",
                    "RELATED_PROJECT_TYPE": "KESHAV_CEMENT",
                    "StateId": "\(self.stateId)",
                    "TalukId": "\(self.talukId)",
                    "Zip": self.pincodeTF.text ?? "",
                    "AadharNumber": self.aadharNumberTF.text ?? "",
                    "DOB":self.selectedDOB
                ],
                "lstCustomerOfficalInfoJson": [
                    "CompanyName": self.firmTF.text ?? "",
                    "GSTNumber": "",
                    "SapNo": "null"
                ]
            ] as [String: Any]
            print(parameter)
            self.VM.myProfileDetailsUpdateApi(parameter: parameter)
        }
        
    }
    func myProfileDetailsApi(){
        
        let parameter = [
            "ActionType": "6",
            "CustomerId": "\(self.userID)"
        ] as [String: Any]
        print(parameter)
        self.VM.myProfileImageListing(parameter: parameter)
        
    }
}
extension KC_MyProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate,   CropperViewControllerDelegate {
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
                    let alertVC = UIAlertController(title: "Kashev need to access camera Gallery", message: "", preferredStyle: .alert)
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
        
        //        DispatchQueue.main.async {
        //            guard let selectedImage = info[.originalImage] as? UIImage else {
        //                return
        //            }
        //            let imageData = selectedImage.resized(withPercentage: 0.1)
        //            let imageData1: NSData = imageData!.pngData()! as NSData
        //            self.profileImageView.image = selectedImage
        //            self.strdata1 = imageData1.base64EncodedString(options: .lineLength64Characters)
        //            self.VM.imageSubmissionAPI(base64: self.strdata1)
        ////            picker.dismiss(animated: true, completion: nil)
        ////            self.dismiss(animated: true, completion: nil)
        //
        //        }
        
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            print(image)
            
            let imageData = image.resized(withPercentage: 0.1)
            let imageData1: NSData = imageData!.pngData()! as NSData
            self.profileImage.image = image
            self.strBase64 = imageData1.base64EncodedString(options: .lineLength64Characters)
            let parameter = [
                "ActorId": "\(self.userID)",
                "ObjCustomerJson": [
                    "LoyaltyId": "\(self.loyaltyId)",
                        "DisplayImage": "\(self.strBase64)"
                        ]
            ] as [String: Any]
            print(parameter)
            self.VM.myProfileImageUploadApI(parameter: parameter)
            
            picker.dismiss(animated: true)
            self.dismiss(animated: true, completion: nil)
                
            
        }
        
         
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
  

        func cropperDidConfirm(_ cropper: CropperViewController, state: CropperState?) {
        cropper.dismiss(animated: true, completion: nil)
     
        if let state = state,
            let image = cropper.originalImage.cropped(withCropperState: state) {
            print(image,"imageDD")
            let imageData = image.resized(withPercentage: 0.1)
            let imageData1: NSData = imageData!.pngData()! as NSData
            self.profileImage.image = image
//            self.strBase64 = imageData1.base64EncodedString(options: .lineLength64Characters)
//            let parameter = [
//                "ActorId": "37",
//                "ObjCustomerJson": [
//                    "LoyaltyId": "\(sef)",
//                        "DisplayImage": "\(self.strBase64)"
//                        ]
//            ] as [String: Any]
//            print(parameter)
//            self.VM.myProfileImageUploadApI(parameter: parameter)
        } else {
            print("Something went wrong")
        }
        self.dismiss(animated: true, completion: nil)
        }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
      let compSepByCharInSet = string.components(separatedBy: aSet)
      let numberFiltered = compSepByCharInSet.joined(separator: "")
      if string == numberFiltered {
          if textField == mobileNumberTF{
              let currentText = mobileNumberTF.text ?? ""
              guard let stringRange = Range(range, in: currentText) else { return false }
              let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
              return updatedText.count <= 10
          }else if textField == pincodeTF {
              let currentText = pincodeTF.text ?? ""
              guard let stringRange = Range(range, in: currentText) else { return false }
              let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
              return updatedText.count <= 6
          }
      
      } else {
        return false
      }
        return false
    }
}
