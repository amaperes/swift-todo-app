//
//  Todo.swift
//  TodoApp
//
//  Created by Antonela Madalina on 15/09/2020.
//  Copyright © 2020 AM Perescu. All rights reserved.
//

import Foundation
import RealmSwift

class Todo: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
