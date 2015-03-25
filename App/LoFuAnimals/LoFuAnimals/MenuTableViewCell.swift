//
//  MenuTableViewCell.swift
//  LoFuAnimals
//
//  Created by Stacey Adams on 3/24/15.
//  Copyright (c) 2015 Stacey & Bryan. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell
{
    
    @IBOutlet weak var menuImage: UIImageView!
    @IBOutlet weak var menuTitle: UILabel!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var menuView: UIView!

    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
