//
//  GenericCollectionViewCell.swift
//  Rewards
//
//  Created by Keith Randell Gapusan on 06/01/2019.
//  Copyright © 2019 Keith Randell Gapusan. All rights reserved.
//

import UIKit

class GenericCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var ivFavorites: UIImageView!
    @IBOutlet weak var ivBanner: CustomImageView!
    @IBOutlet weak var ivLogo: CustomImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    var promo : Promo?{
        didSet{
            self.lblTitle.text = promo?.title ?? ""
            if let logoUrl = promo?.image?.logo{
                self.ivLogo.loadImageUsingUrlString(urlString: logoUrl)
            }
            if let bannerUrl = promo?.image?.main{
                self.ivBanner.loadImageUsingUrlString(urlString:bannerUrl )
            }
            if promo!.favorite {
                self.ivFavorites.tintColor = Constants.primary_color
            }
        }
    }

    
    var banner: Banner?{
        didSet{
            self.lblTitle.text = banner?.title ?? ""
            if let promoUrl = banner?.logo{
                self.ivLogo.loadImageUsingUrlString(urlString: promoUrl)
            }
            if let bannerUrl = banner?.image{
                self.ivBanner.loadImageUsingUrlString(urlString:bannerUrl )
            }
                  self.lblTitle.text = banner?.title
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.ivFavorites.image = UIImage(named: "tab_heart")?.withRenderingMode(.alwaysTemplate)
        self.ivFavorites.tintColor = UIColor.init(white: 1, alpha: 0.5)
       
        self.ivLogo.backgroundColor = .gray
        self.ivLogo.contentMode = .scaleAspectFill
        self.ivLogo.layer.cornerRadius = ivLogo.frame.width / 2
        self.ivLogo.layer.masksToBounds = true
        
        self.ivBanner.contentMode = .scaleAspectFill
        self.ivFavorites.contentMode = .scaleAspectFill
        self.layer.cornerRadius = 5
    }
}
