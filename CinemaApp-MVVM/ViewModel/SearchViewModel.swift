//
//  SearchViewModel.swift
//  CinemaApp-MVVM
//
//  Created by ugur-pc on 9.04.2022.
//

import Foundation

protocol SearchViewModelProtocol {
    func setSearchDelegate(output: SearchMovieOutPutProtocol)
    var searchOutPut: SearchMovieOutPutProtocol? { get }
}


final class SearchViewModel: SearchViewModelProtocol {
    var searchOutPut: SearchMovieOutPutProtocol?
    var movieWebService: MovieService
    var resultCont: SearchCompositionalResultsVC?
    
    
    init(){
        movieWebService = MovieService()
    }
    
    
    func setSearchDelegate(output: SearchMovieOutPutProtocol) {
        searchOutPut = output
    }
    

//    // getSearch
//    func getSearch(with query: String){
//        movieWebService.getSearch(with: query) { [weak self] result, error in
//           
//            guard let self = self else {return }
//                       
//            print("myresult",result)
//            
//           }
//           
//    }
}
    
    

