//
//  DataController.swift
//  BlackBoxBLE
//
//  Created by Jacob  Loranger on 1/24/23.
//

import Foundation
import CoreData
import UIKit

//    This class allows access to UIKit CoreData from a SwiftUI file
class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "BlackBoxBLE")
    var data = [BodyTemp]()
    
//    Creates Persistent Container
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("CoreData failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    
    
//    Pulls Managed object context from UIKit Framework
    func initContext() -> NSManagedObjectContext {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return context
    }
    
//    Fetches CoreData using UIKit Framework
    func fetchData(context: NSManagedObjectContext) -> [BodyTemp] {
        do {
            data = try context.fetch(BodyTemp.fetchRequest())
        } catch {
            print("couldnt fetch")
        }
        return data
    }
}
