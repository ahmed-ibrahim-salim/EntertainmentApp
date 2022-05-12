//
//  BottomSheetController.swift
//  NewUI-UIKit
//
//  Created by Ahmad medo on 10/05/2022.
//

import UIKit
import MOLH

class SheetVController: UITableViewController {
    var langOptions = ["English","العربية","Cancel"]
//    let sheetTitle = "Please select a language:"
    
    var langSelected = false
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return langOptions.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = langOptions[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let currentLang = MOLHLanguage.currentAppleLanguage() == "en" ? "ar" : "en"
            if currentLang == "en" {
                MOLH.setLanguageTo(currentLang)
            print(currentLang)
                let defaults = UserDefaults.standard
                defaults.set("hhhh", forKey: Constants.langSelected)
                MOLH.reset()
            }else {
                dismiss(animated: true, completion: nil)
            }
        }else if indexPath.row == 1{
            let currentLang = MOLHLanguage.currentAppleLanguage() == "ar" ? "en" : "ar"
            if currentLang == "ar" {
                MOLH.setLanguageTo(currentLang)
                MOLH.setLanguageTo(currentLang)
                let defaults = UserDefaults.standard
                defaults.set("hhhh", forKey: Constants.langSelected)
            print(currentLang)

                MOLH.reset()
            }else {
                dismiss(animated: true, completion: nil)
            }
            
        }else if indexPath.row == 2{
            dismiss(animated: true, completion: nil)
        }
    }
    
}
