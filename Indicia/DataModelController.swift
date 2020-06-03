//
//  DataModelController.swift
//  Indicia
//
//  Created by Gambrell, John on 4/22/15.
//  Copyright (c) 2015 Gambrell, John. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

struct GuidePostStruct {
    let imageName : String
    let type : Int
    let tags :String
    let location : CLLocation
    let date : NSDate
   }

enum CDResponse {
    case Success
    case Error
}

class DataModelController: NSObject {
    
    class var sharedInstance : DataModelController{
        
        struct Singleton {
            static let instance = DataModelController()
            
        }
        return Singleton.instance
    }
    
    override init() {
        super.init()
        
    }
    
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: NSURL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1] as NSURL
        }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = Bundle.main.url(forResource: "IndiciaModel", withExtension: "momd")!
        
        return NSManagedObjectModel(contentsOf: modelURL)!
        }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        
        // Create the coordinator and store
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("IndiciaModel.sqlite")
        print(url as Any)
        var error: NSError? = nil
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator!.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch var error1 as NSError {
            error = error1
            coordinator = nil
            // Report any error we got.
            let dict = NSMutableDictionary()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            dict[NSUnderlyingErrorKey] = error
           // error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict as [NSString : NSString])
            
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
           // NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort()
        } catch {
            fatalError()
        }
        
        return coordinator
        }()
    
    lazy var managedObjectContext: NSManagedObjectContext? = {
        
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
        }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if let moc = self.managedObjectContext {
            var error: NSError? = nil
            if moc.hasChanges {
                do {
                    try moc.save()
                } catch let error1 as NSError {
                    error = error1
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    NSLog("Unresolved error \(String(describing: error)), \(error!.userInfo)")
                    abort()
                }
            }
        }
    }
    
    func fetchGuidePostsForCollectionView()->NSArray {
        let fetchGPArray:NSMutableArray = [["sectionTitle":"Recent", "collectionData" : fetchAllGuidePosts()]]

        fetchGPArray.add(["sectionTitle":"Documents", "collectionData" : fetchGuidePostByType(gtype: .Document)] as NSDictionary)
        fetchGPArray.add(["sectionTitle":"Locations", "collectionData" : fetchGuidePostByType(gtype: .Location)] as NSDictionary)
        
        return fetchGPArray
    }
    
    func fetchGuidePostByType(gtype:GuidePostType)->[GuidePost]{
        // var error: NSError?
        do {
            
       
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GuidePost")
        fetchRequest.predicate = NSPredicate(format: "type = %i", gtype.rawValue)
        
            let fetchedResults = try managedObjectContext!.fetch(fetchRequest) as? [GuidePost]
        
        if let results = fetchedResults{
            return results
        }
//        else{
//            print("Error on Fetch All GPs")
//            return []
//        }
        }
        catch {
             print("Error on Fetch All GPs")
        }
        return []
        
    }
   
    
    func fetchAllGuidePosts() -> [GuidePost] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GuidePost")

        do {
            let fetchedResults =  try managedObjectContext!.fetch(fetchRequest) as? [GuidePost]
        
        if let results = fetchedResults{
            return results
        }
        }
        catch{
            print("Error on Fetch All GPs")
        }
    return []
    }
    
    //Mark: App DB funcs
    
    func insertGuidepost(inGP : GuidePostStruct) -> CDResponse{
        
       // let managedContext = DataModelController.sharedInstance.managedObjectContext!
        
        let entity = NSEntityDescription.entity(forEntityName: "GuidePost", in: managedObjectContext!)
        
        let gp = GuidePost(entity: entity!, insertInto: managedObjectContext)
        
        gp.imageName = inGP.imageName
        gp.type = NSNumber(value: inGP.type)
        gp.tags = inGP.tags
        gp.latitiude = NSNumber(value: inGP.location.coordinate.latitude)
        gp.longitude = NSNumber(value: inGP.location.coordinate.longitude)
        gp.date = NSDate()
        
        do {
            try managedObjectContext!.save()
            return .Success
           
        } catch let error as NSError {
            print("CD Save Error: \(error.description)")
            return .Error
        }

    }
    
}
