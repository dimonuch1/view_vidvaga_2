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

    @IBOutlet weak var password: IsaoTextField!
    
    @IBOutlet weak var repit_password: IsaoTextField!
    
    @IBOutlet weak var email: IsaoTextField!
    
    @IBOutlet weak var name: IsaoTextField!
    
    @IBOutlet weak var id: IsaoTextField!
    
    @IBOutlet weak var phone: IsaoTextField!
    
    @IBOutlet weak var registerButton: UIBarButtonItem!
    
    let urlRegistration = "http://oasushqg.beget.tech/user/create"
    
    var json:[String : Any] = [:]

    //MARK: - Start
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        
        if password.text == repit_password.text {
            
        //создание json для пересылки
        //так как мы не можем зайти сюда если будут пустые поля
        //то мы смело анрапаем
        json = ["phone_number": Int(phone.text!)!,
                    "password": password.text!,
                 "military_id":id,
                        "name":name] as [String : Any]
            //если у нас есть email
            if email.text != "" {
                json["email"] = email
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
                let message = json2["message"]
                //обпаботка сообщение которое вернет сервер
                if message == "Ok" {
                    self.alertMessage(title: "", message: "Реєстрація пройша успішно")
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
        if password.text != "" && repit_password.text != "" && name.text != "" && id.text != "" && phone.text != "" {
            registerButton.isEnabled = true
        }
        //если хоть что то не заполнено
        if password.text == "" || repit_password.text == "" || name.text == "" || id.text == "" || phone.text == "" {
            registerButton.isEnabled = false
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
