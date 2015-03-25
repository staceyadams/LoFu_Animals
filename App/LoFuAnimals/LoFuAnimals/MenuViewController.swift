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

    override func viewDidLoad()
    {
        super.viewDidLoad()

        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.rowHeight = 112
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
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        performSegueWithIdentifier(segue[indexPath.row], sender: self)
    }

    
}
