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
            cell.queryStatus.backgroundColor = #colorLiteral(red: 0.1254901961, green: 0.6745098039, blue: 0.2901960784, alpha: 1)
            cell.queryStatus.text = self.VM.queryListArray[indexPath.row].ticketStatus ?? ""
            cell.widthConstraint.constant = 100
            
        }else if self.VM.queryListArray[indexPath.row].ticketStatus ?? "" == "Resolved"{
            cell.queryStatus.backgroundColor = #colorLiteral(red: 0.1254901961, green: 0.6745098039, blue: 0.2901960784, alpha: 1)
            cell.queryStatus.text = self.VM.queryListArray[indexPath.row].ticketStatus ?? ""
            cell.widthConstraint.constant = 100
        }else if self.VM.queryListArray[indexPath.row].ticketStatus ?? "" == "Pending"{
            cell.queryStatus.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
            cell.queryStatus.text = self.VM.queryListArray[indexPath.row].ticketStatus ?? ""
            cell.widthConstraint.constant = 100
        }else if self.VM.queryListArray[indexPath.row].ticketStatus ?? "" == "Delivered"{
            cell.queryStatus.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
            cell.queryStatus.text = self.VM.queryListArray[indexPath.row].ticketStatus ?? ""
            cell.widthConstraint.constant = 100
        }else if self.VM.queryListArray[indexPath.row].ticketStatus ?? "" == "Rejected"{
            cell.queryStatus.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            cell.queryStatus.text = self.VM.queryListArray[indexPath.row].ticketStatus ?? ""
            cell.widthConstraint.constant = 100
        }else if self.VM.queryListArray[indexPath.row].ticketStatus ?? "" == "Approved"{
            cell.queryStatus.backgroundColor = #colorLiteral(red: 0.1254901961, green: 0.6745098039, blue: 0.2901960784, alpha: 1)
            cell.queryStatus.text = self.VM.queryListArray[indexPath.row].ticketStatus ?? ""
            cell.widthConstraint.constant = 100
        }else{
            if self.VM.queryListArray[indexPath.row].ticketStatus ?? "" == ""{
                cell.queryStatus.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.8274509804, blue: 0.2509803922, alpha: 1)
                cell.widthConstraint.constant = 100
                cell.queryStatus.text = self.VM.queryListArray[indexPath.row].ticketStatus ?? ""
            }else{
                cell.queryStatus.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.8274509804, blue: 0.2509803922, alpha: 1)
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
        vc.helptopicid = self.VM.queryListArray[indexPath.row].helpTopicID ?? 0
        vc.helptopicName = self.VM.queryListArray[indexPath.row].helpTopic ?? ""
        vc.helptopicdetails = self.VM.queryListArray[indexPath.row].querySummary ?? ""
        vc.querydetails = self.VM.queryListArray[indexPath.row].queryDetails ?? ""
        vc.querysummary = self.VM.queryListArray[indexPath.row].querySummary ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
