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

    
}
