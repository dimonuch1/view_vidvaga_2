//
//  MenuViewController.swift
//  view_vidvaga_2
//
//  Created by ios on 17.01.17.
//  Copyright © 2017 Alex Berezovskyy. All rights reserved.
//


//боковое меню

import UIKit
import KeychainSwift

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableMenu: UITableView!
    
    var keychain:KeychainSwift = KeychainSwift()
    
    //масивы строк бокового меню
    var menuNameArray: Array =  [String]()
    var iconeImage: Array = [UIImage]()
    
    //ukrop color
    let color = UIColor(red: 30/255, green: 140/255, blue: 93/255,alpha: 1)
    
    //картичка над меню
    @IBOutlet weak var imgProfile: UIImageView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        menuNameArray = ["Новини","Повідомлення","Налаштунки"]
        
        let tmp = Singleton.shared  // Singleton
        
        if  tmp.login == false {
            menuNameArray += ["Увійти"]
        } else {
            menuNameArray += ["Вийти"]
        }
        
        iconeImage = [UIImage(named:"home")!,UIImage(named:"message")!,UIImage(named:"settings")!,UIImage(named:"log_out")!]
        
        imgProfile.layer.borderColor = color.cgColor
        //imgProfile.layer.cornerRadius = 10
        imgProfile.layer.masksToBounds = false
        imgProfile.clipsToBounds = true
        
        tableMenu.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MAKR: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menuNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell") as! MenuTableViewCell
        cell.imgIcon.image = self.iconeImage[indexPath.row]
        cell.lblMemu.text! = menuNameArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
         tableView.deselectRow(at: indexPath, animated: true)
        
        //что то важное
        let revealViewController:SWRevealViewController = self.revealViewController()
        
        let cell:MenuTableViewCell = tableView.cellForRow(at: indexPath) as! MenuTableViewCell
        
        //обработка нажаний
        //переходы в меню
        if cell.lblMemu.text! == "Новини" {
            let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let desController = mainStoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            let newFrontViewController = UINavigationController.init(rootViewController: desController)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }
        if cell.lblMemu.text! == "Повідомлення"{
            let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let desController = mainStoryboard.instantiateViewController(withIdentifier: "MassegeViewController") as! MassegeViewController
            let newFrontViewController = UINavigationController.init(rootViewController: desController)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }
        if cell.lblMemu.text! == "Увійти" {
            let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let desController = mainStoryboard.instantiateViewController(withIdentifier: "LogInViewController") as! LogInViewController
            let newFrontViewController = UINavigationController.init(rootViewController: desController)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }
        if cell.lblMemu.text! == "Вийти" {
            alertAboutExit()
        }
    }
    
    func alertAboutExit() {
        
        //вывод сообщения о выходе
        let alertController = UIAlertController(title: "Вихід", message: "Ви впевненні що хочете вийти?", preferredStyle: UIAlertControllerStyle.alert)
        
        let noAction = UIAlertAction(title: "Ні", style: UIAlertActionStyle.default) {
            (result: UIAlertAction) -> Void in
        }
        
        let okAction = UIAlertAction(title: "Так", style: UIAlertActionStyle.default) {
            (result : UIAlertAction) -> Void in
            let tmp = Singleton.shared
            tmp.login = false
            let defaults = UserDefaults.standard
            defaults.set(tmp.login, forKey: "login")
            defaults.synchronize()
            
            //вызываем для изменения меню
            self.viewDidAppear(true)
        }
        
        alertController.addAction(noAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
    }

}







