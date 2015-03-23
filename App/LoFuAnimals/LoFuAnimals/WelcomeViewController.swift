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
    
    
    var cardViewStartX: CGFloat! = 204
    var cardViewStartY: [CGFloat] = [0, 10, 20, 30, 40, 50]
    var cardViewEndX: [CGFloat] = [2, 106, 210, 2, 106, 210]
    var cardViewEndY: [CGFloat] = [0, 0, 0, 135, 135, 135]
    var animalImageStartX: CGFloat! = 21
    var animalImageStartY: [CGFloat] = [16, 36, 56, 76, 96, 116]
    var animalImageEndX: [CGFloat] = [30, 135, 240, 30, 135, 240]
    var animalImageEndY: [CGFloat] = [65, 65, 65, 200, 200, 200]
    var cardText: [String] = ["猫", "牛", "狗", "羊", "鱼", "马"]
    var animalImageName: [String] = ["sticker_cat", "sticker_cow", "sticker_dog", "sticker_sheep", "sticker_fish", "sticker_horse"]

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bg-jungle")!)
        nextButtonAnimate()

        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: 320, height: 1200)
        cardsStartPosition()
        
        for index in 0...5
        {
            cardLabel[index].text = cardText[index]
            animalImage[index].image = UIImage(named: animalImageName[index])
        }
        
        
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
    
}
