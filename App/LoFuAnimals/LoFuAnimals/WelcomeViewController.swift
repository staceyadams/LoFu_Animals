//
//  WelcomeViewController.swift
//  LoFuAnimals
//
//  Created by Stacey Adams on 3/13/15.
//  Copyright (c) 2015 Stacey & Bryan. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController, UIScrollViewDelegate
{

    @IBOutlet var cardView: [UIView]!
    @IBOutlet var cardLabel: [UILabel]!
    @IBOutlet var animalImage: [UIImageView]!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var speechBubble: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var LoFu: UIImageView!
    @IBOutlet weak var speechBubbleView: UIView!
    
    
    
    
    var cardViewStartX: CGFloat! = 204
    var cardViewStartY: [CGFloat] = [0, 10, 20, 30, 40, 50]
    var cardViewEndX: [CGFloat] = [2, 106, 210, 2, 106, 210]
    var cardViewEndY: [CGFloat] = [0, 0, 0, 135, 135, 135]
    var animalImageStartX: CGFloat! = 21
    var animalImageStartY: [CGFloat] = [16, 36, 56, 76, 96, 116]
    var animalImageEndX: [CGFloat] = [30, 135, 240, 30, 135, 240]
    var animalImageEndY: [CGFloat] = [65, 65, 65, 200, 200, 200]
    var cardText: [String] = ["猫", "牛", "狗", "羊", "鱼", "马"]
    var animalImageName: [String] = ["cat", "cow", "dog", "sheep", "fish", "horse"]

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bg-jungle")!)

        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: 320, height: 1200)

        hideAll ()
        
        for index in 0...5
        {
            cardLabel[index].text = cardText[index]
            animalImage[index].image = UIImage(named: animalImageName[index])
        }
        
        delay(0.5,
        { () -> () in
          self.logoAnimate()
        })
        
        delay(1,
        { () -> () in
            self.cardsStartPosition()
            self.speechBubbleAnimate()
            self.nextButtonAnimate()
        })
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView)
    {
        var offset = Float(scrollView.contentOffset.y)
        if offset > 0 {cardsEndPosition()}
        else {cardsStartPosition()}
        
    }
    
    func cardsStartPosition()
    {
        UIView.animateWithDuration(0.5, animations:
        { () -> Void in
            for index in 0...5
            {
                self.cardView[index].frame.origin.x = self.cardViewStartX
                self.cardView[index].frame.origin.y = self.cardViewStartY[index]
                self.animalImage[index].frame.origin.x = self.animalImageStartX
                self.animalImage[index].frame.origin.y = self.animalImageStartY[index]
            }
            self.message.alpha = 1
        })
    }
    
    func cardsEndPosition()
    {
        UIView.animateWithDuration(0.5, animations:
        { () -> Void in
            for index in 0...5
            {
                self.cardView[index].frame.origin.x = self.cardViewEndX[index]
                self.cardView[index].frame.origin.y = self.cardViewEndY[index]
                self.animalImage[index].frame.origin.x = self.animalImageEndX[index]
                self.animalImage[index].frame.origin.y = self.animalImageEndY[index]
            }
            self.message.alpha = 0
        })
    }
    
    func nextButtonAnimate()
    {
        // Animation with damping and velocity
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 40, options: nil, animations:
            { () -> Void in
                self.nextButton.transform = CGAffineTransformMakeScale(1.2, 1.2)
                var rotate = CGFloat(-1 * M_PI/180)
//                self.speechBubble.transform = CGAffineTransformRotate(self.speechBubble.transform, rotate)
                
            })
            { (finished: Bool) -> Void in
                // Here we use autoreverse and repeat
                UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.Repeat | UIViewAnimationOptions.Autoreverse | UIViewAnimationOptions.AllowUserInteraction, animations:
                    { () -> Void in
                        self.nextButton.transform = CGAffineTransformMakeScale(1, 1)
                        var rotate = CGFloat(1 * M_PI/180)
//                        self.speechBubble.transform = CGAffineTransformRotate(self.speechBubble.transform, rotate)
                    })
                    { (Bool) -> Void in }
        }
    }
    
    
    
    
    func hideAll ()
    {
        logoImage.transform = CGAffineTransformMakeScale(0, 0)
        contentView.alpha = 0
        LoFu.frame.origin.y = 308
        speechBubbleView.transform = CGAffineTransformMakeScale(0, 0)
    }
    
    
    func speechBubbleAnimate()
    {
        UIView.animateWithDuration(0.2, animations:
            { () -> Void in
                self.LoFu.frame.origin.y = 108
                self.contentView.alpha = 1
            })
            { (finished: Bool) -> Void in
                
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 40, options: nil, animations:
                    { () -> Void in
                        self.speechBubbleView.transform = CGAffineTransformMakeScale(1, 1)
                        var rotate = CGFloat(-1 * M_PI/180)
                        self.speechBubbleView.transform = CGAffineTransformRotate(self.speechBubbleView.transform, rotate)
                    })
                    { (finished: Bool) -> Void in
                        UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.Repeat | UIViewAnimationOptions.Autoreverse | UIViewAnimationOptions.AllowUserInteraction, animations:
                            { () -> Void in
                                var rotate = CGFloat(1 * M_PI/180)
                                self.speechBubbleView.transform = CGAffineTransformRotate(self.speechBubbleView.transform, rotate)
                            })
                            { (Bool) -> Void in }
                }
        }
    }
    
    
    
    
    
    
    func logoAnimate()
    {
        UIView.animateWithDuration(0.2, animations:
            { () -> Void in
                
            })
            { (finished: Bool) -> Void in
                
                UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.65, initialSpringVelocity: 10, options: nil, animations:
                    { () -> Void in
                        self.logoImage.transform = CGAffineTransformMakeScale(1, 1)
                        var rotate = CGFloat(-1 * M_PI/180)
                        self.logoImage.transform = CGAffineTransformRotate(self.logoImage.transform, rotate)
                    })
                    { (finished: Bool) -> Void in
                        UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.Repeat | UIViewAnimationOptions.Autoreverse | UIViewAnimationOptions.AllowUserInteraction, animations:
                            { () -> Void in
                                var rotate = CGFloat(1 * M_PI/180)
                                self.logoImage.transform = CGAffineTransformRotate(self.logoImage.transform, rotate)
                            })
                            { (Bool) -> Void in }
                }
        }
    }
    
}
