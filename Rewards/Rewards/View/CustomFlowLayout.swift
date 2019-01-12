//
//  CustomFlowLayout.swift
//  Rewards
//
//  Created by Keith Randell Gapusan on 07/01/2019.
//  Copyright © 2019 Keith Randell Gapusan. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics


class CustomFlowLayout : UICollectionViewFlowLayout {
    
    let cellSpacing:CGFloat = 4
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let original = super.layoutAttributesForElements(in: rect)
        
        if let original = original {
            let attributes = NSArray.init(array: original, copyItems: true) as! [UICollectionViewLayoutAttributes]
            
            for (index, attribute) in attributes.enumerated() {
                if index == 0 { continue }
                let prevLayoutAttributes = attributes[index - 1]
                let origin  = prevLayoutAttributes.frame.maxX
                    //CGRectGetMaxX(prevLayoutAttributes.frame)
                if(origin + cellSpacing + attribute.frame.size.width < self.collectionViewContentSize.width) {
                    attribute.frame.origin.x = origin + cellSpacing
                }
            }
            return attributes
        }
        return nil
    }
    
    
      func sizeEqualSpacing(_ collectionView: UICollectionView, itemsPerRow: CGFloat, sectionInsets: UIEdgeInsets, view: UIView, size : CGSize) -> CGSize{
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        let lower : UInt32 =  UInt32(collectionView.frame.size.height / 3)
        let upper : UInt32 =  UInt32(collectionView.frame.size.height)
        //  let randomNumber = arc4random_uniform(upper - lower) + lower
        return CGSize(width: widthPerItem, height: CGFloat(lower))

    }
}
