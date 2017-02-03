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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
