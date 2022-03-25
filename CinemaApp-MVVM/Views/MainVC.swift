//
//  ViewController.swift
//  CinemaApp-MVVM
//
//  Created by ugur-pc on 25.03.2022.
//

import UIKit

class MainVC: UIViewController {

    
    // General CollectionView
    private let generalCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
      
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        
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
        
    }
    
    func setupViews() {
        view.addSubview(generalCollectionView)
        setGeneralCollectionViewConstraints()
        
        generalCollectionView.delegate = self
        generalCollectionView.dataSource = self
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
        
        return 3
    }
    
    
    // cellForItemAt
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Top
        if indexPath.section == 0 {
            let topCell = generalCollectionView.dequeueReusableCell(withReuseIdentifier: HomeTopCell.identifier, for: indexPath) as! HomeTopCell
            
            return topCell
        }
        
        // bottom
        let bottomListCell = generalCollectionView.dequeueReusableCell(withReuseIdentifier: HomeBottomListCell.identifier, for: indexPath) as! HomeBottomListCell
           
      
        bottomListCell.backgroundColor = .black
        
        
        return bottomListCell
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
        
        return UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
    }
}
