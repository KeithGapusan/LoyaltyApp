//
//  StoreController.swift
//  Rewards
//
//  Created by Keith Randell Gapusan on 06/01/2019.
//  Copyright © 2019 Keith Randell Gapusan. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources


class StoreController: UIViewController ,  UITableViewDelegate{
    let arr = ["Bangladesh", "India", "Pakistan", "Nepal", "Bhutan", "China", "Malaysia", "Myanmar", "Sri Lanka", "Saudi Arabia"]

    let data = Observable<[String]>.just(["first element", "second element", "third element"])
    let disposeBag =  DisposeBag()
    
    private let itemsPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(top: 5.0,
                                             left: 5.0,
                                             bottom: 5.0,
                                             right: 5.0)
    

    
    lazy var collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        cv.backgroundColor = .gray
        return cv
    }()

    let cell : UITableViewCell = {
       let cell = UITableViewCell()
        cell.backgroundColor  = .red
        return cell
    }()
    
    //let dataSource = RxCollectionViewSectionedReloadDataSource<SectionOfCustomData>()

   // let dataSource = RxCollectionViewSectionedReloadDataSource(configureCell: <#(CollectionViewSectionedDataSource<S>, UICollectionView, IndexPath, S.Item) -> UICollectionViewCell#>)
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        

        let countryArray = Variable<[String]>(arr)
        let countries = Observable.just(countryArray)
        view.addSubview(collectionView)
        view.addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        
        collectionView.register(GenericCell.self, forCellWithReuseIdentifier: "id")
        collectionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
  
        

//        countryArray.asObservable().bind(to: collectionView.rx.items(cellIdentifier: "id")) { (index, data, cell) in
//            print(index)
//            if let generic = cell as? GenericCell{
//                generic.lblDescription.text = data
//            }
//        }.disposed(by: disposeBag)
//
//
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        
            
            
            
            
        let dataSource  = RxCollectionViewSectionedReloadDataSource<SectionOfCustomData>(configureCell: {
            data, cv, index , item in
            if index.section == 0{
                let cell = cv.dequeueReusableCell(withReuseIdentifier: "cell", for: index) as! BannerCollectionViewCell
                cell.backgroundColor = .blue
                return cell
            }else{
                let cell = cv.dequeueReusableCell(withReuseIdentifier: "id", for: index) as! GenericCell
                cell.lblDescription.text = item.aString
                
                return cell

            }
        })
    
        let sections = [
            SectionOfCustomData(header: "First section",
                                items: [CustomData(anInt: 0, aString: "zero", aCGPoint: CGPoint.zero),
                                        CustomData(anInt: 1, aString: "one", aCGPoint: CGPoint(x: 1, y: 1)) ]),
            SectionOfCustomData(header: "Second section", items: [CustomData(anInt: 2, aString: "two", aCGPoint: CGPoint(x: 2, y: 2)), CustomData(anInt: 3, aString: "three", aCGPoint: CGPoint(x: 3, y: 3)) ])
        ]
  
        
        Observable.just(sections)
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        
//
//        dataSource.titleForFooterInSection = { dataSource, indexPath in
//            return dataSource.sectionModels[index].footer
//        }

        
    }
    

}

extension StoreController: UICollectionViewDelegateFlowLayout{
    
    
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
    
}



struct CustomData {
    var anInt: Int
    var aString: String
    var aCGPoint: CGPoint
}
struct SectionOfCustomData {
    var header: String
    var items: [Item]
}
extension SectionOfCustomData: SectionModelType {
    typealias Item = CustomData
    
    init(original: SectionOfCustomData, items: [Item]) {
        self = original
        self.items = items
    }
}
