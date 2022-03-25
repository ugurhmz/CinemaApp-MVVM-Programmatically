//
//  HomeTopCell.swift
//  CinemaApp-MVVM
//
//  Created by ugur-pc on 25.03.2022.
//

import UIKit

class HomeTopCell: UICollectionViewCell {
    static var identifier = "HomeTopCell"
    
    
    // topGeneralCollectionView
    private let topGeneralCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
       
        
        // register slider
        cv.register(HomeTopSliderCell.self,
                    forCellWithReuseIdentifier: HomeTopSliderCell.identifier)
        
        return cv
    }()
    
    // pageControl
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
   
    func setupViews() {
        contentView.addSubview(topGeneralCollectionView)
        setTopGeneralCollectionView()
        
        topGeneralCollectionView.delegate = self
        topGeneralCollectionView.dataSource = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("not imp")
    }
    
}


//MARK: - Constraitns

extension HomeTopCell {
    
    private func setTopGeneralCollectionView() {
        NSLayoutConstraint.activate([
            topGeneralCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            topGeneralCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            topGeneralCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            topGeneralCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        
        ])
    }
}



//MARK: - Delegate, DataSource
extension HomeTopCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    
    
    // cellForItemAt
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = topGeneralCollectionView.dequeueReusableCell(withReuseIdentifier: HomeTopSliderCell.identifier, for: indexPath) as! HomeTopSliderCell
        
        cell.backgroundColor = indexPath.row % 2 == 0 ? .purple : .systemPink
        
        return cell
    }
    
}



//MARK: - ViewDelegateFlowLayout
extension HomeTopCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: topGeneralCollectionView.frame.width,
                      height: topGeneralCollectionView.frame.height)
    }
    
    
}

