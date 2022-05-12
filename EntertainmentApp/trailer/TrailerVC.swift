//
//  trailerVC.swift
//  EntertainmentApp
//
//  Created by Ahmad medo on 11/05/2022.
//
import youtube_ios_player_helper
import UIKit

class TrailerVC: UIViewController, YTPlayerViewDelegate {
    
    static var movieID: String = ""
    
    @IBOutlet weak var youtubeplayer: YTPlayerView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        youtubeplayer.load(withVideoId: TrailerVC.movieID, playerVars: ["inlineplayer":1])
        
//        view.addSubview(youtubeplayer)


    }

   
}
