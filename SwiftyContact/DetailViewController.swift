//
//  DetailViewController.swift
//  SwiftyContact
//
//  Created by Demond Childers on 5/10/16.
//  Copyright © 2016 Demond Childers. All rights reserved.
//

import UIKit
import CoreData
import Contacts
import ContactsUI







class DetailViewController: UIViewController, CNContactPickerDelegate, CNContactViewControllerDelegate {
    
//    CNContactPickerDelegate, CNContactViewControllerDelegate
    
    
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    
    @IBOutlet weak var firstNameTextField       :UITextField!
    @IBOutlet weak var lastNameTextField        :UITextField!
    @IBOutlet weak var phoneTextField           :UITextField!
    @IBOutlet weak var addressTextField         :UITextField!
    @IBOutlet weak var emailTextField           :UITextField!
    @IBOutlet weak private var ratingStackView  :UIStackView!


    
    var selectedEntry :Persons?
//    var contactStore = CNContactStore()


    
   
    
    
    //MARK: - Stack View Methods
    

    private func addStar() {
        let starImageView = UIImageView(image: UIImage(named: "IconStar"))
        starImageView.contentMode = .ScaleAspectFit
        let starcount = ratingStackView.arrangedSubviews.count
        if starcount < 10{
            ratingStackView.insertArrangedSubview(starImageView, atIndex: starcount - 1)
            UIView.animateWithDuration(0.25) { () -> Void in
                self.ratingStackView.layoutIfNeeded()
            }
        }
    }
    
    
    
    @IBAction func addButtonPressed(sender: UIButton) {
        print("Add")
        let starImageView = UIImageView(image: UIImage(named: "IconStar"))
        starImageView.contentMode = .ScaleAspectFit
        let starCount = ratingStackView.arrangedSubviews.count
        ratingStackView.insertArrangedSubview(starImageView, atIndex: starCount - 1)
            
    
    
        UIView.animateWithDuration(0.25) { () -> Void in
            self.ratingStackView.layoutIfNeeded()
            
            
            
        }
        
    }
    
    @IBAction func removeButtonPressed(sender: UIButton) {
        print("Remove")
        let starCount = ratingStackView.arrangedSubviews.count
        if starCount  > 0 {
            let starToRemove = ratingStackView.arrangedSubviews[starCount - 2]
            ratingStackView.removeArrangedSubview(starToRemove)
            starToRemove.removeFromSuperview()
            UIView.animateWithDuration(0.25) { () -> Void in
                self.ratingStackView.layoutIfNeeded()
                
            }
        }
    }
    
    
    //MARK: - Interactivity Methods

    func saveAndPop() {
        appDelegate.saveContext()
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    

    
    @IBAction func saveButtonPressed(button: UIBarButtonItem) {
        print("Save Contact")
        selectedEntry!.personFirstName = firstNameTextField.text
        selectedEntry!.personLastName = lastNameTextField.text
        selectedEntry!.personEmail =  emailTextField.text
        selectedEntry!.personPhone = phoneTextField.text
        selectedEntry!.personAddress = addressTextField.text
        selectedEntry!.personRating = ratingStackView.arrangedSubviews.count - 1
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
        }
        if let selContact = selectedEntry {
            emailTextField.text = selContact.personEmail
        } else {
            emailTextField.text = ""
        }
//        if let selContact = selectedEntry {
//            ratingStackView.arrangedSubviews.count = selContact.personRating
//        } else {
//            ratingStackView.arrangedSubviews.count
//                for _ in 0..< rating
//                self.addStar()
        
            
        
    
            
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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
//                self.refreshDataAndTable()
        
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

