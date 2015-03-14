//
//  FlashcardViewController.swift
//  LoFuAnimals
//
//  Created by Stacey Adams on 3/14/15.
//  Copyright (c) 2015 Stacey & Bryan. All rights reserved.
//

import UIKit
import MDCSwipeToChoose

class FlashcardViewController: UIViewController, MDCSwipeToChooseDelegate {

    var animals: [String] = ["cat", "dog", "fish", "hamster", "rabbit", "bird"]
    var frontCardView: MDCSwipeToChooseView!
    var backCardView: MDCSwipeToChooseView!
    var currentAnimal: String!
    var questionsRemaining: Int = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        frontCardView = popCardViewWithFrame(frontCardViewFrame())
        view.addSubview(frontCardView)
        
        backCardView = popCardViewWithFrame(backCardViewFrame())
        view.insertSubview(backCardView, belowSubview: frontCardView)
        
        questionsRemaining = animals.count
        
        
        
        
    }
    
    func popCardViewWithFrame(frame:CGRect) -> MDCSwipeToChooseView?
    {
        if animals.count == 0 {return nil}
        let options = MDCSwipeToChooseViewOptions()
        options.delegate = self
        options.likedText = "Learned" // delete if you can't set size of text
        options.nopeText = "Later"
        options.likedColor = UIColor.clearColor()
        options.threshold = 160
        options.onPan =
        {
            (state: MDCPanState!) in
            let frame = self.backCardViewFrame()
            self.backCardView.frame = CGRectMake(frame.origin.x, frame.origin.y - state.thresholdRatio * CGFloat(10), CGRectGetWidth(frame), CGRectGetHeight(frame))
        }
        // println(frame)
        var animalCard = MDCSwipeToChooseView(frame: frame, options: options)
        animalCard.imageView?.image = UIImage(named: animals[0])
        animalCard.backgroundColor = UIColor.blueColor()
        
        
        
        currentAnimal = animals[0]
        animals.removeAtIndex(0)
//        animalCard.backgroundColor = UIColor(white: 0.4, alpha: 0.5)
        return animalCard
    }
    
    
    
    
    // MARK: - Back/Front Positions
    func frontCardViewFrame() -> CGRect
    {
        let horizontalPadding: CGFloat=20
        let topPadding: CGFloat=60
        let bottomPadding: CGFloat=200
        return CGRectMake(horizontalPadding, topPadding, CGRectGetWidth(self.view.frame) - (horizontalPadding*2), CGRectGetHeight(self.view.frame) - (bottomPadding))
    }
    
    func backCardViewFrame() -> CGRect
    {
        let frontCard = self.frontCardViewFrame()
        return CGRectMake(frontCard.origin.x, frontCard.origin.y + 10, CGRectGetWidth(frontCard), CGRectGetHeight(frontCard))
    }

    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Swipe to Choose Delegate
    // reference ChoosePersonViewController.m
    func viewDidCancelSwipe(view: UIView!)
    {
        println("cancel")
        println("questions: \(questionsRemaining)")

        // show summary screen on completion
        if questionsRemaining < 0
        {
            performSegueWithIdentifier("showSummary", sender: self)
    
        }
    }
    
//    func view(view: UIView!, shouldBeChosenWithDirection direction: MDCSwipeDirection) -> Bool
//    {
//        println("direction chosen, before you get rid of it")
//        return true
//    }
    
    func view(view: UIView!, wasChosenWithDirection direction: MDCSwipeDirection)
    {
        println("direction chosen, after you get rid of it")
        if direction == MDCSwipeDirection.Left
        {
            println("left")
            animals.append(currentAnimal)
        }
        else
        {
            println("right")
            questionsRemaining-=1
        }
        frontCardView = backCardView
        println(animals.count)
        if animals.count > 0
        {
            backCardView = popCardViewWithFrame(backCardViewFrame())
            if backCardView != nil {
                
    //        {
    //            backCardView.alpha = 0
                self.view.insertSubview(backCardView, belowSubview: frontCardView)
                // add in animation to fade backcardview alpha 1
    //            backCardView.alpha = 1 //start at 0
            }
        }
    }
    
    
    @IBAction func pressLater(sender: AnyObject)
    {
        frontCardView.mdc_swipe(MDCSwipeDirection.Left)
    }

    @IBAction func pressLearned(sender: AnyObject)
    {
        frontCardView.mdc_swipe(MDCSwipeDirection.Right)
    }
}
