//
//  MatchingViewController.swift
//  LoFuAnimals
//
//  Created by Stacey Adams on 3/18/15.
//  Copyright (c) 2015 Stacey & Bryan. All rights reserved.
//

import UIKit

class MatchingViewController: UIViewController {

    
    @IBOutlet var card: [UIImageView]!
    @IBOutlet var animalImage: [UIImageView]!
    var selectedIndex: Int! = 0
    
    var animalSticker: [String] = ["cat", "dog", "fish", "rabbit", "bird", "hamster"]
    var animalCard: [String] = ["flashcard_cat", "flashcard_dog", "flashcard_fish", "flashcard_rabbit", "flashcard_bird", "flashcard_hamster"]
    var currentWord: String!
    var currentWordImage: String!
    
    var scale: CGFloat! = 1
    var rotate: CGFloat! = 0
    var originalCenter: CGPoint!
    var startingCenter: CGPoint!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bg-pets")!)
        
        card[0].transform = CGAffineTransformMakeRotation(3.14*0.02)
        card[1].transform = CGAffineTransformMakeRotation(3.14/0.02)
        card[2].transform = CGAffineTransformMakeRotation(3.14*0.03)
        card[3].transform = CGAffineTransformMakeRotation(3.14/0.01)
        card[4].transform = CGAffineTransformMakeRotation(3.14*0.04)
        card[5].transform = CGAffineTransformMakeRotation(3.14/0.02)
        
        
        //for var index = 0; index < 6; index++
        for index in 0...5
        {
            animalImage[index].image = UIImage(named: animalSticker[index])
            card[index].image = UIImage(named: animalCard[index])
        }
        
        
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
        
        if (sender.state == UIGestureRecognizerState.Began)
        {
            scale = 1.5
            transformAnimal()
            originalCenter = animalImage[0].center
            
        } else if (sender.state == UIGestureRecognizerState.Changed)
        {
            animalImage[0].center = CGPoint(x: originalCenter.x + translation.x, y: originalCenter.y + translation.y)

            
        } else if (sender.state == UIGestureRecognizerState.Ended)
        {
            scale = 1
            transformAnimal()
            
            // @TODO once the animal is moved outside of the view, it can no longer be picked up. why????
            
            
            
//            println("animal center \(animalImage[selectedIndex].center )")
//            println("animal card \(animalCardsImage[selectedIndex].center )")
//            
//            if animalImage[selectedIndex].center == animalCardsImage[selectedIndex].center
//            {
//                println("correct")
//            }
//            
//            else
//            {
//                println("right")
//            }
//            
            
        }
    }
    
    func transformAnimal(){
        var scaleTransform = CGAffineTransformMakeScale(scale, scale)
        animalImage[selectedIndex].transform = scaleTransform
    }

}
