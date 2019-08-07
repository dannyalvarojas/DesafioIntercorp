//
//  ViewController.swift
//  Desfio Intercorp
//
//  Created by Danny Alva on 7/26/19.
//  Copyright © 2019 Danny Alva. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var facebookView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.initView()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    //Mark: Private Methods
    func initView() {
        self.phoneButton.addCornerButton()
        
        self.facebookView.layoutIfNeeded()
        let facebookButton = FBSDKLoginButton.init()
        facebookButton.delegate = self
        self.facebookView.backgroundColor = facebookButton.backgroundColor;
        facebookButton.center = CGPoint(x: self.facebookView.frame.size.width/2, y: self.facebookView.frame.size.height/2)
        self.facebookView.addSubview(facebookButton)
        self.facebookView.layer.cornerRadius = 5.0
    }

    // MARK: - FBSDKLoginButtonDelegate
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if let error = error {
            Utils.init().showAlert(message: error.localizedDescription)
            return;
        }
        
        let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        Loader.sharedInstance.initLoader()
        Loader.sharedInstance.start()
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            Loader.sharedInstance.stop()
            if let error = error {
                Utils.init().showAlert(message: error.localizedDescription)
                return
            }
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
}

