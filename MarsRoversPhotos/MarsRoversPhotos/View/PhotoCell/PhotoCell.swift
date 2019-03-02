//
//  PhotoCell.swift
//  MarsRoversPhotos
//
//  Created by Ezequiel Thomazetto on 24/02/19.
//  Copyright © 2019 Ezequiel Thomazetto. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotoCell: UICollectionViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(displayedPhoto: ListPhotos.FetchPhotos.ViewModel.DisplayedPhoto) {
        
        self.photoImageView.af_setImage(withURL: displayedPhoto.photoURL)
    }
}
