//
//  Store.swift
//  CoreDataExampleV
//
//  Created by Amritpal singh on 5/11/16.
//  Copyright (c) 2015 amritpal singh. All rights reserved.
//

import Foundation
import CoreData

class Store: NSManagedObject {

    @NSManaged var sName: String
    @NSManaged var sDesc: String
    @NSManaged var sImage: Data
    @NSManaged var sLat: String
    @NSManaged var sLng: String

}
