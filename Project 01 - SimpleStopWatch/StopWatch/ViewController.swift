//
//  ViewController.swift
//  StopWatch
//
//  Created by Allen on 16/1/4.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit

struct Lap {
    var index: Int
    var timeStampOfLamp: String
    var timeDiffOfLamp: String
}

class ViewController: UIViewController {
    
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var pauseBtn: UIButton!
    @IBOutlet weak var lapTableView: UITableView!
    
    var counter = 0.0
    var prevousCounter = 0.0
    
    var timer = Timer()
    var IsPlaying = false
    var laps = [Lap]()
   
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    override func viewDidLoad() {
        timeLabel.text = String(counter)
        super.viewDidLoad()
    }
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBAction func resetButtonDidTouch(_ sender: AnyObject) {
        timer.invalidate()
        IsPlaying = false
        counter = 0
        prevousCounter = 0
        timeLabel.text = String(counter)
        playBtn.isEnabled = true
        pauseBtn.isEnabled = true
        laps.removeAll()
        lapTableView.reloadData()
    }
    
    @IBAction func playButtonDidTouch(_ sender: AnyObject) {
        if(IsPlaying) {
            return
        }
        playBtn.isEnabled = false
        pauseBtn.isEnabled = true
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.UpdateTimer), userInfo: nil, repeats: true)
        IsPlaying = true
    }
    
    
    @IBAction func lapButtonDidTouch(_ sender: UIButton) {
        guard counter != 0 else { return }
        //add timer to table
        let index = laps.count + 1
        let timeStamp = counter
        let diff = counter - prevousCounter
        prevousCounter = counter
        let lap = Lap(index: index, timeStampOfLamp: "\(String(format: "%.1f", timeStamp))", timeDiffOfLamp: "\(String(format: "%.1f", diff))")
        laps.insert(lap, at: 0)
        lapTableView.reloadData()
    }
    
    @IBAction func pauseButtonDidTouch(_ sender: AnyObject) {
        playBtn.isEnabled = true
        pauseBtn.isEnabled = false
        timer.invalidate()
        IsPlaying = false
    }
    
    func UpdateTimer() {
        counter = counter + 0.1
        timeLabel.text = String(format: "%.1f", counter)
    }
}


// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laps.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "LapCell") as? LapCell {
            let lap = laps[indexPath.row]
            cell.indexLabel.text = "\(lap.index)" +  " Lap"
            cell.timeStampLabel.text = lap.timeStampOfLamp
            cell.timeDiffLabel.text = lap.timeDiffOfLamp
            return cell
        }
        fatalError("Nib not found")
    }
}



class LapCell: UITableViewCell {
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var timeDiffLabel: UILabel!
}

