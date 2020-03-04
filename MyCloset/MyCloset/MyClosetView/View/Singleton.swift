//
//  Singleton.swift
//  MyCloset
//
//  Created by 정의석 on 2020/02/06.
//  Copyright © 2020 pandaman. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase

class Singleton {
    static let shared = Singleton()
    private init() {
        
    }
    
    var acc: Dictionary<String, UIImage> = [:]
    var bag: Dictionary<String, UIImage> = [:]
    var bottom: Dictionary<String, UIImage> = [:]
    var cap: Dictionary<String, UIImage> = [:]
    var outer: Dictionary<String, UIImage> = [:]
    var shoes: Dictionary<String, UIImage> = [:]
    var socks: Dictionary<String, UIImage> = [:]
    var top: Dictionary<String, UIImage> = [:]
    
}


class SelectedImageSingleton {
    static let shared = SelectedImageSingleton()
    private init() {
        
    }
    var selectedImageSet: [String:UIImage] = [:]
}
