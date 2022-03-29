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
    
    typealias cHandler = ([MovieNowPlayingInfo]?,String?) -> Void
    typealias cUpComingHandler = ([MovieUpComingInfo]?, String?) -> Void
    typealias detailHandler = (MovieDetailsModel?,String?) -> Void
    
    
    //MARK: -  getMovies with types
    func fetchNowPlayingMovies(movieType: MovieTypes, completion: @escaping cHandler) {
        let endPoint = apiBaseUrl + "\(movieType.rawValue)?api_key=\(myAPIKey)" + languageAndPage
        
        let request = AF.request(endPoint)
        request.validate().responseDecodable(of: MovieNowPlayingModel.self) { response in
            
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
    
    
    //MARK: - fetch Movie Details
    func fetchDetailsMovie(id: Int, completion: @escaping detailHandler) {
        let endPoint = apiBaseUrl + "\(id)?api_key=\(myAPIKey)" + languageAndPage
        
        let request = AF.request(endPoint)
        request.validate().responseDecodable(of: MovieDetailsModel.self) { response in
            
            switch response.result {
            case .success(let movieDetailInfos):
                completion(movieDetailInfos, nil)
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
    
    
    
    //MARK: - fetch Similar Movies
    func fetchSimilarMovies(id: Int, completion: @escaping cHandler){
        let endPoint = apiBaseUrl + "\(id)/similar?api_key=\(myAPIKey)" + languageAndPage
        
        let req = AF.request(endPoint)
        req.validate().responseDecodable(of: MovieNowPlayingModel.self) { res in
            
            switch res.result {
            case .success(let movieInfos):
                completion(movieInfos.results, nil)
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
    
    // fetch Searching with api
    
}
