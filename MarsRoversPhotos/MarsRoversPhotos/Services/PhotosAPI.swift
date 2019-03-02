//
//  PhotosAPI.swift
//  MarsRoversPhotos
//
//  Created by Ezequiel Thomazetto on 25/02/19.
//  Copyright © 2019 Ezequiel Thomazetto. All rights reserved.
//

import Foundation
import Alamofire

class PhotosAPI: PhotosStoreProtocol {
    
    let sessionManager: SessionManager = Alamofire.SessionManager.default
    var apikey: String = "XHeR7Sh4AjA0Vh0ivmhmHHTPTufCUtqXnfKZQHbk"
    let base_url = "https://api.nasa.gov/mars-photos/api/v1"
    
    func fetchPhotos(request: ListPhotos.FetchPhotos.Request, onSuccess: @escaping (PhotoList) -> (), onError: @escaping (PhotosStoreError) -> ()) {

        let requestPath = request.requestPath(roverRequest: request.roverRequest)
        let requestDate = request.requestDate(earthDate: request.earthDate)
        
        self.sessionManager.request("\(base_url)/rovers/\(requestPath)/photos?earth_date=\(requestDate)&api_key=\(apikey)")
            .validate()
            .responseJSON { response in
            
            guard response.result.error == nil else {
            onError(PhotosStoreError.CannotFetch((response.result.error?.localizedDescription)!))
                return
            }
            
            guard let data = response.data else {
                onError(PhotosStoreError.CannotFetch("Invalid Data"))
                return
            }
            
            do{
                let photoList = try JSONDecoder().decode(PhotoList.self, from: data)
                onSuccess(photoList)
            }
            catch{
                onError(error as! PhotosStoreError)
            }
        }
    }
}
