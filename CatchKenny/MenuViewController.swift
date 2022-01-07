//
//  MenuViewController.swift
//  CatchKenny
//
//  Created by Ali Arda İsenkul on 6.01.2022.
//

import UIKit

class MenuViewController: UIViewController {

    let storedScore = UserDefaults.standard.object(forKey: "highscore")
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func highScoreClicked(_ sender: Any) {
        var highScoreMessage = "There is no record for now!"
        
        if storedScore == nil {
            highScoreMessage = "Highscore: 0"
        }
        else if let newScore = storedScore as? Int {
            highScoreMessage = "Highscore: \(newScore)"
        }
        let alert = UIAlertController(title: "Highest Score", message: highScoreMessage, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Try Again", style: UIAlertAction.Style.default)
        
        alert.addAction(okButton)

        self.present(alert, animated: true, completion: nil)
    }
}
