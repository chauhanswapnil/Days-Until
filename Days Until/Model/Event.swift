//
//  Event.swift
//  Days Until
//
//  Created by Swapnil Chauhan on 04/10/20.
//

import Foundation
import RealmSwift

class Event: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var title = ""
    @objc dynamic var date = Date()
    @objc dynamic var image: Data? = nil
}
