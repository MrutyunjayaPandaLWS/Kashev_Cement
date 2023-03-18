//
//  KC_Language.swift
//  KeshavCement
//
//  Created by ADMIN on 30/12/2022.
//

import UIKit

class KC_LanguageVC: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    

    @IBOutlet weak var languageTableView: UITableView!
    //    @IBOutlet weak var headerLbl: UILabel!
    
    var languageListArray = ["English", "हिंदी","ಕನ್ನಡ"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.languageTableView.delegate = self
        self.languageTableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tokendata()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.languageListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "KC_LanguageTVC", for: indexPath) as! KC_LanguageTVC
        cell.selectionStyle = .none
        cell.titleLbl.text = self.languageListArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        switch String(self.languageListArray[indexPath.row]){
            
        case "English":
            UserDefaults.standard.set("1", forKey: "LanguageLocalizable")
            UserDefaults.standard.synchronize()
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_WelcomeVC") as! KC_WelcomeVC
            self.navigationController?.pushViewController(vc, animated: true)
        return
            
        case "हिंदी":
            UserDefaults.standard.set("2", forKey: "LanguageLocalizable")
            UserDefaults.standard.synchronize()
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_WelcomeVC") as! KC_WelcomeVC
            self.navigationController?.pushViewController(vc, animated: true)
            return
        case "ಕನ್ನಡ":
            UserDefaults.standard.set("3", forKey: "LanguageLocalizable")
            UserDefaults.standard.synchronize()
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "KC_WelcomeVC") as! KC_WelcomeVC
            self.navigationController?.pushViewController(vc, animated: true)
            return
        default:
            print("Error")
            return
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
//                    self.customerTypeApi()
                     }catch let parsingError {
                    print("Error", parsingError)
                }
            })
            task.resume()
        }
        }
    


    

}
