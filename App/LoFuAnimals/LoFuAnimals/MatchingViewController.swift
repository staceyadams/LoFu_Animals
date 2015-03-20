//
//  MatchingViewController.swift
//  LoFuAnimals
//
//  Created by Stacey Adams on 3/18/15.
//  Copyright (c) 2015 Stacey & Bryan. All rights reserved.
//

import UIKit

class MatchingViewController: UIViewController {

    @IBOutlet weak var card1: UIImageView!
    @IBOutlet weak var card2: UIImageView!
    @IBOutlet weak var card3: UIImageView!
    @IBOutlet weak var card4: UIImageView!
    @IBOutlet weak var card5: UIImageView!
    @IBOutlet weak var card6: UIImageView!
    @IBOutlet weak var animal1: UIImageView!
    @IBOutlet weak var animal2: UIImageView!
    @IBOutlet weak var animal3: UIImageView!
    @IBOutlet weak var animal4: UIImageView!
    @IBOutlet weak var animal5: UIImageView!
    @IBOutlet weak var animal6: UIImageView!
    
    
    @IBOutlet var animalImage: [UIImageView]!
    
   
    var selectedIndex: Int! = 0
    
    var animalSticker: [String] = ["cat", "dog", "fish", "rabbit", "bird", "hamster"]
    var animalCards: [String] = ["flashcard_cat", "flashcard_dog", "flashcard_fish", "flashcard_rabbit", "flashcard_bird", "flashcard_hamster"]
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
        
        animalImage[1].image = UIImage(named:animalSticker[0])
        animalImage[2].image = UIImage(named:animalSticker[1])
      
        
        
        //selectedIndex = animalCardsImage.viewWithTag(100)
        
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
            originalCenter = animalImage[selectedIndex].center
            
        } else if (sender.state == UIGestureRecognizerState.Changed)
        {
            animalImage[selectedIndex].center = CGPoint(x: originalCenter.x + translation.x, y: originalCenter.y + translation.y)

            
        } else if (sender.state == UIGestureRecognizerState.Ended)
        {
            scale = 1
            transformAnimal()
            
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
