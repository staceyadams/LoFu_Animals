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
    var animals: [String] = ["flashcard_cat", "flashcard_dog", "flashcard_fish",]// "flashcard_rabbit", "flashcard_hamster", "flashcard_bird"]
    
    var currentPosition: Int = -1 // We increment before using, so set to -1 to begin
    var frontCardView: MDCSwipeToChooseView!
    var backCardView: MDCSwipeToChooseView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        frontCardView = popCardViewWithFrame(frontCardViewFrame(), animal: getNextAnimal())
        view.addSubview(frontCardView)
        
        backCardView = popCardViewWithFrame(backCardViewFrame(), animal: getNextAnimal())
        view.insertSubview(backCardView, belowSubview: frontCardView)
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
        options.likedText = "Learned"
        options.nopeText = "Later"
        options.likedColor = UIColor.clearColor()
        options.nopeColor = UIColor.clearColor()
        
        var animalCard = MDCSwipeToChooseView(frame: frame, options: options)
        
        animalCard.imageView?.image = UIImage(named: animal) // if there is an image, set it to the first one in the array
        animalCard.backgroundColor = UIColor.clearColor() // color the card bg
        println("popcard: \(animal)")
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
        //println("cancel: \(animals[currentPosition])")
    }
    
    func view(view: UIView!, shouldBeChosenWithDirection direction: MDCSwipeDirection) -> Bool
    {
        //println("should: \(animals[currentPosition])")
        return true
    }
    
    func view(view: UIView!, wasChosenWithDirection direction: MDCSwipeDirection)
    {
        // Swipe right to delete the card.
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
        }
        
        // If we removed everything, then we're done.
        if (animals.count == 0)
        {
            performSegueWithIdentifier("showSummary", sender: self)
            return
        }
        
        // If we get to here, there are more things to show
        frontCardView = backCardView // the back card is now the new front card
        backCardView  = popCardViewWithFrame(backCardViewFrame(), animal: getNextAnimal())
        
        // If we have a new back view, fade in under the new front.
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
}
