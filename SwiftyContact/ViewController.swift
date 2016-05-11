//
//  ViewController.swift
//  SwiftyContact
//
//  Created by Demond Childers on 5/10/16.
//  Copyright © 2016 Demond Childers. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var swiftyArray = [Persons]()
    @IBOutlet weak var contactTableView :UITableView!
    
    
    
    
    
    
    
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

    //MARK: - Table View Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return swiftyArray.count
    }
    
    
    
    
    
   
    
    //REFERENCE FOR CUSTOM TABLE VIEW METHODS
    
    //NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //formatter.dateFormat = @"MMMM d, yyyy";
    //cell.birthdayLabel.text= [formatter stringFromDate:currentPerson.personBirthday];
    ////    cell.detailTextLabel.text = [formatter stringFromDate:currentPerson.personBirthday];
    //[cell.niceSwitch setOn:[currentPerson.personNice boolValue]];
    //
    //return cell;
    //}

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let currentEntry = swiftyArray[indexPath.row]
        cell.textLabel!.text = currentEntry.personFirstName! + " " + currentEntry.personLastName!
        cell.detailTextLabel!.text = "\(currentEntry.personPhone!)"
        
        
        
        return cell
        
    }
    
    //Edit Table View
    
//    tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
//    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"Delete" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//    NSLog(@"Delete");
//    Person *personToDelete = _personsArray[indexPath.row];
//    [_manageObjectContext deleteObject:personToDelete];
//    [_appDelegate saveContext];
//    [self refreshDataAndTAble];
//    }];
//    return @[deleteAction];
//    
//    }
//    
    
//    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]?
    
    
    
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

