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
    var showsInfo = [ShowInfo]()
    
    let searchController = UISearchController(searchResultsController: ShowsView.instance())
    private var segmentedType = UISegmentedControl(items: Constants.Common.ShowTypes)
    var showType: ShowType = .movie
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        setupSearchController()
        setupSegmentedControll()
        viewModel.bind(view: self, router: router)
        loadShows()
    }
    
    private func loadShows() {
        viewModel.loadShows(type: showType)
            .observe(on: MainScheduler.instance)
            .subscribe(on: MainScheduler.instance)
            .subscribe { shows in
                self.showsInfo = shows
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
        searchController.searchBar.placeholder = "Search in movies"
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
                vc.showType = self.showType
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
                self.searchController.searchBar.placeholder = "Search in \(self.showType.description.lowercased())"
                self.loadShows()
            }.disposed(by: disposeBag)
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
