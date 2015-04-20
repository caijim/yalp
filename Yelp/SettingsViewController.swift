//
//  SettingsViewController.swift
//  Yelp
//
//  Created by Jim Cai on 4/19/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SearchDelegate, SwitchDelegate {
    var categoryChecked = false
    var distanceChecked = false
    var notChecked = 1;
    var checked = 3;
    var distances = ["3.0 KM", "0.5KM", "0.1 km"]
    var categories = ["Best Match", "Distance", "Highest Rated"]
    var categoryText = ""
    var deals = false
    
    
    var categoryOption = 0
    var distanceOption = 0

    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        

        // Do any additional setup after loading the view.
    }

    func searchDelegate(searchtableViewCell: SearchTableViewCell, searchValue: String) {
        categoryText = searchValue
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3;
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section==0{
            return 2
        }
        else{
            if section==1{
                if distanceChecked{
                    return self.checked
                }
                else{
                    return self.notChecked
                }
            }
            else{
                if categoryChecked{
                    return self.checked
                }
                else{
                    return self.notChecked
                }
                
            }
        }
    
    }
    
    func switchDelegate(searchtableViewCell: SwitchTableViewCell, switchValue: Bool) {
        deals = switchValue
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(30.0)
    }
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerView=UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 150)   )
        headerView.backgroundColor = UIColor(white: 0.8, alpha: 0.5)
        var settingLabel = UILabel(frame: CGRectMake(0, 0, 320, 25))
        switch(section){
        case 0:
            settingLabel.text = "Misc"
            break;
        case 1:
            settingLabel.text = "Distance Away"
            break;
        case 2:
            settingLabel.text = "Sort"
            break;
        default:
            break;
        }
        
        //settingLabel.textColor = UIColor(white: 0.0, alpha: 0.5)
        headerView.insertSubview(settingLabel, atIndex:0)
        
        return headerView
        
        //headerview. = UIColor( white: , alpha)
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch(indexPath.section){
        case 0:
            if indexPath.row==0{
                var cell = tableView.dequeueReusableCellWithIdentifier("SearchCell", forIndexPath: indexPath) as SearchTableViewCell
                cell.delegate = self
                return cell
            }
            else{
                var cell = tableView.dequeueReusableCellWithIdentifier("SwitchCell", forIndexPath: indexPath) as SwitchTableViewCell
                cell.delegate = self
                return cell
            }
        case 1:
            if distanceChecked{
                var cell = tableView.dequeueReusableCellWithIdentifier("ExpandedCell", forIndexPath: indexPath) as ExpandedTableViewCell
                switch(indexPath.row){
                case 0:
                    cell.label.text = "3.0 KM"
                    break
                case 1:
                    cell.label.text = "1.0 KM"
                    break
                default:
                    cell.label.text = "0.1 KM"
                    break
                }
                UIImage(named: "circle.png")
               
                if indexPath.row==distanceOption {
                    cell.contentButton.setBackgroundImage(UIImage(named: "check"), forState: UIControlState.Normal)
                    cell.buttonSelected = true
                }
                else{
                    cell.contentButton.setBackgroundImage(UIImage(named: "circle.png"), forState: UIControlState.Normal)
                }
                return cell
            }
            else{
                var cell = tableView.dequeueReusableCellWithIdentifier("ExpandingCell", forIndexPath: indexPath) as ExpandingViewCell
                cell.label.text = distances[distanceOption]

                return cell
            }
        case 2:
            if categoryChecked{
                var cell = tableView.dequeueReusableCellWithIdentifier("ExpandedCell", forIndexPath: indexPath) as ExpandedTableViewCell

                switch(indexPath.row){
                case 0:
                    cell.label.text = "Best Match"
                    break
                case 1:
                    cell.label.text = "Distance"
                    break
                default:
                    cell.label.text = "Highest Rated"
                    break
                }
                if indexPath.row==0 {

                }
               
                
                if indexPath.row==categoryOption{
                    cell.contentButton.setBackgroundImage(UIImage(named: "check"), forState: UIControlState.Normal)
                    cell.buttonSelected = true
                    
                }
                else{
                    cell.contentButton.setBackgroundImage(UIImage(named: "circle.png"), forState: UIControlState.Normal)
                }

                return cell
            }
            else
            {
                var cell = tableView.dequeueReusableCellWithIdentifier("ExpandingCell", forIndexPath: indexPath) as ExpandingViewCell
                cell.label.text = categories[categoryOption]

                return cell
            }
        default:
            break;
        }
        
        return UITableViewCell()
    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch(indexPath.section){
        case 0:
            break;
        case 1:
            if distanceChecked {
                distanceOption = indexPath.row
                for i in 0...3{
                    var ip = NSIndexPath(forRow: i, inSection: indexPath.section)
                    var ecell = tableView.cellForRowAtIndexPath(indexPath) as ExpandedTableViewCell
                    ecell.contentButton.setBackgroundImage(UIImage(named: "circle.png"), forState: UIControlState.Normal)
                }
                
                var cell = tableView.cellForRowAtIndexPath(indexPath) as ExpandedTableViewCell
                cell.contentButton.setBackgroundImage(UIImage(named: "check"), forState: UIControlState.Normal)
                cell.buttonSelected = true
            }

            distanceChecked = !distanceChecked
            break
        case 2:
            if categoryChecked{
                categoryOption = indexPath.row
                for i in 0...3{
                    var ip = NSIndexPath(forRow: i, inSection: indexPath.section)
                    var ecell = tableView.cellForRowAtIndexPath(indexPath) as ExpandedTableViewCell
                    ecell.contentButton.setBackgroundImage(UIImage(named: "circle.png"), forState: UIControlState.Normal)
                }
                
                var cell = tableView.cellForRowAtIndexPath(indexPath) as ExpandedTableViewCell
                cell.contentButton.setBackgroundImage(UIImage(named: "check"), forState: UIControlState.Normal)
                cell.buttonSelected = true
            }
            categoryChecked = !categoryChecked
            break
        default:
            break
        }
        var set = NSIndexSet(index:indexPath.section)
        
        tableView.reloadSections(set, withRowAnimation: UITableViewRowAnimation.Fade)

    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var deals = self.deals
        var sort = self.categoryOption
        var dist = self.distanceOption
        var cat = self.categoryText
        var nav = segue.destinationViewController as ViewController
        nav.deals = deals
        nav.sort = sort
        nav.dist = dist
        nav.cat = cat
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}
