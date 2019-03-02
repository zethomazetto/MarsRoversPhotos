//
//  ListPhotosInteractor.swift
//  MarsRoversPhotos
//
//  Created by Ezequiel Thomazetto on 24/02/19.
//  Copyright © 2019 Ezequiel Thomazetto. All rights reserved.
//

import UIKit

protocol ListPhotosBusinessLogic {
    func fetchPhotos(request: ListPhotos.FetchPhotos.Request)
}

protocol ListPhotosDataStore {
    var photos: [Photo]? { get }
}

class ListPhotosInteractor: ListPhotosBusinessLogic, ListPhotosDataStore {

    var presenter: ListPhotosPresentationLogic?
    var photosWorker = PhotosWorker(photosStore: PhotosAPI())
    var photos: [Photo]?
    var request: ListPhotos.FetchPhotos.Request?
    
    func fetchPhotosResponse() {
        
        if(self.photos?.count == 0){
            let currentDate = request?.earthDate
            self.request?.earthDate = Calendar.current.date(byAdding: .day, value: -1, to: currentDate!)!
            self.fetchPhotos(request: self.request!)
        }
        else{
            let response = ListPhotos.FetchPhotos.Response(photos: self.photos!)
            self.presenter?.presentFetchedPhotos(response: response)
        }
    }
    
    func fetchPhotos(request: ListPhotos.FetchPhotos.Request) {
        
        self.request = request
        photosWorker.fetchPhotos(request: request, onSuccess: { photos in
            
            self.photos = photos
            self.fetchPhotosResponse()
        }) { error in
            
            let responseError = ListPhotos.FetchPhotos.Error(error: error)
            self.presenter?.presentErrorOnFetchPhotos(responseError: responseError)
        }
    }
}
