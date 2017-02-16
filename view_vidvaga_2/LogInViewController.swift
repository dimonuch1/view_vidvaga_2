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
    
    @IBOutlet weak var activiryIndicator: UIActivityIndicatorView!
    

    
    @IBOutlet weak var registerButton: UIButton!
   
    @IBOutlet weak var enterBottom: UIButton!
    
    @IBOutlet weak var registrationButtom: UIButton!
    
    var json:[String : Any] = [:]
    
    let urlLogin = "http://y937220i.bget.ru/users/login"
    
//MARK: - Start
    
    override func viewDidLoad() {
        super.viewDidLoad()

        phoneNumberText.delegate = self
        passwordText.delegate = self
        
        // Do any additional setup after loading the view.
        
        //обработка выезжания бокового меню
        self.btnMenu.target = revealViewController()
        self.btnMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        //обработка выезжания скольжением пальца
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        /*
        //enterBottom.backgroundColor = UIColor.clear
        enterBottom.layer.cornerRadius = 5
        enterBottom.layer.borderWidth = 1
        enterBottom.layer.borderColor = UIColor.black.cgColor
        
        //registrationButtom.backgroundColor = UIColor.clear
        registrationButtom.layer.cornerRadius = 5
        registrationButtom.layer.borderWidth = 1
        registrationButtom.layer.borderColor = UIColor.black.cgColor
        */
        
        let singleton = Singleton.shared
        
        if singleton.login == true {
            enterBottom.isEnabled = false
            registerButton.isEnabled = false
        }
        
        
        phoneNumberText.becomeFirstResponder()
        phoneNumberText.text = "(+380)"
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
    
    func createPhoneNumber() {
        
        self.phoneNumberText.text = self.phoneNumberText.text?.replacingOccurrences(of: ")", with: "")
        self.phoneNumberText.text = self.phoneNumberText.text?.replacingOccurrences(of: "(", with: "")
        
    }
    
    
//MARK: - Action
    @IBAction func createAcount(_ sender: UIButton) {
        
        self.view.endEditing(true)
        
        self.activiryIndicator.startAnimating()
        
        //не помню заче это нужно
         let revealViewController:SWRevealViewController = self.revealViewController()
        
        if phoneNumberText.text == "" || passwordText.text == "" {
            self.alertMessage(title: "Ошибка", message: "Есть пустые поля")
            
        } else {
            
            //создать окошко алерт оповещающее о том что производится попытка входа
            //добавить ездещий танчик!!!!!
            createPhoneNumber()
            print(self.phoneNumberText.text)
            //анрапаем так как поля точно не пустые
            json = ["phone_number": phoneNumberText.text!,
                        "password": passwordText.text!] as [String : Any]
    
             Alamofire.request(urlLogin, method: .post, parameters: json, encoding: JSONEncoding.default)
             .responseJSON { response in
                
                //создать окошко алерт оповещающее о том что производится попытка входа
                //добавить ездещий танчик
               
                print(response)
             if let json = response.result.value {
               
                let json2 = JSON(json)
                
                print(json2)
                let message = json2["message"].string
                //обпаботка сообщение которое вернет сервер
                
                //рпользователь вошел успешно
             if message == "0" {
                self.activiryIndicator.stopAnimating()
                //+380937222858
                //password
                //self.hideActivityIndicator()
                let singleton = Singleton.shared
                singleton.login = true
                let defaults = UserDefaults.standard
                defaults.set(true, forKey: "login")
                defaults.synchronize()
                
                //переводим на главный экран новостей
                let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let desController = mainStoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                let newFrontViewController = UINavigationController.init(rootViewController: desController)
                revealViewController.pushFrontViewController(newFrontViewController, animated: true)
                
             } else {
                //пользователь вошел не успешно
                //self.hideActivityIndicator()
                self.activiryIndicator.stopAnimating()
                self.alertMessage(title: "Ошибка", message: message ?? "не известная ошибка")
                }
             }
        }
    }
}
    
//MARK: - UITextFieldDelegate
    //ограничение количества симолов в строке
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool
    {
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= MAX_LENGTH_STRING
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
            enterBottom.sendActions(for: .touchUpInside)

        }
        // Do not add a line break
        return false
    }
    
//MARK: - Activiti_indicator
    
    func hideActivityIndicator() {
        let asinc = DispatchQueue.global(qos: .background)
        asinc.async {
            //self.spinner.stopAnimating()
            //self.loadingView.removeFromSuperview()
        }
    }

}
