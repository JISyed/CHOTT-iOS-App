//
//  CoreDataService.swift
//  Chott
//
//  Created by Jibran Syed on 2/24/18.
//  Copyright © 2018 Jishenaz. All rights reserved.
//

import Foundation
import CoreData

class CoreDataService
{
    private init(){}
    
    
    
    /// Creates a new object managed by Core Data. Does not save, you must do that yourself! (Call `CoreDataService.saveContext()`)
    static func makeNewEntity<T>(ofType entityType: T.Type) -> T where T : NSManagedObject 
    {
        let newEntity = T(context: CoreDataService.context)
        return newEntity
    }
    
    /// Deletes the given object managed by Core Data. Does not save, you must do that yourself! (Call `CoreDataService.saveContext()`)
    static func deleteEntity<T>(ofType entityType: T.Type, entity: T) where T : NSManagedObject
    {
        CoreDataService.context.delete(entity)
    }
    
    
    
    static func loadEntities<T>(ofType entityType: T.Type, onComplete: @escaping (_ entities: [T]?) -> Void) where T : NSFetchRequestResult
    {
        let fetchRequest = NSFetchRequest<T>(entityName: "\(T.self)")
        
        var foundEntities: [T]? = nil
        
        do
        {
            foundEntities = try CoreDataService.context.fetch(fetchRequest)
            onComplete(foundEntities)
        }
        catch
        {
            debugPrint("Could not fetch entites of type \(T.self): \(error.localizedDescription)")
            onComplete(nil)
        }
    }
    
    
    
    
    // MARK: - Core Data stack
    
    
    /// Container for all CoreData objects that will be saved
    static var context: NSManagedObjectContext
    {
        return persistentContainer.viewContext
    }
    
    
    private static var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Chott")    // Name must be same as project's name
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    
    
    // MARK: - Core Data Saving support
    
    static func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
}
