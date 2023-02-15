//
//  saveData.swift
//  BlackBoxBLE
//
//  Created by Jacob  Loranger on 1/19/23.
//

import Foundation
import CoreData
import UIKit

// Retrieve new Data Point from bluetooth peripheral
// Reference CoreData model and save new data point

class DatabaseHandler {
    let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func add<T: NSManagedObject>(_type: T.Type) -> T? {
        guard let entityName = T.entity().name else { return nil}
        guard let entity = NSEntityDescription.entity(forEntityName: entityName , in: viewContext) else { return nil }
        let object = T(entity: entity, insertInto: viewContext)
        return object
    }
    
    func save() {
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
        
    }
}
