//
//  ShowPhotoViewController.swift
//  MarsRoversPhotos
//
//  Created by Ezequiel Thomazetto on 24/02/19.
//  Copyright © 2019 Ezequiel Thomazetto. All rights reserved.
//

import UIKit

protocol ShowPhotoDisplayLogic: class {
    func displayPhoto(viewModel: ShowPhoto.GetPhoto.ViewModel)
}

class ShowPhotoViewController: UIViewController, ShowPhotoDisplayLogic {
    
    @IBOutlet var showPhotoView: ShowPhotoView!
    
    var interactor: ShowPhotoBusinessLogic?
    var router: ShowPhotoDataPassing?
    
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
        let interactor = ShowPhotoInteractor()
        let presenter = ShowPhotoPresenter()
        let router = ShowPhotoRouter()
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
        getPhoto()
    }
    
    func getPhoto() {
        
        let request = ShowPhoto.GetPhoto.Request()
        interactor?.getPhoto(request: request)
    }
    
    func displayPhoto(viewModel: ShowPhoto.GetPhoto.ViewModel) {
        
        let displayedPhoto = viewModel.displayedPhoto
        self.showPhotoView.configureView(displayedPhoto: displayedPhoto)
    }
}
