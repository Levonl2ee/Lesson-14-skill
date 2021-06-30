//
//  ViewController.swift
//  Lesson 14
//
//  Created by Левон Амбарцумян on 15.06.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surNameTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.text = NamesUserDefaults.shared.name
        surNameTextField.text = NamesUserDefaults.shared.surName
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        NamesUserDefaults.shared.name = nameTextField.text
        NamesUserDefaults.shared.surName = surNameTextField.text
    }
}

