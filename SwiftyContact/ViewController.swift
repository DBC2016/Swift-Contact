//
//  ViewController.swift
//  SwiftyContact
//
//  Created by Demond Childers on 5/10/16.
//  Copyright © 2016 Demond Childers. All rights reserved.
//

import UIKit
import CoreData
import Contacts
import ContactsUI

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CNContactPickerDelegate, CNContactViewControllerDelegate {
    
    
    
    
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var swiftyArray = [Persons]()
    var contactStore = CNContactStore()

    @IBOutlet weak private var contactTableView :UITableView!
    @IBOutlet weak private var myPicker :UIPickerView!
    

    
      
    
    
    //MARK: - Interactivity Methods
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destController = segue.destinationViewController as! DetailViewController
        if segue.identifier == "seeSelectedContact" {
            //
            let indexPath = contactTableView.indexPathForSelectedRow
            let selectedEntry = swiftyArray[indexPath!.row]
            destController.selectedEntry = selectedEntry
            contactTableView.deselectRowAtIndexPath(indexPath!, animated: true)
            
        } else if segue.identifier == "addNewContact" {
            destController.selectedEntry = nil
            
        }
        
    }
    
    
    @IBAction private func showContactList(sender: UIBarButtonItem) {
        print("Show Contact List")
        let contactLIstVC = CNContactPickerViewController()
        contactLIstVC.delegate = self
        presentViewController(contactLIstVC, animated: true, completion: nil)
    }
    
    func contactPicker(picker: CNContactPickerViewController, didSelectContact contact: CNContact) {
        let fullname = CNContactFormatter.stringFromContact(contact, style: .FullName)
        print("Name: \(contact.givenName) \(contact.familyName) OR \(fullname)")
        
        for email in contact.emailAddresses {
            print("Email (" + CNLabeledValue.localizedStringForLabel(email.label) + "):" + (email.value as! String))
            
        }
        
        for phone in contact.phoneNumbers {
            print("Phone (" + CNLabeledValue.localizedStringForLabel(phone.label) + "):" + (phone.value as! CNPhoneNumber).stringValue)
        }
        
    }
    
    
    private func presentContactMatchingName(name: String) {
        let predicate = CNContact.predicateForContactsMatchingName(name)
        let keysToFetch = [CNContactViewController.descriptorForRequiredKeys()]
        do {
            let contacts = try contactStore.unifiedContactsMatchingPredicate(predicate, keysToFetch: keysToFetch)
            if let firstContact = contacts.first {
                print("Contact: " + firstContact.givenName)
                displayContact(firstContact)
            }
        } catch {
            print("Error")
            
        }
        
    }
    
    private func displayContact(contact: CNContact) {
        let contactVC = CNContactViewController(forContact: contact)
        contactVC.contactStore = contactStore
        contactVC.delegate = self
        navigationController!.pushViewController(contactVC, animated: true)
        
    }
    
    func contactViewController(viewController: CNContactViewController, didCompleteWithContact contact: CNContact?) {
        print("Done With: \(contact!.familyName)")
        
    }
    
    

    //MARK: - Table View Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return swiftyArray.count
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let currentEntry = swiftyArray[indexPath.row]
        cell.textLabel!.text = currentEntry.personFirstName! + " " + currentEntry.personLastName!
        cell.detailTextLabel!.text = "\(currentEntry.personPhone!)"
        
        return cell
        
    }
    
    //Edit Table View aka Swipe Feature
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .Destructive, title: "Delete") { (action, indexPath) in
            let personToDelete = self.swiftyArray[indexPath.row];
            self.managedObjectContext.deleteObject(personToDelete)
            self.appDelegate.saveContext()
            self.refreshDataAndTable()
        }
        return [deleteAction]
    }
    
    // REFERESHES AFTER RETURNING TO TABLE VIEW
    
    
    func refreshDataAndTable() {
        swiftyArray = self.fetchPersons()!
        contactTableView.reloadData()
        
    }
    
    
    
    //MARK: - Core Data Methods
    
    
    //ADD TEMP RECORDS
    
    func tempAddRecords() {
        
        let entityDescription = NSEntityDescription.entityForName("Persons", inManagedObjectContext: managedObjectContext)!
        
        let newPerson = Persons(entity: entityDescription, insertIntoManagedObjectContext: managedObjectContext)
        newPerson.personFirstName = "Demond"
        newPerson.personLastName = "Childers"
        newPerson.personPhone = "313-350-8099"
        newPerson.personEmail = "childers2032@gmail.com"
        newPerson.personAddress = "19491 Burt Rd"
        
        
        let newPerson2 = Persons(entity: entityDescription, insertIntoManagedObjectContext: managedObjectContext)
        newPerson2.personFirstName = "Jason"
        newPerson2.personLastName = "Bourne"
        newPerson2.personPhone = "313-350-9900"
        newPerson2.personEmail = "bourneidentity@gmail.com"
        newPerson2.personAddress = "99000 Harvest Ln"
        
        
        let newPerson3 = Persons(entity: entityDescription, insertIntoManagedObjectContext: managedObjectContext)
        newPerson3.personFirstName = "Barack"
        newPerson3.personLastName = "Obama"
        newPerson3.personPhone = "555-440-1906"
        newPerson3.personEmail = "barryobama@whitehouse.gov"
        newPerson3.personAddress = "1600 Pennsylvania Ave"
        appDelegate.saveContext()
    }
    
    
    //FETCH REQUEST
    
    func fetchPersons() -> [Persons]? {
        let fetchRequest = NSFetchRequest(entityName: "Persons")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "personFirstName", ascending: false)]
        
        do {
            let tempArray = try managedObjectContext.executeFetchRequest(fetchRequest) as! [Persons]
            return tempArray
        } catch {
            return nil
        }
        
        
    }
    
    
    //MARK: - Contact Methods
    
    

    


    //MARK:  - Life Cycle Methods
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tempAddRecords()

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.refreshDataAndTable()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

