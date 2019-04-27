//
//  DetailPresenter.swift
//  iOSMeetup
//
//  Created on 4/23/19.
//  Copyright (c) 2019 dequin. All rights reserved.
//

import UIKit

protocol DetailPresentationLogic {
    func presentGroup(response: Detail.DisplaySelectedGroup.Response)
    func presentGroupImage(response: Detail.GroupImage.Response)
}

class DetailPresenter: DetailPresentationLogic {
    weak  var viewController: DetailDisplayLogic?

    // MARK: Methods

     func presentGroup(response: Detail.DisplaySelectedGroup.Response) {
        let group = response.group
        let description = group.description.htmlToAttributedString ?? NSAttributedString(string: "There's a problem with this group description. Sorry")

        let newDescription: NSMutableAttributedString = description.mutableCopy() as! NSMutableAttributedString
        newDescription.addAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)], range: NSRange(location: 0, length: description.length))

        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        let formattedMembers: String = formatter.string(from: NSNumber(integerLiteral: group.members)) ?? String(group.members)

        let displayedGroup = Detail.DisplaySelectedGroup.ViewModel.DisplayedGroup(
            name: group.name,
            description: newDescription,
            members: "Total members: \(formattedMembers)",
            rating: "Group rating: \(group.rating)"
        )
        let viewModel = Detail.DisplaySelectedGroup.ViewModel(displayGroup: displayedGroup)
        viewController?.displayGroup(viewModel: viewModel)
    }

    func presentGroupImage(response: Detail.GroupImage.Response) {
        let viewModel = Detail.GroupImage.ViewModel(imageData: response.imageData)
        viewController?.displayGroupImage(viewModel: viewModel)
    }
}
