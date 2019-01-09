//
//  CustomImageView.swift
//  Rewards
//
//  Created by Keith Randell Gapusan on 09/01/2019.
//  Copyright © 2019 Keith Randell Gapusan. All rights reserved.
//

import Foundation
import UIKit

class CustomImageView: UIImageView{
    var imageUrlString: String?
    let imageCache = NSCache<AnyObject, AnyObject>()

    func loadImageUsingUrlString(urlString:String){
        
        imageUrlString = urlString
        
        let url = URL(string: urlString)
        image = nil
        if let cache = imageCache.object(forKey: urlString as AnyObject) as? UIImage{
            self.image = cache
            return
        }
        URLSession.shared.dataTask(with: url!) {
            (data, response, error) in
            if error != nil{
                print(error ?? "")
                return
            }
            DispatchQueue.main.async {
                let cache = UIImage(data: data!)
                if self.imageUrlString == urlString{
                    self.image = cache
                }
                self.imageCache.setObject(cache!, forKey: urlString  as AnyObject)
               // imageCache.setObject(cache!, forKey: urlString as AnyObject)
            }
            }.resume()
    }
}
