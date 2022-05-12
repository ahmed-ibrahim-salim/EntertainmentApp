//
//  CoreDataModel.swift
//  NewUI-UIKit
//
//  Created by Ahmad medo on 10/05/2022.
//
import UIKit
import CoreData

class CoreDataModel{
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func AddToCoreD(entityName: String) -> NSManagedObject {
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)!
        let item = NSManagedObject(entity: entity, insertInto: context)
        return item
    }
    
    func removeFromCoreD(item: NSManagedObject){
        context.delete(item)
        do {
            try context.save()
            print("deletion is successfull")
        } catch  {
            print("deletion error")
        }
    }

    func fetch(entityName:String) -> [NSManagedObject]{
        var data = [NSManagedObject]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do {
            if let dataArr = try context.fetch(fetchRequest) as? [NSManagedObject]{
                data = dataArr
            }else {
                print("No Data from fetch request")
            }
        } catch  {
            print("No Data from fetch request")
        }
        return data
    }
}
