//
//  ViewController.swift
//  KeshavCement
//
//  Created by Arokia-M3 on 28/12/22.
//

import UIKit

class KC_WelcomeVC: BaseViewController {

    @IBOutlet weak var noDataFoundLbl: UILabel!
    @IBOutlet weak var customerTypeTableView: UITableView!
    @IBOutlet weak var welcomeLbl: UILabel!
    @IBOutlet weak var plzSelectInfoLbl: UILabel!
    @IBOutlet weak var engineerLbl: UILabel!
    @IBOutlet weak var masonLbl: UILabel!
    @IBOutlet weak var dealerLbl: UILabel!
    @IBOutlet weak var subDealerLbl: UILabel!
    @IBOutlet weak var supportExecutiveLbl: UILabel!
    var categoryTitle = ""
    var VM = KC_CustomerTypeVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.languageLocalization()
        self.noDataFoundLbl.isHidden = true
        self.customerTypeTableView.delegate = self
        self.customerTypeTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tokendata()
    }
    
    @IBAction func engineerActBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_LoginVC") as! KC_LoginVC
        vc.categoryTitle = "Engineer"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func masonActBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_LoginVC") as! KC_LoginVC
        vc.categoryTitle = "Mason"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func dealerActBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_LoginVC") as! KC_LoginVC
        vc.categoryTitle = "Dealer"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func subDealerActBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_LoginVC") as! KC_LoginVC
        vc.categoryTitle = "Sub Dealer"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func supportExecutiveActBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_LoginVC") as! KC_LoginVC
        vc.categoryTitle = "Support Executive"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func languageLocalization(){
        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
            self.welcomeLbl.text = "Welcome".localizableString(loc: "en")
            self.plzSelectInfoLbl.text = "infoText".localizableString(loc: "en")
            self.engineerLbl.text = "Engineer".localizableString(loc: "en")
            self.masonLbl.text = "Mason".localizableString(loc: "en")
            self.dealerLbl.text = "Dealer".localizableString(loc: "en")
            self.subDealerLbl.text = "SubDealer".localizableString(loc: "en")
            self.supportExecutiveLbl.text = "SupExecu".localizableString(loc: "en")
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
            self.welcomeLbl.text = "Welcome".localizableString(loc: "hi")
            self.plzSelectInfoLbl.text = "infoText".localizableString(loc: "hi")
            self.engineerLbl.text = "Engineer".localizableString(loc: "hi")
            self.masonLbl.text = "Mason".localizableString(loc: "hi")
            self.dealerLbl.text = "Dealer".localizableString(loc: "hi")
            self.subDealerLbl.text = "SubDealer".localizableString(loc: "hi")
            self.supportExecutiveLbl.text = "SupExecu".localizableString(loc: "hi")
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
            self.welcomeLbl.text = "Welcome".localizableString(loc: "kn-IN")
            self.plzSelectInfoLbl.text = "infoText".localizableString(loc: "kn-IN")
            self.engineerLbl.text = "Engineer".localizableString(loc: "kn-IN")
            self.masonLbl.text = "Mason".localizableString(loc: "kn-IN")
            self.dealerLbl.text = "Dealer".localizableString(loc: "kn-IN")
            self.subDealerLbl.text = "SubDealer".localizableString(loc: "kn-IN")
            self.supportExecutiveLbl.text = "SupExecu".localizableString(loc: "kn-IN")
        }
        
    }
    func tokendata(){
            if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            }else{
                let parameters : Data = "username=\(username)&password=\(password)&grant_type=password".data(using: .utf8)!

            let url = URL(string: tokenURL)!
            let session = URLSession.shared
            var request = URLRequest(url: url)
            request.httpMethod = "POST"

            do {
                request.httpBody = parameters
            } catch let error {
                print(error.localizedDescription)
            }
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
           
            let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

                guard error == nil else {
                    return
                }
                guard let data = data else {
                    return
                }
                do{
                    let parseddata = try JSONDecoder().decode(TokenModels.self, from: data)
                        print(parseddata.access_token ?? "")
                        UserDefaults.standard.setValue(parseddata.access_token ?? "", forKey: "TOKEN")
                    self.customerTypeApi()
                     }catch let parsingError {
                    print("Error", parsingError)
                }
            })
            task.resume()
        }
        }
    func customerTypeApi(){
        
        let parameter = [
            "ActionType":"33"
        ] as [String: Any]
        print(parameter)
        self.VM.customerTypeListApi(parameter: parameter)
        
    }
}

extension KC_WelcomeVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VM.customerTypeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "KC_WelcomeTVC", for: indexPath) as? KC_WelcomeTVC
        
        cell?.selectionStyle = .none
        cell?.titleLbl.text = self.VM.customerTypeArray[indexPath.row].attributeValue ?? ""
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_LoginVC") as! KC_LoginVC
        vc.categoryTitle = self.VM.customerTypeArray[indexPath.row].attributeValue ?? ""
        vc.categoryId = self.VM.customerTypeArray[indexPath.row].attributeId ?? -1
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
}

