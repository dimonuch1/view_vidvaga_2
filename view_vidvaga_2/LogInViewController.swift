//
//  LogInViewController.swift
//  view_vidvaga_2
//
//  Created by ios on 30.01.17.
//  Copyright © 2017 Alex Berezovskyy. All rights reserved.
//

//для НЕ зарегестрированого пользователя

import UIKit
import TextFieldEffects

class LogInViewController: UIViewController {

    
    @IBOutlet weak var btnMenu: UIBarButtonItem!

    @IBOutlet weak var phoneNumberText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!

    @IBAction func createAcount(_ sender: UIButton) {
     
    }
   
    @IBOutlet weak var enterBottom: UIButton!
    
    @IBOutlet weak var registrationButtom: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //обработка выезжания бокового меню
        self.btnMenu.target = revealViewController()
        self.btnMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        //обработка выезжания скольжением пальца
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        //enterBottom.backgroundColor = UIColor.clear
        enterBottom.layer.cornerRadius = 5
        enterBottom.layer.borderWidth = 1
        enterBottom.layer.borderColor = UIColor.black.cgColor
        
        //registrationButtom.backgroundColor = UIColor.clear
        registrationButtom.layer.cornerRadius = 5
        registrationButtom.layer.borderWidth = 1
        registrationButtom.layer.borderColor = UIColor.black.cgColor

        
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
