//
//  MenuTableViewCell.swift
//  LoFuAnimals
//
//  Created by Stacey Adams on 3/24/15.
//  Copyright (c) 2015 Stacey & Bryan. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell, UIGestureRecognizerDelegate
{
    
    @IBOutlet weak var menuImage: UIImageView!
    @IBOutlet weak var menuTitle: UILabel!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var revealView: UIView!
    
    var mainViewXPanBegan: CGFloat!
    var mainViewFinalX: CGFloat!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        // add a pan recognizer
        var recognizer = UIPanGestureRecognizer(target: self, action: "menuPan:")
        recognizer.delegate = self
        addGestureRecognizer(recognizer)
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    func menuPan(recognizer: UIPanGestureRecognizer)
    {
        var translation = recognizer.translationInView(self)
        var velocity = recognizer.velocityInView(self)
        
        if recognizer.state == .Began
        {
            mainViewXPanBegan = mainView.frame.origin.x
        }
        if recognizer.state == .Changed
        {
            if (velocity.x > 0)
            {
                mainViewFinalX = mainViewXPanBegan + translation.x
                mainView.frame.origin.x = mainViewFinalX
            }
        }
        if recognizer.state == .Ended
        {
            mainView.frame.origin.x = 0
        }
    }


}
