//
//  DetailView+AVPlayerVideo.swift
//  iMovies
//
//  Created by Miyo on 14/11/21.
//

import UIKit
import youtube_ios_player_helper

extension DetailView: YTPlayerViewDelegate {
    
    public func playVideo(from: String, key: String) {
        guard from.lowercased() == "youtube" else { return }
        videoPlayerView.delegate = self
        videoPlayerView.load(withVideoId: key, playerVars: ["playsinline":1])
    }
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        videoPlayerView.playVideo()
        videoPlayerView.isHidden = false
    }
    
}
