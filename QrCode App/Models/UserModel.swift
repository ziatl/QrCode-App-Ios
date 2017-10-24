//
//  UserModel.swift
//  QrCode App
//
//  Created by Liloudini Aziz on 24/10/2017.
//  Copyright © 2017 Liloudini Aziz. All rights reserved.
//

import Foundation
import RealmSwift
class UserModel:Object {
    //Primaty key autogenerate
    @objc dynamic var id = UUID().uuidString;
    @objc dynamic var nom = "";
    @objc dynamic var prenom = "";
    @objc dynamic var login = "";
    @objc dynamic var password = "";
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
