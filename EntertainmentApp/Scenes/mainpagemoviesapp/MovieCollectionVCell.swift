//
//  MovieCollectionVCell.swift
//  EntertainmentApp
//
//  Created by Ahmad medo on 15/07/2022.
//

import UIKit
import SDWebImage

class MovieCollectionVCell: UICollectionViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureCell(movie:Movie){
        movieImage.layer.cornerRadius = 8
        movieImage.sd_setImage(with: URL(string: movie.posterPath ?? "no image"), completed: nil)
    }
}
