//
//  WritingViewController.swift
//  LoFuAnimals
//
//  Created by Stacey Adams on 3/15/15.
//  Copyright (c) 2015 Stacey & Bryan. All rights reserved.
//

import UIKit

class WritingViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var writingTextField: UITextField!
    @IBOutlet weak var writingImage: UIImageView!
    @IBOutlet weak var displayWord: UILabel!
    @IBOutlet weak var backgroundTile: UIView!
    @IBOutlet weak var correctIcon: UIImageView!
    
    var animalsText: [String] = ["猫", "狗", "鱼", "兔子", "鸟", "仓鼠"]
    var animalsCards: [String] = ["cat", "dog", "fish", "rabbit", "bird", "hamster"]
    var currentWord: String!
    var currentWordImage: String!
    
    var currentPosition: Int = 0
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        backgroundTile.backgroundColor = UIColor(patternImage: UIImage(named: "bg-pets")!)
        writingTextField.delegate = self
        correctIcon.alpha = 0
        currentWord = animalsText[currentPosition]
        currentWordImage = animalsCards[currentPosition]
        writingImage.image = UIImage(named:currentWordImage)
        displayWord.text = animalsText[currentPosition]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didPressSubmit(sender: AnyObject)
    {
        correctIcon.transform = CGAffineTransformMakeScale(0, 0)
        correctIcon.alpha = 1
        
        if writingTextField.text == currentWord
        {
            // Check if it's last image. If so, segue.
            if (currentPosition == animalsText.count - 1)
            {
                delay(1.5, { () -> () in
                    self.performSegueWithIdentifier("writingSummarySegue", sender: nil)
                })
            }
            
            //Animate "Correct" Animation
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.correctIcon.image = UIImage(named: "icon-correct")
                self.correctIcon.transform = CGAffineTransformMakeScale(2, 2)
            })
            
            //Get the next animal in place
            getNextAnimal()

            //Artifical delay so "Correct" animation can play
            delay(2.0,
            { () -> () in
                UIView.animateWithDuration(0.2, animations:
                { () -> Void in
                    self.correctIcon.transform = CGAffineTransformMakeScale(0, 0)
                    self.writingTextField.text = nil
                    self.displayWord.text = self.animalsText[self.currentPosition]
                    self.currentWord = self.animalsText[self.currentPosition]
                    self.currentWordImage = self.animalsCards[self.currentPosition]
                    self.writingImage.image = UIImage(named:self.currentWordImage)
                })
            })
        }
        else
        {
           UIView.animateWithDuration(0.2, animations:
            { () -> Void in
                self.correctIcon.image = UIImage(named: "icon-wrong")
                self.correctIcon.transform = CGAffineTransformMakeScale(2, 2)
                delay(2.0,
                { () -> () in
                    UIView.animateWithDuration(0.2, animations:
                    { () -> Void in
                        self.correctIcon.transform = CGAffineTransformMakeScale(0, 0)
                        self.writingTextField.text = nil
                    })
                })
            })
        }

    }
    
    
    func getNextAnimal() -> String
    {
        if currentPosition < animalsText.count - 1 {
            currentPosition++ // Move to next position
        }
        else {
            currentPosition = animalsText.count - 1
        }
        return animalsText[currentPosition]
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        didPressSubmit(self)
        
        return true;
        
    }

}
