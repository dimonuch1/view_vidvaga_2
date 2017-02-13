//
//  MainEventViewController.swift
//  view_vidvaga_2
//
//  Created by ios on 13.02.17.
//  Copyright © 2017 Alex Berezovskyy. All rights reserved.
//

import UIKit

class MainEventViewController: UIViewController {

    var mainTextTmp = ""
    var dateTmp = ""
    var helperTextTmp = ""
    var imageTmp = UIImage()
    var tagsTmp = ""
    
    @IBOutlet weak var mainText: UILabel!
    
    @IBOutlet weak var helperText: UITextView!
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var tags: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainText.text = mainTextTmp
        date.text = dateTmp
        helperText.text = helperTextTmp
        image.image = imageTmp
        tags.text = tagsTmp
        
        
        //обработка выезжания бокового меню
        self.menuButton?.target = revealViewController()
        self.menuButton?.action = #selector(SWRevealViewController.revealToggle(_:))
        //обработка выезжания скольжением пальца
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
