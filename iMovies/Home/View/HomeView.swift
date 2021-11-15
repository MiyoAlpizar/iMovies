//
//  HomeView.swift
//  iMovies
//
//  Created by Miyo on 13/11/21.
//

import UIKit
import RxSwift

class HomeView: UITableViewController {
    
    var router = HomeRouter()
    private var viewModel = HomeViewModel()
    private var rc = UIRefreshControl()
    var oldPosters = [Poster]()
    var posters = [Poster]()
    
    private var disposeBag = DisposeBag()
    private var segmentedType = UISegmentedControl(items: ["Movies", "Series"])
    var type: showType = .movie
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        setupTableViewController()
        setupSegmentedControll()
        loadHomePosters()
    }
    
    private func setupTableViewController() {
        navigationItem.title = "iMovies"
        tableView.separatorColor = .clear
        tableView.alwaysBounceVertical = true
        tableView.register(UINib(nibName: "PostersViewCell", bundle: Bundle.main), forCellReuseIdentifier: PostersViewCell.NAME)
        rc.addTarget(self, action: #selector(loadHomePosters), for: UIControl.Event.valueChanged)
        self.refreshControl = rc
    }
    
    private func setupSegmentedControll() {
        navigationItem.titleView = segmentedType
        segmentedType.selectedSegmentIndex = 0
        segmentedType.rx.selectedSegmentIndex
            .changed
            .subscribe { index in
                self.type = index.element == 0 ? .movie : .serie
                self.loadHomePosters()
            }.disposed(by: disposeBag)
    }

    @objc private func loadHomePosters() {
        viewModel.getHomePosters(type: self.type)
            .subscribe(on: MainScheduler.instance)
            .observe(on: MainScheduler.instance)
            .subscribe { posters in
                self.posters = posters
                self.reloadTableView()
            } onError: { error in
                print(error.localizedDescription)
            } onCompleted: {
                self.tableView.refreshControl?.endRefreshing()
            }.disposed(by: disposeBag)
    }
    
    
    private func reloadTableView() {
        DispatchQueue.main.async { [self] in
            self.tableView.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        }
    }
}


