//
//  StoreListTVC.swift
//  CoreDataExampleV
//
//  Created by Ali Farhat on 4/30/15.
//  Copyright (c) 2015 ali farhat. All rights reserved.
//

import UIKit

import CoreData


class StoreListTVC: UITableViewController {

    
    let moContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    
    var stores = [Store]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Store")
        
        stores  = (try! moContext?.fetch(request)) as! [Store]
    
        self.tableView.reloadData()
        
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        return stores.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) 

        // Configure the cell...
        
        let store = stores[indexPath.row]
        cell.textLabel?.text = store.sName
        cell.detailTextLabel?.text = store.sDesc
        cell.imageView?.image = UIImage(data: store.sImage as Data)

        
        return cell
    }
    

  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        
        if segue.identifier == "editStore"
        {
            let v = segue.destination as! ViewController
            
            let indexpath = self.tableView.indexPathForSelectedRow
            let row = indexpath?.row
            
            v.store = stores[row!]
            
        
        }
        
        
    }


    /******************************************************************************
     *
     * This function search core data
     *
     ******************************************************************************/

     func filterStores(_ searchText: String)
     {
        
       
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Store")
        
        let predicate = NSPredicate(format: "sName  contains %@", searchText)
       
        request.predicate = predicate
        
        stores  = (try! moContext?.fetch(request)) as! [Store]
        
        self.tableView.reloadData()

        
       // let predicate1 = NSCompoundPredicate(type: NSCompoundPredicateType.OrPredicateType, subpredicates: [predicate, predicate])
        
       
        
        
     }
    
    
    /******************************************************************************
    *
    * This function Display Action Controller to get the store name
    *
    ******************************************************************************/
    
    
   

    @IBAction func searchRecords(_ sender: AnyObject) {
        
        
            
            
            // create the alert controller
            
            let v = UIAlertController(title: "Search", message: "Enter enter part of store name", preferredStyle: UIAlertControllerStyle.alert)
            
            
            // Add the text field
            
            v.addTextField { (storeName:UITextField!) -> Void in
                
                storeName.placeholder = "Store Name"
                
            }
            
            
            // Create the button - Alert Action
            
            let okAc = UIAlertAction(title: "Search", style: UIAlertActionStyle.default)
                { (alert: UIAlertAction) in
                    
                    let storeName = v.textFields![0] 
                    
                    self.filterStores(storeName.text!)
                    
                    v.dismiss(animated: true, completion: nil)
            }
            
            
            // Add it to the controller
            
            v.addAction(okAc)
            
            
            // only one cancel action style allowed
            
            let cancelAc = UIAlertAction(title: "cancel", style: UIAlertActionStyle.cancel) { (alert: UIAlertAction) in
                
                v.dismiss(animated: true, completion: nil)
                
            }
            
            v.addAction(cancelAc)
            
            present(v, animated: true , completion: nil)
            
            
        }
        

    
    
    

}
