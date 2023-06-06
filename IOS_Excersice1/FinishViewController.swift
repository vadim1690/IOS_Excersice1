//
//  FinishViewController.swift
//  IOS_Excersice1
//
//  Created by Student28 on 03/06/2023.
//

import Foundation
import UIKit
class FinishViewController: UIViewController {
    var winner:String?
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var winnerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        winnerLabel.text = winner
    }
    
    @IBAction func onFinishClicked(_ sender: Any) {
        
        
        navigationController?.popToRootViewController(animated: false)
    }
}
