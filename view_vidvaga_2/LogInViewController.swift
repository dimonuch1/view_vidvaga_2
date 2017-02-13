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
import Alamofire
import SwiftyJSON

class LogInViewController: UIViewController,UITextFieldDelegate {

    //MARK: - Outlets
    
    let MAX_LENGTH_STRING = 20
    
    @IBOutlet weak var btnMenu: UIBarButtonItem!

    @IBOutlet weak var phoneNumberText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!

    
    @IBOutlet weak var registerButton: UIButton!
   
    @IBOutlet weak var enterBottom: UIButton!
    
    @IBOutlet weak var registrationButtom: UIButton!
    
    let urlLogin = "http://oasushqg.beget.tech/user/create"
    
    //MARK: - Start
    
    override func viewDidLoad() {
        super.viewDidLoad()

        phoneNumberText.delegate = self
        
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
        
        let singleton = Singleton.shared
        
        if singleton.login == true {
            enterBottom.isEnabled = false
            registerButton.isEnabled = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func alertMessage(title:String,message:String) {
        //вывод сообщения о oшибке
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "Ок", style: UIAlertActionStyle.default) {
            (result : UIAlertAction) -> Void in
        }
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    //войти
    @IBAction func createAcount(_ sender: UIButton) {
        
        //не помню заче это нужно
         let revealViewController:SWRevealViewController = self.revealViewController()
        
        if phoneNumberText.text == "" || passwordText.text == "" {
            self.alertMessage(title: "Ошибка", message: "Есть пустые поля")
            
        } else {
            
            //создать окошко алерт оповещающее о том что производится попытка входа
            //добавить ездещий танчик!!!!!
            
            //анрапаем так как поля точно не пустые
            let json = ["phone_number": phoneNumberText.text!,
                        "password": passwordText.text!] as [String : Any]
    
             Alamofire.request(urlLogin, method: .post, parameters: json, encoding: JSONEncoding.default)
             .responseJSON { response in
                
                //создать окошко алерт оповещающее о том что производится попытка входа
                //добавить ездещий танчик
                
             if let json = response.result.value {
                
                let json2 = JSON(json)
                
                let message = json2["message"].string
                //обпаботка сообщение которое вернет сервер
                
                //рпользователь вошел успешно
             if message == "ok" {
                
                let singleton = Singleton.shared
                singleton.login = true
                let defaults = UserDefaults.standard
                defaults.set(true, forKey: "login")
                defaults.synchronize()
             } else {
                //пользователь вошел не успешно
                self.alertMessage(title: "Ошибка", message: message!)
                }
             }
    
            //переводим на главный экран новостей
            let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let desController = mainStoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            let newFrontViewController = UINavigationController.init(rootViewController: desController)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }
    }
}
    
    //MARK: - UITextFieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool
    {
        
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= MAX_LENGTH_STRING
    }
    
    
}
