//
//  Category.swift
//  Todoey
//
//  Created by Chia Khai Fong on 21/6/18.
//  Copyright © 2018 Chia Khai Fong. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name : String = ""
    
    //creating a list of "Item" object beginning with an empty list
    let items = List<Item>()
}
