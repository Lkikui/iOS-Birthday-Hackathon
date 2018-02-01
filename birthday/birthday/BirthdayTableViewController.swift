//
//  BirthdayTableViewController.swift
//  birthday
//
//  Created by Maria Teresa Rojo on 1/31/18.
//  Copyright © 2018 Maria Rojo. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications


class BirthdayTableViewController: UITableViewController, AddBirthdayDelegate {

    var birthdays = [BirthdayItem]()
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {

        let center = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .badge];

        center.requestAuthorization(options: options) {
            (granted, error) in
            if !granted {
                print("Something went wrong")
            }
        }
        
        center.getNotificationSettings { (settings) in
            if settings.authorizationStatus != .authorized {
                // Notifications not allowed
            }
        }
        
        
        super.viewDidLoad()
        fetchAll()
        
        // Add Shadow to navigation bar
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.8
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return birthdays.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell

        let formatter1 = DateFormatter()
        formatter1.dateFormat = "MMM"
        
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "d"
        
        cell.nameLabel.text = birthdays[indexPath.row].name
        cell.giftListLabel.text = birthdays[indexPath.row].gifts
        cell.monthLabel.text = formatter1.string(from: birthdays[indexPath.row].date!)
        cell.dayLabel.text = formatter2.string(from: birthdays[indexPath.row].date!)

        return cell
    }
    
    func fetchAll() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BirthdayItem")
        do {
            let result = try managedObjectContext.fetch(request)
            birthdays = result as! [BirthdayItem]
            birthdays = birthdays.sorted(by: { (a, b) -> Bool in
                return a.date! < b.date!;
        })
            
        }catch {
            print("\(error)")
        }
        tableView.reloadData()
    }
    
    func save(_ controller: AddEditViewController, with name: String, gifts: String, and date: Date, at indexPath: IndexPath?) {
        if let ip = indexPath {
            let item = birthdays[ip.row]
            item.name = name
            item.gifts = gifts
            item.date = date
        } else {
            let item = NSEntityDescription.insertNewObject(forEntityName: "BirthdayItem", into: managedObjectContext) as! BirthdayItem
            item.name = name
            item.gifts = gifts
            item.date = date
            birthdays.append(item)
        }
        do {
            try managedObjectContext.save()
        } catch {
            print("\(error)")
        }
        dismiss(animated: true, completion: nil)
        fetchAll()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "addSegue", sender: indexPath)
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let item = birthdays[indexPath.row]
        managedObjectContext.delete(item)
        
        do {
            try managedObjectContext.save()
        } catch {
            print("\(error)")
        }
        birthdays.remove(at: indexPath.row)
        fetchAll()
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let addEditViewController = navigationController.topViewController as! AddEditViewController
        addEditViewController.delegate = self
        
        if let indexPath = (sender as? IndexPath) {
            addEditViewController.name = birthdays[indexPath.row].name
            addEditViewController.gifts = birthdays[indexPath.row].gifts
            addEditViewController.date = birthdays[indexPath.row].date
            addEditViewController.indexPath = indexPath
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
   

}
