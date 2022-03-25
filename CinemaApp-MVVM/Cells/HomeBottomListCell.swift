//
//  HomeBottomListCell.swift
//  CinemaApp-MVVM
//
//  Created by ugur-pc on 25.03.2022.
//

import UIKit

class HomeBottomListCell: UICollectionViewCell {
    static var identifier = "HomeBottomListCell"
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "a5")
        iv.contentMode = .scaleAspectFill
     
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
   
    // movie title
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.text = "Spider Man"
        label.textColor = .white
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    // movie definition
    private let definitionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also th"
        label.textColor = .white
        label.numberOfLines = 3
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
        contentView.addSubview(definitionLabel)
      
        
        setImageViewConstraints()
        setTitleLabelConstraints()
        setDefinitionleLabelConstraints()
        
      
    }
    
    required init?(coder: NSCoder) {
        fatalError("not imp")
    }
    
    
}


//MARK: - Constraints
extension HomeBottomListCell {
    
    private func setImageViewConstraints(){
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 150),
            imageView.heightAnchor.constraint(equalToConstant: contentView.frame.height)
        ])
    }
    
   
    
    
    
    private func setTitleLabelConstraints(){
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            //titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50)
        ])
    }
    
    private func setDefinitionleLabelConstraints(){
        NSLayoutConstraint.activate([
            definitionLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20),
            definitionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            definitionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15)
        
        ])
    }
    
}
