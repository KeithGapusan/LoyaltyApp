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
    var promoList: [Promo]?
    var bannerList: [Banner]?
    let cell_id = "generic_id"
    let cell_id_section = "section"
    let cell_banner_id = "banner_id"
    var redView = UIView()

    var cellExpanded: Bool = false

    
    private let itemsPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(top: 5.0,
                                             left: 5.0,
                                             bottom: 5.0,
                                             right: 5.0)

    fileprivate func setupCollectionView() {
    collectionView.register(UINib(nibName:"GenericCollectionViewCell",bundle:nil), forCellWithReuseIdentifier: cell_id)
        collectionView.register(UINib(nibName: "SectionCollectionViewCell", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: cell_id_section)
        
        collectionView.register(UINib(nibName: "BannerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cell_banner_id)
        
        collectionView.backgroundColor = .white
        let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        flowLayout?.scrollDirection = .vertical
        flowLayout?.minimumLineSpacing = 0
        flowLayout?.minimumInteritemSpacing = 0
        flowLayout?.sectionHeadersPinToVisibleBounds = true
        collectionView.collectionViewLayout = flowLayout!
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func didPressedSectionHeader(tag:Int){
        print(tag)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.shadowImage = UIImage()
        setupCollectionView()
        
        var apiService = APIServiceHandler()
        apiService.fetchVideo { (promo, banner) in
           // print(banner[0].image)
          //  print("\(promo)")
            self.bannerList = banner
            self.promoList = promo
           // self.collectionView.reloadData()
            let range = Range(uncheckedBounds: (0, self.collectionView.numberOfSections))
            let indexSet = IndexSet(integersIn: range)
            self.collectionView.reloadSections(indexSet)
        }
        redView.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31, alpha: 1)
        view.addSubview(redView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: redView)
        view.addConstraintsWithFormat(format: "V:|-(-16)-[v0(10)]", views: redView)
     //   view.backgroundColor = .blue
        
        
    }

}
extension CouponController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
        
            return promoList?.count ?? 0
        default:
           return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cell_banner_id, for: indexPath) as? BannerCollectionViewCell{
                cell.bannerList = bannerList
                return cell
            }
            break;
        case 1:
            
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cell_id, for: indexPath) as? GenericCollectionViewCell{
                cell.promo = promoList?[indexPath.row]
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

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 1{
            if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: cell_id_section, for: indexPath) as? SectionCollectionViewCell{
                sectionHeader.couponController = self
                return sectionHeader
            }
        }

        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0{
            return CGSize(width: 0, height: 0)
        }else if  section == 1{
           return CGSize(width: collectionView.frame.width, height: self.view.frame.height / 9)
        }else{
            return CGSize(width: 0, height: 0)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
extension CouponController : UICollectionViewDelegateFlowLayout{
 
    fileprivate func cellSizeEqualSpaces(_ collectionView: UICollectionView) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        let lower : UInt32 =  UInt32(collectionView.frame.size.height / 3)
        let upper : UInt32 =  UInt32(collectionView.frame.size.height)
        //  let randomNumber = arc4random_uniform(upper - lower) + lower
        return CGSize(width: widthPerItem, height: CGFloat(lower))
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: collectionView.frame.width, height: self.view.frame.size.height / 3 )
        case 1:

            return cellSizeEqualSpaces(collectionView)
        default:
            
            return CGSize(width: 0 , height: 0)

        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        switch section {
        case 0:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        default:
             return sectionInsets
        }
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    

    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        cell.alpha = 0.0
        UIView.animate(withDuration: 0.15, animations: {
            cell.layer.transform = CATransform3DMakeScale(1,1,1)
            cell.alpha = 1.0
        })

    }
    
    
    fileprivate func animateCellExpand(_ collectionView: UICollectionView, _ indexPath: IndexPath) {
        cellExpanded = true
        
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.zPosition = CGFloat(99)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)

        UIView.animate(withDuration: 0.5, animations: {
            collectionView.alpha = 0.5
            collectionView.frame = (UIApplication.shared.keyWindow?.frame)!

        }) { (completed) in
            UIApplication.shared.keyWindow?.bringSubviewToFront(cell!)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIView.AnimationOptions.curveLinear, animations: {
                                if let statusBar = UIApplication.shared.value(forKey: "statusBar") as? UIView {
                    statusBar.backgroundColor = UIColor.rgb(red: 194, green: 31, blue: 31, alpha: 0.1)
                }
                 collectionView.alpha = 1
                 cell?.frame = collectionView.bounds
            }) { (completed) in
                print("after \(collectionView.frame)")

            }
        }
    }
    
    fileprivate func animateCellToDefaultSize(_ collectionView: UICollectionView, _ indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.zPosition = 0
        UIView.animate(withDuration: 0.5, animations: {
            self.tabBarController?.tabBar.isHidden =  false
            self.navigationController?.isNavigationBarHidden = false
            if let statusBar = UIApplication.shared.value(forKey: "statusBar") as? UIView {
                statusBar.backgroundColor = Constants.primary_color
                
            }
            
        }) { (completed) in
            self.cellExpanded = false
            collectionView.reloadItems(at: [indexPath])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if cellExpanded{
            animateCellToDefaultSize(collectionView, indexPath)
        }else{
            animateCellExpand(collectionView, indexPath)
        }
   }
}
