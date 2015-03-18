//
//  WritingViewController.swift
//  LoFuAnimals
//
//  Created by Stacey Adams on 3/15/15.
//  Copyright (c) 2015 Stacey & Bryan. All rights reserved.
//

import UIKit

class WritingViewController: UIViewController
{

    @IBOutlet weak var writingTextField: UITextField!
    @IBOutlet weak var writingImage: UIImageView!
    
    var animalsText: [String] = ["cat", "dog", "fish", "rabbit", "bird", "hamster"]
    var animalsCards: [String] = ["flashcard_cat", "flashcard_dog", "flashcard_fish", "flashcard_rabbit", "flashcard_bird", "flashcard_hamster"]
    var currentWord: String!
    var currentWordImage: String!
    
    var currentPosition: Int = -1 // We increment before using, so set to -1 to begin
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
      
        currentWord = animalsText[0]
        currentWordImage = animalsCards[0]
        writingImage.image = UIImage(named:currentWordImage)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didPressSubmit(sender: AnyObject)
    {
        if writingTextField.text == currentWord
        {
           // setNextAnimal()
            
            println("\(currentWord) + \(currentWordImage)")
            println(currentPosition)
            
            getNextAnimal()
            
            // currentPosition points to the *back* card, we want to remove the *front*.
            // Make sure if back was at the start of array, we consider front to be end.
            var indexToRemove = currentPosition - 1
            if (indexToRemove == -1) { indexToRemove = animalsText.count - 1 }
            
            // Remove the element
            animalsText.removeAtIndex(indexToRemove)
            
            // If position wasn't the start, we need to decrement. If it *was* the start
            // then we removed from the end, so there's no change to make to currentPosition.
            if (currentPosition > 0 ) { currentPosition-- }
            
            // If that position was the final item, currentPosition will no longer be valid.
            if (currentPosition == animalsText.count) {currentPosition = 0}
            
            currentWord = animalsText[currentPosition]
            currentWordImage = animalsCards[currentPosition]
            writingImage.image = UIImage(named:currentWordImage)
            
            println(currentPosition)
            println("\(currentWord) + \(currentWordImage)")
            
        }
        else
        {
            var alertView = UIAlertView(title: "Try Again", message: "Sorry, that wasn't quite right. Give it another try.", delegate: nil, cancelButtonTitle: "OK")
            alertView.show()
        }
        
        if animalsText.count < 0
        {
            println("move on")
        }
    }
    
    func setNextAnimal()
    {
        // hacky way to move through the index by removing each one as its completed, and resetting current to the first item
        animalsText.removeAtIndex(0)
        animalsCards.removeAtIndex(0)
        currentWord = animalsText[0]
        currentWordImage = animalsCards[0]
        writingImage.image = UIImage(named:currentWordImage)
    }
    
    func getNextAnimal() -> String
    {
        currentPosition++ // Move to next position
        if (currentPosition == animalsText.count) { currentPosition = 0; } // Make sure we loop around
        return animalsText[currentPosition]
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
