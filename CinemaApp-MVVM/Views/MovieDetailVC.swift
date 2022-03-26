//
//  MovieDetailVC.swift
//  CinemaApp-MVVM
//
//  Created by ugur-pc on 26.03.2022.
//

import UIKit

class MovieDetailVC: UIViewController {

    
    // img
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "a1")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    
    // imbdb icon
    private let imbdbIcon: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "imdbIcon")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    // star icon
    private let starIcon: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName:"star.fill")
        iv.contentMode = .scaleToFill
        
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    //imdbVote
    private let voteImdb: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // releaseDate
    private let releaseLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    // movie title
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.text = "Spider Man"
        label.textColor = .white
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    // movie definition
    private let definitionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also th"
        label.textColor = .white
        label.numberOfLines = .max
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let bottomCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        
        
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    
    // STACKVIEW
    private let underPictureStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .leading
      
        stackView.layer.borderWidth = 3
        stackView.layer.borderColor = UIColor.red.cgColor
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        let subViewArr = [imageView, imbdbIcon, starIcon, voteImdb, releaseLabel, titleLabel, definitionLabel, underPictureStackView]
        
        let arrangedStackViewArr = [imbdbIcon, starIcon, voteImdb, releaseLabel]
        
        // addSubview
        subViewArr.forEach { (item) in
            view.addSubview(item)
        }
        
        // add stackView
        arrangedStackViewArr.forEach { (item) in
            underPictureStackView.addArrangedSubview(item)
        }
        
        setConstraints()
    }
    
    
    func setConstraints(){
        setimageViewConstraints()
        setStackViewConstraints()
        setImbdbIconConstraints()
        setStarIconConstraints()
        setTitleConstraints()
        setDefinitionConstraints()
    }
    
   
}


//MARK: - Constraints
extension MovieDetailVC {
    
    // TopImg Constraints
    private func setimageViewConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 400)
        ])
    }
    
    
    // stackView Constraints
    private func setStackViewConstraints(){
            NSLayoutConstraint.activate([
                underPictureStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
                underPictureStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
                underPictureStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
                underPictureStackView.heightAnchor.constraint(equalToConstant: 45)
            ])
        }
    
    
    private func setImbdbIconConstraints(){
        NSLayoutConstraint.activate([
            imbdbIcon.topAnchor.constraint(equalTo: underPictureStackView.topAnchor),
            imbdbIcon.leadingAnchor.constraint(equalTo: underPictureStackView.leadingAnchor),
            imbdbIcon.trailingAnchor.constraint(equalTo: starIcon.leadingAnchor),
            imbdbIcon.bottomAnchor.constraint(equalTo: underPictureStackView.bottomAnchor, constant: -25),
            //imbdbIcon.heightAnchor.constraint(equalToConstant: 10)
        ])
    }
    
    
    // star cons
    private func setStarIconConstraints(){
        NSLayoutConstraint.activate([
            starIcon.topAnchor.constraint(equalTo: imbdbIcon.topAnchor),
            starIcon.leadingAnchor.constraint(equalTo: underPictureStackView.trailingAnchor, constant: 2),
            //starIcon.bottomAnchor.constraint(equalTo: underPictureStackView.bottomAnchor, constant: -55),
            imbdbIcon.heightAnchor.constraint(equalToConstant: 5),
            
        ])
    }
    
    // title cons
    private func setTitleConstraints(){
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: underPictureStackView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: underPictureStackView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            //titleLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
    }
   
    // definition cons
    private func setDefinitionConstraints(){
        NSLayoutConstraint.activate([
            definitionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            definitionLabel.leadingAnchor.constraint(equalTo: underPictureStackView.leadingAnchor),
            definitionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
         
        ])
    }
}
