//
//  MyClosetViewController.swift
//  MyCloset
//
//  Created by 정의석 on 2020/02/04.
//  Copyright © 2020 pandaman. All rights reserved.
//

import UIKit
import Firebase

@objc protocol MyClosetViewControllerDelegate:class {
    @objc optional func secondReloadRequestCap()
    @objc optional func secondReloadRequestOuter()
    @objc optional func secondReloadRequestTop()
    @objc optional func secondReloadRequestBottom()
    @objc optional func secondReloadRequestShoes()
    @objc optional func secondReloadRequestAcc()
    @objc optional func secondReloadRequestBag()
    @objc optional func secondReloadRequestSocks()
}



class MyClosetViewController: UIViewController {
    let addNewClothesButton = UIButton()
    let makeCodiButton = UIButton()
    var reloadCount = 0
    weak var delegate: MyClosetViewControllerDelegate?
    let flowLayout = UICollectionViewFlowLayout()
     
     lazy var collectionView = UICollectionView(
         frame: view.frame, collectionViewLayout: flowLayout
     )
     

     override func viewDidLoad() {
         super.viewDidLoad()
//        login()
        self.setupCollectionView()
        self.setupUI()
        view.backgroundColor = UIColor(named: "cameraBG")

         // Do any additional setup after loading the view.
     }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SelectedImageSingleton.shared.selectedImageSet.removeAll()
        
    }
    
    private func setupUI() {
        
        addNewClothesButton.setTitle("옷 추가하기", for: .normal)
        addNewClothesButton.backgroundColor = UIColor(named: "textColor")
        addNewClothesButton.layer.cornerRadius = 7
        addNewClothesButton.shadow()
        addNewClothesButton.addTarget(self, action: #selector(didTapAddNewButton), for: .touchUpInside)
        
        makeCodiButton.setTitle("코디 만들기", for: .normal)
        makeCodiButton.backgroundColor = UIColor(named: "codiColor")
        makeCodiButton.layer.cornerRadius = 7
        makeCodiButton.shadow()
        makeCodiButton.addTarget(self, action: #selector(didTapMakeCodiButton), for: .touchUpInside)
        
        view.addSubview(addNewClothesButton)
        view.addSubview(makeCodiButton)
        view.bringSubviewToFront(addNewClothesButton)
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        
        addNewClothesButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
            $0.centerX.equalTo(view.snp.centerX)
            $0.width.equalToSuperview().multipliedBy(0.95)
            $0.height.equalTo(42)
        }
        
        makeCodiButton.snp.makeConstraints {
            $0.bottom.equalTo(addNewClothesButton.snp.top).offset(-5)
            $0.centerX.equalTo(view.snp.centerX)
            $0.width.equalToSuperview().multipliedBy(0.95)
            $0.height.equalTo(42)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.width.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(makeCodiButton.snp.top).offset(-10)
        }
    }
    
    @objc private func didTapAddNewButton() {
        let cameraVC = CameraCustomViewController()
        cameraVC.delegate = self
        cameraVC.modalPresentationStyle = .fullScreen
        present(cameraVC, animated: true)
    }
    
    @objc private func didTapMakeCodiButton() {
        let makeCodiVC = MakeCodiViewController()
        makeCodiVC.modalPresentationStyle = .fullScreen
        present(makeCodiVC, animated: true)
    }
     
     private func setupCollectionView() {
         setupFlowLayout()
         
         collectionView.backgroundColor = UIColor(named: "cameraBG")
         collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.register(AccCollectionViewCell.self, forCellWithReuseIdentifier: AccCollectionViewCell.identifier)
        collectionView.register(CapCell.self, forCellWithReuseIdentifier: CapCell.identifier)
        collectionView.register(OuterCell.self, forCellWithReuseIdentifier: OuterCell.identifier)
        collectionView.register(TopCell.self, forCellWithReuseIdentifier: TopCell.identifier)
        collectionView.register(BottomCell.self, forCellWithReuseIdentifier: BottomCell.identifier)
        collectionView.register(ShoesCell.self, forCellWithReuseIdentifier: ShoesCell.identifier)
        collectionView.register(BagCell.self, forCellWithReuseIdentifier: BagCell.identifier)
        collectionView.register(SocksCell.self, forCellWithReuseIdentifier: SocksCell.identifier)

        
        view.addSubview(collectionView)
        
     }
    
//    func login() {
//        Auth.auth().signIn(withEmail: "panda@naver.com", password: "123456") { (result, err) in
//            print(result as Any)
//
//        }
//    }
     
     private func setupFlowLayout() {
        flowLayout.itemSize = CGSize(width: view.frame.width , height: 150)
        flowLayout.minimumLineSpacing = 5
        flowLayout.minimumInteritemSpacing = 20
        flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        flowLayout.scrollDirection = .vertical
     }

}

extension MyClosetViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.item {
        case 0:
            let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: CapCell.identifier, for: indexPath) as! CapCell
            customCell.configure(image: nil, title: "셀")
            self.delegate = customCell
                    return customCell
        case 1:
            let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: OuterCell.identifier, for: indexPath) as! OuterCell
            customCell.configure(image: nil, title: "셀")
            self.delegate = customCell
                    return customCell
        case 2:
           let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: TopCell.identifier, for: indexPath) as! TopCell
            customCell.configure(image: nil, title: "셀")
            self.delegate = customCell
                    return customCell
        case 3:
            let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: BottomCell.identifier, for: indexPath) as! BottomCell
            customCell.configure(image: nil, title: "셀")
            self.delegate = customCell
                    return customCell
        case 4:
           let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: ShoesCell.identifier, for: indexPath) as! ShoesCell
            customCell.configure(image: nil, title: "셀")
            self.delegate = customCell
                    return customCell
        case 5:
           let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: AccCollectionViewCell.identifier, for: indexPath) as! AccCollectionViewCell
            customCell.configure(image: nil, title: "셀")
            self.delegate = customCell
                    return customCell
        case 6:
            let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: BagCell.identifier, for: indexPath) as! BagCell
            customCell.configure(image: nil, title: "셀")
            self.delegate = customCell
                    return customCell
        case 7:
            let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: SocksCell.identifier, for: indexPath) as! SocksCell
            customCell.configure(image: nil, title: "셀")
            self.delegate = customCell
                    return customCell
        default:
            break
        }
        let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: SocksCell.identifier, for: indexPath) as! SocksCell
                   customCell.configure(image: nil, title: "셀")
                   self.delegate = customCell
                   customCell.backgroundColor = UIColor(named: "KeyColor")
                           return customCell

    }
    
    
}

extension MyClosetViewController: CameraCustomViewControllerDelegate {
    func reloadRequest() {
        print("first delegate")
        
        
//            self.delegate?.secondReloadRequestAcc?()
//            self.delegate?.secondReloadRequestOuter?()
//            self.delegate?.secondReloadRequestTop?()
//            self.delegate?.secondReloadRequestBottom?()
//            self.delegate?.secondReloadRequestBag?()
//            self.delegate?.secondReloadRequestShoes?()
//            self.delegate?.secondReloadRequestSocks?()
//            self.delegate?.secondReloadRequestCap?()
//
//
        let indexPaths = Array(0...7).map {IndexPath(item: $0, section: 0)
        }
        collectionView.reloadItems(at: indexPaths)
        
        
    }
    
    
}
