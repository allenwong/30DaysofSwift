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

public class VideoCutter: NSObject {

  /**
  Block based method for crop video url
  
  @param videoUrl Video url
  @param startTime The starting point of the video segments
  @param duration Total time, video length

  */
  public func cropVideoWithUrl(videoUrl url: NSURL, startTime: CGFloat, duration: CGFloat, completion: ((videoPath: NSURL?, error: NSError?) -> Void)?) {
    let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
    dispatch_async(dispatch_get_global_queue(priority, 0)) {
      let asset = AVURLAsset(URL: url, options: nil)
      let exportSession = AVAssetExportSession(asset: asset, presetName: "AVAssetExportPresetHighestQuality")
      let paths: NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
      var outputURL = paths.objectAtIndex(0) as! String
      let manager = NSFileManager.defaultManager()
      do {
        try manager.createDirectoryAtPath(outputURL, withIntermediateDirectories: true, attributes: nil)
      } catch _ {
      }
      outputURL = outputURL.convert.stringByAppendingPathComponent("output.mp4")
      do {
        try manager.removeItemAtPath(outputURL)
      } catch _ {
      }
      if let exportSession = exportSession as AVAssetExportSession? {
        exportSession.outputURL = NSURL(fileURLWithPath: outputURL)
        exportSession.shouldOptimizeForNetworkUse = true
        exportSession.outputFileType = AVFileTypeMPEG4
        let start = CMTimeMakeWithSeconds(Float64(startTime), 600)
        let duration = CMTimeMakeWithSeconds(Float64(duration), 600)
        let range = CMTimeRangeMake(start, duration)
        exportSession.timeRange = range
        exportSession.exportAsynchronouslyWithCompletionHandler { () -> Void in
          switch exportSession.status {
          case AVAssetExportSessionStatus.Completed:
            completion?(videoPath: exportSession.outputURL, error: nil)
          case AVAssetExportSessionStatus.Failed:
            print("Failed: \(exportSession.error)")
          case AVAssetExportSessionStatus.Cancelled:
            print("Failed: \(exportSession.error)")
          default:
            print("default case")
          }
        }
      }
    }
  }
}
