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

public class VideoSplashViewController: UIViewController {

  private let moviePlayer = AVPlayerViewController()
  private var moviePlayerSoundLevel: Float = 1.0
  public var contentURL: URL? {
    didSet {
      setMoviePlayer(contentURL!)
    }
  }

  public var videoFrame: CGRect = CGRect()
  public var startTime: CGFloat = 0.0
  public var duration: CGFloat = 0.0
  public var backgroundColor: UIColor = UIColor.black {
    didSet {
      view.backgroundColor = backgroundColor
    }
  }
  public var sound: Bool = true {
    didSet {
      if sound {
        moviePlayerSoundLevel = 1.0
      }else{
        moviePlayerSoundLevel = 0.0
      }
    }
  }
  public var alpha: CGFloat = CGFloat() {
    didSet {
      moviePlayer.view.alpha = alpha
    }
  }
  public var alwaysRepeat: Bool = true {
    didSet {
      if alwaysRepeat {
        NotificationCenter.default.addObserver(self,
          selector: #selector(VideoSplashViewController.playerItemDidReachEnd),
          name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
          object: moviePlayer.player?.currentItem)
      }
    }
  }
  public var fillMode: ScalingMode = .resizeAspectFill {
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

  override public func viewDidAppear(_ animated: Bool) {
    moviePlayer.view.frame = videoFrame
    moviePlayer.showsPlaybackControls = false
    view.addSubview(moviePlayer.view)
    view.sendSubview(toBack: moviePlayer.view)
  }
  
  override public func viewWillDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    NotificationCenter.default.removeObserver(self)
  }

  private func setMoviePlayer(_ url: URL){
    let videoCutter = VideoCutter()
    videoCutter.cropVideoWithUrl(videoUrl: url, startTime: startTime, duration: duration) { (videoPath, error) -> Void in
      if let path = videoPath as URL? {
            self.moviePlayer.player = AVPlayer(url: path)
            self.moviePlayer.player?.play()
            self.moviePlayer.player?.volume = self.moviePlayerSoundLevel
          }
    }
  }

  override public func viewDidLoad() {
    super.viewDidLoad()
  }

  override public func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  func playerItemDidReachEnd() {
    moviePlayer.player?.seek(to: kCMTimeZero)
    moviePlayer.player?.play()
  }
}
