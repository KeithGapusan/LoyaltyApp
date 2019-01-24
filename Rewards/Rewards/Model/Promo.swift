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
        let attendance = Attendance.init(json: json)
        print("lkeys \(json.keys)")
        print(json.values.first)
        
        
        for data in json{
            let val  = data.value as! [String:Any]
            
            attendanceA.append(Attendance.init(json: val))
        }
        for data in self.attendanceA{
            print(data.timeIn)
        }
//        for data in json.values{
//            self.attennceArray = data as! [String:Any]
//            for data in self.attennceArray{
//                let convertedData = data.value as? [String:Any]
//
//                let  data2 =  Attendance.init(json: convertedData ?? ["":""])
//
//                print("data == \(convertedData)")
//                // print(convertedData.keys)
//                //     }
//
//            }
//        }
       
    }
}

class Attendance: NSObject {
    var timeIn : [Double]?

    
    init(json: [String: Any]) {
        if let timeInjason = json["time_in"] as? [Double]{
            
        }
        self.timeIn  = json["time_in"] as? [Double]
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
