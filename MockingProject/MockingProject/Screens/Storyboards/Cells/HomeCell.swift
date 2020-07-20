//
//  HomeCell.swift
//  MockingProject
//
//  Created by nhatnt on 7/17/20.
//  Copyright © 2020 eplus.epfs.ios. All rights reserved.
//

import UIKit
import Reusable

class HomeCell: UITableViewCell, NibReusable {
    @IBOutlet weak var nameLabel: UILabel!
    
    var name: String? {
        didSet {
            self.nameLabel.text = name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
