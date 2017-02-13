//
//  MenuEventTableViewCell.swift
//  view_vidvaga_2
//
//  Created by ios on 18.01.17.
//  Copyright © 2017 Alex Berezovskyy. All rights reserved.
//


//класс ячеек ленты новостей

import UIKit

class MenuEventTableViewCell: UITableViewCell {
    
    @IBOutlet weak var timeEvent: UILabel!
    
    @IBOutlet weak var textMain: UILabel!
    
    @IBOutlet weak var textHelper: UILabel!
    
    @IBOutlet weak var mainImage: UIImageView!
    
    @IBOutlet weak var tags: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
