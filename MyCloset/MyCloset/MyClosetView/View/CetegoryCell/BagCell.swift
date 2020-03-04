//
//  BagCell.swift
//  MyCloset
//
//  Created by 정의석 on 2020/02/07.
//  Copyright © 2020 pandaman. All rights reserved.
//

//
//  CapCell.swift
//  MyCloset
//
//  Created by 정의석 on 2020/02/07.
//  Copyright © 2020 pandaman. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class BagCell: UICollectionViewCell {
    
        let imageView = UIImageView()
        static let identifier = "BagCell"
        private let titleLabel = UILabel()
        var selectedIndexPath: [IndexPath] = []
        var isChecked = false
        let flowLayout = UICollectionViewFlowLayout()
        var imageFromServer = UIImage()
        
        var bagCompleteDownloadFile = 0
        var bagFileCount = 0
        
        lazy var collectionView = UICollectionView(
            frame: self.contentView.frame, collectionViewLayout: flowLayout
        )
        
        // MARK: Init
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
                    setImageFromStorage()
        }
        
        deinit {
            print("deinit")
        }
        
        // MARK: Setup
        
        private func setupViews() {
            self.clipsToBounds = true
            //imageView
            
            imageView.image = UIImage(named: "cellimage")
            collectionView.backgroundView = imageView
           
            self.contentView.shadow()
            setupFlowLayout()
            
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(MyClosetInnerCollectionViewCell.self, forCellWithReuseIdentifier: MyClosetInnerCollectionViewCell.identifier)
            collectionView.allowsMultipleSelection = true
            collectionView.contentInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: -30)

            contentView.addSubview(collectionView)
            
        }
        
        private func setupFlowLayout() {
            flowLayout.itemSize = CGSize(width: contentView.frame.height * 0.6 , height: contentView.frame.height * 0.6)
            flowLayout.minimumLineSpacing = 10
            flowLayout.minimumInteritemSpacing = 20
            flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
            flowLayout.scrollDirection = .horizontal
        }
        
        private func setupConstraints() {
            
            collectionView.snp.makeConstraints {
                $0.top.bottom.trailing.leading.equalToSuperview()
            }
        }
        
        // MARK: Configure Cell
        func configure(image: UIImage?, title: String) {
            titleLabel.text = title
        }
        
        //MARK: Firebase Storage
        
        func setImageFromStorage() {
            let storageRef = Storage.storage().reference(forURL: "gs://thirdcloset-735f9.appspot.com").child("items/")
            
            let bagRef = storageRef.child("bag/")
            
            var fileCount = 1
            var fileName = ""
            var category: [UIImage] = []
            
            func setBagCell(num: Int) {
                bagRef.child("bag"+"\(num)"+".png").getData(maxSize: 1 * 1024 * 1024) { (data, error) in
                    if let err = error {
                        print(err)
                    } else {
                        self.imageFromServer = UIImage(data: data!)!
                        Singleton.shared.bag.updateValue(self.imageFromServer, forKey: "bag"+"\(num)")
                        //                    self.acc.append(self.acc0)

                        //MARK: ViewDidLoad에서 여기로 바꿨음.
                        self.bagCompleteDownloadFile += 1
                        
                        if num == 0 {
                            self.setupViews()
                            self.setupConstraints()
                        } else if self.bagFileCount == self.bagCompleteDownloadFile {
                            self.collectionView.reloadData()
                        }
                    }
                }
            }
            
            bagRef.listAll { (StorageListResult, Error) in
                
                if Error == nil {
                    fileCount = StorageListResult.items.count
                    print("bag file count", fileCount)
                    self.bagFileCount = fileCount
                    for i in 0...(fileCount-1) {
                        setBagCell(num: i)
                    }
                }
            }
        }
        
    }



    extension BagCell: UICollectionViewDataSource {
        
        
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            var itemCount: Int!

                itemCount = Singleton.shared.bag.count

            return itemCount
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell: UICollectionViewCell!
            let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: MyClosetInnerCollectionViewCell.identifier, for: indexPath) as! MyClosetInnerCollectionViewCell

                customCell.configure(image: Singleton.shared.bag["bag"+"\(indexPath.item)"])
                            print("bag reload")
            
            cell = customCell
            cell.backgroundColor = .white
            
            return cell
        }
    }

    extension BagCell: MyClosetViewControllerDelegate {
        func secondReloadRequestBag() {
            print("Bag Second delegate")
            print("결과 싱글톤",Singleton.shared.bag)
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.collectionView.collectionViewLayout.invalidateLayout()
                self.collectionView.layoutSubviews()
            }
        }
    }

extension BagCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! MyClosetInnerCollectionViewCell
        let seletedBagImage: UIImage = cell.imageView.image!
        SelectedImageSingleton.shared.selectedImageSet.updateValue(seletedBagImage, forKey: "bag")
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        SelectedImageSingleton.shared.selectedImageSet.removeValue(forKey: "bag")
    }
}
