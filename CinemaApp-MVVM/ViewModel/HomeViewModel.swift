//
//  MovieViewModel.swift
//  CinemaApp-MVVM
//
//  Created by ugur-pc on 25.03.2022.
//

import Foundation


protocol HomeViewModelProtocol {
    func fetchItems()
    func changeLoading()
    
    
    var movieInfoList: [MovieInfo] { get set }
    var movieWebService: MovieService {get}
    var movieOutPut: MovieOutPutProtocol? {get}
    
    func setDelegate(output: MovieOutPutProtocol)
}



final class HomeViewModel: HomeViewModelProtocol {
    
    private var isLoading = false
    
    var movieInfoList: [MovieInfo] = []
    var movieWebService: MovieService
    var movieOutPut: MovieOutPutProtocol?
    
    
    init() {
        movieWebService = MovieService()
    }
    
    
    func setDelegate(output: MovieOutPutProtocol) {
        movieOutPut = output
    }
   
    
    // FETCH
    func fetchItems() {
        changeLoading()
        
        movieWebService.fetchMovies(movieType: .nowPlaying) { [weak self] response, error in
           
            self?.changeLoading()
            
            guard error == nil else {
                print(error!)
                return
            }
            
            self?.movieInfoList = response ?? []
            print("RESPONSE -> ",self?.movieInfoList ?? "empty")
            self?.movieOutPut?.saveMovieDatas(listValues: self?.movieInfoList ?? [])
            
        }
    }
    
    
    func changeLoading() {
        isLoading = !isLoading
        movieOutPut?.changeLoading(isLoad: isLoading)
    }
}
