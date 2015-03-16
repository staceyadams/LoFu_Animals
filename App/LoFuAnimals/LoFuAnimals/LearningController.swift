//
//  LearningControllerViewController.swift
//  LoFuAnimals
//
//  Created by Stacey Adams on 3/15/15.
//  Copyright (c) 2015 Stacey & Bryan. All rights reserved.
//

// reference LearningControllerViewController.m in the LikedorNope example for all the things we are customizing

import UIKit
class LearningControllerViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    
    var flashcardsVC: FlashcardViewController!
    var learnSummaryVC: LearningSummaryView
    var writingVC:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bg-pets")!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}