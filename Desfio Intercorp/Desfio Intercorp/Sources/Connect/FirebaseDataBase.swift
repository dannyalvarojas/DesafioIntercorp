//
//  FirebaseDataBase.swift
//  Desfio Intercorp
//
//  Created by Danny Alva on 8/6/19.
//  Copyright © 2019 Danny Alva. All rights reserved.
//

import Foundation
import FirebaseDatabase
import Firebase

class FirebaseDataBase {
    
    var ref:DatabaseReference!
    
    static let sharedInstance: FirebaseDataBase = {
        
        let instance = FirebaseDataBase()
        return instance
    }()
    
    public func initDataBase(){
        ref = Database.database().reference(withPath: "users")
    }
    
    func getUsers(completion: @escaping (_ success:Bool, _ userList:[User]) -> ()) {
        ref?.observe(.value, with: { snapshot in
            var userList: [User] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let user = User(snapshot: snapshot) {
                    userList.append(user)
                }
            }
            completion(true,userList)
        }) { (error) in
            print(error.localizedDescription)
            completion(false,[])
        }
    }
    
    func addUser(user:User, completion: @escaping (_ success: Bool) -> ()) {
        self.ref.childByAutoId().setValue(user.toAnyObject(), withCompletionBlock: { (error, reference) in
            if error == nil {
                completion(true)
                return
            }
            completion(false)
        })
    }
}
