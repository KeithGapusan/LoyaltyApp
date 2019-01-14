//
//  Promo.swift
//  Rewards
//
//  Created by Keith Randell Gapusan on 08/01/2019.
//  Copyright © 2019 Keith Randell Gapusan. All rights reserved.
//

import Foundation

class  Promo: NSObject {
    var image: Image?
    var logo: String?
    var title : String?
    var details: String?
    var favorite: Bool

    init(json: [String: Any]) {
        self.logo             = json["logo"] as? String
        self.details          = json["details"] as? String
        self.title            = json["title"] as? String
        if let image          = json["image"] as? [String: String]{
            self.image =  Image.init(json: image)
        }
        self.favorite          = json["favorites"] as? Bool ?? false
    }
}
/*
 "image": {
    "main": "https://www.wernerlumber.com/wp-content/uploads/2018/01/Tools-hardware-500x350.jpg",
    "logo": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSa_uW7t5mjGmILkEzZc5ymMSKrd8BdIScsWrG1htu5c3VcM0fX"
 },
 "title": "Handyman",
 "details": "details",
 "date": 123123124,
 "type": "discounts",
 "favorites": true
 */

