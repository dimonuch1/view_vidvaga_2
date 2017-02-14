//
//  MainEventViewController.swift
//  view_vidvaga_2
//
//  Created by ios on 13.02.17.
//  Copyright © 2017 Alex Berezovskyy. All rights reserved.
//

import UIKit
import Hue
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
    
    @IBOutlet weak var bookmark: UIButton!
    
    @IBOutlet weak var plusButton: UIButton!
    
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var dislikeButton: UIButton!
    
    
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

    /*
    override func viewWillAppear(_ animated: Bool) {
    
        let gradient = CAGradientLayer()
        gradient.frame = (self.navigationController?.navigationBar.frame)!
        gradient.colors = [UIColor.green.cgColor,UIColor.white.cgColor]
        
        //gradient.locations = [0.2]
        
        //self.navigationController?.navigationBar.setBackgroundImage(image(fromLayer: gradient), for: UIBarMetrics.default)

        
        self.navigationController?.navigationBar.layer.addSublayer(gradient)
    }
    
    func image(fromLayer layer: CALayer) -> UIImage {
        UIGraphicsBeginImageContext(layer.frame.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return outputImage!
    }
   */
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//MARK: - Button_action
    
    
    @IBAction func bookmarkPress(_ sender: UIButton) {
        
        if sender.imageView?.image == UIImage(named: "bookmark_unchek") {
            sender.setImage(UIImage(named:"bookmark_chek"), for: UIControlState.normal)
        }else {
            sender.setImage(UIImage(named: "bookmark_unchek"),for:UIControlState.normal)
        }
        
    }
    
    @IBAction func plusButtonPresed(_ sender: UIButton) {
        
        if sender.imageView?.image == UIImage(named: "plus_small_down") {
            sender.setImage(UIImage(named:"plus_small_green"), for: UIControlState.normal)
        }else {
            sender.setImage(UIImage(named: "plus_small_down"),for:UIControlState.normal)
        }
        
    }
    
    @IBAction func likeButtonPressed(_ sender: UIButton) {
        
        if sender.imageView?.image == UIImage(named: "like_up") {
            sender.setImage(UIImage(named:"like_down"), for: UIControlState.normal)
        }else {
            sender.setImage(UIImage(named: "like_up"),for:UIControlState.normal)
        }
        
    }
    
    @IBAction func dislikeButtonPressed(_ sender: UIButton) {
        
        if sender.imageView?.image == UIImage(named: "dislike_up") {
            sender.setImage(UIImage(named:"dislike_down"), for: UIControlState.normal)
        }else {
            sender.setImage(UIImage(named: "dislike_up"),for:UIControlState.normal)
        }
        
    }
    
    
    
    
    
}
