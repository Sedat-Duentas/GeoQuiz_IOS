//
//  EuropeCountriesRepository.swift
//  GeoQuizApp
//
//  Created by Sedat Düntas on 15.09.23.
//

import Foundation

class CountriesRepository {
    
    // Funktion zum Abrufen von Ländern für einen bestimmten Kontinent
    func fetchCountries(for continent: String, completion: @escaping ([Country]) -> Void) {
        // Erstellen Sie eine URL für die API-Anfrage
        guard let url = URL(string: "https://public.syntax-institut.de/apps/batch6/SedatDuentas/data.json") else {
            return
        }
        
        // Starten Sie eine URLSession-Anfrage, um Daten von der API abzurufen
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    // Dekodieren Sie die empfangenen JSON-Daten
                    let decodedData = try JSONDecoder().decode([String: [Country]].self, from: data)
                    
                    // Extrahieren Sie die Länder für den angegebenen Kontinent
                    if let countries = decodedData[continent] {
                        completion(countries)
                    }
                } catch {
                    print("Error decoding JSON \(error)")
                }
            }
        }.resume() // Starten Sie die URLSession-Anfrage
    }
    
    // Funktion zum Abrufen aller Länder für alle Kontinente
    func fetchAllCountries(completion: @escaping ([Country]) -> Void) {
        let continents = ["europe", "asia", "africa", "northAmerica", "southAmerica", "oceania"]
        var allCountries: [Country] = []
        
        let dispatchGroup = DispatchGroup()
        
        for continent in continents {
            dispatchGroup.enter()
            
            // Rufen Sie Länder für jeden Kontinent separat ab und fügen Sie sie zur allCountries-Liste hinzu
            fetchCountries(for: continent) { countries in
                allCountries.append(contentsOf: countries)
                dispatchGroup.leave()
            }
        }
        
        // Benachrichtigen Sie den Aufrufer, wenn alle Länder für alle Kontinente abgerufen wurden
        dispatchGroup.notify(queue: .main) {
            completion(allCountries)
        }
    }
}
