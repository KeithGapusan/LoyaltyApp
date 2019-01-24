//
//  FavoritesController.swift
//  Rewards
//
//  Created by Keith Randell Gapusan on 06/01/2019.
//  Copyright © 2019 Keith Randell Gapusan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FavoritesController: UIViewController {
 
    private let sectionInsets = UIEdgeInsets(top: 0.0,
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
    
    var labelLoading: UILabel = {
       let lbl = UILabel()
        lbl.text = "Loading..."
        lbl.textAlignment = .center
        lbl.contentMode = .center
        lbl.font = UIFont.systemFont(ofSize: 15, weight: .light)
        lbl.textColor = .lightGray
        //lbl.backgroundColor = .green
        return lbl
    }()
    let id = "id"
   // var promoList = [Promo]()
    // let europeanChocolates = Observable.just(Chocolate.ofEurop
    var promos : Variable<[Promo]> = Variable([])
    var promoList : [Promo]? = []
    let disposeBag = DisposeBag()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        var apiService = APIServiceHandler()
        apiService.fetchPromos { (promo, banner) in
            self.promoList = promo
            let range = Range(uncheckedBounds: (0, self.collectionView.numberOfSections))
            let indexSet = IndexSet(integersIn: range)
            self.collectionView.reloadSections(indexSet)
            self.labelLoading.text = ""
        }
    }
    func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        view.addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        collectionView.register(GenericCell.self,  forCellWithReuseIdentifier: id)
        collectionView.addSubview(labelLoading)
        //labelLoading.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: labelLoading)
        view.addConstraintsWithFormat(format: "V:[v0(20)]", views: labelLoading)
        view.addConstraint(NSLayoutConstraint.init(item: labelLoading, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        
        view.addConstraint(NSLayoutConstraint.init(item: labelLoading, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0))
          }

}
extension FavoritesController : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (promoList?.count)!
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: id, for: indexPath) as? GenericCell
        cell?.promos = promoList?[indexPath.item]
        return cell ?? UICollectionViewCell()
    }

}

extension FavoritesController: UICollectionViewDelegateFlowLayout{
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
}
//
//
