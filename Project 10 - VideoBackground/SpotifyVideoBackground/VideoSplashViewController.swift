//
//  VideoSplashViewController.swift
//  VideoSplash
//
//  Created by Toygar Dündaralp on 8/3/15.
//  Copyright (c) 2015 Toygar Dündaralp. All rights reserved.
//

import UIKit
import MediaPlayer
import AVKit

public enum ScalingMode {
  case resize
  case resizeAspect
  case resizeAspectFill
}

 class VideoSplashViewController: UIViewController {

  fileprivate let moviePlayer = AVPlayerViewController()
  fileprivate var moviePlayerSoundLevel: Float = 1.0
   var contentURL: URL? {
    didSet {
      if let _contentURL = contentURL {
      setMoviePlayer(_contentURL)
      }
    }
  }

   var videoFrame: CGRect = CGRect()
   var startTime: CGFloat = 0.0
   var duration: CGFloat = 0.0
   var backgroundColor: UIColor = UIColor.black {
    didSet {
      view.backgroundColor = backgroundColor
    }
  }
   var sound: Bool = true {
    didSet {
      if sound {
        moviePlayerSoundLevel = 1.0
      }else{
        moviePlayerSoundLevel = 0.0
      }
    }
  }
   var alpha: CGFloat = CGFloat() {
    didSet {
      moviePlayer.view.alpha = alpha
    }
  }
   var alwaysRepeat: Bool = true {
    didSet {
      if alwaysRepeat {
        NotificationCenter.default.addObserver(self,
          selector: #selector(VideoSplashViewController.playerItemDidReachEnd),
          name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
          object: moviePlayer.player?.currentItem)
      }
    }
  }
   var fillMode: ScalingMode = .resizeAspectFill {
    didSet {
      switch fillMode {
      case .resize:
        moviePlayer.videoGravity = AVLayerVideoGravityResize
      case .resizeAspect:
        moviePlayer.videoGravity = AVLayerVideoGravityResizeAspect
      case .resizeAspectFill:
        moviePlayer.videoGravity = AVLayerVideoGravityResizeAspectFill
      }
    }
  }

  override  func viewDidAppear(_ animated: Bool) {
    moviePlayer.view.frame = videoFrame
    moviePlayer.showsPlaybackControls = false
    view.addSubview(moviePlayer.view)
    view.sendSubview(toBack: moviePlayer.view)
  }
  
  override  func viewWillDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    NotificationCenter.default.removeObserver(self)
  }

  fileprivate func setMoviePlayer(_ url: URL){
    let videoCutter = VideoCutter()
    videoCutter.cropVideoWithUrl(videoUrl: url, startTime: startTime, duration: duration) { (videoPath, error) -> Void in
      if let path = videoPath as URL? {
        DispatchQueue.main.async {
            self.moviePlayer.player = AVPlayer(url: path)
            self.moviePlayer.player?.play()
            self.moviePlayer.player?.volume = self.moviePlayerSoundLevel
        }
      }
    }
  }

  override  func viewDidLoad() {
    super.viewDidLoad()
  }

  override  func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  func playerItemDidReachEnd() {
    moviePlayer.player?.seek(to: kCMTimeZero)
    moviePlayer.player?.play()
  }
}
