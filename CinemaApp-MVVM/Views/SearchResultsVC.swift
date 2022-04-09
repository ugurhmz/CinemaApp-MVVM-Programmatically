//
//  SearchResultsVC.swift
//  CinemaApp-MVVM
//
//  Created by ugur-pc on 8.04.2022.
//

import UIKit
import Kingfisher

protocol SearchMovieOutPutProtocol {
    func saveSearchingResult(movieValues: [MovieUpComingInfo])
}



class SearchResultsVC: UIViewController {
    
    public var resultList: [MovieUpComingInfo] = []
  
    
    public var searchResultsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: SearchResultsVC.createCompositionalLayout())
        cv.register(CompositonalCustomCell.self,
                    forCellWithReuseIdentifier: CompositonalCustomCell.identifier)
        
        cv.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    
    
    static func createCompositionalLayout() ->  UICollectionViewCompositionalLayout {
        let mylayout = UICollectionViewCompositionalLayout { (index, enviroment) -> NSCollectionLayoutSection? in
            return SearchResultsVC.createSectionFor(index: index, envr: enviroment)
            
        }
        return mylayout
    }
    
    static func createSectionFor(index: Int, envr: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        return createThirdSection()
    }
    
    
    //MARK: - THIRD SECTION
    static func createThirdSection() -> NSCollectionLayoutSection {
        let inset: CGFloat = 2.5
        
        // items
        let smallItemSize  = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .fractionalHeight(0.5))
        let smallItem = NSCollectionLayoutItem(layoutSize: smallItemSize)
        smallItem.contentInsets = NSDirectionalEdgeInsets(top: inset,
                                                          leading: inset,
                                                          bottom: inset,
                                                          trailing: inset)
        let largeItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                   heightDimension: .fractionalHeight(1))
        let largeItem = NSCollectionLayoutItem(layoutSize: largeItemSize)
        largeItem.contentInsets = NSDirectionalEdgeInsets(top: inset,
                                                          leading: inset,
                                                          bottom: inset,
                                                          trailing: inset)
        
        // group
        let verticalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25),
                                                       heightDimension: .fractionalHeight(1))
        let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: verticalGroupSize,
                                                             subitems: [smallItem])
        
        let horizontalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                         heightDimension: .fractionalHeight(0.6))
        let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: horizontalGroupSize, subitems: [largeItem, verticalGroup, verticalGroup])
        
        
        // section
        let section = NSCollectionLayoutSection(group: horizontalGroup)
        section.orthogonalScrollingBehavior = .groupPaging
        
//        // suplementary
//        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
//                                                heightDimension: .absolute(44))
//        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
//                                                                 elementKind: "header",
//                                                                 alignment: .bottom)
//        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    public func configure(model: [MovieUpComingInfo]) {
        print("mymodel",model)
        self.resultList = model
       
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
       
    }
    
    
    
    
    private func setupViews(){
        [searchResultsCollectionView].forEach{ view.addSubview($0)}
        
        searchResultsCollectionView.collectionViewLayout =  SearchResultsVC.createCompositionalLayout()
            setConstraints()
        searchResultsCollectionView.dataSource = self
        searchResultsCollectionView.delegate = self
        }
    

   

}


//MARK: - Constraints
extension SearchResultsVC {
    
    private func setConstraints(){
        
        NSLayoutConstraint.activate([
            searchResultsCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            searchResultsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchResultsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchResultsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
    }
}


//MARK: - DataSource
extension SearchResultsVC: UICollectionViewDataSource, UICollectionViewDelegate{
    
    // numberOfSections
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    // numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {

            return self.resultList.count
     
    }
    
    
    // cellForItemAt
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = searchResultsCollectionView.dequeueReusableCell(withReuseIdentifier: CompositonalCustomCell.identifier,
                                                             for: indexPath) as! CompositonalCustomCell
        
        
        let mymodel = resultList[indexPath.row]
       
        cell.configure(with: mymodel.posterPath ?? "")
        
//        // RANDOM COLORS
//        cell.backgroundColor =   UIColor(hue: CGFloat(drand48()),
//                                         saturation: 1,
//                                         brightness: 1,
//                                         alpha: 1)
        cell.layer.borderWidth = 0.7
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.cornerRadius = 8
        cell.layer.shadowColor = UIColor.white.cgColor
        cell.layer.shadowPath = UIBezierPath(rect: cell.bounds).cgPath
        cell.layer.shadowRadius = 3
        cell.layer.shadowOffset = .zero
        cell.layer.shadowOpacity = 0.6
        
        return cell
    }
  
    
    
}



