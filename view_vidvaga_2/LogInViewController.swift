//
//  LogInViewController.swift
//  view_vidvaga_2
//
//  Created by ios on 30.01.17.
//  Copyright © 2017 Alex Berezovskyy. All rights reserved.
//

//для НЕ зарегестрированого пользователя

import UIKit

class LogInViewController: UIViewController {

    @IBOutlet weak var btnMenu: UIBarButtonItem!

    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var phoneNumberText: UITextField!
    
    @IBOutlet weak var military_idText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var passwordTwoText: UITextField!
    
    @IBAction func createAcount(_ sender: UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //обработка выезжания бокового меню
        self.btnMenu.target = revealViewController()
        self.btnMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        //обработка выезжания скольжением пальца
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
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
