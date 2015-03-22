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
   
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet var card: [UIImageView]!
    var animals: [String] = ["flashcard_cat", "flashcard_dog", "flashcard_fish", "flashcard_rabbit", "flashcard_bird", "flashcard_hamster"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bg-pets")!)
        
        card[0].transform = CGAffineTransformMakeRotation(3.14*0.02)
        card[1].transform = CGAffineTransformMakeRotation(3.14/0.02)
        card[2].transform = CGAffineTransformMakeRotation(3.14*0.03)
        card[3].transform = CGAffineTransformMakeRotation(3.14/0.01)
        card[4].transform = CGAffineTransformMakeRotation(3.14*0.04)
        card[5].transform = CGAffineTransformMakeRotation(3.14/0.02)
                
        for index in 0...5
        {
            card[index].image = UIImage(named: animals[index])
        }
        
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
            })
            { (finished: Bool) -> Void in
                // Here we use autoreverse and repeat
                UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.Repeat | UIViewAnimationOptions.Autoreverse | UIViewAnimationOptions.AllowUserInteraction, animations:
                    { () -> Void in
                        self.nextButton.transform = CGAffineTransformMakeScale(1, 1)
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
