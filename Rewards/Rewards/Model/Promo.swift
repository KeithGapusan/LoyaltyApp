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
    var attendance : Attendance?


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



class Month: NSObject {
   // var attennceArray = [String:Any]()
    var attendanceA = [Attendance]()
    
    init(json: [Any]){
        for data in json{
            let convertedData = data as? [String:Any]
            print("converted == \(convertedData?.keys)")
        }
    }
    
    
    init(json: [String: Any]) {

        print(json.keys)
        for data in json{
            let val  = data.value as! [String:Any]
            for logs in val.values{
                let attendance = logs as? [[String:Any]]
                for list in attendance!{
                    self.attendanceA.append(Attendance.init(json: list))

                }

            }
            
        }
        for data in self.attendanceA{
            print(data.timeIn)
        }
       
    }
}

class Attendance: NSObject {
    var timeIn : [Double]?

    
    init(json: [String: Any]) {
        print(json.keys)
        if let timeInjason = json["time_in"] as? [Double]{
               self.timeIn  = json["time_in"] as? [Double]
        }
     
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

//"attendance": {
//    "1548227820": {
//        "time_in": [
//        1548227890,
//        1548227890
//        ],
