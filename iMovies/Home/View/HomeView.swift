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
    var homeMovies = [HomeMovies]()
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        setupTableViewController()
        loadMovies()
    }
    
    private func setupTableViewController() {
        navigationItem.title = "iMovies"
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


