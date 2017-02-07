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
    
    
    @IBAction func createAcount(_ sender: UIButton) {
        
        
        if phoneNumberText.text == "" || passwordText.text == "" {
            //вывод сообщения о oшибке
            let alertController = UIAlertController(title: "Ошибка", message: "Есть пустые поля", preferredStyle: UIAlertControllerStyle.alert) //Replace UIAlertControllerStyle.Alert by UIAlertControllerStyle.alert
            
            let okAction = UIAlertAction(title: "Ок", style: UIAlertActionStyle.default) {
                (result : UIAlertAction) -> Void in
            }
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
            
        } else {
            let json = ["phone_number": Int(phoneNumberText.text!),
                        "password": passwordText.text] as [String : Any]
            /*
             Alamofire.request("http://oasushqg.beget.tech/user/create", method: .post, parameters: json, encoding: JSONEncoding.default)
             .responseJSON { response in
             print("response------>>>>>")
             print(response)
             print("response.request----->>>>>")
             print(response.request)  // original URL request
             print("response.response---->>>>>")
             print(response.response) // URL response
             print("response.data---->>>>>")
             print(response.data)     // server data
             print("response.result----->>>>")
             print(response.result)   // result of response serialization
             print("json = response.result.value======>>>")
             if let json = response.result.value {
             print("JSON: \(json)")
             }
             }
             */
            
            let tmp = Singleton.shared
            tmp.change()
            //MenuViewController.updateTableMy()
            
        }

        
        
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
