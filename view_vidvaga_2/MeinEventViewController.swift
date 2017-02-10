//
//  MeinEventViewController.swift
//  view_vidvaga_2
//
//  Created by ios on 18.01.17.
//  Copyright © 2017 Alex Berezovskyy. All rights reserved.
//


//пока не понятно зачем этот класс


import UIKit

class MeinEventViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    var mainEvent = [String]()
    var mainEventImage = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mainEvent.append("Новость про АТО номер 1")
        
        for i in 1...20 {
             mainEvent.append("Новость про АТО номер \(i)")
        }
        mainEventImage = ["ukr","ukr2","ukr3","ukr4","ukr5","ukr6"]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: - UITableViewDataSource
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return mainEvent.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
       
        let identifire = "MenuEventTableViewCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifire, for: indexPath) as! MenuEventTableViewCell
        
       
        
        cell.mainImage.image = UIImage(named:"\(mainEventImage[Int(arc4random_uniform(UInt32(mainEventImage.count)))])")

        cell.textMain.text = mainEvent[Int(arc4random_uniform(UInt32(mainEvent.count)))]
        
        
        
        
        
        return cell
    }
    
   
}
