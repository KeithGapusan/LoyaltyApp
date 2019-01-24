//
//  ApiServiceHandler.swift
//  Rewards
//
//  Created by Keith Randell Gapusan on 09/01/2019.
//  Copyright © 2019 Keith Randell Gapusan. All rights reserved.
//

import Foundation


class APIServiceHandler: NSObject {
    
    static var shared = APIServiceHandler()
    let baseUrl = urlBase.dev.rawValue
    func fetchPromos(completion: @escaping ([Promo], [Banner]) -> ()){
        let url = URL(string: "\(baseUrl)\(urlPath.rewards.rawValue)")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil{
                return
            }
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                var promos = [Promo]()
                var banners = [Banner]()
                for dict in json as! [String:Any]{
                    print(dict.key)
                    switch dict.key {
                    case "banner":
                        for dataBanner in dict.value as! [[String:Any]]{
                            let banner = Banner.init(json: dataBanner)
                            banners.append(banner)
                        }
                    case "promo":
                        for dataPromos in dict.value as! [[String:Any]]{
                            let promo = Promo.init(json: dataPromos)
                            promos.append(promo)
                        }
                    default:
                        print("no content available")
                    }
                }
                DispatchQueue.main.async {
                    completion(promos ,  banners)
                }
            } catch let jsonError{
                print(jsonError)
            }
            
            }.resume()
    }

    func fetchMonth(completion: @escaping (Month) -> ()){
        let url =  "https://demo4853863.mockable.io/attendance"
        guard let serviceUrl = URL(string: url) else { return }
        let parameterDictionary = ["username" : "Test", "password" : "123456"]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        let session = URLSession.shared
      
        session.dataTask(with: request) { (data, response, error) in
            if error != nil{
                return
            }
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                var month : Month?
                for dict in json as! [String:Any]{
                    print(dict.key)
                    switch dict.key {
                    case "attendance":
                        month = Month.init(json:  dict.value as! [String:Any])
                   //     print("dict \(dict.value)")
                        
                        
                       // let month2 = Month.init(json: (dict.value as? [Any])!)
//                        
//                        let array = dict.value as? [[String:Any]]
//                        for monthData in array!{
////                            let data = monthData.
////                            let attendance  = Attendance.init(json:monthData)
//                            print("data=======\(monthData)")
//                        }
//                        
//                        for monthData in dict.value as! [String:Any]{
//                            let data = monthData as? [String:Any]
//
//
//
//                        }
                    case "banner":
                        for dataBanner in dict.value as! [[String:Any]]{
                            let banner = Banner.init(json: dataBanner)
                        }
                    case "promo":
                        for dataPromos in dict.value as! [[String:Any]]{
                            let promo = Promo.init(json: dataPromos)
                          
                        }
                    default:
                        print("no content available")
                    }
                }
                DispatchQueue.main.async {
                    completion(month!)
                }
            } catch let jsonError{
                print(jsonError)
            }
            
            }.resume()
    }

}
