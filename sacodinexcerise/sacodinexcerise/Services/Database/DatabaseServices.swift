//
//  DatabaseServices.swift
//  sacodinexcerise
//
//  Created by psagc on 24/07/24.
//

import CoreData
import Foundation

protocol DatabaseServicesType {
    func saveInspection(inspection: Inspection)
    func getCompletedInspection() -> [StoreInspection]
    func getDraftedInspection() -> [StoreInspection]
    func deleteInspection(byID id: Int)
    func deleteAllInspactions()
}

class DatabaseServices : DatabaseServicesType {
    
    
    static let shared = DatabaseServices()
    
    
    private let context = CoreDataStack.shared.context
    
    // Save a JSON file with the given ID and name
    func saveInspection(inspection: Inspection) {
        let newInspection = NSEntityDescription.insertNewObject(forEntityName: "StoredDataEntity", into: context)
        newInspection.setValue(Int64(inspection.id), forKey: "id")
        newInspection.setValue( inspection.area.name, forKey: "area")
        newInspection.setValue(inspection.inspectionType.name, forKey: "type")
        
        do {
            let inspectionData = try JSONEncoder().encode(inspection)
            newInspection.setValue(inspectionData, forKey: "data")
        } catch {
            fatalError(error.localizedDescription)
        }
        
        var numberOfQuestion: Int64 = 0
        var count: Int64 = 0
        inspection.survey.categories.enumerated().forEach { category in
            category.element.questions.forEach { queston in
                if queston.selectedAnswerChoiceID != nil {
                    count += 1
                }
                numberOfQuestion += 1
            }
        }
        
        newInspection.setValue(count, forKey: "questionAnswered")
        newInspection.setValue(numberOfQuestion, forKey: "numberOfQuestions")
        do {
            try context.save()
            print("Saved data with ID: \(inspection.id)")
        } catch {
            print("Failed to save data: \(error.localizedDescription)")
        }
    }
    
    func getAllStoredInspections() -> [NSManagedObject] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "StoredDataEntity")
        do {
            return try context.fetch(fetchRequest) as? [NSManagedObject] ?? []
        } catch {
            print("Failed to fetch data: \(error.localizedDescription)")
            return []
        }
    }
    
    func getAllOfflineInspections() -> [StoreInspection] {
        var inspectionData: [StoreInspection] = []
        for inspection in getAllStoredInspections() {
            inspectionData.append(StoreInspection(manageObject: inspection))
        }
        return inspectionData
        
    }
    
    func getCompletedInspection() -> [StoreInspection] {
        let completedInspection = getAllOfflineInspections().filter({$0.numberOfQuestions == $0.questionAnswered})
        return completedInspection
    }
    
    func getDraftedInspection() -> [StoreInspection] {
        let draftedInspection = getAllOfflineInspections().filter({$0.questionAnswered < $0.numberOfQuestions})
        return draftedInspection
    }
    
    func deleteInspection(byID id: Int) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "StoredDataEntity")
        fetchRequest.predicate = NSPredicate(format: "id == %ld", id)
        do {
            let results = try context.fetch(fetchRequest) as? [NSManagedObject] ?? []
            for object in results {
                context.delete(object)
            }
            try context.save()
            print("Deleted Inspection with ID: \(id)")
        } catch {
            print("Failed to delete Inspection: \(error.localizedDescription)")
        }
    }
    
    func deleteAllInspactions() {
        
        let entityNames = context.persistentStoreCoordinator?.managedObjectModel.entities.map({$0.name}) ?? []
        
         entityNames.forEach { [weak self] entityName in
             if let name = entityName {
                 let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: name)
                 let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)

                 do {
                     try self?.context.execute(deleteRequest)
                     try self?.context.save()
                 } catch {
                     // error
                     print("Error Deleteing all locatl data")
                 }
             }
            
        }
    }
}

