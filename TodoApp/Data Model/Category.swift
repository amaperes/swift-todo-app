//
//  Category.swift
//  TodoApp
//
//  Created by Antonela Madalina on 15/09/2020.
//  Copyright © 2020 AM Perescu. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var colour: String = ""
    let items = List<Todo>()
}
