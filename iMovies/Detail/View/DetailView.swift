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
    
    public var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        videoPlayerView.isHidden = true
        if let movie = movie {
            setData(movie: movie)
        }
    }
    
    private func setData(movie: Movie) {
        posterImg.sd_setImage(with: movie.backdropURL, completed: nil)
        movieImage.sd_setImage(with: movie.posterURL, completed: nil)
        movieInfo.text = "R - \(movie.releaseDate ?? "")"
        movieTitle.text = movie.title
        movieVotes.text = "\(movie.voteAverage)%"
        moviewOverView.text = movie.overview
        loadVideos(id: movie.id)
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
