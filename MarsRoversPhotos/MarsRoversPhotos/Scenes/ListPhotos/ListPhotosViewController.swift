//
//  ListPhotosViewController.swift
//  MarsRoversPhotos
//
//  Created by Ezequiel Thomazetto on 24/02/19.
//  Copyright © 2019 Ezequiel Thomazetto. All rights reserved.
//

import UIKit

protocol ListPhotosDisplayLogic: class {
    func displayFetchedPhotos(viewModel: ListPhotos.FetchPhotos.ViewModel)
    func displayError(error: PhotosStoreError)
}

class ListPhotosViewController: MainViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, ListPhotosDisplayLogic{
    
    @IBOutlet var listPhotosView: ListPhotosView!
    
    var displayedPhotos: [ListPhotos.FetchPhotos.ViewModel.DisplayedPhoto] = []
    var interactor: ListPhotosBusinessLogic?
    var router: (NSObjectProtocol & ListPhotosRoutingLogic & ListPhotosDataPassing)?

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        
        let viewController = self
        let interactor = ListPhotosInteractor()
        let presenter = ListPhotosPresenter()
        let router = ListPhotosRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: View lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchPhotos()
    }
    
    // MARK: - Fetch photos
    
    func fetchPhotos() {
        
        let request = ListPhotos.FetchPhotos.Request(roverRequest: getCurrentRover(), earthDate: Date())
        interactor?.fetchPhotos(request: request)
        displayedPhotos = []
        self.listPhotosView.startUserRequest()
    }
    
    func displayFetchedPhotos(viewModel: ListPhotos.FetchPhotos.ViewModel) {
        
        displayedPhotos = viewModel.displayedPhotos
        self.listPhotosView.stopUserRequest()
    }
    
    func displayError(error: PhotosStoreError) {
        
        self.showError(description: error.localizedDescription, action: self.defaultFetchErrorAction)
        displayedPhotos = []
        self.listPhotosView.stopUserRequest()
    }

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return displayedPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let displayedPhoto = displayedPhotos[indexPath.row]
        let photoCell: PhotoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        photoCell.configure(displayedPhoto: displayedPhoto)
        return photoCell
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "ShowPhoto", sender: nil)
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = collectionView.frame.size.height
        let width  = collectionView.frame.size.width
        return CGSize(width: width * 0.48, height: height * 0.45)
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: RoverSegmentedControl
    
    func getCurrentRover() -> ListPhotos.FetchPhotos.Request.Rover {
        
        var resultRover: ListPhotos.FetchPhotos.Request.Rover
        switch self.listPhotosView.roverSegmentedControl.selectedSegmentIndex {
            case 0: resultRover = .Curiosity
            case 1: resultRover = .Opportunity
            case 2: resultRover  = .Spirit
            default: resultRover  = .Curiosity
        }
        
        return resultRover
    }
    
    @IBAction func roverSwitch(_ sender: Any) {
        
        fetchPhotos()
    }
}
