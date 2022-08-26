//
//  MovieSettingsVC.swift
//  NewUI-UIKit
//
//  Created by Ahmad medo on 10/05/2022.
//

import UIKit
import SDWebImage

class MovieSettingsVC: UIViewController {
    
    @IBOutlet var settingTableV: UITableView!
    @IBOutlet weak var profileNameLbl: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    var settingsMenuLabels = [String]()
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setPageStrings()
        profileImageRequest()
        setSettingsTableView()
        
    }
    
    // MARK: - Functions
    func setSettingsTableView(){
        self.settingTableV.register(UINib(nibName: "SettingsTViewCell", bundle: nil), forCellReuseIdentifier: "settingsmenucell")
        settingTableV.delegate = self
        settingTableV.dataSource = self
    }
    
    func setPageStrings()  {
        self.navigationItem.title = "Settings".localized
        self.profileNameLbl.text = "Ahmed Ibrahim Salem"
        self.settingsMenuLabels = ["Language".localized,"Privacy Policy".localized,"Favourites".localized]
        
    }
    
    func profileImageRequest(){
        let imageUrl = URL(string: "https://www.themoviedb.org/t/p/w150_and_h150_face/nFxoNlP2ouZRWH8gjSXtVWeoNFq.jpg")
        self.profileImage.sd_setImage(with: imageUrl, completed: nil)
        self.profileImage.layer.cornerRadius = 65
    }

}

// MARK: - Extensions
extension MovieSettingsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsMenuLabels.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = settingTableV.dequeueReusableCell(withIdentifier: "settingsmenucell") as? SettingsTViewCell{
            cell.settingsMenuLbl.text = settingsMenuLabels[indexPath.row]
            // no gery background when selected
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sheetController = SheetVController()
        if indexPath.row == 0{
            
            // open setting -> language
//            UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)

            self.present(sheetController, animated: false, completion:{})
        }else if indexPath.row == 2{
            let vc = self.handleStoryBoards(sbName: "MoviesMain", ID: "favourites", navTitle: "Favourites".localized) as? FavouritesVC ?? UIViewController()
            navigationController?.pushViewController(vc, animated: true)        }
        
    }
    
    
}
