//
//  LearningControllerViewController.swift
//  LoFuAnimals
//
//  Created by Stacey Adams on 3/15/15.
//  Copyright (c) 2015 Stacey & Bryan. All rights reserved.
//

import UIKit

class LearningControllerViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    var flashcardVC: UIViewController!
    var writingVC: UIViewController!
    var learningSummaryVC: UIViewController!
    
    var viewControllersArray = [UIViewController]()
    var selectedIndex: Int! = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set background
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bg-pets")!)
        
        // set storyboards
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        flashcardVC = storyboard.instantiateViewControllerWithIdentifier("flashcardStory") as UIViewController
        writingVC = storyboard.instantiateViewControllerWithIdentifier("writingStory") as UIViewController
        learningSummaryVC = storyboard.instantiateViewControllerWithIdentifier("summaryStory") as UIViewController
        
        viewControllersArray = [flashcardVC, writingVC, learningSummaryVC]
        
        //show flashcardsVC as the initial view
        loadLearningView([0])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func loadLearningView(sender: AnyObject)
    {
        // remove the stuff from the existing view
        removeChildView(viewControllersArray[selectedIndex]) // remove existing view before adding a new view. Uses func created below.
        
        // set SelectedIndex to the current view (array number)
        // selectedIndex = @todo
        
        // add in the new view
        addChildViewController(viewControllersArray[selectedIndex]) // add new view
        var learningContentView = viewControllersArray[selectedIndex].view // sets size of content view
        learningContentView.frame = contentView.frame // sets size of external VC view to fit into container view
        contentView.addSubview(learningContentView) // get view from the external VC and put it into our container on this VC
        viewControllersArray[selectedIndex].didMoveToParentViewController(self) // attaches child VC to this controller
    }
    
    func removeChildView(content: UIViewController)
    {
        content.willMoveToParentViewController(nil)
        content.view.removeFromSuperview()
        content.removeFromParentViewController()
    }

}
