//
//  CardsViewController.swift
//  LoFuAnimals
//
//  Created by Stacey Adams on 3/22/15.
//  Copyright (c) 2015 Stacey & Bryan. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {

    @IBOutlet var cardImage: [UIImageView]!
    var card: [String] = ["flashcard_cat", "flashcard_dog", "flashcard_fish", "flashcard_rabbit", "flashcard_bird", "flashcard_hamster"]
    var cardImageStartX: CGFloat! = 108
    var cardImageStartY: CGFloat! = 135
//    var cardImageStartX: CGFloat! = 160
//    var cardImageStartY: CGFloat! = 30
    var cardImageEndX: [CGFloat] = [2, 106, 210, 2, 106, 210]
    var cardImageEndY: [CGFloat] = [0, 0, 0, 135, 135, 135]

    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
  
        for index in 0...5
        {
          cardImage[index].image = UIImage(named: card[index])
        }
        
        UIView.animateWithDuration(0.3, animations:
        { () -> Void in
            self.cardsStartPosition()
        })
            { (finished: Bool) -> Void in
            delay(0.3,
            { () -> () in
                self.cardsEndPosition()
                self.cardsRotate()
            })
    }
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }

    
    func cardsStartPosition()
    {
        UIView.animateWithDuration(0.5, animations:
            { () -> Void in
                for index in 0...5
                {
                    self.cardImage[index].frame.origin.x = self.cardImageStartX
                    self.cardImage[index].frame.origin.y = self.cardImageStartY
                }
        })
    }
    
    func cardsEndPosition()
    {
        UIView.animateWithDuration(0.5, animations:
            { () -> Void in
                for index in 0...5
                {
                    self.cardImage[index].frame.origin.x = self.cardImageEndX[index]
                    self.cardImage[index].frame.origin.y = self.cardImageEndY[index]
                }
        })
    }
    
    func cardsRotate()
    {
        cardImage[0].transform = CGAffineTransformMakeRotation(3.14*0.02)
        cardImage[1].transform = CGAffineTransformMakeRotation(3.14/0.02)
        cardImage[2].transform = CGAffineTransformMakeRotation(3.14*0.03)
        cardImage[3].transform = CGAffineTransformMakeRotation(3.14/0.01)
        cardImage[4].transform = CGAffineTransformMakeRotation(3.14*0.04)
        cardImage[5].transform = CGAffineTransformMakeRotation(3.14/0.02)
    }
    
    
 }
