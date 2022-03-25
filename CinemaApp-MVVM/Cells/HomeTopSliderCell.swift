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
    private let movieImageView: UIImageView = {
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
   
    
    // StackView for title & definition
    private let labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        //stackView.alignment = .center
        
        //stackView.layer.borderWidth = 3
        //stackView.layer.borderColor = UIColor.red.cgColor
        stackView.spacing = 20
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    
    func setupViews() {
        contentView.addSubview(movieImageView)
        contentView.addSubview(transparentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(definitionLabel)
        contentView.addSubview(labelsStackView)
       
        
        
        
        setMovieImageViewConstraints()
        setTransparentViewConstraints()
        setTitleConstraints()
        setDefinitionConstraints()
        setStackViewConstraints()
        
        
        
        labelsStackView.addArrangedSubview(titleLabel)
        labelsStackView.addArrangedSubview(definitionLabel)
        
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
    
    private func setStackViewConstraints(){
        NSLayoutConstraint.activate([
            labelsStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 70),
            labelsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            labelsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            labelsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
   
    private func setTitleConstraints(){
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: labelsStackView.topAnchor, constant: 105),
            titleLabel.leadingAnchor.constraint(equalTo: labelsStackView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: labelsStackView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: definitionLabel.topAnchor)
        ])
    }
    
    
    private func setDefinitionConstraints(){
        NSLayoutConstraint.activate([
            definitionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            definitionLabel.leadingAnchor.constraint(equalTo: labelsStackView.leadingAnchor),
            definitionLabel.trailingAnchor.constraint(equalTo: labelsStackView.trailingAnchor),
            definitionLabel.bottomAnchor.constraint(equalTo: labelsStackView.bottomAnchor, constant: -55)
        ])
    }
    
    
    
}
