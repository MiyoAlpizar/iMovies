//
//  SearchView.swift
//  iMovies
//
//  Created by Miyo on 14/11/21.
//

import UIKit
import RxSwift
import RxCocoa

class SearchView: UITableViewController {
    
    var router = SearchRouter()
    var viewModel = SearchViewModel()
    var disposeBag = DisposeBag()
    var movies = [Movie]()
    var filteredMovies = [Movie]()
    
    let searchController = UISearchController(searchResultsController: ShowsView.instance())
    private var segmentedType = UISegmentedControl(items: Constants.Common.ShowTypes)
    var showType: ShowType = .movie
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        setupSearchController()
        setupSegmentedControll()
        viewModel.bind(view: self, router: router)
        loadMovies()
    }
    
    private func loadMovies() {
        viewModel.loadMovies()
            .observe(on: MainScheduler.instance)
            .subscribe(on: MainScheduler.instance)
            .subscribe { movies in
                self.movies = movies
                self.filteredMovies = movies
                self.reloadTableView()
            } onError: { error in
                print(error.localizedDescription)
            }.disposed(by: disposeBag)

    }
    
    private func setupController() {
        navigationItem.title = "Search"
        self.tableView.rowHeight = 90
        self.tableView.register(UINib(nibName: PlayMovieCell.NAME, bundle: .main), forCellReuseIdentifier: PlayMovieCell.NAME)
    }
    
    private func setupSearchController() {
        navigationItem.searchController = searchController
        searchController.delegate = self
        searchController.searchBar.rx.text
            .orEmpty
            .distinctUntilChanged()
            .debounce(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe { filterText in
                guard let vc = self.searchController.searchResultsController as? ShowsView else {
                    return
                }
                guard let text = filterText.element else {
                    return
                }
                guard text != "" else {
                    return
                }
                vc.filterMovies(text: text)
                
            }.disposed(by: disposeBag)
    }
    
    private func setupSegmentedControll() {
        navigationItem.titleView = segmentedType
        segmentedType.selectedSegmentIndex = 0
        segmentedType.rx.selectedSegmentIndex
            .changed
            .subscribe { index in
                self.showType = index.element == 0 ? .movie : .serie
                self.getGenres()
            }.disposed(by: disposeBag)
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
