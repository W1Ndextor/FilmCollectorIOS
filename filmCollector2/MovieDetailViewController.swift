//
//  MovieDetailViewController.swift
//  filmCollector2
//
//  Created by student on 5/3/16.
//  Copyright © 2016 Josh. All rights reserved.
//

import UIKit
import CoreData

class MovieDetailViewController: UIViewController {
    
    var managedObjectContext: NSManagedObjectContext!
    var selectedMovie: Student?
    var student: Student?

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var directorTextField: UITextField!
    @IBOutlet weak var ratingTextField: UITextField!
    @IBOutlet weak var genreTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let selectedMovie = selectedMovie{
            titleTextField.text = selectedMovie.fname
            directorTextField.text = selectedMovie.lname
            ratingTextField.text = selectedMovie.course
            genreTextField.text = selectedMovie.gpa
            
            title = "Update Student"
            
        } else {
            title = "Add Student"
        }

        }
    
    override func viewWillDisappear(animated: Bool) {
     
        if let selectedMovie = selectedMovie, fname = titleTextField.text, lname = directorTextField.text, course = ratingTextField.text, gpa = genreTextField.text {
            selectedMovie.fname = fname
            selectedMovie.lname = lname
            selectedMovie.course = course
            selectedMovie.gpa = gpa
        } else if selectedMovie == nil {
            
            if let fname = titleTextField.text, lname = directorTextField.text, course = ratingTextField.text, gpa = genreTextField.text, entity = NSEntityDescription.entityForName("Student", inManagedObjectContext: managedObjectContext) where !fname.isEmpty && !lname.isEmpty && !gpa.isEmpty && !course.isEmpty {
                
                
            student = Student(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
                
                student?.fname = fname
                student?.lname = lname
                student?.course = course
                student?.gpa = gpa
        }
        
        }
        do{
            try managedObjectContext.save()
        } catch {
            print("Error saving the managed object context!")
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
