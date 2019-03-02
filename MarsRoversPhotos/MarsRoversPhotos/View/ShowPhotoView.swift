//
//  ShowPhotoView.swift
//  MarsRoversPhotos
//
//  Created by Ezequiel Thomazetto on 02/03/19.
//  Copyright © 2019 Ezequiel Thomazetto. All rights reserved.
//

import UIKit
import AlamofireImage

enum CameraName {
    case Short
    case Full
}

class ShowPhotoView: UIView {

    @IBOutlet weak var cameraNameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    var cameraName: CameraName = .Short
    var shortCameraName: String?
    var fullCameraName: String?
    
    override func layoutSubviews() {
        
        self.configureCameraNameLabelTap()
    }
    
    func configureCameraNameLabelTap() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(nameTapped(sender:)))
        self.cameraNameLabel.addGestureRecognizer(tap)
    }
    
    @objc func nameTapped(sender:UITapGestureRecognizer) {
        
        setCameraName()
    }
    
    func setCameraName() {
        
        switch cameraName {
            case .Short:
                cameraNameLabel.text = shortCameraName
                cameraName = .Full
            case .Full:
                cameraNameLabel.text = fullCameraName
                cameraName = .Short
        }
    }
    
    func configureView(displayedPhoto: ShowPhoto.GetPhoto.ViewModel.DisplayedPhoto) {
        
        self.photoImageView.af_setImage(withURL: displayedPhoto.photoURL)
        self.shortCameraName = displayedPhoto.name
        self.fullCameraName = displayedPhoto.full_name
        setCameraName()
    }
}
