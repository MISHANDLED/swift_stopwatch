//
//  ViewController.swift
//  StopWatch
//
//  Created by Devansh Mohata on 18/12/22.
//

import UIKit

/*
 * Basic Stopwatch with on Screen only, if we go background stopwatch will stop
 */

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet weak var pauseBtn: UIButton!
    
    var timer = Timer()
    var totalDuration = 0;
    var isPause = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startBtn.isEnabled = true
        pauseBtn.isEnabled = false
        stopBtn.isEnabled = false
    }
    
    @IBAction func startBtnClicked(_ sender: UIButton) {
        timeLabel.text = "00:00:00"
        startTimer()
        startBtn.isEnabled = false
        pauseBtn.isEnabled = true
        stopBtn.isEnabled = true
    }
    
    @IBAction func pauseBtnClicked(_ sender: UIButton) {
        if isPause {
            timer.invalidate()
            pauseBtn.titleLabel?.text = "Resume"
        } else {
            startTimer()
            pauseBtn.titleLabel?.text = "Pause"
        }
        
        isPause.toggle()
    }
    
    @IBAction func stopBtnClicked(_ sender: UIButton) {
        timer.invalidate()
        totalDuration = 0
        
        startBtn.isEnabled = true
        pauseBtn.isEnabled = false
        stopBtn.isEnabled = false
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.updateLabel), userInfo: nil, repeats: true)
    }
    
    @objc func updateLabel() {
        totalDuration += 1;
        
        let hours = totalDuration/3600
        let minutes = (totalDuration%3600)/60
        let seconds = (totalDuration%3600)%60
        
        timeLabel.text = "\(hours<10 ? "0\(hours)" : "\(hours)"):\(minutes<10 ? "0\(minutes)" : "\(minutes)"):\(seconds<10 ? "0\(seconds)" : "\(seconds)")"
    }
}

