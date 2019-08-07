//
//  VerificationCodeViewController.swift
//  Desfio Intercorp
//
//  Created by Danny Alva on 8/5/19.
//  Copyright © 2019 Danny Alva. All rights reserved.
//

import UIKit
import Firebase

class VerificationCodeViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var verificationText :UITextField!
    @IBOutlet weak var validateButton :UIButton!
    var verificationID :String!
    var code: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - IBActions
    @IBAction func goToHombe(sender: Any?) {
        if !Utils.init().validateCode(code: self.code) {
            Utils.init().showAlert(message: "Ingresa el código enviado por SMS")
            return
        }
        
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: self.verificationID,
            verificationCode: self.code)
        
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
    
    //MARK: Private Metods
    func initView() {
        self.title = "Ingreso con celular"
        self.validateButton.addCornerButton()
        self.code = Constants.NO_TEXT
        
        Utils.init().addToolbarTextField(textfield: self.verificationText, target: self, action: #selector(doneKeyboard))
    }
    
    @objc func doneKeyboard() {
        self.view.endEditing(true)
    }
    
    // MARK: - UITexfieldDelegate
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.code = Constants.NO_TEXT
        self.code = textField.text
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= 6
    }
}
