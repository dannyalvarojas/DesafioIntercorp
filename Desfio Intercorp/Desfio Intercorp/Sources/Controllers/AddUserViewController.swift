//
//  AddUserViewController.swift
//  Desfio Intercorp
//
//  Created by Danny Alva on 8/5/19.
//  Copyright © 2019 Danny Alva. All rights reserved.
//

import UIKit

class AddUserViewController: UIViewController {
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var lastNameText: UITextField!
    @IBOutlet weak var birthdayText: UITextField!
    @IBOutlet weak var ageText: UITextField!
    @IBOutlet weak var saveButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.initView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - Private Methods
    func initView() {
        self.title = "Usuario Nuevo"
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action:#selector(back))
        self.navigationItem.leftBarButtonItem  = addButton
        
        self.saveButton.addCornerButton()
        
        Utils.init().addToolbarTextField(textfield: self.nameText, target: self, action: #selector(doneKeyboard))
        Utils.init().addToolbarTextField(textfield: self.lastNameText, target: self, action: #selector(doneKeyboard))
        Utils.init().addToolbarTextField(textfield: self.ageText, target: self, action: #selector(doneKeyboard))
        Utils.init().addToolbarTextField(textfield: self.birthdayText, target: self, action: #selector(doneKeyboard))
        
        self.initDatePicker()
    }
    
    @objc func back () {
        self.dismiss(animated: true, completion: nil)
    }
    
    func initDatePicker() {
        let calendar = Calendar(identifier: .gregorian)
        var comps = DateComponents()
        comps.year = -20
        let maxDate = calendar.date(byAdding: comps, to: Date())
        comps.year = -100
        let minDate = calendar.date(byAdding: comps, to: Date())
        
        let datePickerView  : UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePicker.Mode.date
        datePickerView.maximumDate = maxDate
        datePickerView.minimumDate = minDate
            self.birthdayText.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(handleDatePicker(_:)), for: UIControl.Event.valueChanged)
    }
    
    @objc func doneKeyboard() {
        self.view.endEditing(true)
    }
    
    @IBAction func handleDatePicker(_ sender: Any) {
        let datePickerView  = sender as! UIDatePicker
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        self.birthdayText.text = dateFormatter.string(from: datePickerView.date)
    }
    
    
    // MARK: - IBActions
    @IBAction func saveUser(_ sender: Any) {
        guard let name = self.nameText.text,
            let lastName = self.lastNameText.text,
            let age = self.ageText.text,
            let birthday = self.birthdayText.text else {
                return
        }
        let user = User(name: name, lastName: lastName, age: age, birthday: birthday)
        Loader.sharedInstance.initLoader()
        Loader.sharedInstance.start()
        FirebaseDataBase.sharedInstance.addUser(user: user, completion: { (success) -> Void in
            Loader.sharedInstance.stop()
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        })
        
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
