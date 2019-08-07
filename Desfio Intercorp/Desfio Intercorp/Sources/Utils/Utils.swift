//
//  Utils.swift
//  Desfio Intercorp
//
//  Created by Danny Alva on 8/5/19.
//  Copyright © 2019 Danny Alva. All rights reserved.
//

import UIKit

class Utils: NSObject {
    
    public func showAlert(message:String) {
        let alert = UIAlertController.init(title: "", message: message, preferredStyle: UIAlertController.Style.alert);
        alert.addAction(UIAlertAction.init(title: Constants.ACCEPT_BUTTON, style: .default, handler: nil))
        guard let viewController = UIApplication.shared.keyWindow?.rootViewController?.presentedViewController else {
            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
            return
        }
       viewController.present(alert, animated: true, completion: nil)
    }
    
    func validatePhoneNumber(phone:String) -> Bool {
        let phoneRegex = "[9][0-9]{8}$"
        let predicatePhone = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return predicatePhone.evaluate(with: phone)
    }
    
    func validateCode(code:String) -> Bool {
        let codeRegex = "^[0-9]{6}$"
        let predicateCode = NSPredicate(format: "SELF MATCHES %@", codeRegex)
        return predicateCode.evaluate(with: code)
    }
    
    func addToolbarTextField(textfield: UITextField, target:Any, action:Selector) {
        let numberToolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        numberToolbar.barStyle = .default
        numberToolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Aceptar", style: .plain, target: target, action: action)]
        numberToolbar.sizeToFit()
        textfield.inputAccessoryView = numberToolbar
    }
}
