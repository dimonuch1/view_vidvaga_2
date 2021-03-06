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

class RegistrationViewController: UIViewController,UITextFieldDelegate {

//MARK: - Outlets
    
    let MAX_LENGTH_STRING = 30
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var repit_password: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var id: UITextField!
    
    @IBOutlet weak var phone: UITextField!
    
    @IBOutlet weak var registerButton: UIBarButtonItem!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    //let urlRegistration = "http://oasushqg.beget.tech/users"
    
   let urlRegistration = "http://y937220i.bget.ru/users"
    
    var json:[String : Any] = [:]

    
    
//MARK: - Start
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        
        if password.text == repit_password.text {
            
        //создание json для пересылки
        //так как мы не можем зайти сюда если будут пустые поля
        //то мы смело анрапаем
            
        createPhoneNumber()
            
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
            
            self.activityIndicator.startAnimating()

            if let json = response.result.value {
                //print("JSON: \(json)")
                let json2 = JSON(json)
                let message = json2["message"].string
                //обпаботка сообщение которое вернет сервер
                if message == "ok" {
                    
                    self.activityIndicator.stopAnimating()
                    
                    self.alertMessage(title: "Реєстрація пройша успішно", message: "Дочекайтеся SMS пароля для підтвердження")
                    
                    //переход на окно отправки смс пароля
                    
                    //что то важное
                    let revealViewController:SWRevealViewController = self.revealViewController()

                    let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let desController = mainStoryboard.instantiateViewController(withIdentifier: "SmsRegistration") as! SmsRegistration
                    
                    let newFrontViewController = UINavigationController.init(rootViewController: desController)
                    revealViewController.pushFrontViewController(newFrontViewController, animated: true)
                } else {
                    self.activityIndicator.stopAnimating()
                    self.alertMessage(title: "Помилка", message: message ?? "Не відома помилка")
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

    //удаление скобочек из номера телефона
    func createPhoneNumber() {
        self.phone.text = self.phone.text?.replacingOccurrences(of: ")", with: "")
        self.phone.text = self.phone.text?.replacingOccurrences(of: "(", with: "")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        password.delegate = self
        repit_password.delegate = self
        id.delegate = self
        phone.delegate = self
        
        password.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        repit_password.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        id.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        phone.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        
        phone.becomeFirstResponder()
        phone.text = "(+380)"
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//MARK: - UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= MAX_LENGTH_STRING
    }
 
 
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
            UIApplication.shared.sendAction(registerButton.action!, to: registerButton.target, from: self, for: nil)
        }
        // Do not add a line break
        return false
    }
}




//MARK: - SmsRegistration

class SmsRegistration:UIViewController,UITextFieldDelegate {
    
    //необходимое количество цифер для пароля
    let COUNT_CHARACTERS_SMS = 4
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    let urlSmsRegistration = "site_domain/api/users/verify"
    
    @IBOutlet weak var sendSmsCode: UIBarButtonItem!
    
    @IBOutlet weak var smsPassord: IsaoTextField!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    @IBAction func sendButton(_ sender: UIBarButtonItem) {
        
        let json = ["code":Int(smsPassord.text!)!] as [String:Int]
        
        Alamofire.request(urlSmsRegistration, method: .post, parameters: json, encoding: JSONEncoding.default)
            .responseJSON { response in
                self.activityIndicator.startAnimating()
                if let json = response.result.value {
                    let json2 = JSON(json)
                    let message = json2["message"].string
                    //обпаботка сообщение которое вернет сервер
                    if message == "Ok" {
                       self.activityIndicator.stopAnimating()
                        //сделать пост запрос на сервер о том что пользователь ввел правильный пароль из смс
                        
                    } else {
                        self.activityIndicator.stopAnimating()
                        self.alertMessage(title: "Помилка", message: message ?? "Не відома помилка")
                    }
                }
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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        smsPassord.delegate = self
        
        smsPassord.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        //обработка выезжания бокового меню
        self.menuButton?.target = revealViewController()
        self.menuButton?.action = #selector(SWRevealViewController.revealToggle(_:))
        //обработка выезжания скольжением пальца
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
//MARK: - UITextFieldDelegate

    func textFieldDidChange(_ textField: UITextField) {
    
        if smsPassord.text?.characters.count == COUNT_CHARACTERS_SMS {
            smsPassord.isEnabled = true
        } else {
            smsPassord.isEnabled = false
        }
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool
    {
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= COUNT_CHARACTERS_SMS
    }
}

