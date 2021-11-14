//
//  MoviesGenerView.swift
//  iMovies
//
//  Created by Miyo on 14/11/21.
//

import UIKit
import RxSwift

private let reuseIdentifier = "Cell"

class MoviesGenreView: UICollectionViewController {
    
    var router = MoviesGenreRouter()
    private var viewModel = MoviesGenreViewModel()
    private var rc = UIRefreshControl()
    var movies = [Movie]()
    private var disposeBag = DisposeBag()
    var genre: Genre? {
        didSet {
            loadMovies()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        viewModel.bind(view: self, router: router)
        loadMovies()
    }
    
    private func loadMovies() {
        guard let genre = genre else {
            return
        }
        title = genre.name
        viewModel.loadMoviesByGenre(id: genre.id)
            .subscribe(on: MainScheduler.instance)
            .observe(on: MainScheduler.instance)
            .subscribe { movies in
                self.movies = movies
                self.reloadCollectionView()
            } onError: { error in
                print(error.localizedDescription)
            }.disposed(by: disposeBag)
    }
    
    func reloadCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    private func setupCollectionView() {
        let width = (UIScreen.main.bounds.width / 3) - 24
        let height = width * 1.4
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: width, height: height)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UINib(nibName: "MoviePosterCell", bundle: nil), forCellWithReuseIdentifier: MoviePosterCell.NAME)
        collectionView.collectionViewLayout = layout
        
    }
    
}
