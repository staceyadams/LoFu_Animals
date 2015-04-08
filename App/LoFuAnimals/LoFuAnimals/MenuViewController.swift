//
//  MenuViewController.swift
//  LoFuAnimals
//
//  Created by Stacey Adams on 3/24/15.
//  Copyright (c) 2015 Stacey & Bryan. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{

    @IBOutlet weak var menuTableView: UITableView!
    var menuImageName: [String] = ["flashcard_cat", "flashcard_cow", "flashcard_monkey", "flashcard_goat"]
    var menuTextName: [String] = ["Pets", "Farm Animals", "Jungle Animals", "Mountain Animals"]
    var menuBgName: [String] = ["bg-pets", "bg-farm", "bg-jungle", "bg-mountain"]
    var segue: [String] = ["seguePets", "segueFarm", "segueJungle", "segueMountain"]
//    var revealImageName0: [String] = ["flashcard_cat", "flashcard_sheep", "flashcard_monkey", "flashcard_moose"]
//    var revealImageName1: [String] = ["flashcard_dog", "flashcard_cow", "flashcard_gorilla", "flashcard_deer"]
//    var revealImageName2: [String] = ["flashcard_fish", "flashcard_pig", "flashcard_tiger", "flashcard_wolf"]
//    var revealImageName3: [String] = ["flashcard_rabbit", "flashcard_rooster", "flashcard_elephant", "flashcard_fox"]
//    var revealImageName4: [String] = ["flashcard_bird", "flashcard_hen", "flashcard_cheetah", "flashcard_bear"]
//    var revealImageName5: [String] = ["flashcard_hamster", "flashcard_horse", "flashcard_panda", "flashcard_goat"]

    var revealImageName0: [String] = ["cat", "sheep", "monkey", "moose"]
    var revealImageName1: [String] = ["dog", "cow", "gorilla", "deer"]
    var revealImageName2: [String] = ["fish", "pig", "tiger", "fwolf"]
    var revealImageName3: [String] = ["rabbit", "rooster", "elephant", "fox"]
    var revealImageName4: [String] = ["bird", "hen", "cheetah", "bear"]
    var revealImageName5: [String] = ["hamster", "horse", "panda", "goat"]
    var selectedIndex: Int! = 0


    override func viewDidLoad()
    {
        super.viewDidLoad()

        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.rowHeight = 112
        menuTableView.backgroundColor = UIColor.clearColor()
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCellWithIdentifier("MenuCell") as MenuTableViewCell
        
        cell.menuImage.image = UIImage(named: menuImageName[indexPath.row])
        cell.menuTitle.text = menuTextName[indexPath.row]
        cell.menuView.backgroundColor = UIColor(patternImage: UIImage(named: menuBgName[indexPath.row])!)
        cell.mainView.backgroundColor = UIColor(patternImage: UIImage(named: menuBgName[indexPath.row])!)
        cell.selectionStyle = .None
        
//        var imageView = cell.revealImage[indexPath.row] as UIImageView
//        selectedIndex = imageView.tag
//        cell.revealImage[selectedIndex].image = UIImage(named: revealImageName[selectedIndex])

        for index in 0...5
        {
//            var imageView = cell.revealImage[indexPath.row] as UIImageView
//            selectedIndex = imageView.tag
            cell.revealImage0.image = UIImage(named: revealImageName0[indexPath.row])
            cell.revealImage1.image = UIImage(named: revealImageName1[indexPath.row])
            cell.revealImage2.image = UIImage(named: revealImageName2[indexPath.row])
            cell.revealImage3.image = UIImage(named: revealImageName3[indexPath.row])
            cell.revealImage4.image = UIImage(named: revealImageName4[indexPath.row])
            cell.revealImage5.image = UIImage(named: revealImageName5[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        performSegueWithIdentifier(segue[indexPath.row], sender: self)
    }

    
}
