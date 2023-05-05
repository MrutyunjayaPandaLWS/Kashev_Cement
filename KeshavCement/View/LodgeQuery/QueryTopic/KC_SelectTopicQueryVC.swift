//
//  HR_SelectTopicQueryVC.swift
//  HR_Johnson
//
//  Created by ArokiaIT on 2/10/22.
//

import UIKit
import LanguageManager_iOS
protocol QueryTopicDelegate {
    func selectedTopic(_ vc: KC_SelectTopicQueryVC)
}
class KC_SelectTopicQueryVC: BaseViewController{

    
   // func popupAlertDidTap(_ vc: HR_PopUpVC) {}
    

    @IBOutlet weak var queryHeader: UILabel!
    @IBOutlet weak var queryCategoryListTableView: UITableView!
    @IBOutlet weak var topicView: UIView!
//
//    @IBOutlet weak var queryCateogryHeightConstraint: NSLayoutConstraint!
//    @IBOutlet weak var topicViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var nodatafound: UILabel!
//    var topicImageArray = ["s1", "s2", "s3", "s4","s5", "s6", "s7", "s8", "s9"]
    var delegate: QueryTopicDelegate!
//    var userId = UserDefaults.standard.string(forKey: "UserID") ?? ""
//    var loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyId") ?? ""
    var seletedTopic = ""
    var selectedID = 0
//    var helptopicArray = [ObjHelpTopicList]()
//    var requestAPIs = RestAPI_Requests()
    var VM = KC_QueryTopicListVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.nodatafound.isHidden = true
        self.queryHeader.text = "selectTopicQuery".localiz()
        self.nodatafound.text = "NoDataFound".localiz()
        self.queryCategoryListTableView.delegate = self
        self.queryCategoryListTableView.dataSource = self

       
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
        {
            let touch = touches.first
            if touch?.view != self.queryCategoryListTableView
            {
                self.dismiss(animated: true, completion: nil) }
        }
    override func viewWillAppear(_ animated: Bool) {
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                self.view.makeToast("No internet connection!!", duration: 2.0, position: .bottom)
            }
        }else{
            self.queryTopicListApi()
        }
    }
    
    func queryTopicListApi(){
        
        let parameter = [
            "ActorId": "\(self.userID)",
            "IsActive": "true",
            "ActionType": "4"
        ] as [String: Any]
        self.VM.queryTopicListAPI(parameter: parameter)
    }
    

//    func helptopicAPI(){
//        self.startLoading()
//        let parameters = [
//            "ActionType":"4",
//            "IsActive":"true"
//        ] as [String:Any]
//        print(parameters)
//        self.requestAPIs.helptopic_Post_API(parameters: parameters) { (result, error) in
//            if error == nil {
//                if result != nil{
//                    DispatchQueue.main.async {
//                        self.helptopicArray = (result?.objHelpTopicList ?? [])
//                        print(self.helptopicArray.count, "Help Topic Count")
//
//                        if self.helptopicArray.count == 0{
//                            self.queryCategoryListTableView.isHidden = true
//                            self.nodatafound.isHidden = false
//                        }else{
//                            self.queryCategoryListTableView.isHidden = false
//                            self.nodatafound.isHidden = true
//                            self.queryCategoryListTableView.reloadData()
//                        }
//                       self.stopLoading()
//                    }
//                }else{
//                    print("NO RESPONSE")
//                    DispatchQueue.main.async {
//                        self.stopLoading()
//                    }
//                }
//            }else{
//                print("ERROR_GOODPACK \(error)")
//                DispatchQueue.main.async {
//                    self.stopLoading()
//                }
//
//            }
//        }
//    }
}
extension KC_SelectTopicQueryVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VM.queryTopicListArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "HR_QueryTopicTVC", for: indexPath) as! HR_QueryTopicTVC
        cell.selectionStyle = .none
        cell.queryTopic.text = self.VM.queryTopicListArray[indexPath.row].helpTopicName ?? ""
      //  cell.categoryImg.image = UIImage(named: "\(self.topicImageArray[indexPath.row])")
        return cell

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        self.seletedTopic = self.VM.queryTopicListArray[indexPath.row].helpTopicName ?? ""
        self.selectedID =  self.VM.queryTopicListArray[indexPath.row].helpTopicId ?? -1
        self.delegate.selectedTopic(self)
        self.dismiss(animated: true, completion: nil)
      
      
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }



}
