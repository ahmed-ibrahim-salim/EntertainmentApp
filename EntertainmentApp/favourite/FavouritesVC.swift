//
//  FavouritesVC.swift
//  NewUI-UIKit
//
//  Created by Ahmad medo on 10/05/2022.
//

import UIKit
import SDWebImage
import CoreData
class FavouritesVC: UIViewController {
    
    @IBOutlet weak var favCollectionView: UICollectionView!
    let favMoviesList = CoreDataModel().fetch(entityName: "MovieEntityCoreData")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFavCView()
    }
    
    func setFavCView(){
        self.favCollectionView.register(UINib(nibName: "FavouritesCViewCell", bundle: nil), forCellWithReuseIdentifier: "favcell")
        favCollectionView.delegate = self
        favCollectionView.dataSource = self
    }
}


extension FavouritesVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favMoviesList.count
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let sb = UIStoryboard(name: "MoviesMain", bundle: nil)
//        let vc = sb.instantiateViewController(identifier: "detailsvc") as? DetailsVC ?? UIViewController()
//        if collectionView == topratedCollectionV {
//            DetailsVC.movie = topRated?[indexPath.row]
//        }else if collectionView == popularCView {
//            DetailsVC.movie = popular?[indexPath.row]
//
//        }else if collectionView == upComingCVIew {
//            DetailsVC.movie = upcoming?[indexPath.row]
//        }
//        navigationController?.pushViewController(vc, animated: true)
//    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favcell", for: indexPath) as? FavouritesCViewCell
        
        let url = URL(string: favMoviesList[indexPath.row].value(forKey: "imageURL") as? String ?? "")
        cell?.favImage.sd_setImage(with: url, completed: nil)
        cell?.favImage.layer.cornerRadius = 15
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width/2.2, height: collectionView.bounds.height/3.5)
    }
    
}
