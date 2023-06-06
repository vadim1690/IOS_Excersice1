//
//  ViewController.swift
//  IOS_Excersice1
//
//  Created by Student28 on 31/05/2023.
//

import UIKit
import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate{
    
   
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var rightImage: UIImageView!
    @IBOutlet weak var leftImage: UIImageView!
    @IBOutlet weak var enterNameButton: UIButton!
    let userNameKey = "UserName"
    let locationManager = CLLocationManager()
   
    let targetLongitude = 34.817549168324334
    var userName:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let saveName = UserDefaults.standard.string(forKey: userNameKey){
            greetingLabel.text = "Hello, \(saveName)"
            userName = saveName
            initializeOnUserEntered()
        }else{
            showNameButton()
        }
    }
    
    private func startUpdatingLocation(){
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    
    @IBAction func startGame(_ sender: UIButton) {
        
        
         let gameViewController = storyboard?.instantiateViewController(withIdentifier: "GameViewController") as? GameViewController
         gameViewController?.name = userName
        gameViewController?.playerStartsAtLeft = rightImage.isHidden
         navigationController?.pushViewController(gameViewController!, animated: true)
       
//        self.dismiss(animated: true){
//            self.present(gameViewController, animated:true,completion: nil)
//        }
    }
    
    
    
    func locationManager(_ manager:CLLocationManager,didUpdateLocations locations: [CLLocation]){
        guard let currentLocation = locations.last else {return}
        
        let deviceLongitude = currentLocation.coordinate.longitude
        print(deviceLongitude)
        if deviceLongitude < targetLongitude {
            leftImage.isHidden = false
            rightImage.isHidden = true
        }else{
            rightImage.isHidden = false
            leftImage.isHidden = true
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse {
            startUpdatingLocation()
        }
        if manager.authorizationStatus == .denied {
            print("Location manager error: denied)")
        }
        if manager.authorizationStatus == .restricted {
            print("Location manager error: restricted")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager error: \(error.localizedDescription)")
    }
    
    @IBAction func enterNameButtonTapped(_ sender:UIButton){
        let alertController = UIAlertController(title: "Enter Name", message: nil, preferredStyle: .alert)
        alertController.addTextField{ textField in
            textField.placeholder = "Name"
        }
        
        let finishAction = UIAlertAction(title: "Finish", style: .default){ [weak self] _ in
            if let name = alertController.textFields?.first?.text{
                self?.updateGreetingLabel(with: name)
                self?.initializeOnUserEntered()
            }
        }
        
        alertController.addAction(finishAction)
        present(alertController,animated:true,completion: nil)
        

    }
    
    @IBOutlet weak var greetingLabel: UILabel!
    private func updateGreetingLabel(with name: String){
        greetingLabel.text = "Hello, \(name)"
        UserDefaults.standard.set(name,forKey: userNameKey)
        userName = name
        
    }
    
    func initializeOnUserEntered(){
        showNameLabel()
        startUpdatingLocation()
        startButton.isHidden = false
    }
    
    func showNameLabel(){
        enterNameButton.isHidden = true
        greetingLabel.isHidden = false
    }
    
    func showNameButton(){
        enterNameButton.isHidden = false
        greetingLabel.isHidden = true
        startButton.isHidden = true
    }
    

    


}


