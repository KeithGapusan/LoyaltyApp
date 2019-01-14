//
//  FavoritesController.swift
//  Rewards
//
//  Created by Keith Randell Gapusan on 06/01/2019.
//  Copyright © 2019 Keith Randell Gapusan. All rights reserved.
//

import UIKit

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
    var promoList = [Promo]()
    
    
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
        return promoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: id, for: indexPath) as? GenericCell
        cell?.promos = promoList[indexPath.item]
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


class  GenericCell: BaseCell {
    
    
    let imageViewBanner: CustomImageView  = {
        let iv = CustomImageView()
        iv.backgroundColor = .lightGray
        return iv
        
    }()
    
    let viewDetailHolder : UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor.rgb(red: 10, green: 10, blue: 10, alpha: 0.3)
        
        return view
    }()
    
    let imageViewLogo: CustomImageView = {
        var iv =  CustomImageView()
        iv.backgroundColor  = .white
        return iv
    }()
    
    let imageViewFavorites: UIImageView = {
        var iv =  UIImageView()
      //  iv.backgroundColor = UIColor.lightGray
        return iv
    }()
    
    
    let lblDescription : UILabel = {
        var lbl = UILabel()
        
        lbl.text = "Loading"
        lbl.font = UIFont.systemFont(ofSize: 20)
        lbl.textColor = .white
       // lbl.backgroundColor = .green
        return lbl
    }()

    var promos:Promo?{
        didSet{
            if let logoUrl = promos?.image?.logo{
                self.imageViewLogo.loadImageUsingUrlString(urlString: logoUrl)
            }
            if let bannerUrl = promos?.image?.main{
                self.imageViewBanner.loadImageUsingUrlString(urlString: bannerUrl)          
            }
            //imageViewLogo.image = UIImage(named: promos?.image?.logo ?? "coffee")?.withRenderingMode(.alwaysTemplate)
        }
    }
    
    override func setupView() {
        setupImageViewBanner()
        setupDetailViewHolder()
        setupImageViewFavorites()

        imageViewLogo.layer.cornerRadius = 25
        imageViewLogo.layer.masksToBounds = true
        imageViewLogo.contentMode = .scaleAspectFill
        
        imageViewFavorites.image = #imageLiteral(resourceName: "tab_heart").withRenderingMode(.alwaysTemplate)
        imageViewFavorites.tintColor = Constants.primary_color
        

    }
    func setupImageViewBanner(){
        addSubview(imageViewBanner)
        addConstraintsWithFormat(format: "H:|[v0]|", views: imageViewBanner)
        addConstraintsWithFormat(format: "V:|[v0]|", views: imageViewBanner)
    }

    func setupDetailViewHolder(){
        addSubview(viewDetailHolder)
        addConstraintsWithFormat(format: "V:[v0(60)]|", views: viewDetailHolder)
        addConstraintsWithFormat(format: "H:|[v0]|", views: viewDetailHolder)
         setupImageLogo()
    }
    func setupImageViewFavorites(){
        addSubview(imageViewFavorites)
        addConstraintsWithFormat(format: "V:|-10-[v0(50)]", views: imageViewFavorites)
        addConstraintsWithFormat(format: "H:[v0(50)]-10-|", views: imageViewFavorites)
    }
    
    func setupImageLogo(){
        
        viewDetailHolder.addSubview(imageViewLogo)
        viewDetailHolder.addSubview(lblDescription)
        viewDetailHolder.addConstraintsWithFormat(format: "V:|[v0]|", views: lblDescription)
        addConstraintsWithFormat(format: "V:[v0(50)]", views: imageViewLogo)
        addConstraintsWithFormat(format: "H:|-10-[v0(50)]-20-[v1]-10-|", views: imageViewLogo, lblDescription)
        addConstraint(NSLayoutConstraint.init(item: imageViewLogo , attribute: .centerY, relatedBy: .equal, toItem: viewDetailHolder, attribute: .centerY, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint.init(item: lblDescription, attribute: .centerY, relatedBy: .equal, toItem: viewDetailHolder, attribute: .centerY, multiplier: 1, constant: 0))

    }
    
}
