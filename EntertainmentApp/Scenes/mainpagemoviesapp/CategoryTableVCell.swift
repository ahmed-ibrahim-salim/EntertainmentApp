//
//  CategoryCell.swift
//  EntertainmentApp
//
//  Created by Ahmad medo on 15/07/2022.
//

import UIKit

class CategoryTableVCell: UITableViewCell {

    @IBOutlet weak var categoryCollectionV: UICollectionView!
    
    var collectionDataSource: [Movie]?{
        didSet{
            categoryCollectionV.reloadData()
        }
    }
    
//    var collectionDataSource = [UIImage(systemName: "sun.min"),UIImage(systemName: "sun.max.circle"),UIImage(systemName: "sunrise")]
//
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionV()

        // Initialization code
    }
    func configureCell(data:[Movie]?){
        collectionDataSource = data
    }
    func setUpCollectionV(){
        categoryCollectionV.delegate = self
        categoryCollectionV.dataSource = self
        categoryCollectionV.register(UINib(nibName: "MovieCollectionVCell", bundle: nil), forCellWithReuseIdentifier: "MovieCollectionVCell")
    }
}

extension CategoryTableVCell: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionDataSource?.count ?? 1
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionVCell", for: indexPath) as? MovieCollectionVCell
        
        guard let newCell = cell else{return UICollectionViewCell()}
        
//        newCell.movieImage.image = collectionDataSource?[indexPath.row]
        
        if let movie = collectionDataSource?[indexPath.row]{
            newCell.configureCell(movie: movie)
        }
        
        return newCell
    }
    
}
