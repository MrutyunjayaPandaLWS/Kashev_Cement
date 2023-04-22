//
//  HistoryNotificationsViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit
import Lottie
import SDWebImage
//import Firebase

class HistoryNotificationsViewController: BaseViewController {
    
    @IBOutlet weak var expandedview: UIView!
    @IBOutlet weak var animationLottieView: AnimationView!
    private var animationView: AnimationView?
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var NotificationstableView: UITableView!
    @IBOutlet weak var noDataFound: UILabel!
    
    @IBOutlet weak var expandedimageview: UIImageView!
    @IBAction func closeexpandedview(_ sender: Any) {
        expandedview.isHidden = true
    }
    
//    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
//    let loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyID") ?? ""
    var VM = HistoryNotificationsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        expandedview.isHidden = true
        self.noDataFound.isHidden = true
        self.NotificationstableView.register(UINib(nibName: "HistoryNotificationsTableViewCell", bundle: nil), forCellReuseIdentifier: "HistoryNotificationsTableViewCell")
        notificationListApi()
        self.NotificationstableView.delegate = self
        self.NotificationstableView.dataSource = self
        languagelocalization()
        self.noDataFound.textColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "My Notifications")
//
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])

        
    }
    
    func playAnimation(){
        animationView = .init(name: "lf30_editor_jh47f7lt")
          animationView!.frame = animationLottieView.bounds
          // 3. Set animation content mode
          animationView!.contentMode = .scaleAspectFit
          // 4. Set animation loop mode
          animationView!.loopMode = .loop
          // 5. Adjust animation speed
          animationView!.animationSpeed = 0.5
        animationLottieView.addSubview(animationView!)
          // 6. Play animation
          animationView!.play()

    }
    
    func languagelocalization(){
        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
            self.header.text = "Notification"
            
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
            self.header.text = "अधिसूचना"
            
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
            self.header.text = "বিজ্ঞপ্তি"
        }else{
            self.header.text = "Notification"
        }
    }
    
    func notificationListApi(){
        let parameters = [
            "ActionType": 0,
            "ActorId": self.userID,
            "LoyaltyId": self.loyaltyId
        ] as [String: Any]
        print(parameters)
        self.VM.notificationListApi(parameters: parameters)
        
    }
    
    @IBAction func backBTN(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension HistoryNotificationsViewController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VM.notificationListArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryNotificationsTableViewCell") as! HistoryNotificationsTableViewCell
        cell.createdDate.text = self.VM.notificationListArray[indexPath.row].jCreatedDate ?? ""
        cell.notificationHeader.text = self.VM.notificationListArray[indexPath.row].title ?? ""
        cell.notificationMessage.text = self.VM.notificationListArray[indexPath.row].pushMessage ?? ""
        let receivedImage = String(self.VM.notificationListArray[indexPath.row].imagesURL ?? "")
        cell.notificationImg.sd_setImage(with: URL(string: PROMO_IMG + receivedImage), placeholderImage: UIImage(named: "no_image1.jpg"))
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if  self.VM.notificationListArray[indexPath.item].imagesURL != nil {
            var secondaryIMG = self.VM.notificationListArray[indexPath.item].imagesURL ?? ""
//            let splited = secondaryIMG.components(separatedBy: "~")
//            print("\(PROMO_IMG)\(splited[1])")
            expandedimageview.sd_setImage(with: URL(string: "\(PROMO_IMG)\(secondaryIMG)"), placeholderImage: UIImage(named: "no_image1.jpg"))
            expandedview.isHidden = false
            return
        }else{
            return
        }

    }
}
