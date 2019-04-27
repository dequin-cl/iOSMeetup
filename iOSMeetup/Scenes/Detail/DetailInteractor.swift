//
//  DetailInteractor.swift
//  iOSMeetup
//
//  Created on 4/23/19.
//  Copyright (c) 2019 dequin. All rights reserved.
//

import Foundation

protocol DetailBusinessLogic {
    func showGroupDetail(request: Detail.DisplaySelectedGroup.Request)
    func getGroupImage(request: Detail.GroupImage.Request)
}

protocol DetailDataStore {
    var group: Group! { get set }
}

class DetailInteractor: DetailBusinessLogic, DetailDataStore {
    var presenter: DetailPresentationLogic?
    var worker: DetailWorker = DetailWorker()
    // var name: String = ""
    var group: Group!
    // MARK: Methods

     func showGroupDetail(request: Detail.DisplaySelectedGroup.Request) {

        let response = Detail.DisplaySelectedGroup.Response(group: group)
        presenter?.presentGroup(response: response)
    }

    func getGroupImage(request: Detail.GroupImage.Request) {

        let url = URL(string: group.groupPhoto.highres_link)

        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            guard let imageData = data else {
                return
            }
            DispatchQueue.main.async {
                let response = Detail.GroupImage.Response(imageData: imageData)
                self.presenter?.presentGroupImage(response: response)
            }
        }
    }
}
