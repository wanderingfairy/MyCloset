//
//  PrevCodiViewController.swift
//  MyCloset
//
//  Created by 정의석 on 2020/02/04.
//  Copyright © 2020 pandaman. All rights reserved.
//

import UIKit
import SnapKit
import Firebase
import FirebaseStorage

class PrevCodiViewController: UIViewController {
    var prevCodiData: [String:UIImage] = [:]
    var collection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Previous CodiSet"
        configureCollection()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("rere")
         setImageFromStorage()
//        collection.reloadData()
//        configureCollection()
    }
    
    func setImageFromStorage() {
        let storageRef = Storage.storage().reference(forURL: "gs://thirdcloset-735f9.appspot.com").child("codiSet/")
        
        let codiRef = storageRef.child("codiSet/")
        
        var fileCount = 1
        var fileName = ""
        var category: [UIImage] = []
        var codiSetFileCount = 0
        var imageFromServer = UIImage()
        var codiCompleteDownloadFile = 0
        var indexPaths = [IndexPath]()
        
        func setCodiFile(num: Int) {
            codiRef.child("codiSet"+"\(num)"+".jpeg").getData(maxSize: 1 * 1024 * 1024) { (data, error) in
                if let err = error {
                    print(err)
                } else {
                    imageFromServer = UIImage(data: data!)!
                    DispatchQueue.global().sync {
                        CodiSingleton.shared.codiImages.updateValue(imageFromServer, forKey: "codiSet"+"\(num)"+".jpeg")
                    }
                   
                    //                    self.acc.append(self.acc0)
                    self.prevCodiData = CodiSingleton.shared.codiImages
                    self.collection.reloadData()
                    self.collection.layoutSubviews()
                    
                    
                }
            }
        }
        
        codiRef.listAll { (StorageListResult, Error) in
            
            if Error == nil {
                fileCount = StorageListResult.items.count
                print("codiSet file count", fileCount)
                codiSetFileCount = fileCount
                for i in 0...(fileCount-1) {
                    setCodiFile(num: i)
                }
            }
        }
    }
    
    
    private func configureCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        let itemWidth = view.frame.width - 20
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth + 150)
        collection = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        //collection.backgroundColor = UIColor(named: "cameraBG")
        collection.backgroundColor = .white
        collection.dataSource = self
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CellID")
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchGesture(_:)))
        collection.addGestureRecognizer(pinchGesture)
        view.addSubview(collection)
    }
    @objc func pinchGesture(_ sender: UIPinchGestureRecognizer) {
        collection.transform = collection.transform.scaledBy(x: sender.scale, y: sender.scale)
        sender.scale = 1.0
    }
}
extension PrevCodiViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.prevCodiData.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellID", for: indexPath)
        guard !CodiSingleton.shared.codiImages.isEmpty else { return cell }
         var imageArray: Array<UIImage> = []
        for key in self.prevCodiData {
            imageArray.append(key.value)
        }
        let imageView = UIImageView(image: imageArray[indexPath.item])
        imageView.frame = cell.contentView.frame
        cell.contentView.addSubview(imageView)
        cell.layer.borderWidth = 5
        cell.layer.borderColor = UIColor.darkGray.cgColor
        cell.layer.cornerRadius = 20
        cell.clipsToBounds = true
        return cell
    }
}
