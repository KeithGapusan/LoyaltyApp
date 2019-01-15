//
//  ProfileController.swift
//  Rewards
//
//  Created by Keith Randell Gapusan on 06/01/2019.
//  Copyright © 2019 Keith Randell Gapusan. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {

    private let sectionInsets = UIEdgeInsets(top: 200.0,
                                             left: 0.0,
                                             bottom: 0.0,
                                             right: 0.0)
    
    let itemsPerRow:  CGFloat = 1.0
    lazy var collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        cv.backgroundColor = .white
        return cv
    }()
    
    let imageView =  UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        view.addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        
        //imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 300)
        imageView.image = UIImage.init(named: "coffee")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        view.addSubview(imageView)
        view.addConstraintsWithFormat(format: "V:|[v0(200)]", views: imageView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: imageView)
        
        collectionView.register(GenericCell.self, forCellWithReuseIdentifier: "id")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = sectionInsets
    }
    

}
extension ProfileController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "id", for: indexPath) as! GenericCell
        
        
        return cell
        
    }
    
    
}

extension ProfileController: UICollectionViewDelegateFlowLayout{
    func sizeEqualSpacing(_ collectionView: UICollectionView, itemsPerRow: CGFloat, sectionInsets: UIEdgeInsets, view: UIView) -> CGSize{
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        let lower : UInt32 =  UInt32(collectionView.frame.size.height / 3)
        let upper : UInt32 =  UInt32(collectionView.frame.size.height)
        //  let randomNumber = arc4random_uniform(upper - lower) + lower
        return CGSize(width: widthPerItem, height: CGFloat(lower))
        
    }
    
    fileprivate func cellSizeEqualSpaces(_ collectionView: UICollectionView) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        let lower : UInt32 =  UInt32(collectionView.frame.size.height / 3)
        let upper : UInt32 =  UInt32(collectionView.frame.size.height)
        //  let randomNumber = arc4random_uniform(upper - lower) + lower
        return CGSize(width: widthPerItem, height: CGFloat(lower))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //  return sizeEqualSpacing(collectionView, itemsPerRow: 2, sectionInsets: sectionInsets, view: self.view)
        return cellSizeEqualSpaces(collectionView)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = 200 - (scrollView.contentOffset.y + 50)
        let height = min(max(y, 60), 300)
        imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height )
        
        
    }

}
