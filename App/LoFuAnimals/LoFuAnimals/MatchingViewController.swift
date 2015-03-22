//
//  MatchingViewController.swift
//  LoFuAnimals
//
//  Created by Stacey Adams on 3/18/15.
//  Copyright (c) 2015 Stacey & Bryan. All rights reserved.
//

import UIKit

class MatchingViewController: UIViewController {
    @IBOutlet var statusIcon: [UIImageView]!
    @IBOutlet var animalImage: [UIImageView]!
    @IBOutlet var cardView: [UIView]!
    @IBOutlet var cardTextLabel: [UILabel]!
    @IBOutlet var cardImage: [UIImageView]! //card image
    
    @IBOutlet weak var trayBG: UIView!
    @IBOutlet weak var text1: UILabel!
    @IBOutlet weak var text2: UILabel!
    @IBOutlet weak var finishedView: UIView!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var speechBubble: UIImageView!
    @IBOutlet weak var winBanner: UIImageView!
    var winBannerImages = UIImage.animatedImageNamed("winBanner_", duration: 0.5)

    var animalSticker: [String] = ["sticker_cat", "sticker_dog", "sticker_fish", "sticker_rabbit", "sticker_bird", "sticker_hamster"]
    var cardText: [String] = ["猫", "狗", "鱼", "兔子", "鸟", "仓鼠"]
    
    var selectedIndex: Int! = 0
    var correctAnswerCount = 0
    var scale: CGFloat! = 1
    var rotate: CGFloat! = 0
    var originalCenter: CGPoint!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bg-pets")!)
        
        cardView[0].transform = CGAffineTransformMakeRotation(3.14*0.02)
        cardView[1].transform = CGAffineTransformMakeRotation(3.14/0.02)
        cardView[2].transform = CGAffineTransformMakeRotation(3.14*0.03)
        cardView[3].transform = CGAffineTransformMakeRotation(3.14/0.01)
        cardView[4].transform = CGAffineTransformMakeRotation(3.14*0.04)
        cardView[5].transform = CGAffineTransformMakeRotation(3.14/0.02)
        
        
        //for var index = 0; index < 6; index++
        for index in 0...5
        {
            animalImage[index].image = UIImage(named: animalSticker[index])
            cardImage[index].image = UIImage(named: "paper")
            cardTextLabel[index].text = cardText[index]
            statusIcon[index].hidden = true
        }
        
        finishedView.alpha = 0
        wiggleStickers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onDragAnimal(sender: UIPanGestureRecognizer)
    {
        var location = sender.locationInView(view)
        var translation = sender.translationInView(view)
        var imageView = sender.view as UIImageView
        
        if (sender.state == UIGestureRecognizerState.Began)
        {
            scale = 1.3
            selectedIndex = imageView.tag
            originalCenter = animalImage[selectedIndex].center
            transformAnimal()
            self.statusIcon[self.selectedIndex].hidden = true
            self.statusIcon[selectedIndex].transform = CGAffineTransformMakeScale(0, 0)

            
        } else if (sender.state == UIGestureRecognizerState.Changed)
        {
            animalImage[selectedIndex].center = CGPoint(x: originalCenter.x + translation.x, y: originalCenter.y + translation.y)

            
        } else if (sender.state == UIGestureRecognizerState.Ended)
        {
            scale = 1
            transformAnimal()
            
            UIView.animateWithDuration(0.1, animations:
            { () -> Void in
                self.statusIcon[self.selectedIndex].hidden = false
                self.statusIcon[self.selectedIndex].transform = CGAffineTransformMakeScale(self.scale, self.scale)
            })
            
            var animalImageX = animalImage[selectedIndex].center.x
            var cardX = cardView[selectedIndex].frame.origin.x
            var animalImageY = animalImage[selectedIndex].center.y
            var cardY = cardView[selectedIndex].frame.origin.y
            var cardWidth = cardView[selectedIndex].frame.width
            var cardHeight = cardView[selectedIndex].frame.height
            
//            println("animal x \(animalImageX)")
//            println("card x \(cardX)")
//            println("animal y \(animalImageY)")
//            println("card y \(cardY)")
//            println("less than X: \(cardX + cardWidth)")
//            println("less than Y: \(cardY + cardHeight)")
            
            // If dropped back into tray area, don't show status icon
            if animalImageY >= trayBG.frame.origin.y
            {statusIcon[selectedIndex].hidden = true}
            
            
            // If it's within the correct card's dimensions, place it
            // Because the cards are rotated, this math isn't entirely accurate
            if (animalImageX >= cardX) && (animalImageX <= cardX + cardWidth) &&
               (animalImageY >= cardY) && (animalImageY <= cardY + cardHeight)
            
            {
                animalImage[selectedIndex].center.y = cardView[selectedIndex].center.y + 25
                animalImage[selectedIndex].center.x = cardView[selectedIndex].center.x
                statusIcon[selectedIndex].image = UIImage(named: "icon-correct")
                positionIcon()
                correctAnswerCount++
            }
            
            else
            {
                statusIcon[selectedIndex].image = UIImage(named: "icon-wrong")
                positionIcon()
            }
            
            // Once all answers are correct, go to finished state
            if correctAnswerCount == cardView.count
            {
                UIView.animateWithDuration(0.3, animations:
                { () -> Void in
                    self.trayBG.alpha = 0
                    self.text1.hidden = true
                    self.text2.hidden = true
                    self.finishedView.alpha = 1
                    self.finishedViewAnimate()
                    self.winBanner.image = self.winBannerImages
                })

            }
            
        }
    }
    
    func transformAnimal()
    {
        var scaleTransform = CGAffineTransformMakeScale(scale, scale)
        animalImage[selectedIndex].transform = scaleTransform
    }

    func positionIcon()
    {
        statusIcon[selectedIndex].center.x = animalImage[selectedIndex].center.x + 25
        statusIcon[selectedIndex].center.y = animalImage[selectedIndex].center.y + 25
    }
    
    func wiggleStickers()
    {
        // Animation with damping and velocity
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 40, options: nil, animations:
            { () -> Void in
                var rotate = CGFloat(-2 * M_PI/180)
                for index in 0...5
                {
                    self.animalImage[index].transform = CGAffineTransformRotate(self.animalImage[index].transform, rotate)
                }
            })
            { (finished: Bool) -> Void in
                // Here we use autoreverse and repeat
                UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.Repeat | UIViewAnimationOptions.Autoreverse | UIViewAnimationOptions.AllowUserInteraction, animations:
                    { () -> Void in
                        var rotate = CGFloat(2 * M_PI/180)
                        for index in 0...5
                        {
                            self.animalImage[index].transform = CGAffineTransformRotate(self.animalImage[index].transform, rotate)
                        }
                    })
                    { (Bool) -> Void in }
        }
    }
    
    func finishedViewAnimate()
    {
        // Animation with damping and velocity
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 40, options: nil, animations:
            { () -> Void in
                var rotate = CGFloat(-2 * M_PI/180)
                var scaleAnim = CGFloat(1.2)
                self.homeButton.transform = CGAffineTransformMakeScale(scaleAnim, scaleAnim)
                self.speechBubble.transform = CGAffineTransformRotate(self.speechBubble.transform, rotate)
                for index in 0...5
                {
                    self.statusIcon[index].transform = CGAffineTransformMakeScale(1.1, 1.1)
                    self.cardTextLabel[index].transform = CGAffineTransformMakeScale(scaleAnim, scaleAnim)
                }
            })
            { (finished: Bool) -> Void in
                // Here we use autoreverse and repeat
                UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.Repeat | UIViewAnimationOptions.Autoreverse | UIViewAnimationOptions.AllowUserInteraction, animations:
                    { () -> Void in
                        var rotate = CGFloat(2 * M_PI/180)
                        var scaleAnim = CGFloat(1)
                        self.homeButton.transform = CGAffineTransformMakeScale(scaleAnim, scaleAnim)
                        self.speechBubble.transform = CGAffineTransformRotate(self.speechBubble.transform, rotate)
                        for index in 0...5
                        {
                            self.statusIcon[index].transform = CGAffineTransformMakeScale(1, 1)
                            self.cardTextLabel[index].transform = CGAffineTransformMakeScale(scaleAnim, scaleAnim)
                        }
                    })
                    { (Bool) -> Void in }
        }
    }
}
