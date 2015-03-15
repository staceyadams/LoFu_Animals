//
//  FlashcardViewController.swift
//  LoFuAnimals
//
//  Created by Stacey Adams on 3/14/15.
//  Copyright (c) 2015 Stacey & Bryan. All rights reserved.
//

// reference ChoosePersonViewController.m in the LikedorNope example for all the things we are customizing

import UIKit
import MDCSwipeToChoose

class FlashcardViewController: UIViewController, MDCSwipeToChooseDelegate {
    
//    var animals: [String] = ["cat", "dog", "fish", "rabbit", "hamster", "bird"]
    var animals: [String] = ["flashcard_cat", "flashcard_dog", "flashcard_fish", "flashcard_rabbit", "flashcard_hamster", "flashcard_bird"]

    var currentAnimal: String!
    var animalsRemaining: Int = 0
    var frontCardView: MDCSwipeToChooseView!
    var backCardView: MDCSwipeToChooseView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        frontCardView = popCardViewWithFrame(frontCardViewFrame())
        view.addSubview(frontCardView)
        
        backCardView = popCardViewWithFrame(backCardViewFrame())
        view.insertSubview(backCardView, belowSubview: frontCardView)
        
        animalsRemaining = animals.count
        
    }
    
    func popCardViewWithFrame(frame:CGRect) -> MDCSwipeToChooseView?
    {
        if animals.count == 0 {return nil} // if there are no animals in the array, don't do anything
        
        // set the options from MDCSwipeToChooseViewOptions
        let options = MDCSwipeToChooseViewOptions()
        options.delegate = self
        options.threshold = 10
        options.onPan =
        {
            (state: MDCPanState!) in
            let frame = self.backCardViewFrame()
            self.backCardView.frame = CGRectMake(frame.origin.x - state.thresholdRatio * CGFloat(5), frame.origin.y - state.thresholdRatio * CGFloat(5), CGRectGetWidth(frame), CGRectGetHeight(frame))
        }
        // hide the text because I can't figure out how to customize on init
        options.likedText = "Learned"
        options.nopeText = "Later"
        options.likedColor = UIColor.clearColor()
        options.nopeColor = UIColor.clearColor()
        
        var animalCard = MDCSwipeToChooseView(frame: frame, options: options)
        animalCard.imageView?.image = UIImage(named: animals[0]) // if there is an image, set it to the first one in the array
        animalCard.backgroundColor = UIColor.clearColor() // color the card bg
        currentAnimal = animals[0]
        animals.removeAtIndex(0)
        return animalCard
    }
    
    
    // MARK: - Card positions and sizing
    func frontCardViewFrame() -> CGRect
    {
        let horizontalPadding: CGFloat=33
        let topPadding: CGFloat=100
        let bottomPadding: CGFloat=100
//        return CGRectMake(horizontalPadding, topPadding, CGRectGetWidth(self.view.frame) - (horizontalPadding*2), CGRectGetHeight(self.view.frame) - (bottomPadding))
        return CGRectMake(horizontalPadding, topPadding, 255, 328) // set size based on image size instead of screen space
    }
    
    func backCardViewFrame() -> CGRect
    {
        let frontCard = self.frontCardViewFrame()
        return CGRectMake(frontCard.origin.x + 3, frontCard.origin.y + 3, CGRectGetWidth(frontCard), CGRectGetHeight(frontCard))
    }
    
    
    // MARK: - Swipe to choose delegate
    func viewDidCancelSwipe(view: UIView!)
    {
        // when there aren't any cards left, go to the next screen
        if animalsRemaining < 0
        {
            performSegueWithIdentifier("showSummary", sender: self)
    
        }
    }
    
    func view(view: UIView!, shouldBeChosenWithDirection direction: MDCSwipeDirection) -> Bool
    {
        // do stuff here when a direction has been chosen, before it disappears off screen
        return true
    }
    
    func view(view: UIView!, wasChosenWithDirection direction: MDCSwipeDirection)
    {
        if direction == MDCSwipeDirection.Left
        {
            animals.append(currentAnimal) // if swiped left, add this animal back into the end of the array
            // @todo: this is actually setting the one after, not the one we want
        }
        else
        {
            animalsRemaining-=1 // reduce the count of number of cards left by 1
        }
        
        frontCardView = backCardView // the back card is now the new front card
        
        if animals.count > 0 // if there are still cards, then populate the back card with a new back card
        {
            backCardView = popCardViewWithFrame(backCardViewFrame())
            if backCardView != nil
            {
                backCardView.alpha = 0
                self.view.insertSubview(backCardView, belowSubview: frontCardView)
                UIView.animateWithDuration(0.2, animations:
                { () -> Void in
                    self.backCardView.alpha = 1
                }, completion: nil)
            }
        }
    }
    
    
    
    // @todo why does it error on the buttons but not on the swipes??
    
    @IBAction func pressLater(sender: AnyObject)
    {
        frontCardView.mdc_swipe(MDCSwipeDirection.Left)
    }

    @IBAction func pressLearned(sender: AnyObject)
    {
        frontCardView.mdc_swipe(MDCSwipeDirection.Right)
    }
}
