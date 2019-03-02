//
//  ShowPhotoInteractor.swift
//  MarsRoversPhotos
//
//  Created by Ezequiel Thomazetto on 27/02/19.
//  Copyright © 2019 Ezequiel Thomazetto. All rights reserved.
//

import UIKit

protocol ShowPhotoBusinessLogic {
    func getPhoto(request: ShowPhoto.GetPhoto.Request)
}

protocol ShowPhotoDataStore {
    var photo: Photo! { get set }
}

class ShowPhotoInteractor: ShowPhotoBusinessLogic, ShowPhotoDataStore {
    
    var presenter: ShowPhotoPresentationLogic?
    var photo: Photo!
    
    func getPhoto(request: ShowPhoto.GetPhoto.Request) {
        
        let response = ShowPhoto.GetPhoto.Response(photo: photo)
        presenter?.presentPhoto(response: response)
    }
}
