//
//  DetailBottomCell.swift
//  CinemaApp-MVVM
//
//  Created by ugur-pc on 26.03.2022.
//

import UIKit

class DetailBottomCell: UICollectionViewCell {
    
    static var identifier = "DetailBottomCell"
    
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "a3")
        iv.contentMode = .scaleToFill
        iv.layer.cornerRadius = 15
        iv.clipsToBounds = true
       
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.text = "Fight CLub ( 2013) "
        label.textColor = .white
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
       
    }
    
    
    
    func setupViews() {

        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        
        setConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("not imp")
    }
}


extension DetailBottomCell  {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
     
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -22),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
           // imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            imageView.heightAnchor.constraint(equalToConstant: contentView.frame.height/2),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        
            
            
        ])
    }
    
   
}
