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
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieInfo: UILabel!
    @IBOutlet weak var movieVotes: UILabel!
    @IBOutlet weak var moviewOverView: UILabel!
    
    
    var viewModel: DetailViewModel = DetailViewModel()
    
    public var showInfo: ShowInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        videoPlayerView.isHidden = true
        if let showInfo = showInfo {
            setData(showInfo: showInfo)
        }
    }
    
    private func setData(showInfo: ShowInfo) {
        posterImg.sd_setImage(with: showInfo.landscapePoster!, completed: nil)
        movieImage.sd_setImage(with: showInfo.portraitPoster!, completed: nil)
        movieInfo.text = "R - \(showInfo.date ?? "No date")"
        movieTitle.text = showInfo.name
        movieVotes.text = "\(showInfo.voteAverage)%"
        moviewOverView.text = showInfo.overview
        loadVideos(id: showInfo.id, type: showInfo.type)
    }
    
    private func loadVideos(id: Int, type: showType) {
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
}
