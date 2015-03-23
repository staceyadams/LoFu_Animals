//
//  WelcomeViewController.swift
//  LoFuAnimals
//
//  Created by Stacey Adams on 3/13/15.
//  Copyright (c) 2015 Stacey & Bryan. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController, UIScrollViewDelegate
{

    @IBOutlet var cardView: [UIView]!
    @IBOutlet var cardLabel: [UILabel]!
    @IBOutlet var animalImage: [UIImageView]!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
            
        // Do any additional setup after loading the view.
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: 320, height: 1200)
        
        for index in 0...5
        {
//            println("animalImage: \(animalImage[index].frame.origin.x), \(animalImage[index].frame.origin.y)")
//            println("cardView: \(cardView[index].frame.origin.x), \(cardView[index].frame.origin.y)")
//            println("cardLabel: \(cardLabel[index].frame.origin.x), \(cardLabel[index].frame.origin.y)")
            
        }
        
        /*
        STARTING X/Y
        animalImage: 21.0, 16.0
        cardView: 204.0, 0.0
        cardLabel: 17.0, 14.0
        animalImage: 21.0, 36.0
        cardView: 204.0, 10.0
        cardLabel: 17.0, 14.0
        animalImage: 21.0, 56.0
        cardView: 204.0, 20.0
        cardLabel: 17.0, 14.0
        animalImage: 21.0, 76.0
        cardView: 204.0, 30.0
        cardLabel: 17.0, 14.0
        animalImage: 21.0, 96.0
        cardView: 204.0, 40.0
        cardLabel: 17.0, 14.0
        animalImage: 21.0, 116.0
        cardView: 204.0, 50.0
        cardLabel: 17.0, 14.0
        
        
        FINAL X/Y
        animalImage: 30.0, 65.0
        cardView: 2.0, 0.0
        cardLabel: 17.0, 14.0
        animalImage: 135.0, 65.0
        cardView: 106.0, 0.0
        cardLabel: 17.0, 14.0
        animalImage: 240.0, 65.0
        cardView: 210.0, 0.0
        cardLabel: 17.0, 14.0
        animalImage: 30.0, 200.0
        cardView: 2.0, 135.0
        cardLabel: 17.0, 14.0
        animalImage: 135.0, 200.0
        cardView: 106.0, 135.0
        cardLabel: 17.0, 14.0
        animalImage: 235.0, 200.0
        cardView: 210.0, 135.0
        cardLabel: 17.0, 14.0
        */
        
        
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView)
    {
    
    }

    @IBAction func onPressStart(sender: AnyObject)
    {
        println("i'm being clicked")
    }
    
}
