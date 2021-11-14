//
//  HomeView.swift
//  iMovies
//
//  Created by Miyo on 13/11/21.
//

import UIKit
import RxSwift

private let reuseIdentifier = "Cell"

class HomeView: UICollectionViewController {
    
    private var router = HomeRouter()
    private var viewModel = HomeViewModel()
    private var refreshControll = UIRefreshControl()
    private var homeMovies = [HomeMovies]()
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        setupController()
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        loadMovies()
    }
    
    private func setupController() {
        title = "iMovies"
        collectionView.alwaysBounceVertical = true
        refreshControll.addTarget(self, action: #selector(loadMovies), for: UIControl.Event.valueChanged)
        self.collectionView.refreshControl = refreshControll
    }

    @objc private func loadMovies() {
        viewModel.getHomeMovies()
            .subscribe(on: MainScheduler.instance)
            .observe(on: MainScheduler.instance)
            .subscribe { homeMovies in
                self.homeMovies = homeMovies
                self.reloadCollectionView()
            } onError: { error in
                print(error.localizedDescription)
            } onCompleted: {
                self.collectionView.refreshControl?.endRefreshing()
            }.disposed(by: disposeBag)
    }
    
    private func reloadCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.refreshControl?.endRefreshing()
            self.collectionView.reloadData()
            for item in self.homeMovies {
                print(item.category.description)
            }
        }
    }
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return homeMovies.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return homeMovies[section].movies.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        return cell
    }
    
}
