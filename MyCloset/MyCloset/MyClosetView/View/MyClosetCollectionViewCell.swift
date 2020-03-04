////
////  MyClosetCollectionViewCell.swift
////  MyCloset
////
////  Created by 정의석 on 2020/02/05.
////  Copyright © 2020 pandaman. All rights reserved.
////
//
//import UIKit
//import SnapKit
//import Firebase
//import FirebaseDatabase
//import FirebaseStorage
//
//enum Cloth {
//    case top, bottom, cap, acc, bag, outer, shoes, socks
//
//    static let allValues = [top, bottom, cap, acc, bag, outer, shoes, socks]
//}
//
//class MyClosetCollectionViewCell: UICollectionViewCell {
//
//    static let identifier = "MyClosetCollectionViewCell"
//    private let titleLabel = UILabel()
//    var selectedIndexPath: [IndexPath] = []
//    var isChecked = false
//    let flowLayout = UICollectionViewFlowLayout()
//    var imageFromServer = UIImage()
//
//    var accCompleteDownloadFile = 0
//    var accFileCount = 0
//
//    var bagCompleteDownloadFile = 0
//    var bagFileCount = 0
//
//    var bottomCompleteDownloadFile = 0
//    var bottomFileCount = 0
//
//    var outerCompleteDownloadFile = 0
//    var outerFileCount = 0
//
//    var topCompleteDownloadFile = 0
//    var topFileCount = 0
//
//    var shoesCompleteDownloadFile = 0
//    var shoesFileCount = 0
//
//    var socksCompleteDownloadFile = 0
//    var socksFileCount = 0
//
//    var capCompleteDownloadFile = 0
//    var capFileCount = 0
//
//
//
//    var acc: Dictionary<String, UIImage> = [:]
//    var bag: Dictionary<String, UIImage> = [:]
//    var bottom: Dictionary<String, UIImage> = [:]
//    var cap: Dictionary<String, UIImage> = [:]
//    var outer: Dictionary<String, UIImage> = [:]
//    var shoes: Dictionary<String, UIImage> = [:]
//    var socks: Dictionary<String, UIImage> = [:]
//    var top: Dictionary<String, UIImage> = [:]
//
//    var cloth: Cloth!
//
//    lazy var collectionView = UICollectionView(
//        frame: self.contentView.frame, collectionViewLayout: flowLayout
//    )
//
//    // MARK: Init
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        //MARK: 서버에서 이미지 받아오기 %주의%
//
//                setImageFromStorage()
//    }
//
//    deinit {
//        print("deinit")
//    }
//
//    // MARK: Setup
//
//    private func setupViews() {
//        self.clipsToBounds = true
//        //imageView
//
//        layer.borderWidth = 2
//        layer.borderColor = UIColor.gray.cgColor
//        layer.cornerRadius = 8
//        self.contentView.shadow()
//        setupFlowLayout()
//
//        collectionView.backgroundColor = .white
//        collectionView.dataSource = self
//        //        collectionView.delegate = self
//        collectionView.register(MyClosetInnerCollectionViewCell.self, forCellWithReuseIdentifier: MyClosetInnerCollectionViewCell.identifier)
//        collectionView.allowsMultipleSelection = true
//        contentView.addSubview(collectionView)
//
//    }
//
//    private func setupFlowLayout() {
//        flowLayout.itemSize = CGSize(width: contentView.frame.height * 0.8 , height: contentView.frame.height * 0.8)
//        flowLayout.minimumLineSpacing = 10
//        flowLayout.minimumInteritemSpacing = 20
//        flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
//        flowLayout.scrollDirection = .horizontal
//    }
//
//    private func setupConstraints() {
//
//        collectionView.snp.makeConstraints {
//            $0.top.bottom.trailing.leading.equalToSuperview()
//        }
//    }
//
//    // MARK: Configure Cell
//    func configure(image: UIImage?, title: String) {
//        titleLabel.text = title
//    }
//
//    //MARK: Firebase Storage
//
//    func setImageFromStorage() {
//        let storageRef = Storage.storage().reference(forURL: "gs://thirdcloset-735f9.appspot.com").child("items/")
//
//        let accRef = storageRef.child("acc/")
//        let bagRef = storageRef.child("bag/")
//        let bottomRef = storageRef.child("bottom/")
//        let capRef = storageRef.child("cap/")
//        let outerRef = storageRef.child("outer/")
//        let shoesRef = storageRef.child("shoes/")
//        let socksRef = storageRef.child("socks/")
//        let topRef = storageRef.child("top/")
//
//        let refArray = [accRef, bagRef, bottomRef, capRef, outerRef, shoesRef, socksRef, topRef]
//
//        var fileCount = 1
//        var fileName = ""
//        var category: [UIImage] = []
//
//        func setAccCell(num: Int) {
//            accRef.child("acc"+"\(num)"+".png").getData(maxSize: 1 * 1024 * 1024) { (data, error) in
//                if let err = error {
//                    print(err)
//                } else {
//                    self.imageFromServer = UIImage(data: data!)!
//                    Singleton.shared.acc.updateValue(self.imageFromServer, forKey: "acc"+"\(num)")
//                    //                    self.acc.append(self.acc0)
//
//                    //MARK: ViewDidLoad에서 여기로 바꿨음.
//                    self.accCompleteDownloadFile += 1
//
//                    if num == 0 {
//                        self.setupViews()
//                        self.setupConstraints()
//                    } else if self.accFileCount == self.accCompleteDownloadFile {
//                        self.setupViews()
//                        self.setupConstraints()
//                        self.collectionView.reloadData()
//
//
//
//                    }
//                }
//            }
//        }
//
//        accRef.listAll { (StorageListResult, Error) in
//
//            if Error == nil {
//                fileCount = StorageListResult.items.count
//                print("acc file count", fileCount)
//                self.accFileCount = fileCount
//                for i in 0...(fileCount-1) {
//                    setAccCell(num: i)
//                }
//            }
//        }
//
//        func setSocksCell(num: Int) {
//            socksRef.child("socks"+"\(num)"+".png").getData(maxSize: 1 * 1024 * 1024) { (data, error) in
//                if let err = error {
//                    print(err)
//                } else {
//                    self.imageFromServer = UIImage(data: data!)!
//                    //                    self.socks.append(self.acc0)
//                    Singleton.shared.socks.updateValue(self.imageFromServer, forKey: "socks"+"\(num)")
//
//                    self.socksCompleteDownloadFile += 1
//                    //MARK: ViewDidLoad에서 여기로 바꿨음.
//                    if num == 0 {
//                        self.setupViews()
//                        self.setupConstraints()
//                    } else if self.socksFileCount == self.socksCompleteDownloadFile {
//                        self.setupViews()
//                        self.setupConstraints()
//                        self.collectionView.reloadData()
//
//
//                    }
//                }
//            }
//        }
//
//        socksRef.listAll { (StorageListResult, Error) in
//
//            if Error == nil {
//                fileCount = StorageListResult.items.count
//                                self.socksFileCount = fileCount
//                for i in 0...(fileCount-1) {
//                    setSocksCell(num: i)
//                }
//            }
//        }
//
//        func setBagCell(num: Int) {
//            bagRef.child("bag"+"\(num)"+".png").getData(maxSize: 1 * 1024 * 1024) { (data, error) in
//                if let err = error {
//                    print(err)
//                } else {
//                    self.imageFromServer = UIImage(data: data!)!
//                    //                    self.bag.append(self.acc0)
//                    Singleton.shared.bag.updateValue(self.imageFromServer, forKey: "bag"+"\(num)")
//
//                    self.bagCompleteDownloadFile += 1
//                    //MARK: ViewDidLoad에서 여기로 바꿨음.
//                    if num == 0 {
//                        self.setupViews()
//                        self.setupConstraints()
//                    } else if self.bagFileCount == self.bagCompleteDownloadFile {
//                        self.setupViews()
//                        self.setupConstraints()
//                        self.collectionView.reloadData()
//
//
//                    }
//                }
//            }
//        }
//
//        bagRef.listAll { (StorageListResult, Error) in
//
//            if Error == nil {
//                fileCount = StorageListResult.items.count
//                print("bag file count", fileCount)
//                print("bag file items", StorageListResult.items)
//                self.bagFileCount = fileCount
//                for i in 0...(fileCount-1) {
//                    setBagCell(num: i)
//                }
//            }
//        }
//
//        func setShoesCell(num: Int) {
//            shoesRef.child("shoes"+"\(num)"+".png").getData(maxSize: 1 * 1024 * 1024) { (data, error) in
//                if let err = error {
//                    print(err)
//                } else {
//                    self.imageFromServer = UIImage(data: data!)!
//                    //                    self.shoes.append(self.acc0)
//                    Singleton.shared.shoes.updateValue(self.imageFromServer, forKey: "shoes"+"\(num)")
//
//                    self.shoesCompleteDownloadFile += 1
//                    //MARK: ViewDidLoad에서 여기로 바꿨음.
//                    if num == 0 {
//                        self.setupViews()
//                        self.setupConstraints()
//                    } else if self.shoesFileCount == self.shoesCompleteDownloadFile {
//                        self.setupViews()
//                        self.setupConstraints()
//                        self.collectionView.reloadData()
//
//
//                    }
//                }
//            }
//        }
//
//        shoesRef.listAll { (StorageListResult, Error) in
//
//            if Error == nil {
//                fileCount = StorageListResult.items.count
//                                self.shoesFileCount = fileCount
//                for i in 0...(fileCount-1) {
//                    setShoesCell(num: i)
//                }
//            }
//        }
//
//        func setBottomCell(num: Int) {
//            bottomRef.child("bottom"+"\(num)"+".png").getData(maxSize: 1 * 1024 * 1024) { (data, error) in
//                if let err = error {
//                    print(err)
//                } else {
//                    self.imageFromServer = UIImage(data: data!)!
//                    //                    self.bottom.append(self.acc0)
//                    Singleton.shared.bottom.updateValue(self.imageFromServer, forKey: "bottom"+"\(num)")
//
//                    self.bottomCompleteDownloadFile += 1
//                    //MARK: ViewDidLoad에서 여기로 바꿨음.
//                    if num == 0 {
//                        self.setupViews()
//                        self.setupConstraints()
//                    } else if self.bottomFileCount == self.bottomCompleteDownloadFile {
//                        self.setupViews()
//                        self.setupConstraints()
//                        self.collectionView.reloadData()
//
//
//                    }
//                }
//            }
//        }
//
//        bottomRef.listAll { (StorageListResult, Error) in
//
//            if Error == nil {
//                fileCount = StorageListResult.items.count
//                                self.bottomFileCount = fileCount
//                for i in 0...(fileCount-1) {
//                    setBottomCell(num: i)
//                }
//            }
//        }
//
//        func setTopCell(num: Int) {
//            topRef.child("top"+"\(num)"+".png").getData(maxSize: 1 * 1024 * 1024) { (data, error) in
//                if let err = error {
//                    print(err)
//                } else {
//                    self.imageFromServer = UIImage(data: data!)!
//                    //                    self.top.append(self.acc0)
//                    Singleton.shared.top.updateValue(self.imageFromServer, forKey: "top"+"\(num)")
//
//                    self.topCompleteDownloadFile += 1
//                    //MARK: ViewDidLoad에서 여기로 바꿨음.
//                    if num == 0 {
//                        self.setupViews()
//                        self.setupConstraints()
//                    } else if self.topFileCount == self.topCompleteDownloadFile {
//                        self.setupViews()
//                        self.setupConstraints()
//                        self.collectionView.reloadData()
//
//
//                    }
//                }
//            }
//        }
//
//        topRef.listAll { (StorageListResult, Error) in
//
//            if Error == nil {
//                fileCount = StorageListResult.items.count
//                                self.topFileCount = fileCount
//                for i in 0...(fileCount-1) {
//                    setTopCell(num: i)
//                }
//            }
//        }
//
//        func setOuterCell(num: Int) {
//            outerRef.child("outer"+"\(num)"+".png").getData(maxSize: 1 * 1024 * 1024) { (data, error) in
//                if let err = error {
//                    print(err)
//                } else {
//                    self.imageFromServer = UIImage(data: data!)!
//                    //                    self.outer.append(self.acc0)
//                    Singleton.shared.outer.updateValue(self.imageFromServer, forKey: "outer"+"\(num)")
//
//                    self.outerCompleteDownloadFile += 1
//                    //MARK: ViewDidLoad에서 여기로 바꿨음.
//                    if num == 0 {
//                        self.setupViews()
//                        self.setupConstraints()
//                    } else if self.outerFileCount == self.outerCompleteDownloadFile {
//                        self.setupViews()
//                        self.setupConstraints()
//                        self.collectionView.reloadData()
//
//
//                    }
//                }
//            }
//        }
//
//        outerRef.listAll { (StorageListResult, Error) in
//
//            if Error == nil {
//                fileCount = StorageListResult.items.count
//                                self.outerFileCount = fileCount
//                for i in 0...(fileCount-1) {
//                    setOuterCell(num: i)
//                }
//            }
//        }
//
//        func setCapCell(num: Int) {
//            capRef.child("cap"+"\(num)"+".png").getData(maxSize: 1 * 1024 * 1024) { (data, error) in
//                if let err = error {
//                    print(err)
//                } else {
//                    self.imageFromServer = UIImage(data: data!)!
//                    //                    self.cap.append(self.acc0)
//                    Singleton.shared.cap.updateValue(self.imageFromServer, forKey: "cap"+"\(num)")
//
//                    self.capCompleteDownloadFile += 1
//                    //MARK: ViewDidLoad에서 여기로 바꿨음.
//                    if num == 0 {
//                        self.setupViews()
//                        self.setupConstraints()
//                    } else if self.capFileCount == self.capCompleteDownloadFile {
//                        self.setupViews()
//                        self.setupConstraints()
//                        self.collectionView.reloadData()
//
//
//                    }
//                }
//            }
//        }
//
//        capRef.listAll { (StorageListResult, Error) in
//
//            if Error == nil {
//                fileCount = StorageListResult.items.count
//                                self.capFileCount = fileCount
//                for i in 0...(fileCount-1) {
//                    setCapCell(num: i)
//                }
//            }
//        }
//
//    }
//
//}
//
//extension MyClosetCollectionViewCell: UICollectionViewDataSource {
//
//
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        var itemCount: Int!
//        switch cloth {
//        case .cap:
//            itemCount = Singleton.shared.cap.count
//        case .outer:
//            itemCount = Singleton.shared.outer.count
//        case .top:
//            itemCount = Singleton.shared.top.count
//        case .bottom:
//            itemCount = Singleton.shared.bottom.count
//        case .acc:
//            itemCount = Singleton.shared.acc.count
//        case .bag:
//            itemCount = Singleton.shared.bag.count
//        case .shoes:
//            itemCount = Singleton.shared.shoes.count
//        case .socks:
//            itemCount = Singleton.shared.socks.count
//        default:
//            break
//        }
//
//        return itemCount
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell: UICollectionViewCell!
//        let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: MyClosetInnerCollectionViewCell.identifier, for: indexPath) as! MyClosetInnerCollectionViewCell
//
//        switch cloth {
//        case .cap:
//            customCell.configure(image: Singleton.shared.cap["cap"+"\(indexPath.item)"])
//            print("cap reload")
//        case .outer:
//            customCell.configure(image: Singleton.shared.outer["outer"+"\(indexPath.item)"])
//                        print("outer reload")
//        case .top:
//            customCell.configure(image: Singleton.shared.top["top"+"\(indexPath.item)"])
//                        print("top reload")
//        case .bottom:
//            customCell.configure(image: Singleton.shared.bottom["bottom"+"\(indexPath.item)"])
//                        print("bottomreload")
//        case .acc:
//            customCell.configure(image: Singleton.shared.acc["acc"+"\(indexPath.item)"])
//                        print("acc reload")
//        case .bag:
//            customCell.configure(image: Singleton.shared.bag["bag"+"\(indexPath.item)"])
//                        print("bag reload")
//        case .shoes:
//            customCell.configure(image: Singleton.shared.shoes["shoes"+"\(indexPath.item)"])
//                        print("shoes reload")
//        case .socks:
//            customCell.configure(image: Singleton.shared.socks["socks"+"\(indexPath.item)"])
//                        print("socks reload")
//        default:
//            break
//        }
//
//
//        cell = customCell
//        cell.backgroundColor = .white
//
//        return cell
//    }
//}
//
//extension MyClosetCollectionViewCell: MyClosetViewControllerDelegate {
//    func secondReloadRequest() {
//        print("Second delegate")
//        print("결과 싱글톤",Singleton.shared.outer)
//
//        DispatchQueue.global().sync {
//            self.cloth = .cap
//            self.collectionView.reloadData()
//            print(cloth ?? "클로즈없음")
//        }
//                DispatchQueue.global().sync {
//        self.cloth = .outer
//        self.collectionView.reloadData()
//                print(cloth ?? "클로즈없음")
//        }
//
//                DispatchQueue.global().sync {
//        self.cloth = .top
//        self.collectionView.reloadData()
//                print(cloth ?? "클로즈없음")
//        }
//
//                DispatchQueue.global().sync {
//        self.cloth = .bottom
//        self.collectionView.reloadData()
//                print(cloth ?? "클로즈없음")
//        }
//
//                DispatchQueue.global().sync {
//        self.cloth = .shoes
//        self.collectionView.reloadData()
//                print(cloth ?? "클로즈없음")
//        }
//
//                DispatchQueue.global().sync {
//        self.cloth = .bag
//        self.collectionView.reloadData()
//                print(cloth ?? "클로즈없음")
//        }
//
//                DispatchQueue.global().sync {
//        self.cloth = .acc
//        self.collectionView.reloadData()
//                print(cloth ?? "클로즈없음")
//        }
//
//                DispatchQueue.global().sync {
//        self.cloth = .socks
//        self.collectionView.reloadData()
//        }
//
//        print(cloth ?? "클로즈없음")
//    }
//}
