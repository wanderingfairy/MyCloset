//
//  MyClosetModel.swift
//  MyCloset
//
//  Created by 정의석 on 2020/02/04.
//  Copyright © 2020 pandaman. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase

enum Gender {
    case male
    case female
    case other
}

enum Category {
    case cap
    case outer
    case top
    case bottom
    case shoes
    case bag
    case acc
    case socks
}

struct User {
    let userName: String
    let gender: Gender
}

struct Item {
    let image: UIImage
    let category: Category
}

struct SelectedItem {
    let cap: Category?
    let outer: Category?
    let top: Category
    let bottom: Category
    let shoes: Category
    let bag: Category?
    let acc: Category?
    let socks: Category?
}

