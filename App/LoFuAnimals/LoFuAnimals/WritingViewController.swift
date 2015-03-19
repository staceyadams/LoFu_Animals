//
//  WritingViewController.swift
//  LoFuAnimals
//
//  Created by Stacey Adams on 3/15/15.
//  Copyright (c) 2015 Stacey & Bryan. All rights reserved.
//

import UIKit

class WritingViewController: UIViewController, UITextFieldDelegate
{

    @IBOutlet weak var writingTextField: UITextField!
    @IBOutlet weak var writingImage: UIImageView!
    @IBOutlet weak var displayWord: UILabel!
    @IBOutlet weak var backgroundTile: UIView!
    
    var animalsText: [String] = ["猫", "狗", "fish", "rabbit", "bird", "hamster"]
    var animalsCards: [String] = ["cat", "dog", "fish", "rabbit", "bird", "hamster"]
    var currentWord: String!
    var currentWordImage: String!
    
    var currentPosition: Int = 0 // We increment before using, so set to -1 to begin
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        backgroundTile.backgroundColor = UIColor(patternImage: UIImage(named: "bg-pets")!)
        writingTextField.delegate = self
      
        currentWord = animalsText[0]
        currentWordImage = animalsCards[0]
        writingImage.image = UIImage(named:currentWordImage)
        displayWord.text = animalsText[0]
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
            
//println("\(currentWord) + \(currentWordImage)")
            // println(currentPosition)
            
            getNextAnimal()
            
            displayWord.text = animalsText[currentPosition]
            currentWord = animalsText[currentPosition]
            currentWordImage = animalsCards[currentPosition]
            writingImage.image = UIImage(named:currentWordImage)
            
            //println(currentPosition)
            //println("\(currentWord) + \(currentWordImage)")
            
            writingTextField.resignFirstResponder()
            
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
    
    func getNextAnimal() -> String
    {
        currentPosition++ // Move to next position
        if (currentPosition == animalsText.count) {
            
            currentPosition = animalsText.count; // Keep the image the sam as the final one
            
            //Do the Segue
            //prepareForSegue("waiting", sender: nil)
            println("SEGUE NOW!")
        }
        
        return animalsText[currentPosition]
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true;
        
    }

}
