//
//  DetailViewController.swift
//  SwiftyContact
//
//  Created by Demond Childers on 5/10/16.
//  Copyright © 2016 Demond Childers. All rights reserved.
//

import UIKit
import CoreData





class DetailViewController: UIViewController {
    
    
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    
    @IBOutlet weak var firstNameTextField   :UITextField!
    @IBOutlet weak var lastNameTextField    :UITextField!
    @IBOutlet weak var phoneTextField       :UITextField!
    @IBOutlet weak var addressTextField     :UITextField!
    @IBOutlet weak var emailTextField       :UITextField!
    
    
    var selectedEntry :Persons?
    var swiftyArray = [Persons]()
    
    
    
    
    
    
    //MARK: - Interactivity Methods

//    
//    -(void)saveAndPop {
//    [_appDelegate saveContext];
//    [self.navigationController popViewControllerAnimated:true];
//    
//    }
//    
//    
//    -(IBAction)saveButtonPressed:(id)sender {
//    NSLog(@"Save");
//    //    _currentPerson.personFirstName = _firstNameTextField.text;
//    _currentPerson.personLastName = _lastNameTextField.text;
//    _currentPerson.personBirthday = _birthdayPicker.date;
//    _currentPerson.personEmail = _emailTextField.text;
//    [self saveAndPop];
//    
//    }
//    
//    -(IBAction)deleteButtonPressed:(id)sender {
//    NSLog(@"Delete");
//    [_managedObjectContext deleteObject:_currentPerson];
//    [self saveAndPop];
//    
//    }
//    
    
    

    
    @IBAction func saveButtonPressed(button: UIBarButtonItem) {
        
        
    }
    
    @IBAction func deleteButtonPressed(button: UIBarButtonItem) {
        
        
    }
    

    
    
    
    
    //MARK: - Life Cycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Got \(selectedEntry?.personFirstName)")


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    




}