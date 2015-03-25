//
//  HomeViewController.swift
//  LoFuAnimals
//
//  Created by Stacey Adams on 3/24/15.
//  Copyright (c) 2015 Stacey & Bryan. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var petView: UIView!
    @IBOutlet weak var farmView: UIView!
    @IBOutlet weak var jungleView: UIView!
    @IBOutlet weak var mountainView: UIView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scrollView.contentSize = CGSize(width: 1280, height: 568)
        
        petView.backgroundColor = UIColor(patternImage: UIImage(named: "bg-pets")!)
        farmView.backgroundColor = UIColor(patternImage: UIImage(named: "bg-farm")!)
        jungleView.backgroundColor = UIColor(patternImage: UIImage(named: "bg-jungle")!)
        mountainView.backgroundColor = UIColor(patternImage: UIImage(named: "bg-mountain")!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView)
    {
        var page = Int(scrollView.contentOffset.x / 320)
        
        pageControl.currentPage = page
        println(page)
        if (page == 3)
        {
        }
        
        
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
