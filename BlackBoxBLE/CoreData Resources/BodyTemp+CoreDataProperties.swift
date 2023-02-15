//
//  BodyTemp+CoreDataProperties.swift
//  BlackBoxBLE
//
//  Created by Jacob  Loranger on 1/19/23.
//
//

import Foundation
import CoreData


extension BodyTemp {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BodyTemp> {
        return NSFetchRequest<BodyTemp>(entityName: "BodyTemp")
    }

    @NSManaged public var time: Date?
    @NSManaged public var data: Double

}

extension BodyTemp : Identifiable {

}
