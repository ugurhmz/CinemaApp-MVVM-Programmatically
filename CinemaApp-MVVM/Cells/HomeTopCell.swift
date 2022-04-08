//
//  HomeTopCell.swift
//  CinemaApp-MVVM
//
//  Created by ugur-pc on 25.03.2022.
//
import AlamofireImage

import UIKit


protocol HomeTopCellProtocol:AnyObject{
    func didPressCell(sendId: Int)
}


class HomeTopCell: UICollectionViewCell {
    
   
    weak var topcellDelegate: HomeTopCellProtocol?
    
    
    var cellMovieUpComingList = [MovieUpComingInfo]()
    
    static var identifier = "HomeTopCell"
    //var albumArr = ["a1","a2","a3","a4","a5"]
    
    // topGeneralCollectionView
    private let topGeneralCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.isPagingEnabled = true
        
        // register slider
        cv.register(HomeTopSliderCell.self,
                    forCellWithReuseIdentifier: HomeTopSliderCell.identifier)
        
        return cv
    }()
    
    
    // pageControl
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.numberOfPages = 5
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        return pageControl
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
   
    func setupViews() {
        
        [topGeneralCollectionView, pageControl].forEach { contentView.addSubview($0)}
      
        
        setTopGeneralCollectionViewConstraints()
        setPageControlConstraints()
        
        topGeneralCollectionView.delegate = self
        topGeneralCollectionView.dataSource = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("not imp")
    }
    
    
    
}

extension HomeTopCell {
    
    func setX(model: [MovieUpComingInfo]) {
        
        self.cellMovieUpComingList = model
        
        pageControl.numberOfPages = cellMovieUpComingList.count
        
        topGeneralCollectionView.reloadData()
    }
}




//MARK: - Constraitns

extension HomeTopCell {
    
    private func setTopGeneralCollectionViewConstraints() {
        NSLayoutConstraint.activate([
            topGeneralCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: -70),
            topGeneralCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            topGeneralCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            topGeneralCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        
        ])
    }
    
    
    private func setPageControlConstraints(){
        NSLayoutConstraint.activate([
            pageControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            pageControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            pageControl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

}



//MARK: - Delegate, DataSource
extension HomeTopCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageControl.currentPage = indexPath.row
    }
    
    
//    // paging
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
//                                   withVelocity velocity: CGPoint,
//                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        let x = targetContentOffset.pointee.x
//        pageControl.currentPage = Int(x / topGeneralCollectionView.frame.width)
//    }
    
    
    // numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return cellMovieUpComingList.isEmpty == true ? 0 : cellMovieUpComingList.count
    }
    
    
    
    // cellForItemAt
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
       
        let cell = topGeneralCollectionView.dequeueReusableCell(withReuseIdentifier: HomeTopSliderCell.identifier, for: indexPath) as! HomeTopSliderCell
        
        //cell.backgroundColor = indexPath.row % 2 == 0 ? .purple : .systemPink
       // cell.mvImages = albumArr[indexPath.item]
       
        cell.saveModel(model: cellMovieUpComingList[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let newId = cellMovieUpComingList[indexPath.item].id else {
            return
        }
        print("newId", newId)
        self.topcellDelegate?.didPressCell(sendId: newId)
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
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
       
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

