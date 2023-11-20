//
//  KC_DOBVC.swift
//  KeshavCement
//
//  Created by ADMIN on 16/02/2023.
//
import UIKit
import LanguageManager_iOS
@objc protocol DateSelectedDelegate {
    @objc optional func acceptDate(_ vc: KC_DOBVC)
    @objc optional func declineDate(_ vc: KC_DOBVC)
}
class KC_DOBVC: UIViewController {
    @IBOutlet weak var okButton: UIButton!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    let date = Date()
    let nameFormatter = DateFormatter()
    var selectedDate = ""
    var isComeFrom = ""
    var receivedDate = ""
    var delegate: DateSelectedDelegate!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.isComeFrom != "TENTATIVE"{
            datePicker.maximumDate = date
        }else{
            datePicker.minimumDate = Date()
        }
        
    }
    override func touchesBegan(_ touchscreen: Set<UITouch>, with event: UIEvent?)
    {
        let touch = touchscreen.first
        if touch?.view != self.presentingViewController
        {
            self.dismiss(animated: true, completion: nil)

        }
    }
    
    @IBAction func okBtn(_ sender: Any) {
        let today = Date() //Jun 21, 2017, 7:18 PM
        let sevenDaysBeforeToday = Calendar.current.date(byAdding: .year, value: -18, to: today)!
        print(sevenDaysBeforeToday)
        if isComeFrom == "DOB"{
            if datePicker.date > sevenDaysBeforeToday{
                let alert = UIAlertController(title: "", message: "18years".localiz(), preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK".localiz(), style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }else{
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                selectedDate = formatter.string(from: datePicker.date)
                self.delegate.acceptDate!(self)
                self.dismiss(animated: true, completion: nil)
            }
//
        }else if isComeFrom == "TENTATIVE"{
            //let sevenDaysBeforeToday = Calendar.current.date(byAdding: .year, value: -18, to: today)!
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            selectedDate = formatter.string(from: datePicker.date)
            self.delegate.acceptDate!(self)
            self.dismiss(animated: true, completion: nil)
            
        }else if isComeFrom == "ANNIVERSARY"{
//            if datePicker.date > sevenDaysBeforeToday{
//                let alert = UIAlertController(title: "", message: "ItseemsYouarelessthan18years".localiz(), preferredStyle: UIAlertController.Style.alert)
//                alert.addAction(UIAlertAction(title: "OK".localiz(), style: UIAlertAction.Style.default, handler: nil))
//                self.present(alert, animated: true, completion: nil)
//            }else{
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy"
                selectedDate = formatter.string(from: datePicker.date)
                self.delegate.acceptDate!(self)
                self.dismiss(animated: true, completion: nil)
//            }
        }else if isComeFrom == "1"{
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            selectedDate = formatter.string(from: datePicker.date)
            self.delegate.acceptDate!(self)
            self.dismiss(animated: true, completion: nil)
        }else if isComeFrom == "2"{
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            selectedDate = formatter.string(from: datePicker.date)
            self.delegate.acceptDate!(self)
            self.dismiss(animated: true, completion: nil)
        }else{
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            selectedDate = formatter.string(from: datePicker.date)
            self.delegate.acceptDate!(self)
            self.dismiss(animated: true, completion: nil)
        }
        
        
    }
    @IBAction func cancelBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
