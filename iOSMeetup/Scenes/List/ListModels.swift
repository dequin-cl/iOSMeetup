//
//  ListModels.swift
//  iOSMeetup
//
//  Created by Iván on 4/22/19.
//  Copyright (c) 2019 dequin. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import SwiftyJSON
import UIKit

enum List {
    // MARK: Use cases

    enum FetchGroups {
        struct Request {
        }
        struct Response {
            let groups: [Group]
        }
        struct ViewModel {
            struct DisplayedGroup {
                let name: String
                let city: String
            }
            let displayedGroups: [DisplayedGroup]
        }
    }
}

struct Groups {
    let results: [Group]
    let meta: Meta
    struct Meta: Codable {
        let next: String
        let count: Int
        let total_count: Int
    }
}

// MARK: Entity Model
struct Group {
    let name: String
    let description: String
    let members: Int
    let rating: Double
    let who: String
    let country: String
    let city: String
    let groupPhoto: GroupPhoto
    struct GroupPhoto {
        let highres_link: String
        let photo_id: Int
        let base_url: String
        let type: String
        let photo_link: String
        let thumb_link: String
        init(json: JSON) {
            highres_link = json["highres_link"].stringValue
            photo_id = json["photo_id"].intValue
            base_url = json["base_url"].stringValue
            type = json["type"].stringValue
            photo_link = json["photo_link"].stringValue
            thumb_link = json["thumb_link"].stringValue
        }
    }

    init(json: JSON) {
        name = json["name"].stringValue
        description = json["description"].stringValue
        members = json["members"].intValue
        rating = json["rating"].doubleValue
        who = json["who"].stringValue
        country = json["country"].stringValue
        city = json["city"].stringValue
        groupPhoto = GroupPhoto(json: json["group_photo"])
    }
}
