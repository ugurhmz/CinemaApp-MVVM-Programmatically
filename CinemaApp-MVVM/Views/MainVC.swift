//
//  ViewController.swift
//  CinemaApp-MVVM
//
//  Created by ugur-pc on 25.03.2022.
//

import UIKit


protocol MovieOutPutProtocol {
    func changeLoading(isLoad: Bool)
    func saveMovieDatas(listValues: [MovieInfo])
}



class MainVC: UIViewController {

    private lazy var movieList: [MovieInfo] = []
    lazy var viewModel = HomeViewModel()
    private let indicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    
    
    
    // General CollectionView
    private let generalCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
      
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .black
        
        //register cells
        cv.register(HomeTopCell.self,
                    forCellWithReuseIdentifier: HomeTopCell.identifier)
        cv.register(HomeBottomListCell.self,
                    forCellWithReuseIdentifier: HomeBottomListCell.identifier)
        
        return cv
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        //viewModel delegate
        viewModel.setDelegate(output: self)
        viewModel.fetchItems()
        
    }
    
    func setupViews() {
        view.addSubview(generalCollectionView)
        view.addSubview(indicator)
        setGeneralCollectionViewConstraints()
        
        generalCollectionView.delegate = self
        generalCollectionView.dataSource = self
        
        indicator.startAnimating()
    }


}


//MARK: - MovieOutPutProtocol
extension MainVC: MovieOutPutProtocol {
    
    func changeLoading(isLoad: Bool) {
        isLoad ? indicator.startAnimating() : indicator.stopAnimating()
    }
    
    func saveMovieDatas(listValues: [MovieInfo]) {
        self.movieList = listValues
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
            generalCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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
        
        return  self.movieList.count
    }
    
    
    // cellForItemAt
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Top
        if indexPath.section == 0 {
            
            let topCell = generalCollectionView.dequeueReusableCell(withReuseIdentifier: HomeTopCell.identifier, for: indexPath) as! HomeTopCell
            
            topCell.setX(model: movieList)
            
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
        
        bottomListCell.saveModel(model: movieList[indexPath.item])
       
        
        return bottomListCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if section == 1 {
            return 25
        }
        return .zero
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
        
        return UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }
    
   
}
