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
    var fiveSecCount: Int = 0
    var recordTime: Double = 0.0
    var sum: String = "LET'S GO!!!"
    var sumBefore: String = "LET'S GO!!!"
    var testText = ""

    @IBOutlet weak var remainTimeLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var quizLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    @IBAction func startButton(_ sender: Any) {
        startTime()
    }
    @IBAction func resetButton(_ sender: Any) {
        timer?.invalidate()
        countLabel.text = "Q"
        totalTimeLabel.text = "00:00"
        remainTimeLabel.text = "PUSH START BUTTON"
        quizLabel.text = "QUIZ WILL APPEAR HERE"
        count = 0
        fiveSecCount = 0
        recordTime = 0.0
        sum = "LET'S GO!!!"
        sumBefore = "LET'S GO!!!"
        testText = ""
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        totalTimeLabel.text = "00:00"
        remainTimeLabel.text = "PUSH START BUTTON"
        countLabel.text = "Q"
        // Do any additional setup after loading the view, typically from a nib.
    }
    func startTime() {
        if timer == nil {
            time = Date()
            self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.timerCount), userInfo: nil, repeats: true)
        }
    }
    
    @objc func timerCount() {
        let currentTime = Date().timeIntervalSince(time)
        print("currentTime is")
        print(currentTime)
        let minute = (Int)(fmod((currentTime/60), 60))
        let second = (Int)(fmod(currentTime, 60))
        
        let sMinute = String(format:"%02d", minute)
        let sSecond = String(format:"%02d", second)
        
        totalTimeLabel.text = sMinute + ":" + sSecond
        
        fiveSecCount = (Int)(5 - second % 6)
        
        if fiveSecCount == 0 {
            remainTimeLabel.text = "GO TO NEXT QUIZ"
            if currentTime > recordTime + 1.0{
                recordTime = currentTime
                count = count + 1
                makeQuiz()
                countLabel.text = "Q" + String(count)
            }
            quizLabel.text = "ANSWER: " + sumBefore
        } else {
            remainTimeLabel.text = String(fiveSecCount)
            quizLabel.text = testText
            sumBefore = ""
        }
    }
    
    func makeQuiz() {
        let num1 = Int.random(in: 1 ... 100)
        let num2 = Int.random(in: 1 ... 100)
        let change = Int.random(in: 1 ... 4)
        let text: String
        
        sumBefore = sum
        
        switch change {
        case 1:
            sum = String(num1 + num2)
            text = String(num1) + " + " + String(num2)
        case 2:
            sum = String(num1 * num2)
            text = String(num1) + " × " + String(num2)
        case 3:
            sum = String(num1 - num2)
            text = String(num1) + " - " + String(num2)
        case 4:
            if num1 > num2 {
                sum = String(num1 % num2)
                text = String(num1) + " mod " + String(num2)
            } else {
                sum = String(num2 % num1)
                text = String(num2) + " mod " + String(num1)
            }
        default:
            fatalError()
        }
        testText = text
    }
}
