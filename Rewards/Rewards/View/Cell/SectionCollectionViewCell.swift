//
//  SectionCollectionViewCell.swift
//  Rewards
//
//  Created by Keith Randell Gapusan on 06/01/2019.
//  Copyright © 2019 Keith Randell Gapusan. All rights reserved.
//

import UIKit

class SectionCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgViewAll : UIImageView!
    @IBOutlet weak var imgViewHot : UIImageView!
    @IBOutlet weak var imgViewUpcomming: UIImageView!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    
    var couponController: CouponController?
    
    @IBAction func didPressedButton(_ sender: UIButton) {
        switch sender {
        case btn1:
            print("btn1 Pressed")
            couponController?.didPressedSectionHeader(tag: 1)
        case btn2:
            print("btn2 pressed")
            couponController?.didPressedSectionHeader(tag: 2)
        case btn3:
            print("btn3 pressed")
            couponController?.didPressedSectionHeader(tag: 3)
        default:
            print("not applicable")
        }
    }
    
    fileprivate func setupImageViews() {
        // Initialization code
        self.imgViewAll.image = #imageLiteral(resourceName: "promo")
        self.imgViewHot.image = #imageLiteral(resourceName: "Hot")
        self.imgViewUpcomming.image = #imageLiteral(resourceName: "upcoming")
        self.imgViewAll.contentMode = .scaleAspectFit
        self.imgViewHot.contentMode = .scaleAspectFit
        self.imgViewUpcomming.contentMode = .scaleAspectFit
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupImageViews()
    }

}
