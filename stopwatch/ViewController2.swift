//
//  ViewController2.swift
//  StopWatch
//
//  Created by Devansh Mohata on 18/12/22.
//

import UIKit

class ViewController2: UIViewController {

    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var pauseBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    
    var timer = Timer()
    var startDate = Date()
    var isPause = true
    var pauseTime: Date?
    var totalPause = 0.0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startBtn.isEnabled = true
        pauseBtn.isEnabled = false
        stopBtn.isEnabled = false
    }
    
    @IBAction func startBtnClicked(_ sender: UIButton) {
        timeLabel.text = "00:00:00"

        startBtn.isEnabled = false
        pauseBtn.isEnabled = true
        stopBtn.isEnabled = true
        
        startDate = Date()
        startTimer()
    }
    
    @IBAction func pauseBtnClicked(_ sender: UIButton) {
        if isPause {
            timer.invalidate()
            pauseTime = Date()
        } else {
            if let t = pauseTime {
                totalPause += (Date().timeIntervalSinceReferenceDate - t.timeIntervalSinceReferenceDate)
                pauseTime = nil
            }
            startTimer()
        }
        isPause.toggle()
    }
    
    @IBAction func stopBtnClicked(_ sender: UIButton) {
        timer.invalidate()
        totalPause = 0
        isPause = true
        startBtn.isEnabled = true
        pauseBtn.isEnabled = false
        stopBtn.isEnabled = false
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateLabel), userInfo: nil, repeats: true)
    }
    
    @objc func updateLabel() {
        let timeDiff = Int(Date().timeIntervalSinceReferenceDate - startDate.timeIntervalSinceReferenceDate - totalPause)
        
        let hours = timeDiff/3600
        let minutes = (timeDiff%3600)/60
        let seconds = (timeDiff%3600)%60
        
        timeLabel.text = "\(hours<10 ? "0\(hours)" : "\(hours)"):\(minutes<10 ? "0\(minutes)" : "\(minutes)"):\(seconds<10 ? "0\(seconds)" : "\(seconds)")"
    }
}
