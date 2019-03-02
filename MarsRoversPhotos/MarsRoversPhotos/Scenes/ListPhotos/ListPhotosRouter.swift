//
//  ListPhotosRouter.swift
//  MarsRoversPhotos
//
//  Created by Ezequiel Thomazetto on 24/02/19.
//  Copyright © 2019 Ezequiel Thomazetto. All rights reserved.
//

import UIKit

@objc protocol ListPhotosRoutingLogic {
    func routeToShowPhoto(segue: UIStoryboardSegue?)
}

protocol ListPhotosDataPassing
{
    var dataStore: ListPhotosDataStore? { get }
}

class ListPhotosRouter: NSObject, ListPhotosRoutingLogic, ListPhotosDataPassing{

    weak var viewController: ListPhotosViewController?
    var dataStore: ListPhotosDataStore?
    
    // MARK: Routing
    
    func routeToShowPhoto(segue: UIStoryboardSegue?) {
        
        if let segue = segue {
            let destinationVC = segue.destination as! ShowPhotoViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToShowOrder(source: dataStore!, destination: &destinationDS)
        } else {
            let destinationVC = viewController?.storyboard?.instantiateViewController(withIdentifier: "ShowPhotoViewController") as! ShowPhotoViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToShowOrder(source: dataStore!, destination: &destinationDS)
            navigateToShowOrder(source: viewController!, destination: destinationVC)
        }
    }
    
    // MARK: Navigation
    
    func navigateToShowOrder(source: ListPhotosViewController, destination: ShowPhotoViewController) {
        
        source.show(destination, sender: nil)
    }
    
    // MARK: Passing data
    
    func passDataToShowOrder(source: ListPhotosDataStore, destination: inout ShowPhotoDataStore) {
        
        let selectedCell = viewController?.listPhotosView.listPhotosCollectionView.indexPathsForSelectedItems?.last?.row
        destination.photo = source.photos?[selectedCell!]
    }
}
