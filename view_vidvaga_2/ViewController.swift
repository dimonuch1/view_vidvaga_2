//
//  ViewController.swift
//  view_vidvaga_2
//
//  Created by ios on 16.01.17.
//  Copyright © 2017 Alex Berezovskyy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let color = UIColor(red: 30/255, green: 140/255, blue: 93/255,alpha: 1)//ukrop color
    
    var mainEvent = [String]()
    var mainEventImage = [String]()
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.setupColor()
    
        self.menuButton.target = revealViewController()
        self.menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        for var i in 0...5 {
            mainEvent.append("Новость про АТО номер \(i)")
            //print(i)
        }
        mainEventImage = ["ukr","ukr2","ukr3","ukr4","ukr7","ukr6"]
        
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
       
        //self.navigationItem.leftBarButtonItem = barButton
        
       barButton.target = revealViewController()
       barButton.action = #selector(SWRevealViewController.revealToggle(_:))
        
        self.navigationItem.setRightBarButton(barButton, animated: true)
        
        //self.navigationItem.leftBarButtonItem = barButton
    }

    func setupColor() {
        //set color for title navigationItem
        let myAttribute = [NSFontAttributeName: UIFont(name: "Chalkduster", size: 23.0)!,NSForegroundColorAttributeName:color]
        let str = NSAttributedString(string: "Vidvaga.info", attributes: myAttribute)
        let titleLabel = UILabel()
        titleLabel.attributedText = str
        titleLabel.sizeToFit()
        self.navigationItem.titleView = titleLabel
        //set color for title navigationItemLeft
        self.navigationItem.leftBarButtonItem?.tintColor = color
    }
    
    //MARK: - UITableViewDataSource
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return mainEvent.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        print(indexPath.row)
        let identifire = "MenuEventTableViewCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifire, for: indexPath) as? MenuEventTableViewCell
        /*
        if cell == nil {
            cell = MenuEventTableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: identifire)
        }
        */
        cell!.buttonEvent.setImage(UIImage(named:"\(mainEventImage[indexPath.row])"), for: UIControlState.normal)
        print(mainEventImage[indexPath.row])
        cell!.textMain.text = mainEvent[indexPath.row]

       
        
       return cell!
}
    
    
    //Mark: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 130.0
    }

}
