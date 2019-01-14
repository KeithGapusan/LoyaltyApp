//
//  RobinsonsCardCollectionViewCell.swift
//  Rewards
//
//  Created by Keith Randell Gapusan on 13/01/2019.
//  Copyright © 2019 Keith Randell Gapusan. All rights reserved.
//

import UIKit


class RobinsonsCardCollectionViewCell : BaseCell{
    
    let ivRobinsonsCard: UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "rrc-card")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let lblCardNumber : UILabel = {
        let label = UILabel()
        label.text = "Loading . . . "
        label.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.medium)
        label.textColor = .white
        return label
    }()
    override func setupView() {
        
        addSubview(ivRobinsonsCard)
        addConstraintsWithFormat(format: "V:|[v0]|", views: ivRobinsonsCard)
        addConstraintsWithFormat(format: "H:|[v0]|", views: ivRobinsonsCard)
        ivRobinsonsCard.addSubview(lblCardNumber)

        ivRobinsonsCard.addConstraintsWithFormat(format: "H:|-25-[v0]", views: lblCardNumber)
        ivRobinsonsCard.addConstraintsWithFormat(format: "V:[v0]-25-|", views: lblCardNumber)
    }
    
}
