//
//  MovieViewModel.swift
//  CinemaApp-MVVM
//
//  Created by ugur-pc on 25.03.2022.
//

import Foundation


protocol HomeViewModelProtocol {
    func fetchNowPlayingItems()
    func changeLoading()
    func fetchUpcomingItems()
    
    var movieNowPlayingList: [MovieNowPlayingInfo] { get set }
    var movieWebService: MovieService {get}
    var movieOutPut: MovieOutPutProtocol? {get}
    
    func setDelegate(output: MovieOutPutProtocol)
}



final class HomeViewModel: HomeViewModelProtocol {
   
    
    private var isLoading = false
    
    var movieNowPlayingList: [MovieNowPlayingInfo] = []
    var movieUpComingList: [MovieUpComingInfo] = []
    var movieWebService: MovieService
    var movieOutPut: MovieOutPutProtocol?
    
    
    init() {
        movieWebService = MovieService()
    }
    
    
    func setDelegate(output: MovieOutPutProtocol) {
        movieOutPut = output
    }
   
    
    // fetch now playing
    func fetchNowPlayingItems() {
        changeLoading()
        
        movieWebService.fetchNowPlayingMovies(movieType: .nowPlaying) { [weak self] response, error in
           
            self?.changeLoading()
            
            guard error == nil else {
                print(error!)
                return
            }
            
            self?.movieNowPlayingList = response ?? []
            self?.movieOutPut?.saveMovieNowPlayingDatas(listValues: self?.movieNowPlayingList ?? [])
            
        }
    }
    

    
    // fetch upComing
    func fetchUpcomingItems(){
        changeLoading()
        movieWebService.fetchUpComingMovies(movieType: .upComing) { [weak self] response, error in
            self?.changeLoading()
            
            guard error == nil else {
                print(error!)
                return}
            
            self?.movieUpComingList = response ??  []
          
            self?.movieOutPut?.saveMovieUpComingPlayingDatas(listValues: self?.movieUpComingList ?? [])
        }
    }
    
    
    
    
    func changeLoading() {
        isLoading = !isLoading
        movieOutPut?.changeLoading(isLoad: isLoading)
    }
}
