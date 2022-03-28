//
//  MovieDetailVC.swift
//  CinemaApp-MVVM
//
//  Created by ugur-pc on 26.03.2022.
//

import UIKit


protocol DetailOutPutProtocol {
    func changeLoading(isLoad: Bool)
    func saveMovieDetailDatas(listValues: MovieDetailsModel)
    func saveSimilarMovieDatas(listValues: [MovieNowPlayingInfo])
}




class MovieDetailVC: UIViewController {

    var detailsMv: MovieDetailsModel?
    
    private lazy var detailMovieSimilarList: [MovieNowPlayingInfo] = []
    lazy var viewModel = DetailViewModel()
    private let indicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var myId = 5
    private let randomImage: String = "https://picsum.photos/200/300"
    
   
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
        iv.image = UIImage(named:"staricon")
        iv.contentMode = .scaleAspectFit
        
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    //imdbVote
    private let voteImdb: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // releaseDate
    private let releaseLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .bold)
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
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.text = "Pil, a little vagabond girl, lives on the streets of the medieval city of Roc-en-Brume, along with her three tame weasels. She survives of food stolen from the castle of the sinister Regent Tristain. One day, to escape his guards, Pil disguises herself as a princess. Thus she embarks upon a mad, delirious adventure, together with Crobar, a big clumsy guard who thinks she's a noble, and Rigolin, a young crackpot jester. Pil is going to have to save Roland, rightful heir to the throne under the curse of a spell. This adventure will turn the entire kingdom upside down, and teach Pil that nobility can be found in all of us."
        label.textColor = .white
        label.numberOfLines = 15
        label.translatesAutoresizingMaskIntoConstraints = false
       
        return label
    }()
    
    private let bottomCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        cv.backgroundColor = .clear
      
       
        layout.minimumLineSpacing = 5
        cv.register(DetailBottomCell.self, forCellWithReuseIdentifier: DetailBottomCell.identifier)
        
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    
    // STACKVIEW
    private let underPictureStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .leading
      
//        stackView.layer.borderWidth = 3
//        stackView.layer.borderColor = UIColor.red.cgColor
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    
    private let smilarLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.text = "Similar Videos"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        
        //viewModel Delegate
        viewModel.setDetailDelegate(output: self)
        viewModel.fetchMovieDetailItems(movieId: myId)
        viewModel.fechMovieSimilarItems(movieId: myId)
    }
    
    func setupViews() {
        let subViewArr = [imageView, imbdbIcon, starIcon, voteImdb, releaseLabel, titleLabel, definitionLabel, underPictureStackView, bottomCollectionView, smilarLabel]
        
        let arrangedStackViewArr = [imbdbIcon, starIcon, voteImdb, releaseLabel]
        
        // addSubview
        subViewArr.forEach { (item) in
            view.addSubview(item)
        }
        
        // add stackView
        arrangedStackViewArr.forEach { (item) in
            underPictureStackView.addArrangedSubview(item)
        }
        bottomCollectionView.delegate = self
        bottomCollectionView.dataSource = self
        bottomCollectionView.backgroundColor = .clear
        setConstraints()
    }
    
    
    func setConstraints(){
        setimageViewConstraints()
        setStackViewConstraints()
        setImbdbIconConstraints()
        setStarIconConstraints()
        setTitleConstraints()
        setDefinitionConstraints()
        setbottomCollectionView()
    }
    
}


//MARK: - DetailOutPutProtocol
extension MovieDetailVC: DetailOutPutProtocol {
    
    func changeLoading(isLoad: Bool) {
        isLoad ? indicator.startAnimating() : indicator.stopAnimating()
    }
    
    // details
    func saveMovieDetailDatas(listValues: MovieDetailsModel) {
        
        DispatchQueue.main.async {
            
            self.detailsMv = listValues
            let mvInfos = self.detailsMv
            
            let defaultLink = "http://image.tmdb.org/t/p/w500"
            var mvPref: String = ""
            if let mypath = self.detailsMv?.posterPath {
                mvPref = mypath
            }
            
            let completePath = defaultLink + mvPref
            
            self.imageView.af.setImage(withURL: URL(string: completePath ) ??
                                  URL(string: self.randomImage)!)
            
            self.titleLabel.text = "\(mvInfos?.title ?? "-") ( \(mvInfos?.releaseDate?.prefix(4)  ?? "-") )"
            
            
            self.definitionLabel.text =  "\(mvInfos?.overview ?? "-")"
            
            self.voteImdb.text = "\(mvInfos?.voteAverage ?? 0.0)/10"
            self.releaseLabel.text = "\(mvInfos?.releaseDate ?? "-")"
        }
    }
    
    // similar movies
    func saveSimilarMovieDatas(listValues: [MovieNowPlayingInfo]) {
        self.detailMovieSimilarList = listValues
        bottomCollectionView.reloadData()
    }
    
    
}





// Delegate, DataSource
extension MovieDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
  
 
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    // Total number of cells
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return detailMovieSimilarList.count
    }
   
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let bottomCell = bottomCollectionView.dequeueReusableCell(withReuseIdentifier: DetailBottomCell.identifier, for: indexPath) as! DetailBottomCell
        
        bottomCell.setUp(model: detailMovieSimilarList[indexPath.item])
      
        
        return bottomCell
    }
    
}

extension MovieDetailVC : UICollectionViewDelegateFlowLayout {
    
    // Her hücre boyutu, width, height
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
      
        
        return CGSize(width: (bottomCollectionView.frame.width / 2.90) - 20,
                      height: bottomCollectionView.frame.height / 1 - 60)
     
    }
    
    
    
    
    // Hücreler arası boşluk
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
       
        return UIEdgeInsets(top: 0, left: 10, bottom: 5, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
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
            imageView.heightAnchor.constraint(equalToConstant: 300)
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
            starIcon.topAnchor.constraint(equalTo: underPictureStackView.topAnchor, constant: -3),
            //starIcon.leadingAnchor.constraint(equalTo: underPictureStackView.trailingAnchor, constant: 2),
           
            starIcon.bottomAnchor.constraint(equalTo: underPictureStackView.bottomAnchor, constant: -20),
            
            //imbdbIcon.heightAnchor.constraint(equalToConstant: 5),
            imbdbIcon.widthAnchor.constraint(equalToConstant: 5),
            
            
            
            voteImdb.topAnchor.constraint(equalTo: underPictureStackView.topAnchor),
            voteImdb.leadingAnchor.constraint(equalTo: starIcon.trailingAnchor, constant: -33),
            starIcon.bottomAnchor.constraint(equalTo: underPictureStackView.bottomAnchor, constant: -20),
            
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
    
    private func setbottomCollectionView(){
        NSLayoutConstraint.activate([
            
            
           // smilarLabel.topAnchor.constraint(equalTo: definitionLabel.bottomAnchor, constant: 5),
            smilarLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            smilarLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            smilarLabel.bottomAnchor.constraint(equalTo: bottomCollectionView.topAnchor,constant: -5),
            
            
            
            bottomCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: 5),
            bottomCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            //bottomCollectionView.heightAnchor.constraint(equalToConstant: 100),
            bottomCollectionView.topAnchor.constraint(equalTo: definitionLabel.bottomAnchor, constant: 70)
        ])
    }
    
    
    
}
