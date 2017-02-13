//
//  ViewController.swift
//  view_vidvaga_2
//
//  Created by ios on 16.01.17.
//  Copyright © 2017 Alex Berezovskyy. All rights reserved.
//

struct One {
    var keychin:KeychainSwift
}


import UIKit
import CoreData
import KeychainSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //хранитель ключей
     let MyKeychainWrapper = KeychainSwift()
    
    
    //ukrop color
    let color = UIColor(red: 30/255, green: 140/255, blue: 93/255,alpha: 1)
    
    //масивы содержания ячеек
    var mainEvent = [String]()
    var mainEventImage = [String]()
    var helperTextArray = [String]()
    
    //массив будущих обьектов entity  MainEventtable
    var events = [NSManagedObject]()
    
    //наш контекст для кор даты (планируется не использовать)
    var managedObjectContext:NSManagedObjectContext!
    
    //Mark: - IBOutlet
    
    //кнопка зваонка в ОДА
    @IBOutlet weak var phone: UIButton!
    
    //кнопка вызова боковго меню
    @IBOutlet weak var menuButton: UIBarButtonItem?
    
    
    
    //=============================================================================================
    
    //MARK: - Start
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    // set images like
        
        self.navigationItem.titleView = UIImageView(image:UIImage(named:"main_image"))
        
        //var application = UIApplication.shared.delegate as! AppDelegate
       
        managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        //установка картиночки телефончика в кнопку звонка в ОДА
        //self.phone.setImage(UIImage(named:"call"), for: UIControlState.normal)
        //self.phone.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        
        
        self.setupColor()
    
        //обработка выезжания бокового меню
        self.menuButton?.target = revealViewController()
        self.menuButton?.action = #selector(SWRevealViewController.revealToggle(_:))
        //обработка выезжания скольжением пальца
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        
        for i in 0...5 {
            mainEvent.append("В украине началась борьба с резервистами очень важная новость про АТО какой то там номер была-боа бла-бла шурмшцукмшгцкгшцушгкуцшгкапшгапшгркашруиашцушцуа\(i)")
        }
        
        for i in 0...5 {
            helperTextArray.append("Helper text number \(i)")
        }
       
        //saveCoreTest()
        
       printCoreData()
        printCoreData()
        
        mainEventImage = ["ukr","ukr2","ukr3","ukr4","ukr7","ukr6"]
        
}
    
    
    //что то очень не понятное
    func saveCoreTest(){
        saveInCoreData(mainText: mainEvent[Int(arc4random_uniform(UInt32(mainEvent.count)))],
                       helperText: helperTextArray[Int(arc4random_uniform(UInt32(helperTextArray.count)))])
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createMenuButton (){
        let button = UIButton(type: .custom)
        button.setImage(UIImage.init(named: "1.png"), for: UIControlState.normal)
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        
        let barButton = UIBarButtonItem(customView: button)
        
       barButton.target = revealViewController()
       barButton.action = #selector(SWRevealViewController.revealToggle(_:))
        
        self.navigationItem.setRightBarButton(barButton, animated: true)
}

    
    //установка тайтл надписи
    func setupColor() {
        //set color for title navigationItem
        let myAttribute = [NSFontAttributeName: UIFont(name: "Times New Roman", size: 23.0)!,NSForegroundColorAttributeName:UIColor.black]
        let str = NSAttributedString(string: "Vidvaga.info", attributes: myAttribute)
        let titleLabel = UILabel()
        titleLabel.attributedText = str
        titleLabel.sizeToFit()
        self.navigationItem.titleView = titleLabel
        //set color for title navigationItemLeft
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.black
        
    }
    
    //MARK: - UITableViewDataSource
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return mainEvent.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        print(indexPath.row)
        let identifire = "MenuEventTableViewCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifire, for: indexPath) as? MenuEventTableViewCell
        
        //cell!.image.setImage(UIImage(named:"\(mainEventImage[indexPath.row])"), for: UIControlState.normal)
        
        cell?.mainImage.image = UIImage(named:"\(mainEventImage[indexPath.row])")
        
        print(mainEventImage[indexPath.row])
        cell!.textMain.text = mainEvent[indexPath.row]

        
       return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        //что то важное
        let revealViewController:SWRevealViewController = self.revealViewController()
        
        let cell = tableView.cellForRow(at: indexPath) as! MenuEventTableViewCell
        
        let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let desController = mainStoryboard.instantiateViewController(withIdentifier: "MainEventViewController") as! MainEventViewController
    
        desController.mainTextTmp = cell.textMain.text!
        print(cell.textMain.text!)
        print(indexPath)
        desController.helperTextTmp = cell.textHelper.text ?? "no text"
        desController.dateTmp = cell.timeEvent.text ?? "no date"
        desController.imageTmp = (cell.mainImage.image)!
        desController.tagsTmp = cell.tags.text ?? "no tags"
        
        let newFrontViewController = UINavigationController.init(rootViewController: desController)
        revealViewController.pushFrontViewController(newFrontViewController, animated: true)
    }
    
    //Mark: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 130.0
    }

    
    
    //MARK: - Action
    
    @IBAction func pressedOnNews(_ sender: UIButton) {
        
        print("press")
        
    }

    
    //добавление в избраное
    @IBAction func bookmarks(_ sender: UIButton) {

        if sender.imageView?.image == UIImage(named:"bookmark_unchek") {
            sender.setImage(UIImage(named:"bookmark_chek"), for: UIControlState.normal)
            //сохранение в избранное
        //sender.superview.
        //self.saveInBookmarks(mainText: <#T##String#>, helperText: <#T##String#>, date: <#T##NSDate#>, type: <#T##String#>)
            
        } else {
            //убираем флажек избранного
            //реализовать процедуру удаления из избранного
            
             sender.setImage(UIImage(named:"bookmark_unchek"), for: UIControlState.normal)
        }
}
    
    //звонок
    @IBAction func btnPhone(_ sender: UIButton) {
        //вывод сообщения о намерении позвонить
        let alertController = UIAlertController(title: "Информация", message: "Звонок в ОДА", preferredStyle: UIAlertControllerStyle.alert) //Replace UIAlertControllerStyle.Alert by UIAlertControllerStyle.alert
        //если пользователь не хочет звонить
        let DestructiveAction = UIAlertAction(title: "Отмена", style: UIAlertActionStyle.destructive) {
            (result : UIAlertAction) -> Void in
            print("Destructive")
        }
        
        // Replace UIAlertActionStyle.Default by UIAlertActionStyle.default
        //хочет звонить
        let okAction = UIAlertAction(title: "Звонить", style: UIAlertActionStyle.default) {
            (result : UIAlertAction) -> Void in
            //номер для набора
            let url:NSURL = NSURL(string:"tel//:12345678")!
            
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            } else {
                //если у пользователя не ios 10
                UIApplication.shared.openURL(url as URL)
            }
            
            print("OK")
        }
        
        alertController.addAction(DestructiveAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    // MARK: - CoraData
    
    //получение контекста
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    //сохранение в кор дату
    func saveInCoreData(mainText:String , helperText:String) {

        //массив event теперь масив обьектов entity  MainEventtable
        let events = NSEntityDescription.insertNewObject(forEntityName: "MainEventTable", into: managedObjectContext)
        events.setValue(mainText, forKey: "mainEventText")
        events.setValue(helperText, forKey: "helperText")
        events.setValue(NSDate(), forKey: "date")
        
        do{
            try managedObjectContext.save()
        } catch {
            print("\(error)")
        }
    }
    
    
    //вывод кор даты на экран
    func printCoreData(){
        do{
            let result = try managedObjectContext.fetch(MainEventTable.fetchRequest())
            
            for tmp in result as! [NSManagedObject] {
                if let mainText = tmp.value(forKey: "mainEventText") {
                    print(mainText)
                }
                if let helperText = tmp.value(forKey: "helperText") {
                    print(helperText)
                }
                if let date = tmp.value(forKey: "date") {
                    print(date)
                }
            }
        } catch {
            
        }
    }
    
    func saveInBookmarks(mainText:String , helperText:String , date:NSDate , type:String) {
        
        //массив event теперь масив обьектов entity  MainEventtable
        let events = NSEntityDescription.insertNewObject(forEntityName: "BookmarksEvent", into: managedObjectContext)
        events.setValue(mainText, forKey: "mainEventText")
        events.setValue(helperText, forKey: "helperText")
        events.setValue(date, forKey: "date")
        
        do{
            try managedObjectContext.save()
        } catch {
            print("\(error)")
        }
    }


    //print bookmarks from core data
    
    func printFromBookmarksCoreData(){
        do{
            let result = try managedObjectContext.fetch(BookmarksEvent.fetchRequest())
            
            for tmp in result as! [NSManagedObject] {
                if let mainText = tmp.value(forKey: "mainEventText") {
                    print(mainText)
                }
                if let helperText = tmp.value(forKey: "helperText") {
                    print(helperText)
                }
                if let date = tmp.value(forKey: "date") {
                    print(date)
                }
                print()
            }
        } catch {
            
        }
    }
}


// MARK: - Singleton

class Singleton {
    func change() {
        self.login = !self.login
        print("login = \(self.login)")
    }
    
    var login:Bool
    
    static let shared = Singleton()
    
    private init() {
        self.login = false
    }
    
}




