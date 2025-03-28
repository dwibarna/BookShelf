//
//  LibraryBook+CoreDataProperties.swift
//  BookShelf
//
//  Created by Dwi Aji Sobarna on 28/03/25.
//
//

import Foundation
import CoreData


extension LibraryBook {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LibraryBook> {
        return NSFetchRequest<LibraryBook>(entityName: "LibraryBook")
    }

    @NSManaged public var title: String?
    @NSManaged public var author: String?
    @NSManaged public var isRead: Bool
    @NSManaged public var dateAdded: Date?

}

extension LibraryBook : Identifiable {

}
