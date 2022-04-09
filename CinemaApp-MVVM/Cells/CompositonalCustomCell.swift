//
//  CompositonalCustomCell.swift
//  CinemaApp-MVVM
//
//  Created by ugur-pc on 8.04.2022.
//

import UIKit
import Kingfisher

class CompositonalCustomCell: UICollectionViewCell {
    
    static var identifier = "CompositonalCustomCell"
    
    
    public var myImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "a3")
        iv.contentMode = .scaleToFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(myImageView)
        setConstraints()
     
    }
    
    required init?(coder: NSCoder) {
        fatalError("not imp")
    }
    
   
    public func configure(with model: String){
            
       
        
        guard var url = URL(string: "https://image.tmdb.org/t/p/w500\(model)") else {
            return
        }
        print("myurl",model.isEmpty)
        
        if  model.isEmpty {
            url = URL(string: "https://digitalfinger.id/wp-content/uploads/2019/12/no-image-available-icon-6.png")!
           
        }
        
     
        myImageView.kf.setImage(with: url)
    }
    
}

extension CompositonalCustomCell {
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            myImageView.topAnchor.constraint(equalTo: topAnchor),
            myImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            myImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            myImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
              ])
    }
}
