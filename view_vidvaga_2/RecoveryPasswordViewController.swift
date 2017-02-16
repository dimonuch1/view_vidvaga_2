//
//  RecoveryPasswordViewController.swift
//  view_vidvaga_2
//
//  Created by ios on 16.02.17.
//  Copyright © 2017 Alex Berezovskyy. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import TextFieldEffects

class RecoveryPasswordViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var phone: IsaoTextField!
    
    let MAX_LENGTH_STRING = 20
    
    let urlRecovery = "..."
    
    @IBOutlet weak var activityIndocator: UIActivityIndicatorView!
    
    
    var json:[String : Any] = [:]
    
    @IBAction func recovery(_ sender: UIButton) {
        
        //не помню заче это нужно
        let revealViewController:SWRevealViewController = self.revealViewController()
        
        json = ["phone_number": phone.text!] as [String : Any]
        
        Alamofire.request(urlRecovery, method: .post, parameters: json, encoding: JSONEncoding.default)
            .responseJSON { response in
                
                self.activityIndocator.startAnimating()

                print(response)
                if let json = response.result.value {
                    
                    let json2 = JSON(json)
                    
                    print(json2)
                    let message = json2["message"].string
                    //обпаботка сообщение которое вернет сервер
                    
                    //рпользователь вошел успешно
                    if message == "ok" {
                        self.activityIndocator.stopAnimating()
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
                        self.activityIndocator.stopAnimating()
                        self.alertMessage(title: "Ошибка", message: message ?? "не известная ошибка")
                    }
                }
        }
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

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        phone.becomeFirstResponder()
        phone.delegate = self
        phone.text = "(+380)"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
