//
//  CouponController.swift
//  Rewards
//
//  Created by Keith Randell Gapusan on 06/01/2019.
//  Copyright © 2019 Keith Randell Gapusan. All rights reserved.
//

import UIKit

class CouponController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    let cell_id = "generic_id"
    let cell_id_section = "section"
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.shadowImage = UIImage()
        //collectionView.register(GenericCollectionViewCell.self, forCellWithReuseIdentifier: cell_id)
        collectionView.register(UINib(nibName:"GenericCollectionViewCell",bundle:nil), forCellWithReuseIdentifier: cell_id)
//    collectionView.register(UINib(nibName:"SectionCollectionViewCell",bundle:nil), forCellWithReuseIdentifier: cell_id_section)
        collectionView.register(UINib(nibName: "SectionCollectionViewCell", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: cell_id_section)
        collectionView.backgroundColor = .white
       collectionView.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 10, right: 5)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 5, right: 0)
        collectionView.contentSize  = CGSize(width: (self.view.bounds.width - (self.collectionView.contentInset.left + self.collectionView.contentInset.right)) / 2, height: 220)
        let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        flowLayout?.scrollDirection = .vertical
        flowLayout?.minimumLineSpacing = 0
        flowLayout?.minimumInteritemSpacing = 0
        flowLayout?.sectionHeadersPinToVisibleBounds = true
        
        flowLayout?.itemSize =  CGSize(width: (self.view.bounds.width - (self.collectionView.contentInset.left + self.collectionView.contentInset.right)) / 2, height: 220)
        
        collectionView.collectionViewLayout = flowLayout!
        collectionView.delegate = self
        collectionView.dataSource = self
     
        
    }

}
extension CouponController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 30
        default:
           return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cell_id, for: indexPath) as? GenericCollectionViewCell{
                cell.iv_banner.backgroundColor = .gray
                return cell
            }
            break;
        case 1:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cell_id, for: indexPath) as? GenericCollectionViewCell{
               
                return cell
                
            }
             break;
        default:
            return UICollectionViewCell()
        }
       
        
        
        return UICollectionViewCell()
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
             return CGSize(width: collectionView.frame.width, height: self.view.frame.size.height / 3 )
        default:

           //  return CGSize(width: (collectionView.frame.width  / 2) - 6, height: self.view.frame.size.height / 3 )
        let witdh = (self.view.bounds.width - (self.collectionView.contentInset.left + self.collectionView.contentInset.right)) / 2
        print("\(self.view.bounds.width )-- \(witdh) - \(collectionView.frame.size) == \(collectionView.contentInset)")
        return CGSize(width: witdh + 1, height: self.view.frame.size.height / 3)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch section {
        case 0:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        case 1:
            return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        default:
            return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        }
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 1{
            if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: cell_id_section, for: indexPath) as? SectionCollectionViewCell{
                
                return sectionHeader
            }
        }

        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 1{
           return CGSize(width: self.view.frame.width, height: self.view.frame.height / 9)
        }else{
            return CGSize(width: 0, height: 0)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
   // interitem
}
