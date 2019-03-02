//
//  MainViewController.swift
//  MarsRoversPhotos
//
//  Created by Ezequiel Thomazetto on 02/03/19.
//  Copyright © 2019 Ezequiel Thomazetto. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    let defaultFetchErrorAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    
    func showError(description: String, action: UIAlertAction) {
        
        let alert = UIAlertController(title: "Error", message: description, preferredStyle: .alert)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
