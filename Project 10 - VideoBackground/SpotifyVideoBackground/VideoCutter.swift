//
//  VideoCutter.swift
//  VideoSplash
//
//  Created by Toygar Dündaralp on 8/3/15.
//  Copyright (c) 2015 Toygar Dündaralp. All rights reserved.
//

import UIKit
import AVFoundation

extension String {
  var convert: NSString { return (self as NSString) }
}

open class VideoCutter: NSObject {

  /**
  Block based method for crop video url
  
  @param videoUrl Video url
  @param startTime The starting point of the video segments
  @param duration Total time, video length

  */
  open func cropVideoWithUrl(videoUrl url: URL, startTime: CGFloat, duration: CGFloat, completion: ((_ videoPath: URL?, _ error: NSError?) -> Void)?) {
    let priority = DispatchQueue.GlobalQueuePriority.default
    DispatchQueue.global(priority: priority).async {
      let asset = AVURLAsset(url: url, options: nil)
      let exportSession = AVAssetExportSession(asset: asset, presetName: "AVAssetExportPresetHighestQuality")
      let paths: NSArray = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
      var outputURL = paths.object(at: 0) as! String
      let manager = FileManager.default
      do {
        try manager.createDirectory(atPath: outputURL, withIntermediateDirectories: true, attributes: nil)
      } catch _ {
      }
      outputURL = outputURL.convert.appendingPathComponent("output.mp4")
      do {
        try manager.removeItem(atPath: outputURL)
      } catch _ {
      }
      if let exportSession = exportSession as AVAssetExportSession? {
        exportSession.outputURL = URL(fileURLWithPath: outputURL)
        exportSession.shouldOptimizeForNetworkUse = true
        exportSession.outputFileType = AVFileTypeMPEG4
        let start = CMTimeMakeWithSeconds(Float64(startTime), 600)
        let duration = CMTimeMakeWithSeconds(Float64(duration), 600)
        let range = CMTimeRangeMake(start, duration)
        exportSession.timeRange = range
        exportSession.exportAsynchronously { () -> Void in
          switch exportSession.status {
          case AVAssetExportSessionStatus.completed:
            completion?(exportSession.outputURL, nil)
          case AVAssetExportSessionStatus.failed:
            print("Failed: \(exportSession.error)")
          case AVAssetExportSessionStatus.cancelled:
            print("Failed: \(exportSession.error)")
          default:
            print("default case")
          }
        }
      }
    }
  }
}
