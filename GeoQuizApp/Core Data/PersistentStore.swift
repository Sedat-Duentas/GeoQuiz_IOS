//
//  PersistentStore.swift
//  GeoQuizApp
//
//  Created by Sedat Düntas on 07.09.23.
//

import Foundation
import CoreData

// Dies ist eine Singleton-Klasse, die den Zugriff auf den Core Data Persistent Store verwaltet.
struct PersistentStore {
    
    static let shared = PersistentStore()
    
    // Initialisierung der PersistentStore-Instanz.
    init() {
        // Erstellen einer NSPersistentContainer mit dem Namen "DataModel".
        container = NSPersistentContainer(name: "DataModel")
        
        // Konfigurieren der automatischen Zusammenführung von Änderungen aus übergeordneten Kontexten.
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        // Laden der Persistent Stores für die Core Data-Verwaltung.
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Error with Core Data: \(error), \(error.userInfo)")
            }
        }
    }
    
    // MARK: - Variables
    
    private let container: NSPersistentContainer
    var context: NSManagedObjectContext { container.viewContext }
    
    // MARK: - Functions
    
    // Speichern aller ausstehenden Änderungen im Core Data-Context.
    func save() {
        guard context.hasChanges else { return }
        
        do {
            try context.save()
        } catch let error as NSError {
            NSLog("Unresolved error saving context: \(error), \(error.userInfo)")
        }
    }
    
    // Abrufen der zuletzt gespielten Spiele aus dem Persistent Store, sortiert nach Datum absteigend und begrenzt auf 20 Spiele.
    func fetchLastPlayedGames() -> [Game] {
        let fetchRequest: NSFetchRequest<Game> = Game.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        fetchRequest.fetchLimit = 20

        do {
            return try context.fetch(fetchRequest)
        } catch {
            NSLog("Error fetching last played games: \(error)")
            return []
        }
    }
}
