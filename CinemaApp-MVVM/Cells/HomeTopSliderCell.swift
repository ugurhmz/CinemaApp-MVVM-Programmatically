//
//  HomeTopSliderCell.swift
//  CinemaApp-MVVM
//
//  Created by ugur-pc on 25.03.2022.
//

import UIKit

class HomeTopSliderCell: UICollectionViewCell {
    
    static var identifier = "HomeTopSliderCell"
    
    var mvImages: String? {
        didSet {
            if let img = mvImages {
                movieImageView.image = UIImage(named: img)
            }
        }
    }
    
    
    
    // movie image
    var movieImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage()
        iv.translatesAutoresizingMaskIntoConstraints = false
        
        return iv
    }()
    
    
    // transparent view
    private let transparentView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.3)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    
    func setupViews() {
        contentView.addSubview(movieImageView)
        contentView.addSubview(transparentView)
        
        setMovieImageViewConstraints()
        setTransparentViewConstraints()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("not imp")
    }
    
}



//MARK: - Constraints
extension HomeTopSliderCell {
    
    private func  setMovieImageViewConstraints() {
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            movieImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    
    
    private func setTransparentViewConstraints() {
        NSLayoutConstraint.activate([
            transparentView.topAnchor.constraint(equalTo: movieImageView.topAnchor),
            transparentView.leadingAnchor.constraint(equalTo: movieImageView.leadingAnchor),
            transparentView.trailingAnchor.constraint(equalTo: movieImageView.trailingAnchor),
            transparentView.bottomAnchor.constraint(equalTo: movieImageView.bottomAnchor)
        ])
    }
}
