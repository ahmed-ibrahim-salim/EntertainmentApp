//
//  moviesModel.swift
//  NewUI-UIKit
//
//  Created by Ahmad medo on 10/05/2022.
//

import Foundation
// MARK: - MoviesModel

struct MoviesModel: Codable {
    let page: Int?
    var results: [Movie]?
    let totalPages, totalResults: Int?

}
// MARK: - Result
struct Movie: Codable {
    let adult: Bool?
    var backdropPath: String?
    let genreIDS: [Int]?
    let id: Int?
    let originalLanguage, originalTitle, overview: String?
    let popularity: Double?
    var posterPath: String?
    let releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
}
