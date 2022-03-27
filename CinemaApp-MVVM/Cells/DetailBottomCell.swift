//
//  DetailBottomCell.swift
//  CinemaApp-MVVM
//
//  Created by ugur-pc on 26.03.2022.
//

import UIKit

class DetailBottomCell: UICollectionViewCell {
    
    static var identifier = "DetailBottomCell"
    
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "a3")
        iv.contentMode = .scaleToFill
        iv.layer.cornerRadius = 15
        iv.clipsToBounds = true
       
       
      
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
       
    }
    
    
    
    func setupViews() {
        contentView.addSubview(imageView)
        setImageConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("not imp")
    }
}


extension DetailBottomCell  {
    
    private func setImageConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
