//
//  ListPhotosPresenter.swift
//  MarsRoversPhotos
//
//  Created by Ezequiel Thomazetto on 24/02/19.
//  Copyright © 2019 Ezequiel Thomazetto. All rights reserved.
//

import UIKit

protocol ListPhotosPresentationLogic {
    func presentFetchedPhotos(response: ListPhotos.FetchPhotos.Response)
    func presentErrorOnFetchPhotos(responseError: ListPhotos.FetchPhotos.Error)
}

class ListPhotosPresenter: ListPhotosPresentationLogic {

    weak var viewController: ListPhotosDisplayLogic?
    
    func presentFetchedPhotos(response: ListPhotos.FetchPhotos.Response) {
        
        var displayedPhotos: [ListPhotos.FetchPhotos.ViewModel.DisplayedPhoto] = []
        
        for photo in response.photos{
            
            let photoURL = URL(string: photo.img_src)
            let displayedPhoto = ListPhotos.FetchPhotos.ViewModel.DisplayedPhoto(photoURL: photoURL!)
            displayedPhotos.append(displayedPhoto)
        }
        
        let viewModel = ListPhotos.FetchPhotos.ViewModel(displayedPhotos: displayedPhotos)
        viewController?.displayFetchedPhotos(viewModel: viewModel)
        
    }

    func presentErrorOnFetchPhotos(responseError: ListPhotos.FetchPhotos.Error) {
        
        viewController?.displayError(error: responseError.error)
    }
}
