//
//  WelcomeViewController.swift
//  LoFuAnimals
//
//  Created by Stacey Adams on 3/13/15.
//  Copyright (c) 2015 Stacey & Bryan. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: 1280, height: 568)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var page = Int(scrollView.contentOffset.x / 320)
        pageControl.currentPage = page
        // println(page)
        // on page 4, hide the page control and show the button
        if (page == 3) {
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.pageControl.alpha = 0
                self.startButton.alpha = 1
            })
        }
        else {
            pageControl.alpha = 1
            startButton.alpha = 0
        }
        
        
    }

}
