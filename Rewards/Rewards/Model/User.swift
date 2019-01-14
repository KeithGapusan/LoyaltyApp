//
//  User.swift
//  Rewards
//
//  Created by Keith Randell Gapusan on 13/01/2019.
//  Copyright © 2019 Keith Randell Gapusan. All rights reserved.
//

import Foundation


class User:NSObject{
    var id : Int
    var first_name:  String
    var last_name: String
    var middle_name: String
    var birth_date: Date
    var profile_url : String
    
    init(json: [String:Any]){
        self.id = json["id"] as? String
        self.first_name = json["first_name"] as? String
        self.last_name = json["last_name"] as? String
        self.middle_name = json["middle_name"] as? String
        self.birth_date = json["birtdate"] as? Double
        self.profile_url = json["profile_photo"] as? String
    }
    
}
