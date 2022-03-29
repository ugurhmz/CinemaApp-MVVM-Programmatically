//
//  MovieModel.swift
//  CinemaApp-MVVM
//
//  Created by ugur-pc on 25.03.2022.
//

import Foundation



struct MovieNowPlayingModel: Codable {
    let dates: Dates?
    let page: Int
    let results: [MovieNowPlayingInfo]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results, dates
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct MovieNowPlayingInfo: Codable {
    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
   

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount   = "vote_count"
    }
}

// MARK: - Dates
struct Dates: Codable {
    let maximum, minimum: String?
}

enum OriginalLanguage: String, Codable {
    case en = "en"
    case fr = "fr"
    case ja = "ja"
    case no = "no"
}
