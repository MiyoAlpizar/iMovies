//
//  DetailView.swift
//  iMovies
//
//  Created by Miyo on 14/11/21.
//

import UIKit
import RxSwift
import youtube_ios_player_helper

class DetailView: UIViewController {

    
    
    private var disposeBag = DisposeBag()
    @IBOutlet weak var posterImg: UIImageView!
    @IBOutlet weak var videoPlayerView: YTPlayerView!
    @IBOutlet weak var tableView: UITableView!
    var viewModel: DetailViewModel = DetailViewModel()
    var router = DetailRouter()
    
    public var showInfo: ShowInfo?
    public var similarShows = [ShowInfo]()
    public weak var cellDelegate: PosterViewCellProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        videoPlayerView.isHidden = true
        setupTableView()
        if let showInfo = showInfo {
            setData(showInfo: showInfo)
        }
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
        tableView.alwaysBounceVertical = true
        tableView.rowHeight = Constants.Sizes.MediumPoster.height
        tableView.register(UINib(nibName: PostersViewCell.NAME, bundle: Bundle.main), forCellReuseIdentifier: PostersViewCell.NAME)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    private func setData(showInfo: ShowInfo) {
        posterImg.sd_setImage(with: showInfo.landscapePoster!, completed: nil)
        loadVideos(id: showInfo.id, type: showInfo.type)
        loadSimilarShows(id: showInfo.id, type: showInfo.type)
    }
    
    private func loadVideos(id: Int, type: ShowType) {
        viewModel.loadVideos(id: id, type: type)
            .subscribe(on: 	MainScheduler.instance)
            .observe(on: MainScheduler.instance)
            .subscribe { movies in
                if (movies.count > 0) {
                    self.playVideo(from: movies[0].site, key: movies[0].key)
                }
            } onError: { error in
                print(error.localizedDescription)
            } .disposed(by: disposeBag)

    }
    
    private func loadSimilarShows(id: Int, type: ShowType) {
        viewModel.loadSimilarShows(type: type, id: id)
            .subscribe(on:MainScheduler.instance)
            .observe(on:MainScheduler.instance)
            .subscribe { shows in
                self.similarShows = shows
                self.reloadTableView()
            } onError: { error in
                print(error.localizedDescription)
            } .disposed(by: disposeBag)

    }
    
    private func reloadTableView() {
        DispatchQueue.main.async { [self] in
            self.tableView.reloadData()
            
        }
    }
}
