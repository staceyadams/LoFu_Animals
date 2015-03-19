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
    
    var animals: [String] = ["flashcard_cat", "flashcard_dog", "flashcard_fish", "flashcard_rabbit", "flashcard_bird", "flashcard_hamster"]
    
    var currentPosition: Int = -1 // We increment before using, so set to -1 to begin
    var frontCardView: MDCSwipeToChooseView!
    var backCardView: MDCSwipeToChooseView!

    @IBOutlet weak var cardsLeftLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bg-pets")!)
        
        frontCardView = popCardViewWithFrame(frontCardViewFrame(), animal: getNextAnimal())
        frontCardView.layer.borderColor = UIColor.clearColor().CGColor
        view.addSubview(frontCardView)
        
        backCardView = popCardViewWithFrame(backCardViewFrame(), animal: getNextAnimal())
        backCardView.layer.borderColor = UIColor.clearColor().CGColor
        view.insertSubview(backCardView, belowSubview: frontCardView)
        
        cardsLeftLabel.text = "\(animals.count)"
    }

    
    // Returns the next animal from array, (loops back to beginning if we're at the end), and increment
    // the pointer to the next position. We can call this multiple times to keep moving to the next, etc.
    func getNextAnimal() -> String
    {
        currentPosition++ // Move to next position
        if (currentPosition == animals.count) { currentPosition = 0; } // Make sure we loop around
        return animals[currentPosition]
    }
    
    
    // Sets up the card view with the passed in animal
    func popCardViewWithFrame(frame:CGRect, animal:String) -> MDCSwipeToChooseView?
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
        options.likedText = "✅ Learned!"
        options.nopeText = "⁉️ Again"
        options.likedColor = UIColor(red: 42/255, green: 177/255, blue: 0, alpha: 1.0)
        options.nopeColor = UIColor(red: 207/255, green: 18/255, blue: 19/255, alpha: 1.0)
        
        var animalCard = MDCSwipeToChooseView(frame: frame, options: options)
        animalCard.imageView?.image = UIImage(named: animal) // if there is an image, set it to the first one in the array
        animalCard.backgroundColor = UIColor.clearColor() // color the card bg
        return animalCard
        
    }
    
    
    // Card positions and sizing
    func frontCardViewFrame() -> CGRect
    {
        let horizontalPadding: CGFloat = 15
        let topPadding: CGFloat = 90
        let bottomPadding: CGFloat = 100
//        return CGRectMake(horizontalPadding, topPadding, CGRectGetWidth(self.view.frame) - (horizontalPadding*2), CGRectGetHeight(self.view.frame) - (bottomPadding))
        var cardRect = CGRectMake(horizontalPadding, topPadding, 290, 372)

        
        return cardRect // set size based on image size instead of screen space
    }
    
    func backCardViewFrame() -> CGRect
    {
        let frontCard = self.frontCardViewFrame()
        return CGRectMake(frontCard.origin.x + 6, frontCard.origin.y + 6, CGRectGetWidth(frontCard), CGRectGetHeight(frontCard))
    }
    
    
    // Left or Right?
    func viewDidCancelSwipe(view: UIView!)
    {
        // do stuff here if it's not swiped far enough
    }
    
    func view(view: UIView!, shouldBeChosenWithDirection direction: MDCSwipeDirection) -> Bool
    {
        // do stuff here before the card goes away
        return true
    }
    
    func view(view: UIView!, wasChosenWithDirection direction: MDCSwipeDirection)
    {
        // Swipe right to delete the card (after learning it)
        if (direction == MDCSwipeDirection.Right)
        {
            // currentPosition points to the *back* card, we want to remove the *front*.
            // Make sure if back was at the start of array, we consider front to be end.
            var indexToRemove = currentPosition - 1
            if (indexToRemove == -1) { indexToRemove = animals.count - 1 }
            
            // Remove the element
            animals.removeAtIndex(indexToRemove)
            
            // If position wasn't the start, we need to decrement. If it *was* the start
            // then we removed from the end, so there's no change to make to currentPosition.
            if (currentPosition > 0 ) { currentPosition-- }
            
            // If that position was the final item, currentPosition will no longer be valid.
            if (currentPosition == animals.count) {currentPosition = 0}
            
            // Update count
            cardsLeftLabel.text = "\(animals.count)"
        }
        
        
        func removeChildView(content: UIViewController)
        {
            content.willMoveToParentViewController(nil)
            content.view.removeFromSuperview()
            content.removeFromParentViewController()
        }
        
        // If all cards are gone, segue to summary screen
        if (animals.count == 0)
        {
            performSegueWithIdentifier("summarySegue", sender: self)
            return
        }
        
        // Show more cards if we have them
        frontCardView = backCardView // the back card is now the new front card
        backCardView  = popCardViewWithFrame(backCardViewFrame(), animal: getNextAnimal())
        backCardView.layer.borderColor = UIColor.clearColor().CGColor
        
        // If we have a new back view, fade it in under the new front
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
    
    // @todo why does it error on the buttons but not on the swipes??
    
    @IBAction func pressLater(sender: AnyObject)
    {
        frontCardView.mdc_swipe(MDCSwipeDirection.Left)
    }

    @IBAction func pressLearned(sender: AnyObject)
    {
        frontCardView.mdc_swipe(MDCSwipeDirection.Right)
    }
    

    // Back button
    @IBAction func didClickBackButton(sender: AnyObject)
    {
        navigationController!.popViewControllerAnimated(true)
    }
    
    
}
