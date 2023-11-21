//
//  Country.swift
//  GeoQuizApp
//
//  Created by Sedat Düntas on 11.09.23.
//

import Foundation

struct Country: Codable, Identifiable {
    let id = UUID() // Identifiable erfordert ein id-Attribut
    
    // Eigenschaften, die Informationen über ein Land enthalten
    let country: String     // Der Name des Landes
    let capital: String     // Die Hauptstadt des Landes
    let language: String    // Die offizielle Sprache des Landes
    let flag: String        // Der Dateiname oder Pfad zur Flagge des Landes
    let currency: String    // Die Währung des Landes
}
