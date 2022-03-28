//
//  DetailViewModel.swift
//  CinemaApp-MVVM
//
//  Created by ugur-pc on 28.03.2022.
//

import Foundation


protocol DetailViewModelProtocol {
    func fetchMovieDetailItems(movieId: Int)
    func fechMovieSimilarItems(movieId: Int)
    func changeLoading()
    
    var movieSimilarList: [MovieNowPlayingInfo]  { get set}
    var movieWebService: MovieService {get}
    var  movieDetailOutPut: DetailOutPutProtocol? {get}
    
    func setDetailDelegate(output: DetailOutPutProtocol)
}


final class DetailViewModel: DetailViewModelProtocol {
    
    
    private var isLoading = false
    
    var movieSimilarList: [MovieNowPlayingInfo] = []
    var movieWebService: MovieService
    var movieDetailOutPut: DetailOutPutProtocol?
    
    init(){
        movieWebService = MovieService()
    }
    
    
    func setDetailDelegate(output: DetailOutPutProtocol) {
        self.movieDetailOutPut = output
    }
    
    
    // Details
    func fetchMovieDetailItems(movieId: Int) {
        changeLoading()
        
        movieWebService.fetchDetailsMovie(id: movieId) { [weak self] response, error in
            self?.changeLoading()
            
            guard error == nil else {
                print(error!)
                return
            }
            print("fetchMovieDetailItems",response!)
            self?.movieDetailOutPut?.saveMovieDetailDatas(listValues: response!)
        }
    }
    
    // Similar list
    func fechMovieSimilarItems(movieId: Int) {
        changeLoading()
        
        movieWebService.fetchSimilarMovies(id: movieId) { [weak self] response, error in
            self?.changeLoading()
            
            guard error == nil else {
                print(error!)
                return
            }
            
            self?.movieDetailOutPut?.saveSimilarMovieDatas(listValues: response!)
        }
    }
    
    
    
    
    
    
    func changeLoading() {
        isLoading = !isLoading
        movieDetailOutPut?.changeLoading(isLoad: isLoading)
    }
}
