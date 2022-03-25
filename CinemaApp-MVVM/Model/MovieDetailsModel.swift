// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

struct MovieDetailsModel : Decodable {
    public var adult : Bool?
    public var backdropPath : String?
    public var belongsToCollection : MovieDetailBelongsCollection?
    public var budget : Int?
    public var genres : [MovieDetailGenres]?
    public var id : Int?
    public var homepage : String?
    public var imdbId : String?
    public var originalLanguage : String?
    public var originalTitle : String?
    public var overview : String?
    public var popularity: Double?
    public var posterPath : String?
    public var releaseDate : String?
    public var productionCompanies : [MovieDetailProdictionComponies]?
    public var productionCountries : [MovieDetailProdictionCountries]?
    public var title : String?
    public var revenue : Int?
    public var runtime : Int?
    public var video: Bool?
    public var spokenLanguages : [MovieDetailProdictionCountries]?
    public var voteAverage : Double?
    public var status : String?
    public var tagline : String?
    public var voteCount : Int?
    
    enum CodingKeys: String, CodingKey {
        case adult = "adult"
        case backdropPath = "backdrop_path"
        case belongsToCollection = "belongs_to_collection"
        case budget, genres, homepage, id
        case imdbId = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue, runtime
        case spokenLanguages = "spoken_languages"
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        
    }
}


public struct MovieDetailGenres : Decodable {
    public var englishName : String?
    public var iso639 : String?
    public var name : String?
    enum CodingKeys: String, CodingKey {
       case englishName = "english_name"
        case iso639 = "iso_639_1"
        case name  = "name"
        
  
    }
}
public struct MovieDetailSpokenLanguages : Decodable {
    public var id : Int?
    public var name : String?
}
public struct MovieDetailProdictionComponies : Decodable {
    public var id : Int?
    public var name : String?
    public var logoPath : String?
    public var originCountry : String?
    
    enum CodingKeys: String, CodingKey {
       case id = "id"
        case name = "name"
        case logoPath  = "logo_path"
        case originCountry  = "origin_country"
  
    }
    
}

public struct MovieDetailBelongsCollection : Decodable {
    public var id : Int?
    public var name : String?
    public var posterPath : String?
    public var backdropPath : String?
    enum CodingKeys: String, CodingKey {
       case id = "id"
        case name = "name"
        case posterPath  = "poster_path"
        case backdropPath  = "backdrop_path"
  
    }
}
public struct MovieDetailProdictionCountries : Decodable {
    public var iso3166 : String?
    public var name : String?

    
    enum CodingKeys: String, CodingKey {
       case iso3166 = "iso_3166_1"
        case name = "name"
    
  
    }
    
}
