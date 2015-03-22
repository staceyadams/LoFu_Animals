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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        cardImage[0].transform = CGAffineTransformMakeRotation(3.14*0.02)
        cardImage[1].transform = CGAffineTransformMakeRotation(3.14/0.02)
        cardImage[2].transform = CGAffineTransformMakeRotation(3.14*0.03)
        cardImage[3].transform = CGAffineTransformMakeRotation(3.14/0.01)
        cardImage[4].transform = CGAffineTransformMakeRotation(3.14*0.04)
        cardImage[5].transform = CGAffineTransformMakeRotation(3.14/0.02)
        
        for index in 0...5
        {
            cardImage[index].image = UIImage(named: card[index])
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
 }
