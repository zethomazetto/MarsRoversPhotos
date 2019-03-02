//
//  ListPhotosModels.swift
//  MarsRoversPhotos
//
//  Created by Ezequiel Thomazetto on 24/02/19.
//  Copyright © 2019 Ezequiel Thomazetto. All rights reserved.
//

import UIKit

enum ListPhotos {
    
    enum FetchPhotos {
        
        struct Request {
            
            enum Rover {
                case Curiosity
                case Opportunity
                case Spirit
            }
            
            func requestPath(roverRequest: Rover) -> String {
                var resultPath: String
                
                switch roverRequest {
                case .Curiosity:
                    resultPath = "curiosity"
                case .Opportunity:
                    resultPath = "opportunity"
                case .Spirit:
                    resultPath = "spirit"
                }
                
                return resultPath
            }
            
            func requestDate(earthDate: Date) -> String {
                let formatter = DateFormatter()
                formatter.dateFormat = "YYYY-MM-dd"
                return formatter.string(from: earthDate)
            }
            
            var roverRequest: Rover
            var earthDate: Date
            
        }
        
        struct Response {
            var photos: [Photo]
        }
        
        struct Error {
            var error: PhotosStoreError
        }
        
        struct ViewModel {
            
            struct DisplayedPhoto {
                var photoURL: URL
            }
            
            var displayedPhotos: [DisplayedPhoto]
        }
    }
}
