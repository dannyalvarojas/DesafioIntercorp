//
//  User.swift
//  Desfio Intercorp
//
//  Created by Danny Alva on 8/6/19.
//  Copyright © 2019 Danny Alva. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

struct User {
    var ref:DatabaseReference?
    var name: String
    var lastName: String
    var age: String
    var birthday: String
    
    init(name: String, lastName:String, age: String, birthday:String) {
        self.ref = nil
        self.name = name
        self.lastName = lastName
        self.age = age
        self.birthday = birthday
    }
    
    init?(snapshot: DataSnapshot){
        guard
            let value = snapshot.value as? [String:AnyObject],
            let name = value["name"] as? String,
            let lastName = value["lastName"] as? String,
            let age = value["age"] as? String,
            let birthday = value["birthday"] as? String
            else {
                return nil
        }
        self.ref = snapshot.ref
        self.name = name
        self.lastName = lastName
        self.age = age
        self.birthday = birthday
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "lastName":lastName,
            "age":age,
            "birthday":birthday
        ]
    }
}
