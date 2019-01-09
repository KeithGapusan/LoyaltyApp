//
//  BannerCollectionViewCell.swift
//  Rewards
//
//  Created by Keith Randell Gapusan on 06/01/2019.
//  Copyright © 2019 Keith Randell Gapusan. All rights reserved.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    var bannerList : [Banner]?{
        didSet{
            
            collectionView.reloadData()
        }
    }
    var viewController : UIViewController?
    let cellId = "generic_id"
////setCollectionViewDataSourceDelegate
//   lazy var banners: [Banner]  = {
//        var list = [Banner]()
//       list.append(Banner.init(image: "coffee", logo: "coffee", title: "title1", details: "title1"))
//     list.append(Banner.init(image: "coffee", logo: "coffee", title: "title2", details: "title2"))
//     list.append(Banner.init(image: "coffee", logo: "coffee", title: "title1", details: "title4"))
//        return list
//
//    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.register(UINib(nibName: "GenericCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellId)
        let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        flowLayout?.scrollDirection = .horizontal
        flowLayout?.minimumLineSpacing = 0
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = UIColor.gray
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
       // collectionView.delegate = viewController.self
   //     collectionView.data
        

    }

}
extension BannerCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannerList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? GenericCollectionViewCell{
            let data =  bannerList?[indexPath.row]
            cell.banner = data
            return cell
        }
        return UICollectionViewCell()
    }
    
    
}
extension BannerCollectionViewCell : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.size.width, height: frame.size.height)
    }
}
