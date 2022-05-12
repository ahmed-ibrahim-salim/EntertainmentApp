//
//  AppDelegate.swift
//  EntertainmentApp
//
//  Created by Ahmad medo on 10/05/2022.
//

import UIKit
import MOLH
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate, MOLHResetable {
    var window: UIWindow?
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MovieCoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                fatalError("Unresolved error, \((error as NSError).userInfo)")
            }
        })
        return container
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        MOLH.shared.activate(true)
        reset()
        return true
    }
    func reset() {
        let rootViewController: UIWindow = ((UIApplication.shared.delegate?.window)!)!
        let story = UIStoryboard(name: "MoviesMain", bundle: nil)
        let root = story.instantiateViewController(withIdentifier: "mainmovies")
        rootViewController.rootViewController = root
    }
}
