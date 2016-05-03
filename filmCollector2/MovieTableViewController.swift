//
//  MovieTableViewController.swift
//  filmCollector2
//
//  Created by student on 5/3/16.
//  Copyright © 2016 Josh. All rights reserved.
//

import UIKit
import CoreData

class MovieTableViewController: UITableViewController {
    
    
    var managedObjectContext: NSManagedObjectContext!
    var movies = [Movie]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        reloadData()
        
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    //calls reload data and reloads table view controller will get called when we push on the back button
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addMovie:"),
            UIBarButtonItem(title: "Sort", style: .Plain, target: self, action: "selectSort:")
        ]

        reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reloadData(sortDescriptor: String? = nil) {
        
        //                                entity name to fetch data from
        let fetchRequest = NSFetchRequest(entityName: "Movie")
        
        
        
        if let sortDescriptor = sortDescriptor {
            let sort = NSSortDescriptor(key: sortDescriptor, ascending: true)
            fetchRequest.sortDescriptors = [sort]
        }
        
        do {
            
            //returns object which is casted to array shopping list and is stored in results
            if let results = try managedObjectContext.executeFetchRequest(fetchRequest) as?
                [Movie] {
                    movies = results
                    //not recursive reload data call, this is the call to reload data in the tableview..tableview is an actual control in the storyboard
                    tableView.reloadData()
            }
            
        } catch {
            fatalError("There was an error fetching shopping lists!")
            
        }
    }
    
    func addMovie(sender: AnyObject?){
        if let itemsTableViewController =
            storyboard?.instantiateViewControllerWithIdentifier("MovieDetails") as?
                //casting to a shoppinglisttableviewcontroller (with as)_____________|^|
            MovieDetailViewController {
                
                itemsTableViewController.managedObjectContext = managedObjectContext
                
                //heres the actual segue
                navigationController?.pushViewController(itemsTableViewController, animated: true)
        }
    }
    
    func selectSort(sender: AnyObject?) {
        
        let sheet = UIAlertController(title: "Sort", message: "Movies", preferredStyle: .ActionSheet)
        
        sheet.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: {(action) -> Void in }))
        
        sheet.addAction(UIAlertAction(title: "By Title", style: .Default, handler: {(action) -> Void in
            self.reloadData("title")
        }))
        sheet.addAction(UIAlertAction(title: "By Director", style: .Default, handler: {(action) -> Void in
            self.reloadData("director")
        }))
        
       
        
        presentViewController(sheet, animated: true, completion: nil)
        
        
    }


    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath)

        // Configure the cell...
        let movie = movies[indexPath.row]
        
        //maps to title
        cell.textLabel?.text = movie.title
        
        //maps to subtitle
        cell.detailTextLabel?.text = movie.director


        

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if let itemsTableViewController =
            storyboard?.instantiateViewControllerWithIdentifier("MovieDetails") as?
                //casting to a shoppinglisttableviewcontroller (with as)_____________|^|
            MovieDetailViewController {
                
                //getting list selected to pass it to the new screen
                let list = movies[indexPath.row]
                
                itemsTableViewController.managedObjectContext = managedObjectContext
                itemsTableViewController.selectedMovie = list
                
                //heres the actual segue
                navigationController?.pushViewController(itemsTableViewController, animated: true)
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    

    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
