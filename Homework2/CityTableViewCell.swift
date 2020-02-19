//
//  CityTableViewCell.swift
//  Homework2
//
//  Created by Sam Millar on 11/5/19.
//  Copyright © 2019 Sam Millar. All rights reserved.
//

import Foundation
import UIKit

class CityTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cityTitle: UILabel!
    @IBOutlet weak var cityImage: UIImageView!{
        didSet {
            cityImage.layer.cornerRadius = cityImage.bounds.width / 2
            cityImage.clipsToBounds = true
            
            cityImage.contentMode = UIView.ContentMode.scaleAspectFill
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
