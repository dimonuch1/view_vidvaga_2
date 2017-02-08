//
//  RegistrationViewController.swift
//  view_vidvaga_2
//
//  Created by ios on 02.02.17.
//  Copyright © 2017 Alex Berezovskyy. All rights reserved.
//

import UIKit
import TextFieldEffects

class RegistrationViewController: UIViewController {

    
    @IBOutlet weak var password: IsaoTextField!
    
    @IBOutlet weak var repit_password: IsaoTextField!
    
    @IBOutlet weak var email: IsaoTextField!
    
    @IBOutlet weak var name: IsaoTextField!
    
    @IBOutlet weak var id: IsaoTextField!
    
    @IBOutlet weak var phone: IsaoTextField!
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        
    }
    
    @IBOutlet weak var registerButton: UIBarButtonItem!
  
    
    
    func textFieldDidChange(_ textField: UITextField) {
        if password.text != "" && repit_password.text != "" && name.text != "" && id.text != "" && phone.text != "" {
                registerButton.isEnabled = true
        }
        print("didChange \(textField)")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem?.title = "Назад"
        
        password.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        repit_password.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        name.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        id.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        phone.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
