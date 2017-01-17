//
//  ViewController.swift
//  view_vidvaga_2
//
//  Created by ios on 16.01.17.
//  Copyright © 2017 Alex Berezovskyy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let color = UIColor(red: 30/255, green: 140/255, blue: 93/255,alpha: 1)//ukrop color
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        self.setupColor()
    
        
        self.menuButton.target = revealViewController()
        self.menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        //self.menuButton.setBackgroundImage(UIImage.init(named: "1.png"), for: .normal, barMetrics: .default)

        
        //self.menuButton = self.createMenuButton()
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

}
