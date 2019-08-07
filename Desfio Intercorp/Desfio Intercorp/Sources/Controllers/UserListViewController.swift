//
//  UserListViewController.swift
//  Desfio Intercorp
//
//  Created by Danny Alva on 8/6/19.
//  Copyright © 2019 Danny Alva. All rights reserved.
//

import UIKit
import Firebase

class UserListViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var userTable: UITableView!
    var userList: [User] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if (Auth.auth().currentUser == nil) {
            //self.performSegue(withIdentifier: "segueToLogin", sender: self)
            let storyboard:UIStoryboard = UIStoryboard(name: "LoginStoryboard", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
            let navController = UINavigationController(rootViewController: vc)
            self.present(navController, animated: true, completion: nil)
            return
        }
        
        Loader.sharedInstance.initLoader()
        Loader.sharedInstance.start()
        FirebaseDataBase.sharedInstance.initDataBase()
        FirebaseDataBase.sharedInstance.getUsers(completion: { (success, list) -> Void in
            Loader.sharedInstance.stop()
            if success {
                self.userList = list
                self.userTable.reloadData()
            }
        })
    }
    
    // MARK: - Private Methods
    
    func initView() {
        self.title = "Usuarios"
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action:#selector(addUser))
        self.navigationItem.rightBarButtonItem  = addButton
        
    }
    
    @objc func addUser () {
        self.performSegue(withIdentifier: "segueAddUser", sender: self)
    }

    // MARK: - UItableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UserCell = tableView.dequeueReusableCell(withIdentifier: "userCell") as! UserCell
        cell.loadData(user: self.userList[indexPath.row])
        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
