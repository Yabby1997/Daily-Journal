//
//  Entry+CoreDataProperties.swift
//  Daily Journal
//
//  Created by yabby on 2021/02/16.
//
//

import Foundation
import CoreData


extension Entry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entry> {
        return NSFetchRequest<Entry>(entityName: "Entry")
    }

    @NSManaged public var date: Date?
    @NSManaged public var text: String?

}

extension Entry : Identifiable {

}
