//
//  SendMessageViewController.swift
//  Desfio Intercorp
//
//  Created by Danny Alva on 8/5/19.
//  Copyright © 2019 Danny Alva. All rights reserved.
//

import UIKit
import Firebase

class SendMessageViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var phoneTextField : UITextField!
    @IBOutlet weak var sendButton : UIButton!
    var phoneNumber:String!
    var verificationCode:String!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationController = segue.destination as! VerificationCodeViewController
        destinationController.verificationID = self.verificationCode
    }
 
    
    // MARK: - UITexfieldDelegate
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.phoneNumber = Constants.NO_TEXT
        
        self.phoneNumber = textField.text
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= 9
    }
    
    // MARK: - Private Metods
    func initView() {
        self.title = "Ingreso con celular"
        self.phoneNumber = Constants.NO_TEXT
        self.sendButton.addCornerButton()
        
        Utils.init().addToolbarTextField(textfield: self.phoneTextField, target: self, action: #selector(doneKeyboard))
    }
    
    @objc func doneKeyboard() {
        self.view.endEditing(true)
    }
    
    
    // MARK: - IBActions
    
    @IBAction func sendMessagePhone(_ sender: Any) {
        
        if !Utils.init().validatePhoneNumber(phone: phoneNumber) {
            Utils.init().showAlert(message: "Ingresa un número válido de celular")
            return
        }
        
        Loader.sharedInstance.initLoader()
        Loader.sharedInstance.start()
        self.phoneNumber = "+51"+self.phoneNumber
        PhoneAuthProvider.provider().verifyPhoneNumber(self.phoneNumber, uiDelegate: nil) { (verificationID, error) in
            Loader.sharedInstance.stop()
            if let error = error {
                Utils.init().showAlert(message: error.localizedDescription)
                return
            }
            self.verificationCode = verificationID
            self.performSegue(withIdentifier: "segueVerificationCode", sender: self)
        }
    }
    

}
