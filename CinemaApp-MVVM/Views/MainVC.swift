//
//  ViewController.swift
//  CinemaApp-MVVM
//
//  Created by ugur-pc on 25.03.2022.
//

import UIKit


protocol MovieOutPutProtocol {
    func changeLoading(isLoad: Bool)
    func saveMovieNowPlayingDatas(listValues: [MovieNowPlayingInfo])
    func saveMovieUpComingPlayingDatas(listValues: [MovieUpComingInfo])
}



class MainVC: UIViewController {

    private lazy var homeMovieNowPlayingList: [MovieNowPlayingInfo] = []
    private lazy var homeMovieUpComingList: [MovieUpComingInfo] = []
    lazy var viewModel = HomeViewModel()
    private let indicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var searchMode = false
    var filteredList = [MovieNowPlayingInfo]()
  
    
    // General CollectionView
    private let generalCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
      
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .lightGray
        
        
        //register cells
        cv.register(HomeTopCell.self,
                    forCellWithReuseIdentifier: HomeTopCell.identifier)
        cv.register(HomeBottomListCell.self,
                    forCellWithReuseIdentifier: HomeBottomListCell.identifier)
        
        return cv
    }()
    
//    // searchbar
//    lazy var searchController: UISearchController = {
//       let searchController = UISearchController(searchResultsController: SearchResultsVC())
//        searchController.searchBar.tintColor = .black
//        searchController.hidesNavigationBarDuringPresentation = false
//        return searchController
//    }()
    
    
    private let searchController: UISearchController = {
         let controller = UISearchController(searchResultsController: SearchResultsVC())
         controller.searchBar.placeholder = "Searching.."
         controller.searchBar.searchBarStyle = .minimal
         return controller
     }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        //viewModel delegate
        viewModel.setDelegate(output: self)
        viewModel.fetchNowPlayingItems()
        viewModel.fetchUpcomingItems()
      
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.tintColor = .white
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
   
    
    func setupViews() {
        view.addSubview(generalCollectionView)
        view.addSubview(indicator)
        setGeneralCollectionViewConstraints()
        
        generalCollectionView.delegate = self
        generalCollectionView.dataSource = self
        
        indicator.startAnimating()
        //configureSearchBarButton()
     
    }


}


//MARK: - SearchBar
extension MainVC {
    
    func configureSearchBarButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showSearchBar))
    }

    @objc func showSearchBar() {
        searchingFunc(shouldShow: true)
    }

    @objc func searchingFunc(shouldShow: Bool) {
        if shouldShow {
            // searchBar
            let searchBar = UISearchBar()
            searchBar.delegate = self
            searchBar.sizeToFit()
            searchBar.showsCancelButton = true
            searchBar.becomeFirstResponder() // icona tıklayınca searchbar focus
            searchBar.tintColor = .white
            searchBar.searchTextField.backgroundColor = .lightGray.withAlphaComponent(0.8)
            searchBar.searchTextField.textColor = .white

            navigationItem.rightBarButtonItem = nil
            navigationItem.titleView = searchBar

        } else {
            navigationItem.titleView = nil
            configureSearchBarButton()
            searchMode = false
            generalCollectionView.reloadData()
        }
    }

}


//MARK: - SearchBarDelegate
extension MainVC: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchingFunc(shouldShow: false)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty || searchBar.text == nil {
            searchMode = false
            generalCollectionView.reloadData()
            view.endEditing(true)
        } else {    // search mode ON

            searchMode = true
            
            filteredList = homeMovieNowPlayingList.filter({
                $0.title.lowercased().contains(searchText.lowercased()) as! Bool
            })

            generalCollectionView.reloadData()
        }
    }
    
}

//MARK: - MovieOutPutProtocol
extension MainVC: MovieOutPutProtocol {
    
   
    
    
    func changeLoading(isLoad: Bool) {
        isLoad ? indicator.startAnimating() : indicator.stopAnimating()
    }
    
    // now_playing
    func saveMovieNowPlayingDatas(listValues: [MovieNowPlayingInfo]) {
        self.homeMovieNowPlayingList = listValues
        generalCollectionView.reloadData()
    }
    
    // upcoming
    func saveMovieUpComingPlayingDatas(listValues: [MovieUpComingInfo]) {
        self.homeMovieUpComingList = listValues
        generalCollectionView.reloadData()
    }
    
    
}



//MARK: -  Constraints
extension MainVC {
    
    private func setGeneralCollectionViewConstraints() {
        NSLayoutConstraint.activate([
            generalCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            generalCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            generalCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            generalCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
           
        ])
    }
    
    
}



//MARK: - Delegate, DataSource
extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    
    // numberOfItemsInSection ( how many cells )
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        }
        
        return searchMode ? filteredList.count :   self.homeMovieNowPlayingList.count
    }
    
    
    // cellForItemAt
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Top
        if indexPath.section == 0 {
            
            let topCell = generalCollectionView.dequeueReusableCell(withReuseIdentifier: HomeTopCell.identifier, for: indexPath) as! HomeTopCell
            
            topCell.setX(model: homeMovieUpComingList)
            topCell.topcellDelegate = self
            return topCell
        }
        
        // bottom
        let bottomListCell = generalCollectionView.dequeueReusableCell(withReuseIdentifier: HomeBottomListCell.identifier, for: indexPath) as! HomeBottomListCell
           
      
        bottomListCell.backgroundColor = .black
      
        bottomListCell.layer.shadowColor = UIColor.white.cgColor
        bottomListCell.layer.shadowPath = UIBezierPath(rect: bottomListCell.bounds).cgPath
        bottomListCell.layer.shadowRadius = 5
        bottomListCell.layer.shadowOffset = .zero
        bottomListCell.layer.shadowOpacity = 0.8
        
        searchMode ?   bottomListCell.saveModel(model: filteredList[indexPath.item])  :
        bottomListCell.saveModel(model: homeMovieNowPlayingList[indexPath.item])
       
        
        return bottomListCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if section == 1 {
            return 8
        }
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
       
        if indexPath.section == 0 {
            print("clicked")
        }
        
        print("gelenid", homeMovieNowPlayingList[indexPath.item].id)
        let movieDetailVC = MovieDetailVC()
        movieDetailVC.myId =  homeMovieNowPlayingList[indexPath.item].id
        navigationController?.pushViewController(movieDetailVC, animated: false)
    }
    
  
    
}



//MARK: - DelegateFlowLayout
extension MainVC: UICollectionViewDelegateFlowLayout {
    
    
    // sizeForItemAt, cell -> w,h
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        // topCell
        if indexPath.section == 0 {
            return CGSize(width: generalCollectionView.frame.width,
                          height: 350)
        }
        
        // bottomListcell
        return CGSize(width: generalCollectionView.frame.width,
                      height: generalCollectionView.frame.width - 280)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
           return  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
        return UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
    }
    
   
   
}






//MARK: - HomeTopCell'den -> Buraya veri gönderimi, delegate Design Pattern
extension MainVC: HomeTopCellProtocol {
    func didPressCell(sendId: Int) {
        let movieDetailvc = MovieDetailVC()
        movieDetailvc.myId = sendId
        self.navigationController?.pushViewController(movieDetailvc, animated: true)
    }
    
    
}


extension MainVC : UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchBar = searchController.searchBar
        //print("mytext",searchBar.text)
        
        guard let query = searchBar.text,
                !query.trimmingCharacters(in: .whitespaces).isEmpty,
                query.trimmingCharacters(in: .whitespaces).count >= 3,
                          
                let resultController = searchController.searchResultsController as? SearchResultsVC else {  return}
        
      
       
        MovieService.shared.getSearch(with: query ) { res, error in
            DispatchQueue.main.async {
                 print("myres",res)
            }
        }
        
    }
    
}
