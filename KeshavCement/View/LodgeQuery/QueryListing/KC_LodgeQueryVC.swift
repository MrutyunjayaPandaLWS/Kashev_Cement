//
//  KC_LodgeQueryVC.swift
//  KeshavCement
//
//  Created by ADMIN on 16/01/2023.
//

import UIKit
import LanguageManager_iOS

class KC_LodgeQueryVC: BaseViewController{
//, QueryTopicDelegate{
//    func selectedTopic(_ vc: KC_SelectTopicQueryVC) {
//        let vc1 = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier:  "KC_AddLodgeQueryVC") as! KC_AddLodgeQueryVC
//        vc1.selectedQueryTopic = vc.seletedTopic
//        vc1.selectedQueryID = vc.selectedID
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//
    

    @IBOutlet weak var queryHeaderLbl: UILabel!
    @IBOutlet weak var lodgeQueryTableView: UITableView!
    
    var VM = KC_QueryListVM()
    var selectedQueryTopic = ""
    var selectedQueryID = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.lodgeQueryTableView.delegate = self
        self.lodgeQueryTableView.dataSource = self
        self.queryHeaderLbl.text = "Query".localiz()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.VM.queryListArray.removeAll()
        self.queryListApi()
    }
 
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func createNewQueryBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier:  "KC_AddLodgeQueryVC") as! KC_AddLodgeQueryVC
        self.navigationController?.pushViewController(vc, animated: true)
//        vc.delegate = self
//        vc.modalTransitionStyle = .coverVertical
//        vc.modalPresentationStyle = .overFullScreen
//        self.present(vc, animated: true)
    }
    
    func queryListApi(){
        
        let parameter = [
            "ActionType": 1,
            "ActorId": "\(self.userID)"
        ] as [String: Any]
        print(parameter)
        self.VM.queryListAPI(parameter: parameter)
    }
    
}
extension KC_LodgeQueryVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VM.queryListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "KC_LodgeQueryTVC", for: indexPath) as! KC_LodgeQueryTVC
        if self.VM.queryListArray[indexPath.row].ticketStatus ?? "" == "Closed"{
            cell.queryStatus.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
            cell.queryStatus.textColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
            cell.queryStatus.text = self.VM.queryListArray[indexPath.row].ticketStatus ?? ""
            cell.widthConstraint.constant = 100
            
        }else if self.VM.queryListArray[indexPath.row].ticketStatus ?? "" == "Resolved"{
            cell.queryStatus.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
            cell.queryStatus.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            cell.queryStatus.text = self.VM.queryListArray[indexPath.row].ticketStatus ?? ""
            cell.widthConstraint.constant = 100
        }else if self.VM.queryListArray[indexPath.row].ticketStatus ?? "" == "Pending"{
            cell.queryStatus.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
            cell.queryStatus.textColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
            cell.queryStatus.text = self.VM.queryListArray[indexPath.row].ticketStatus ?? ""
            cell.widthConstraint.constant = 100
        }else if self.VM.queryListArray[indexPath.row].ticketStatus ?? "" == "Delivered"{
            cell.queryStatus.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
            cell.queryStatus.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            cell.queryStatus.text = self.VM.queryListArray[indexPath.row].ticketStatus ?? ""
            cell.widthConstraint.constant = 100
        }else if self.VM.queryListArray[indexPath.row].ticketStatus ?? "" == "Rejected"{
            cell.queryStatus.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            cell.queryStatus.textColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
            cell.queryStatus.text = self.VM.queryListArray[indexPath.row].ticketStatus ?? ""
            cell.widthConstraint.constant = 100
        }else if self.VM.queryListArray[indexPath.row].ticketStatus ?? "" == "Approved"{
            cell.queryStatus.backgroundColor = #colorLiteral(red: 0.1254901961, green: 0.6745098039, blue: 0.2901960784, alpha: 1)
            cell.queryStatus.textColor = #colorLiteral(red: 0.9725490212, green: 0.9725490212, blue: 0.9725490212, alpha: 1)
            cell.queryStatus.text = self.VM.queryListArray[indexPath.row].ticketStatus ?? ""
            cell.widthConstraint.constant = 100
        }else if self.VM.queryListArray[indexPath.row].ticketStatus ?? "" == "Out for Delivery"{
            cell.queryStatus.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
            cell.queryStatus.textColor = #colorLiteral(red: 0.9725490212, green: 0.9725490212, blue: 0.9725490212, alpha: 1)
            cell.queryStatus.text = self.VM.queryListArray[indexPath.row].ticketStatus ?? ""
            cell.widthConstraint.constant = 100
        }else if self.VM.queryListArray[indexPath.row].ticketStatus ?? "" == "Posted for approval"{
            cell.queryStatus.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
            cell.queryStatus.textColor = #colorLiteral(red: 0.9725490212, green: 0.9725490212, blue: 0.9725490212, alpha: 1)
            cell.queryStatus.text = self.VM.queryListArray[indexPath.row].ticketStatus ?? ""
            cell.widthConstraint.constant = 100
        }else if self.VM.queryListArray[indexPath.row].ticketStatus ?? "" == "Posted for approval 2"{
            cell.queryStatus.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
            cell.queryStatus.textColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
            cell.queryStatus.text = self.VM.queryListArray[indexPath.row].ticketStatus ?? ""
            cell.widthConstraint.constant = 100
        }else if self.VM.queryListArray[indexPath.row].ticketStatus ?? "" == "Cancel Request"{
            cell.queryStatus.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
            cell.queryStatus.textColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
            cell.queryStatus.text = self.VM.queryListArray[indexPath.row].ticketStatus ?? ""
            cell.widthConstraint.constant = 100
        }else if self.VM.queryListArray[indexPath.row].ticketStatus ?? "" == "Re-Open"{
            cell.queryStatus.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
            cell.queryStatus.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            cell.queryStatus.text = self.VM.queryListArray[indexPath.row].ticketStatus ?? ""
            cell.widthConstraint.constant = 100
        }else if self.VM.queryListArray[indexPath.row].ticketStatus ?? "" == "Resolved-Follow Up"{
            cell.queryStatus.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
            cell.widthConstraint.constant = 140
            cell.queryStatus.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            cell.queryStatus.text = self.VM.queryListArray[indexPath.row].ticketStatus ?? ""
//            cell.widthConstraint.constant = 100
        }else{
            if self.VM.queryListArray[indexPath.row].ticketStatus ?? "" == ""{
                cell.queryStatus.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.8274509804, blue: 0.2509803922, alpha: 1)
                cell.queryStatus.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
                cell.widthConstraint.constant = 100
                cell.queryStatus.text = self.VM.queryListArray[indexPath.row].ticketStatus ?? ""
            }else{
                cell.queryStatus.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.8274509804, blue: 0.2509803922, alpha: 1)
                cell.queryStatus.textColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
                cell.widthConstraint.constant = 140
                cell.queryStatus.text = self.VM.queryListArray[indexPath.row].ticketStatus ?? ""
            }


        }
        
        cell.queryInfo.text = "  \(self.VM.queryListArray[indexPath.row].helpTopic ?? "")"
        cell.queryId.text = self.VM.queryListArray[indexPath.row].customerTicketRefNo ?? ""
        let strDate = self.VM.queryListArray[indexPath.row].jCreatedDate ?? "01/01/0001  00:00:00"
        print(strDate)
        let array = strDate.components(separatedBy: " ")
        cell.queryDate.text = "\(array[0])"
        cell.queryTime.text = "\(array[1])"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_Chatvc2ViewController") as! HR_Chatvc2ViewController
        vc.CustomerTicketIDchatvc = self.VM.queryListArray[indexPath.row].customerTicketID ?? 0
        print(vc.CustomerTicketIDchatvc, "CustomerChat ID")
        vc.queryStatus = self.VM.queryListArray[indexPath.row].ticketStatus ?? ""
        vc.helptopicid = self.VM.queryListArray[indexPath.row].helpTopicID ?? 0
        vc.helptopicName = self.VM.queryListArray[indexPath.row].helpTopic ?? ""
        vc.helptopicdetails = self.VM.queryListArray[indexPath.row].querySummary ?? ""
        vc.querydetails = self.VM.queryListArray[indexPath.row].queryDetails ?? ""
        vc.querysummary = self.VM.queryListArray[indexPath.row].querySummary ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
