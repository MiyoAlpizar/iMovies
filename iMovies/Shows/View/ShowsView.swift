//
//  MoviesGenerView.swift
//  iMovies
//
//  Created by Miyo on 14/11/21.
//

import UIKit
import RxSwift


class ShowsView: UICollectionViewController {
    
    var router = ShowsRouter()
    private var viewModel = ShowsViewModel()
    private var rc = UIRefreshControl()
    var showsInfo = [ShowInfo]()
    private var disposeBag = DisposeBag()
    var genre: Genre? {
        didSet {
            self.navigationItem.title = genre?.name
        }
    }
    var showType: ShowType = .movie
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        viewModel.bind(view: self, router: router)
        loadMovies()
    }
    
    private func loadMovies() {
        guard let genre = genre else { return }
        viewModel.loadShowsByGenre(type: showType, id: genre.id)
            .observe(on: MainScheduler.instance)
            .subscribe(on: MainScheduler.instance)
            .subscribe { shows in
                self.showsInfo = shows
                self.reloadCollectionView()
            } onError: { error in
                print(error.localizedDescription)
            }.disposed(by: disposeBag)
    }
    
    public func filterMovies(text: String) {
        viewModel.filterShows(type: showType, query: text)
            .observe(on: MainScheduler.instance)
            .subscribe(on: MainScheduler.instance)
            .debounce(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe { shows in
                self.showsInfo = shows
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
        let width = (UIScreen.main.bounds.width / 3) - 20
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
