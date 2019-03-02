//
//  ShowPhotoPresenter.swift
//  MarsRoversPhotos
//
//  Created by Ezequiel Thomazetto on 27/02/19.
//  Copyright © 2019 Ezequiel Thomazetto. All rights reserved.
//

import UIKit

protocol ShowPhotoPresentationLogic {
    func presentPhoto(response: ShowPhoto.GetPhoto.Response)
}

class ShowPhotoPresenter: ShowPhotoPresentationLogic {

    weak var viewController: ShowPhotoDisplayLogic?
    
    func presentPhoto(response: ShowPhoto.GetPhoto.Response) {
        
        let photo = response.photo
        let photoURL = URL(string: photo.img_src)
        let displayedPhoto = ShowPhoto.GetPhoto.ViewModel.DisplayedPhoto(name: photo.camera.name, full_name: photo.camera.full_name, photoURL: photoURL!)
        let viewModel = ShowPhoto.GetPhoto.ViewModel(displayedPhoto: displayedPhoto)
        viewController?.displayPhoto(viewModel: viewModel)
    }
}
