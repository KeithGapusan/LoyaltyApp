//
//  Banner.swift
//  Rewards
//
//  Created by Keith Randell Gapusan on 08/01/2019.
//  Copyright © 2019 Keith Randell Gapusan. All rights reserved.
//

import Foundation

class  Banner: NSObject {
    var image: String?
    var logo: String?
    var title : String?
    var details: String?
    
    init(json: [String:Any]){
        self.image = json["image"] as? String ?? ""
        self.logo = json["logo"] as? String ?? ""
        self.title = json["promo_title"] as? String ?? ""
        self.details = json["promo_title"] as? String ?? ""
    }
    
    init(image: String, logo: String, title: String, details:String) {
        self.image = image
        self.logo = logo
        self.details = details
        self.title = title
    }
    
}
