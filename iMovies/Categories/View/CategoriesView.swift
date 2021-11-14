//
//  CategoriesView.swift
//  iMovies
//
//  Created by Miyo on 14/11/21.
//

import UIKit
import RxSwift

class CategoriesView: UITableViewController {
    
    var viewModel = CategoriesViewModel()
    var disposeBag = DisposeBag()
    var rc = UIRefreshControl()
    var genres = [Genre]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        getGenres()
    }
    
    private func setupController() {
        navigationItem.title = "Genres"
        rc.addTarget(self, action: #selector(getGenres), for: UIControl.Event.valueChanged)
        self.refreshControl = rc
        self.tableView.register(UINib(nibName: "CategoryViewCell", bundle: .main), forCellReuseIdentifier: CategoryViewCell.NAME)
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        }
    }
    
    @objc private func getGenres() {
        viewModel.loadGenres()
            .subscribe(on: MainScheduler.instance)
            .observe(on: MainScheduler.instance)
            .subscribe { genres in
                self.genres = genres
                self.reloadTableView()
            } onError: { error in
                print(error.localizedDescription)
            }.disposed(by: disposeBag)
    }
    
}
