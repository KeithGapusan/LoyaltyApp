//
//  Image.swift
//  Rewards
//
//  Created by Keith Randell Gapusan on 08/01/2019.
//  Copyright © 2019 Keith Randell Gapusan. All rights reserved.
//

import Foundation

class Image: NSObject {
    var main : String?
    var logo : String?
    
    init(json : [String:Any]){
        self.main =  json["main"] as? String
        self.logo =  json["logo"] as? String
    }
        
}
/*
"image": {
    "main": "https://www.wernerlumber.com/wp-content/uploads/2018/01/Tools-hardware-500x350.jpg",
    "logo": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSa_uW7t5mjGmILkEzZc5ymMSKrd8BdIScsWrG1htu5c3VcM0fX"
},*/
