//
//  Constants.swift
//  Rewards
//
//  Created by Keith Randell Gapusan on 09/01/2019.
//  Copyright © 2019 Keith Randell Gapusan. All rights reserved.
//

import Foundation
import UIKit

enum urlBase:String {
    case dev  = "http://demo7001562.mockable.io"
    case staging = "http://demo7001562.mockable.io/r"
    case prod = ""
    
}

enum urlPath: String{
    case rewards = "/rewards/all"
    
}

class Constants: NSObject {
    static let primary_color = UIColor.rgb(red: 114, green: 20, blue: 32, alpha: 1.0)
}
