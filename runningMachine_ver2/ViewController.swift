//
//  ViewController.swift
//  runningMachine_ver2
//
//  Created by Keitaro Ushiroda on 2019/02/20.
//  Copyright © 2019 Keitaro Ushiroda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    weak var timer: Timer?
    var time = Date()
    var count = 0

    @IBOutlet weak var remainTimeLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    
    @IBAction func startButton(_ sender: Any) {
        startTime()
    }
    @IBAction func resetButton(_ sender: Any) {
        timer?.invalidate()
        totalTimeLabel.text = "00:00"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    func startTime() {
        time = Date()
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.timerCount), userInfo: nil, repeats: true)
    }
    func fiveSecCount() {
    }
    
    @objc func timerCount() {
        let currentTime = Date().timeIntervalSince(time)
        let minute = (Int)(fmod((currentTime/60), 60))
        let second = (Int)(fmod(currentTime, 60))
        
        let sMinute = String(format:"%02d", minute)
        let sSecond = String(format:"%02d", second)
        
        totalTimeLabel.text = sMinute + ":" + sSecond
        
        let fiveSecCount = (Int)(5 - second % 6)
        
        if fiveSecCount == 0 {
            remainTimeLabel.text = "Let's go Next!"
            count = count + 1
        } else {
            remainTimeLabel.text = String(fiveSecCount) + "," + String(count)
        }
    }
    
    

}

