//
//  SummaryViewController.swift
//  LoFuAnimals
//
//  Created by Stacey Adams on 3/19/15.
//  Copyright (c) 2015 Stacey & Bryan. All rights reserved.
//

import UIKit

class SummaryViewController: UIViewController
{
   
    @IBOutlet var card: [UIImageView]!
    var animals: [String] = ["flashcard_cat", "flashcard_dog", "flashcard_fish", "flashcard_rabbit", "flashcard_bird", "flashcard_hamster"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bg-pets")!)
                
        for index in 0...5
        {
            card[index].image = UIImage(named: animals[index])
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

}
