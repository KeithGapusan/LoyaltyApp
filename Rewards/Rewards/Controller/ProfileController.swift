//
//  ProfileController.swift
//  Rewards
//
//  Created by Keith Randell Gapusan on 06/01/2019.
//  Copyright © 2019 Keith Randell Gapusan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ProfileController: UIViewController {

    var minHeaderHeight: CGFloat = 0
    
    var maxHeaderHeight: CGFloat = 300
    private let sectionInsets = UIEdgeInsets(top: -50.0,
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
        cv.backgroundColor = .clear
        return cv
    }()
    let imageView =  UIImageView()

    fileprivate func setupView() {
        view.addSubview(imageView)
        imageView.frame.size = CGSize(width: view.frame.width, height: maxHeaderHeight)
        
        view.addSubview(collectionView)
        collectionView.register(GenericCell.self, forCellWithReuseIdentifier: "id")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInsetAdjustmentBehavior = .never

        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        //view.bringSubviewToFront(imageView)
//
        collectionView.contentInset.top = imageView.frame.height
        collectionView.contentOffset.y = -imageView.frame.height
        imageView.image = UIImage.init(named: "coffee")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
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
        
        
        if scrollView.contentOffset.y < -maxHeaderHeight {
            imageView.frame.size.height = -scrollView.contentOffset.y
        } else if scrollView.contentOffset.y >= -maxHeaderHeight && scrollView.contentOffset.y < -minHeaderHeight {
            imageView.frame.size.height = -scrollView.contentOffset.y
        } else {
            imageView.frame.size.height = minHeaderHeight
        }
        
        scrollView.scrollIndicatorInsets = scrollView.contentInset
        
    }

}
