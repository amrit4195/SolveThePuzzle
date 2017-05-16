//
//  ViewController.swift
//  CoreDataExampleV
//
//  Created by Amritpal singh on 5/11/16.
//  Copyright (c) 2015 amritpal singh. All rights reserved.
//

import UIKit

import CoreData


class ViewController: UIViewController {

  
    @IBOutlet weak var txtLng: UITextField!
    @IBOutlet weak var txtLat: UITextField!
    @IBOutlet weak var txtDesc: UITextField!
    @IBOutlet weak var txtName: UITextField!
    
    @IBOutlet weak var img_Store: UIImageView!
  
    var store:Store?
  

    
    let moContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        if let s = store
        {
            txtName.text = s.sName
            txtDesc.text = s.sDesc
            txtLat.text =  s.sLat
            txtLng.text =  s.sLat
            img_Store.image = UIImage(data:s.sImage as Data)
        }
            

        
   
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    @IBAction func saveData(_ sender: AnyObject) {
        
        // Get the description of the entity 
        
        if store == nil
        {
            let storeDescription = NSEntityDescription.entity(forEntityName: "Store", in: moContext!)
        
        
            // Then, We Create the Managed Object to be  inserted into the cored data
            store = Store(entity: storeDescription!, insertInto: moContext)
        }
        
        // set the attributes
        store?.sName = txtName.text!
        store?.sDesc = txtDesc.text!
        store?.sLat  = txtLat.text!
        store?.sLng  = txtLng.text!
    
        
        // save the managed object into the storage
        
       
        let img = UIImage(named: "logo.jpeg")
        let imgData = UIImageJPEGRepresentation(img!, 1)
        store?.sImage = imgData!
        
        
        
        // Finally we issue the command to save the data
        var error: NSError?
        
        
        do {
            // Save The object
       
            try moContext?.save()
        } catch let error1 as NSError {
            error = error1
        }
        
        
        //Check if there is any erros
        
        if let err = error {
            
            let a = UIAlertView(title: "Error", message: err.localizedFailureReason, delegate: nil, cancelButtonTitle: "OK")
            a.show()
            
        } else {
            
            let a = UIAlertView(title: "Success", message: "Your Record is saved", delegate: nil, cancelButtonTitle: "OK")
            a.show()
            
            self.hideKB(self)
            
            
           // txtName.text = ""
        }

    
    
    }
    
    
    @IBAction func hideKB(_ sender: AnyObject) {
        
        
        for v in self.view.subviews
        {
            if v.isKind(of: UITextField.self)
            {
                v.resignFirstResponder()
            }
            
        }
        
    }
    
}

