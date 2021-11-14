//
//  CategoriesView.swift
//  iMovies
//
//  Created by Miyo on 14/11/21.
//

import UIKit
import RxSwift
import RxCocoa

class CategoriesView: UITableViewController {
    
    var viewModel = CategoriesViewModel()
    var disposeBag = DisposeBag()
    var rc = UIRefreshControl()
    var genres = [Genre]()
    var filteredGenres = [Genre]()
    
    lazy var searchController: UISearchController = {
       let search = UISearchController(searchResultsController: nil)
        search.searchBar.sizeToFit()
        search.searchBar.placeholder = "Filter genre"
        return search
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        setupSearchController()
        getGenres()
    }
    
    private func setupController() {
        navigationItem.title = "Genres"
        rc.addTarget(self, action: #selector(getGenres), for: UIControl.Event.valueChanged)
        self.refreshControl = rc
        self.tableView.separatorColor = .clear
        self.tableView.register(UINib(nibName: "CategoryViewCell", bundle: .main), forCellReuseIdentifier: CategoryViewCell.NAME)
    }
    
    func reloadTableView() {
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
                self.filteredGenres = genres
                self.reloadTableView()
            } onError: { error in
                print(error.localizedDescription)
            }.disposed(by: disposeBag)
    }
    
    private func setupSearchController() {
        navigationItem.searchController = searchController
        searchController.delegate = self
        searchController.searchBar.rx.text
            .orEmpty
            .distinctUntilChanged()
            .subscribe { filterText in
                guard let text = filterText.element else {
                    self.filteredGenres = self.genres
                    self.reloadTableView()
                    return
                }
                guard text != "" else {
                    self.filteredGenres = self.genres
                    self.reloadTableView()
                    return
                }
                self.filteredGenres = self.genres.filter({ genre in
                    return genre.name.lowercased().contains(text.lowercased())
                })
                self.reloadTableView()
            }.disposed(by: disposeBag)
    }
    
}
