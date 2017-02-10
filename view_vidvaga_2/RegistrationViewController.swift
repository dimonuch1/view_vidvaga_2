//
//  RegistrationViewController.swift
//  view_vidvaga_2
//
//  Created by ios on 02.02.17.
//  Copyright © 2017 Alex Berezovskyy. All rights reserved.
//

import UIKit
import TextFieldEffects
import Alamofire
import SwiftyJSON

class RegistrationViewController: UIViewController {

    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var repit_password: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var id: UITextField!
    
    @IBOutlet weak var phone: UITextField!
    
    @IBOutlet weak var registerButton: UIBarButtonItem!
    
    //let urlRegistration = "http://oasushqg.beget.tech/users"
    
   let urlRegistration = "http://y937220i.bget.ru/users"
    
    var json:[String : Any] = [:]

    //MARK: - Start
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        
        if password.text == repit_password.text {
            
        //создание json для пересылки
        //так как мы не можем зайти сюда если будут пустые поля
        //то мы смело анрапаем
        json = ["phone_number": phone.text!,
                    "password": password.text!,
                 "military_id":Int(id.text!)!] as [String : Any]
            //если у нас есть email
            if email.text != "" {
                json["email"] = email.text
            }
            
        //запрос
         Alamofire.request(urlRegistration, method: .post, parameters: json, encoding: JSONEncoding.default)
         .responseJSON { response in
            
            //создать окошко алерт оповещающее о том что производится попытка входа
            //добавить ездещий танчик!!!!

         /*
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
         */
            
            if let json = response.result.value {
                //print("JSON: \(json)")
                let json2 = JSON(json)
                let message = json2["message"].string
                //обпаботка сообщение которое вернет сервер
                if message == "ok" {
                    self.alertMessage(title: "Реєстрація пройша успішно", message: "Дочекайтеся SMS пароля для підтвердження")
                    
                    //отмечаем вход в систему
                    /*
                    let singleton = Singleton.shared
                    singleton.login = true
                    let defaults = UserDefaults.standard
                    defaults.set(true, forKey: "login")
                    defaults.synchronize()
                    */
                    
                     //переход на окно отправки смс пароля
                    
                    //что то важное
                    let revealViewController:SWRevealViewController = self.revealViewController()

                    let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let desController = mainStoryboard.instantiateViewController(withIdentifier: "SmsRegistration") as! SmsRegistration
                    
                    let newFrontViewController = UINavigationController.init(rootViewController: desController)
                    revealViewController.pushFrontViewController(newFrontViewController, animated: true)
                } else {
                    self.alertMessage(title: "Помилка", message: message!)
                }
            }
         }
            
           
            //если пароли не совпадают
        } else {
            self.alertMessage(title: "Помилка", message: "Паролі не збігаються")
        }
    }
    
    func alertMessage(title:String,message: String) {
        
        //вывод сообщения о oшибке
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "Ок", style: UIAlertActionStyle.default) {
            (result : UIAlertAction) -> Void in
        }
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
  
    //отлавливаем изменение в текстовых полях
    //что бы включить кнопку регестрация когда все поля будут заполнены
    func textFieldDidChange(_ textField: UITextField) {
        if password.text != "" && repit_password.text != "" && id.text != "" && phone.text != "" {
            registerButton.isEnabled = true
        }
        //если хоть что то не заполнено
        if password.text == "" || repit_password.text == "" || id.text == "" || phone.text == "" {
            registerButton.isEnabled = false
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        password.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        repit_password.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        id.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        phone.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: - SmsRegistration

class SmsRegistration:UIViewController {
    
    //необходимое количество цифер для пароля
    let COUNT_CHARACTERS_SMS = 4
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    let urlSmsRegistration = "site_domain/api/users/verify"
    
    @IBOutlet weak var sendSmsCode: UIBarButtonItem!
    
    @IBOutlet weak var smsPassord: IsaoTextField!
    @IBAction func sendButton(_ sender: UIBarButtonItem) {
        
        let json = ["code":Int(smsPassord.text!)!] as [String:Int]
        
        Alamofire.request(urlSmsRegistration, method: .post, parameters: json, encoding: JSONEncoding.default)
            .responseJSON { response in
                
                if let json = response.result.value {
                    let json2 = JSON(json)
                    let message = json2["message"]
                    //обпаботка сообщение которое вернет сервер
                    if message == "Ok" {
                       
                    }
                }
        }

        
    }

    func textFieldDidChange(_ textField: UITextField) {
    
        if smsPassord.text?.characters.count == COUNT_CHARACTERS_SMS {
            smsPassord.isEnabled = true
        } else {
            smsPassord.isEnabled = false
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        smsPassord.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        //обработка выезжания бокового меню
        self.menuButton?.target = revealViewController()
        self.menuButton?.action = #selector(SWRevealViewController.revealToggle(_:))
        //обработка выезжания скольжением пальца
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
    }
    
}

