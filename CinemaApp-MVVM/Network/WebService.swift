//
//  WebService.swift
//  CinemaApp-MVVM
//
//  Created by ugur-pc on 25.03.2022.
//

import Foundation
import Alamofire

enum MovieTypes: String {
    case nowPlaying = "now_playing"
    case upComing = "upcoming"
}


final class MovieService {
    
    
    let apiBaseUrl = "https://api.themoviedb.org/3/movie/"
    let languageAndPage = "&language=en-US&page=1#"
    let myAPIKey = "6fe8370265c396656c58d7dd9ff3e712"
    
    typealias cHandler = ([MovieInfo]?,String?) -> Void
    typealias cUpComingHandler = ([MovieUpComingInfo]?, String?) -> Void
    typealias detailHandler = ([MovieDetailsModel]?,String?) -> Void
    
    
    //MARK: -  getMovies with types
    func fetchNowPlayingMovies(movieType: MovieTypes, completion: @escaping cHandler) {
        let endPoint = apiBaseUrl + "\(movieType.rawValue)?api_key=\(myAPIKey)" + languageAndPage
        
        let request = AF.request(endPoint)
        request.validate().responseDecodable(of: MovieModel.self) { response in
            
            switch response.result {
            case .success(let movieInfos):
                    completion(movieInfos.results, nil)
            case .failure(let error):
                    completion(nil, error.localizedDescription)
            }
        }
    }
    
    //MARK: - get Now
    func fetchUpComingMovies(movieType: MovieTypes, completion: @escaping cUpComingHandler) {
        let endPoint = apiBaseUrl + "\(movieType.rawValue)?api_key=\(myAPIKey)" + languageAndPage
        
        let request = AF.request(endPoint)
        request.validate().responseDecodable(of: MovieUpComingModel.self) { response in
            
            switch response.result {
            case .success(let movieInfos):
                    completion(movieInfos.results, nil)
            case .failure(let error):
                    completion(nil, error.localizedDescription)
            }
        }
    }
}
