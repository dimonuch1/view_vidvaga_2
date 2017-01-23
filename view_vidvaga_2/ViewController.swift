//
//  ViewController.swift
//  view_vidvaga_2
//
//  Created by ios on 16.01.17.
//  Copyright © 2017 Alex Berezovskyy. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let color = UIColor(red: 30/255, green: 140/255, blue: 93/255,alpha: 1)//ukrop color
    
    var mainEvent = [String]()
    var mainEventImage = [String]()
    var helperTextArray = [String]()
    
    var events = [NSManagedObject]()
    
    var managedObjectContext:NSManagedObjectContext!
    
    //Mark: - IBOutlet
    
    @IBOutlet weak var phone: UIButton!
    
    @IBOutlet weak var menuButton: UIBarButtonItem?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    // set images like
        
        var application = UIApplication.shared.delegate as! AppDelegate
        managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        self.phone.setImage(UIImage(named:"phone"), for: UIControlState.normal)
        self.phone.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        
        self.setupColor()
    
        self.menuButton?.target = revealViewController()
        self.menuButton?.action = #selector(SWRevealViewController.revealToggle(_:))
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        
        for var i in 0...5 {
            mainEvent.append("Новость про АТО номер \(i)")
        }
        
        for var i in 0...5 {
            helperTextArray.append("Helper text number \(i)")
        }
       
        //saveCoreTest()
        
       printCoreData()
        
        mainEventImage = ["ukr","ukr2","ukr3","ukr4","ukr7","ukr6"]
        
}
    
    
    func printCoreData(){
        do{
            let result = try managedObjectContext.fetch(MainEventTable.fetchRequest())
            
            for var tmp in result as! [NSManagedObject] {
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
        
        var barButton = UIBarButtonItem(customView: button)
        
       barButton.target = revealViewController()
       barButton.action = #selector(SWRevealViewController.revealToggle(_:))
        
        self.navigationItem.setRightBarButton(barButton, animated: true)
}

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
        
        cell!.buttonEvent.setImage(UIImage(named:"\(mainEventImage[indexPath.row])"), for: UIControlState.normal)
        print(mainEventImage[indexPath.row])
        cell!.textMain.text = mainEvent[indexPath.row]

        cell!.btnLike.setImage(UIImage(named:"like"), for: UIControlState.normal)
        cell!.btnDislike.setImage(UIImage(named:"dislike"), for: UIControlState.normal)
        
       return cell!
}
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //Mark: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 130.0
    }

    //MARK: - Action
    
    @IBAction func pressedOnNews(_ sender: UIButton) {
        
        print("press")
        
    }

    @IBAction func bookmarks(_ sender: UIButton) {

        if sender.imageView?.image == UIImage(named:"bookmarks_false") {
            sender.setImage(UIImage(named:"bookmarks_true"), for: UIControlState.normal)
        } else {
             sender.setImage(UIImage(named:"bookmarks_false"), for: UIControlState.normal)
        }
}
    
    
    @IBAction func btnPhone(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: "Информация", message: "Звонок в ОДА", preferredStyle: UIAlertControllerStyle.alert) //Replace UIAlertControllerStyle.Alert by UIAlertControllerStyle.alert
        let DestructiveAction = UIAlertAction(title: "Отмена", style: UIAlertActionStyle.destructive) {
            (result : UIAlertAction) -> Void in
            print("Destructive")
        }
        
        // Replace UIAlertActionStyle.Default by UIAlertActionStyle.default
        let okAction = UIAlertAction(title: "Звонить", style: UIAlertActionStyle.default) {
            (result : UIAlertAction) -> Void in
            let url:NSURL = NSURL(string:"tel//:12345678")!
            
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url as URL)
            }
            
            print("OK")
        }
        
        alertController.addAction(DestructiveAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    // MARK: - Save in CoraData
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    
    func saveInCoreData(mainText:String , helperText:String) {

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
}



