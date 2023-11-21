//
//  CategoriesViewModel.swift
//  GeoQuizApp
//
//  Created by Sedat Düntas on 28.09.23.
//

import Foundation

class GameSelectionViewModel: ObservableObject {
    // Eine veröffentlichte Eigenschaft zur Speicherung der ausgewählten Spielkategorie
    @Published var category: GameOption = .flags
    
    // Eine veröffentlichte Eigenschaft zur Speicherung des ausgewählten Kontinents
    @Published var continent: ContinentOption?
    
    // Eine berechnete Eigenschaft, die prüft, ob ein Spiel ausgewählt wurde
    var gameSelected: Bool {
        // Das Spiel wird als ausgewählt betrachtet, wenn ein Kontinent ausgewählt wurde
        return continent != nil
    }
}
