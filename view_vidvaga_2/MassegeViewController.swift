//
//  MassegeViewController.swift
//  view_vidvaga_2
//
//  Created by ios on 17.01.17.
//  Copyright © 2017 Alex Berezovskyy. All rights reserved.
//

import UIKit

class MassegeViewController: UIViewController {

    let color = UIColor(red: 30/255, green: 140/255, blue: 93/255,alpha: 1)//ukrop color
    
    @IBOutlet weak var btnMenu: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.btnMenu.target = revealViewController()
        self.btnMenu.action = #selector(SWRevealViewController.revealToggle(_:))

        self.navigationItem.leftBarButtonItem?.tintColor = color
        
        // Do any additional setup after loading the view.
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
