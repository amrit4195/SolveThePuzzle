//
//  Store.swift
//  SolveThePuzzle
//
//  Created by Amritpal Singh on 15/5/17.
//  Copyright © 2017 Deakin University. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class Store: NSManagedObject {
    @NSManaged var sTime: String
    @NSManaged var sImage: Data
    @NSManaged var sName: String
}
