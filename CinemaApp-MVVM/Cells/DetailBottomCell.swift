//
//  DetailBottomCell.swift
//  CinemaApp-MVVM
//
//  Created by ugur-pc on 26.03.2022.
//

import UIKit

class DetailBottomCell: UICollectionViewCell {
    
    static var identifier = "DetailBottomCell"
    private let randomImage: String = "https://picsum.photos/200/300"
    
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
        
        setConstraints()
    }
    
    func setUp(model: MovieNowPlayingInfo) {
        let defaultLink = "http://image.tmdb.org/t/p/w500"
        let completePath = defaultLink + model.posterPath
        
        imageView.af.setImage(withURL: URL(string: completePath ) ??
                                  URL(string: randomImage)!)
        
        print("modelTitle", model.title)
        print("modelTitle", model.releaseDate.prefix(4))
        titleLabel.text = "\(model.title) (\(model.releaseDate.prefix(4)))"
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("not imp")
    }
}


extension DetailBottomCell  {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
     
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -17),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
           // imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            imageView.heightAnchor.constraint(equalToConstant: contentView.frame.height/1.4),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        
            
            
        ])
    }
    
   
}
