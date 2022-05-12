//
//  handleSettingsVCS.swift
//  NewUI-UIKit
//
//  Created by ahmadibrahim on 12/11/21.
//

import Foundation
import UIKit

extension UIViewController {
    func handleStoryBoards(sbName: String,ID:String,navTitle: String) -> UIViewController {
        let sb = UIStoryboard(name: sbName, bundle: nil)
        
        let vc = sb.instantiateViewController(identifier: ID)
        
        navigationItem.backButtonTitle = ""
        vc.navigationItem.title = navTitle
        return vc
    }
}
