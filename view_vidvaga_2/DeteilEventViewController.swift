//
//  DeteilEventViewController.swift
//  view_vidvaga_2
//
//  Created by ios on 01.02.17.
//  Copyright © 2017 Alex Berezovskyy. All rights reserved.
//

import UIKit

class DeteilEventViewController: UIViewController {

    var mainTextTmp = ""
    var dateTmp = ""
    var helperTextTmp = ""
    var imageTmp = UIImage()
    
    @IBOutlet weak var mainText: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var helperText: UITextView!
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
      
    //@IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        mainText.text = mainTextTmp
        date.text = dateTmp
        helperText.text = helperTextTmp
        image.image = imageTmp
        
        
        
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
