//
//  GenericCell.swift
//  Rewards
//
//  Created by Keith Randell Gapusan on 15/01/2019.
//  Copyright © 2019 Keith Randell Gapusan. All rights reserved.
//

import Foundation
import UIKit

class  GenericCell: BaseCell {
    
    
    let imageViewBanner: CustomImageView  = {
        let iv = CustomImageView()
        iv.backgroundColor = .lightGray
        return iv
        
    }()
    
    let viewDetailHolder : UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor.rgb(red: 10, green: 10, blue: 10, alpha: 0.3)
        
        return view
    }()
    
    let imageViewLogo: CustomImageView = {
        var iv =  CustomImageView()
        iv.backgroundColor  = .white
        return iv
    }()
    
    let imageViewFavorites: UIImageView = {
        var iv =  UIImageView()
        //  iv.backgroundColor = UIColor.lightGray
        return iv
    }()
    
    
    let lblDescription : UILabel = {
        var lbl = UILabel()
        
        lbl.text = "Loading"
        lbl.font = UIFont.systemFont(ofSize: 20)
        lbl.textColor = .white
        // lbl.backgroundColor = .green
        return lbl
    }()
    
    var promos:Promo?{
        didSet{
            if let logoUrl = promos?.image?.logo{
                self.imageViewLogo.loadImageUsingUrlString(urlString: logoUrl)
            }
            if let bannerUrl = promos?.image?.main{
                self.imageViewBanner.loadImageUsingUrlString(urlString: bannerUrl)
            }
            //imageViewLogo.image = UIImage(named: promos?.image?.logo ?? "coffee")?.withRenderingMode(.alwaysTemplate)
        }
    }
    
    override func setupView() {
        setupImageViewBanner()
        setupDetailViewHolder()
        setupImageViewFavorites()
        
        imageViewLogo.layer.cornerRadius = 25
        imageViewLogo.layer.masksToBounds = true
        imageViewLogo.contentMode = .scaleAspectFill
        
        imageViewFavorites.image = #imageLiteral(resourceName: "tab_heart").withRenderingMode(.alwaysTemplate)
        imageViewFavorites.tintColor = Constants.primary_color
        
        
    }
    func setupImageViewBanner(){
        addSubview(imageViewBanner)
        addConstraintsWithFormat(format: "H:|[v0]|", views: imageViewBanner)
        addConstraintsWithFormat(format: "V:|[v0]|", views: imageViewBanner)
    }
    
    func setupDetailViewHolder(){
        addSubview(viewDetailHolder)
        addConstraintsWithFormat(format: "V:[v0(60)]|", views: viewDetailHolder)
        addConstraintsWithFormat(format: "H:|[v0]|", views: viewDetailHolder)
        setupImageLogo()
    }
    func setupImageViewFavorites(){
        addSubview(imageViewFavorites)
        addConstraintsWithFormat(format: "V:|-10-[v0(50)]", views: imageViewFavorites)
        addConstraintsWithFormat(format: "H:[v0(50)]-10-|", views: imageViewFavorites)
    }
    
    func setupImageLogo(){
        
        viewDetailHolder.addSubview(imageViewLogo)
        viewDetailHolder.addSubview(lblDescription)
        viewDetailHolder.addConstraintsWithFormat(format: "V:|[v0]|", views: lblDescription)
        addConstraintsWithFormat(format: "V:[v0(50)]", views: imageViewLogo)
        addConstraintsWithFormat(format: "H:|-10-[v0(50)]-20-[v1]-10-|", views: imageViewLogo, lblDescription)
        addConstraint(NSLayoutConstraint.init(item: imageViewLogo , attribute: .centerY, relatedBy: .equal, toItem: viewDetailHolder, attribute: .centerY, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint.init(item: lblDescription, attribute: .centerY, relatedBy: .equal, toItem: viewDetailHolder, attribute: .centerY, multiplier: 1, constant: 0))
        
    }
    
}

