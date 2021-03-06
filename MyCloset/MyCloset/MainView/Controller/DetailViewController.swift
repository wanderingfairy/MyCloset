//
//  DetailViewController.swift
//  MyCloset
//
//  Created by 정의석 on 2020/02/07.
//  Copyright © 2020 pandaman. All rights reserved.
//

import UIKit
class DetailViewController: UIViewController {
    let imageView = UIImageView()
    var titleStr = ""
    var imageViewHeightConst:NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchGesture(_:)))
        view.addGestureRecognizer(pinchGesture)
        configureImageView()
        configureConstraints()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    @objc func pinchGesture(_ sender:UIPinchGestureRecognizer) {
        imageView.transform = imageView.transform.scaledBy(x: sender.scale, y: sender.scale)
        sender.scale = 1.0
    }
    private func configureImageView() {
        title = self.titleStr
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
    }
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 300),
        ])
        imageViewHeightConst = imageView.heightAnchor.constraint(equalToConstant: 0)
        imageViewHeightConst.isActive = true
    }
    func set(image: UIImage) {
        let imageHeight = image.size.height
        let imageWidth = image.size.width
        let imageSizeRatio = (view.frame.width * 0.7) / imageWidth
        let constant = CGFloat(imageHeight * imageSizeRatio)
        imageViewHeightConst.constant = constant
        self.view.layoutIfNeeded()
        imageView.image = image
    }
}
