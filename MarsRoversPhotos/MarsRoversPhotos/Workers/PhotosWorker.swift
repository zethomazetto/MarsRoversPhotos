//
//  PhotosWorker.swift
//  MarsRoversPhotos
//
//  Created by Ezequiel Thomazetto on 24/02/19.
//  Copyright © 2019 Ezequiel Thomazetto. All rights reserved.
//

import Foundation

class PhotosWorker {

    var photosStore: PhotosStoreProtocol
    
    init(photosStore: PhotosStoreProtocol) {
        
        self.photosStore = photosStore
    }
    
    func fetchPhotos(request: ListPhotos.FetchPhotos.Request, onSuccess: @escaping (_ result: [Photo]) -> (), onError: @escaping (_ error: PhotosStoreError) -> ()) {
        
        photosStore.fetchPhotos(request: request, onSuccess: { photoList in
            onSuccess(photoList.photos)
        }) { error in
            onError(error)
        }
    }
}

protocol PhotosStoreProtocol {
    
    func fetchPhotos(request: ListPhotos.FetchPhotos.Request, onSuccess: @escaping (_ result: PhotoList) -> (), onError: @escaping (_ error: PhotosStoreError) -> ())
}

enum PhotosStoreError: Error {
    
    case CannotFetch(String)
}
