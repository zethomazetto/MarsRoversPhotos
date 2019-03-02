//
//  ListPhotosView.swift
//  MarsRoversPhotos
//
//  Created by Ezequiel Thomazetto on 02/03/19.
//  Copyright © 2019 Ezequiel Thomazetto. All rights reserved.
//

import UIKit

class ListPhotosView: UIView {

    @IBOutlet weak var roverSegmentedControl: UISegmentedControl!
    @IBOutlet weak var listPhotosCollectionView: UICollectionView!
    let spinner = UIActivityIndicatorView(style: .gray)

    override func layoutSubviews() {
        
        self.registerPhotoCell()
        self.setupSpinner()
    }
    
    func registerPhotoCell() {
        
        self.listPhotosCollectionView.register(UINib(nibName: "PhotoCell", bundle: .main), forCellWithReuseIdentifier: "PhotoCell")
    }
    
    func setupSpinner() {
        
        self.listPhotosCollectionView.addSubview(spinner)
        self.spinner.hidesWhenStopped = true
        self.spinner.center = self.center
    }
    
    func startUserRequest() {
        
        self.listPhotosCollectionView.reloadData()
        self.spinner.startAnimating()
    }
    
    func stopUserRequest() {
        
        self.listPhotosCollectionView.reloadData()
        self.spinner.stopAnimating()
    }
}
