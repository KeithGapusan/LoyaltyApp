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
    @IBOutlet weak var iv_banner: UIImageView!
    @IBOutlet weak var ivLogo: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.ivFavorites.image = UIImage(named: "tab_heart")?.withRenderingMode(.alwaysTemplate)
        self.ivFavorites.tintColor = .red
      //  self.ivFavorites.contentMode = .scaleAspectFit
    }

}
