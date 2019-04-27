//
//  DetailViewController.swift
//  iOSMeetup
//
//  Created on 4/23/19.
//  Copyright (c) 2019 dequin. All rights reserved.
//

import UIKit

protocol DetailDisplayLogic: AnyObject {
    func displayGroup(viewModel: Detail.DisplaySelectedGroup.ViewModel)
    func displayGroupImage(viewModel: Detail.GroupImage.ViewModel)
}

class DetailViewController: UIViewController, DetailDisplayLogic {
    var interactor: DetailBusinessLogic?
    var router: (NSObjectProtocol & DetailRoutingLogic & DetailDataPassing)?

    //@IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var groupDescription: UILabel!
    @IBOutlet weak var groupMembers: UILabel!
    @IBOutlet weak var groupRating: UILabel!
    @IBOutlet weak var groupPhoto: UIImageView!

    // MARK: Object lifecycle

    override  init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
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
        let interactor = DetailInteractor()
        let presenter = DetailPresenter()
        let router = DetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: Routing

    override  func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureGroupPhoto()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showGroupDetail()
        getGroupImage()
    }

    // MARK: Methods
    private func configureGroupPhoto() {
        let loadingGif = UIImage.gifImageWithName("loading")
        groupPhoto.image = loadingGif
        groupPhoto.alpha = 0.5
    }

     func showGroupDetail() {
        let request = Detail.DisplaySelectedGroup.Request()
        interactor?.showGroupDetail(request: request)
    }

    func getGroupImage() {
        let request = Detail.GroupImage.Request()
        interactor?.getGroupImage(request: request)
    }

     func displayGroup(viewModel: Detail.DisplaySelectedGroup.ViewModel) {
        let displayGroup = viewModel.displayGroup
        groupName.text = displayGroup.name
        groupDescription.attributedText = displayGroup.description
        groupMembers.text = displayGroup.members
        groupRating.text = displayGroup.rating
    }

    func displayGroupImage(viewModel: Detail.GroupImage.ViewModel) {
        UIView.animate(
            withDuration: 0.3
        ) {
            self.groupPhoto.image = UIImage(data: viewModel.imageData)
            self.groupPhoto.alpha = 1
        }
    }
}
