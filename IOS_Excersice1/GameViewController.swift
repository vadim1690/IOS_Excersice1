//
//  GameViewController.swift
//  IOS_Excersice1
//
//  Created by Student28 on 01/06/2023.
//

import Foundation

import UIKit
class GameViewController: UIViewController {
    
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var leftPlayerNameLabel: UILabel!
    @IBOutlet weak var rightPlayerNameLabel: UILabel!
    @IBOutlet weak var leftScoreLabel: UILabel!
    @IBOutlet weak var rightScoreLabel: UILabel!
    @IBOutlet weak var rightPowerLabel: UILabel!
    @IBOutlet weak var leftPowerLabel: UILabel!
    @IBOutlet weak var rightPowerTextLabel: UILabel!
    @IBOutlet weak var leftPowerTextLabel: UILabel!
    @IBOutlet weak var centerLabel: UILabel!
    var name: String?
    var playerStartsAtLeft: Bool?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if  playerStartsAtLeft ?? false {
            leftPlayerNameLabel.text = name
            rightPlayerNameLabel.text = "PC"
        }else{
            rightPlayerNameLabel.text = name
            leftPlayerNameLabel.text = "PC"
        }
        
        
        
        let leftImages = [
            UIImage(named: "leftImage1"),
            UIImage(named: "leftImage2"),
            UIImage(named: "leftImage3"),
            UIImage(named: "leftImage4"),
            UIImage(named: "leftImage5"),
            UIImage(named: "leftImage6"),
            UIImage(named: "leftImage7"),
            UIImage(named: "leftImage8"),
            UIImage(named: "leftImage9"),
            UIImage(named: "leftImage10")

        ]

        let rightImages = [
            UIImage(named: "rightImage1"),
            UIImage(named: "rightImage2"),
            UIImage(named: "rightImage3"),
            UIImage(named: "rightImage4"),
            UIImage(named: "rightImage5"),
            UIImage(named: "rightImage6"),
            UIImage(named: "rightImage7"),
            UIImage(named: "rightImage8"),
            UIImage(named: "rightImage9"),
            UIImage(named: "rightImage10"),

        ]
        var leftPlayerScore = 0
        var rightPlayerScore = 0
        let leftImagePowers = [Int.random(in: 0..<1000),
                               Int.random(in: 0..<1000),
                               Int.random(in: 0..<1000),
                               Int.random(in: 0..<1000),
                               Int.random(in: 0..<1000),
                               Int.random(in: 0..<1000),
                               Int.random(in: 0..<1000),
                               Int.random(in: 0..<1000),
                               Int.random(in: 0..<1000),
                               Int.random(in: 0..<1000)
                               ] // Corresponding power values for leftImages
        let rightImagePowers = [Int.random(in: 0..<1000),
                                Int.random(in: 0..<1000),
                                Int.random(in: 0..<1000),
                                Int.random(in: 0..<1000),
                                Int.random(in: 0..<1000),
                                Int.random(in: 0..<1000),
                                Int.random(in: 0..<1000),
                                Int.random(in: 0..<1000),
                                Int.random(in: 0..<1000),
                                Int.random(in: 0..<1000)
                                ]// Corresponding power values for rightImages
        
        var currentTurn = 0
        let maxTurns = 10
        var leftIndex = 0
        var rightIndex = 0
        let timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { timer in

        
            if currentTurn >= maxTurns {
                timer.invalidate() // Stop the timer after 10 turns
                // Display the winner based on the final scores
                var winner :String?
                if leftPlayerScore > rightPlayerScore {
                    if  self.playerStartsAtLeft ?? false {
                        winner = "The winner is \( self.name ?? "")"
                    }else{
                        winner = "The winner is PC"
                    }
                } else if leftPlayerScore < rightPlayerScore {
                    if  self.playerStartsAtLeft ?? false {
                        winner =  "The winner is PC"
                    }else{
                        winner = "The winner is \( self.name ?? "")"
                    }
                } else {
                    winner =  "It's a Tie!"
                }
                self.openNextController(winner: winner)
                return
            }
            // Perform the game logic for each turn
            self.leftPowerLabel.isHidden = false
            self.rightPowerLabel.isHidden = false
            self.leftPowerTextLabel.isHidden = false
            self.rightPowerTextLabel.isHidden = false
            self.leftImageView.image = leftImages[leftIndex]
            self.rightImageView.image = rightImages[rightIndex]
            let leftPower = leftImagePowers[leftIndex]
            let rightPower = rightImagePowers[rightIndex]
            self.leftPowerLabel.text = String(leftPower)
            self.rightPowerLabel.text = String(rightPower)
            if leftPower > rightPower {
                leftPlayerScore += 1
            } else if leftPower < rightPower {
                rightPlayerScore += 1
            }
            self.leftScoreLabel.text = "\(leftPlayerScore)"
            self.rightScoreLabel.text = "\(rightPlayerScore)"
            currentTurn += 1
            leftIndex += 1
            rightIndex += 1
        }
        RunLoop.current.add(timer, forMode: .common)
    }
    
    
    func openNextController(winner:String?){
        let finishViewController = storyboard?.instantiateViewController(withIdentifier: "FinishViewController") as? FinishViewController
        finishViewController?.winner = winner
        navigationController?.pushViewController(finishViewController!, animated: true)
    }
    
}

