//
//  HomeView.swift
//  iMovies
//
//  Created by Miyo on 13/11/21.
//

import UIKit
import RxSwift

class HomeView: UITableViewController {
    
    private var router = HomeRouter()
    private var viewModel = HomeViewModel()
    private var refreshControll = UIRefreshControl()
    private var homeMovies = [HomeMovies]()
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        setupTableViewController()
        loadMovies()
    }
    
    private func setupTableViewController() {
        title = "iMovies"
        tableView.separatorColor = .clear
        tableView.alwaysBounceVertical = true
        tableView.register(UINib(nibName: "PostersViewCell", bundle: Bundle.main), forCellReuseIdentifier: PostersViewCell.NAME)
        refreshControll.addTarget(self, action: #selector(loadMovies), for: UIControl.Event.valueChanged)
        tableView.refreshControl = refreshControl
        
    }

    @objc private func loadMovies() {
        viewModel.getHomeMovies()
            .subscribe(on: MainScheduler.instance)
            .observe(on: MainScheduler.instance)
            .subscribe { homeMovies in
                self.homeMovies = homeMovies
                self.reloadTableView()
            } onError: { error in
                print(error.localizedDescription)
            } onCompleted: {
                self.tableView.refreshControl?.endRefreshing()
            }.disposed(by: disposeBag)
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        }
    }
}

extension HomeView {
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return homeMovies.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeMovies[section].movies.count > 0 ? 1 : 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return homeMovies[section].category.description
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostersViewCell.NAME) as! PostersViewCell
        cell.category = homeMovies[indexPath.section].category
        cell.movies = homeMovies[indexPath.section].movies
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if homeMovies[indexPath.section].category == .popular {
            return Constants.Sizes.BigPoster.height
        }
        return Constants.Sizes.MediumPoster.height
    }
    
}
