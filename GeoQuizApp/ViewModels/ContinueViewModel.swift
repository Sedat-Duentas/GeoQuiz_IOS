//
//  ContinueViewModel.swift
//  GeoQuizApp
//
//  Created by Sedat Düntas on 28.09.23.
//

import Foundation

// ViewModel für die 'ContinueView', das die Liste der abgeschlossenen Spiele verwaltet
class ContinueViewModel: ObservableObject {
    @Published var games = [Game]() // Eine Liste, um die abgeschlossenen Spiele zu speichern
    @Published var currentGame: Game? // Eine Eigenschaft zur Verfolgung des aktuellen Spiels
    
    // Initialisierer des ViewModels
    init() {
        fetchgame() // Beim Initialisieren des ViewModels die Spiele abrufen
    }
    
    // Funktion zum Abrufen der Spiele aus dem Persistent Store
    func fetchgame() {
        let allGames = PersistentStore.shared.fetchLastPlayedGames() // Alle gespeicherten Spiele abrufen
        
        // Filtern Sie die Spiele, bei denen nicht alle Fragen beantwortet wurden
        games = allGames.filter { $0.answercount != $0.countries }
    }
    
    // Funktion zum Löschen eines Spiels
    func deleteGame(game: Game) {
        PersistentStore.shared.context.delete(game) // Das Spiel aus dem CoreData-Kontext löschen
        PersistentStore.shared.save() // Die Änderungen im Persistent Store speichern
        
        fetchgame() // Die Liste der Spiele aktualisieren, um das gelöschte Spiel zu entfernen
    }
}
