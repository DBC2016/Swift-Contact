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
    
    
    
    
    
    
    //MARK: - Interactivity Methods

    func saveAndPop() {
        appDelegate.saveContext()
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    

    
    @IBAction func saveButtonPressed(button: UIBarButtonItem) {
        print("Save Contact")
        selectedEntry?.personFirstName = firstNameTextField.text
        selectedEntry?.personLastName = lastNameTextField.text
        selectedEntry?.personEmail =  emailTextField.text
        selectedEntry?.personPhone = phoneTextField.text
        selectedEntry?.personAddress = addressTextField.text
        self.saveAndPop()
        
        
    
        
    }
    
    @IBAction func deleteButtonPressed(button: UIBarButtonItem) {
        print("Delete Contact")
        if let selEntry = selectedEntry{
            managedObjectContext.deleteObject(selEntry)
            self.saveAndPop()
        }
        
        
    }
    
  
        
        
    func personLoadUp() {
        
        if let selContact = selectedEntry {
            firstNameTextField.text = selContact.personFirstName
        } else {
            firstNameTextField.text = ""
        }
        if let selContact = selectedEntry {
            lastNameTextField.text = selContact.personLastName
        } else {
            lastNameTextField.text = ""
        }
        if let selContact = selectedEntry {
            phoneTextField.text = selContact.personPhone
        } else {
            phoneTextField.text = ""
        }
        if let selContact = selectedEntry {
            addressTextField.text = selContact.personAddress
        } else {
            addressTextField.text = ""
            if let selContact = selectedEntry {
                emailTextField.text = selContact.personEmail
            }
            
        }

        
    }

    
    //MARK: - Life Cycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        if selectedEntry != nil{
            self.personLoadUp()
        
        } else {
            let entityDescription = NSEntityDescription.entityForName("Persons", inManagedObjectContext: managedObjectContext)!
            selectedEntry = Persons(entity: entityDescription, insertIntoManagedObjectContext: managedObjectContext)
            self.personLoadUp()
        }
           }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if managedObjectContext.hasChanges {
            managedObjectContext.rollback()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    


}

