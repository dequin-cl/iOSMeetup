//
//  DetailModels.swift
//  iOSMeetup
//
//  Created on 4/23/19.
//  Copyright (c) 2019 dequin. All rights reserved.
//
import Foundation

// swiftlint:disable nesting
enum Detail {

    enum DisplaySelectedGroup {
        struct Request {
        }
        struct Response {
            let group: Group
        }
        struct ViewModel {
            struct DisplayedGroup {
                let name: String
                let description: NSAttributedString
                let members: String
                let rating: String
            }
            var displayGroup: DisplayedGroup
        }
    }

    enum GroupImage {
        struct Request {
        }
        struct Response {
            let imageData: Data
        }
        struct ViewModel {
            let imageData: Data
        }
    }
}

// swiftlint:enable nesting
