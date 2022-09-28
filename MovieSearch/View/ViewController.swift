//
//  ViewController.swift
//  MovieSearch
//
//  Created by Eray on 23.09.2022.
//

import UIKit
import FirebaseRemoteConfig



class ViewController: UIViewController {
    
    @IBOutlet weak var rcLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        didConnected()
    }
    
}


// RC Setup and Check Internet Extension
extension ViewController {
    func didConnected(){
        if NetworkMonitor.shared.isConnected {
            setupRemoteConfigDefaults()
            displayNewValues()
            fetchRemoteConfig()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
                self.setupNavi()
            }
        }else {
            let alert = UIAlertController(title: "Error", message: "An error occured. Please check your connection.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    func setupRemoteConfigDefaults() {
        let defaultValue = ["InitialText": "" as NSObject]
        remoteConfig.setDefaults(defaultValue)
    }
    
    func fetchRemoteConfig(){
        remoteConfig.fetch(withExpirationDuration: 0) { [unowned self] (status, error) in
            guard error == nil else { return }
            print("Got the value from Remote Config!")
            remoteConfig.activate()
            self.displayNewValues()
        }
    }
    func displayNewValues(){
        let newLabelText = remoteConfig.configValue(forKey: "defaultValue").stringValue ?? ""
        rcLabel.text = newLabelText
    }
     
    func setupNavi(){
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "MovieSearchVC") as! MovieSearchVC
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
