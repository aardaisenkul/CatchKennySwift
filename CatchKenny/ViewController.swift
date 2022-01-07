//
//  ViewController.swift
//  CatchKenny
//
//  Created by Ali Arda İsenkul on 6.01.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var score = 0
    var counter = 30
    var timer = Timer()
    var imgTimer = Timer()
    var highScore = 0
    var randomWidth = 0
    var randomHeight = 0
    var addCoordinate = UIScreen.main.bounds.width/4
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var kennyImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Highscore check
        let storedScore = UserDefaults.standard.object(forKey: "highscore")
        if storedScore == nil {
            highScore = 0
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        
        if let newScore = storedScore as? Int {
            highScore = newScore
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        // Make image touchable and start its timer
        kennyImage.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(userTap))
        kennyImage.addGestureRecognizer(gestureRecognizer)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunction), userInfo: nil, repeats: true)
       
        imgTimer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(kennyRandom), userInfo: nil, repeats: true)
        
       
       
       
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        timer.invalidate()
        imgTimer.invalidate()
    }

    // Tap function
    @objc func userTap() {
        score += 1
        scoreLabel.text = "Score: \(score)"
       }
    
    // Kenny update function
    @objc func kennyRandom() {
        let maxX = view.frame.maxX - (kennyImage.frame.width + 50)
        let xCoord = CGFloat.random(in: 0...maxX)
        let yCoord = CGFloat.random(in: 0...kennyImage.frame.height*3)

        UIView.animate(withDuration: 0.3) {
            self.kennyImage.transform = CGAffineTransform(translationX: xCoord, y: yCoord)
        }
        
      
    }
    
    // Countdown function
    @objc func timerFunction() {
        
        counter -= 1
        timeLabel.text = "\(counter)"
        if counter == 0 {
            timer.invalidate()
            imgTimer.invalidate()
            timeLabel.text = "Time's Over"
            makeAlert(titleInput: "Game Over", messageInput: "Time's Up, your score is: \(score)!")
            if self.score > self.highScore {
                self.highScore = self.score
                highScoreLabel.text = "Highscore: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
        }
    }
    // Ending Function
    func makeAlert(titleInput: String, messageInput:String) {
           let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let restartButton = UIAlertAction(title: "Try Again", style: UIAlertAction.Style.default) { action in
            self.restartGame()
        }
        let homeButton = UIAlertAction(title: "Main Menu", style: UIAlertAction.Style.default) { action in
            self.navigationController?.popViewController(animated: true)
        }
           alert.addAction(restartButton)
           alert.addAction(homeButton)

           self.present(alert, animated: true, completion: nil)
       }
    
    // Restart Function
    func restartGame(){
        counter = 30
        score = 0
        timeLabel.text = "\(counter)"
        scoreLabel.text = "Score: \(score)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunction), userInfo: nil, repeats: true)
    }

}

