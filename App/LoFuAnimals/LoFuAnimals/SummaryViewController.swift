//
//  SummaryViewController.swift
//  LoFuAnimals
//
//  Created by Stacey Adams on 3/19/15.
//  Copyright (c) 2015 Stacey & Bryan. All rights reserved.
//

import UIKit

class SummaryViewController: UIViewController
{
   
    @IBOutlet weak var cardsView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var speechBubble: UIImageView!
    var cardsViewVC: CardsViewController!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        cardsViewVC = storyboard.instantiateViewControllerWithIdentifier("cardsStory") as CardsViewController
        
        addChildViewController(cardsViewVC)
        var contentView = cardsViewVC.view
        contentView.frame = cardsView.bounds // Use bounds instead of frame whenever you want to set the size, but have a x, y position of 0,0
        cardsView.addSubview(contentView)
        cardsViewVC.didMoveToParentViewController(self)
        
        
        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bg-pets")!)        
        nextButtonAnimate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func nextButtonAnimate()
    {
        // Animation with damping and velocity
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 40, options: nil, animations:
            { () -> Void in
                self.nextButton.transform = CGAffineTransformMakeScale(1.2, 1.2)
                var rotate = CGFloat(-1 * M_PI/180)
                self.speechBubble.transform = CGAffineTransformRotate(self.speechBubble.transform, rotate)
                
            })
            { (finished: Bool) -> Void in
                // Here we use autoreverse and repeat
                UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.Repeat | UIViewAnimationOptions.Autoreverse | UIViewAnimationOptions.AllowUserInteraction, animations:
                    { () -> Void in
                        self.nextButton.transform = CGAffineTransformMakeScale(1, 1)
                        var rotate = CGFloat(1 * M_PI/180)
                        self.speechBubble.transform = CGAffineTransformRotate(self.speechBubble.transform, rotate)
                    })
                    { (Bool) -> Void in }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
