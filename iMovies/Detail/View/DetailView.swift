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
    @IBOutlet weak var videoPlayerView: YTPlayerView!
    var viewModel: DetailViewModel = DetailViewModel()
    public var movie: Movie? {
        didSet {
            if let movie = movie {
                loadVideos(id: movie.id)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func loadVideos(id: Int) {
        viewModel.loadVideos(id: id)
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
}
