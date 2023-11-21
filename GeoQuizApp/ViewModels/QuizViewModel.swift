//
//  QuizViewModel.swift
//  GeoQuizApp
//
//  Created by Sedat Düntas on 04.10.23.
//

import Foundation
import SwiftUI

class QuizViewModel: ObservableObject {
    
    // MARK: - Variables
    
    // Beobachtbare Eigenschaften, die in der View angezeigt und aktualisiert werden
    @Published var countries: [Country] = []
    @Published var index = 1
    @Published var currentCountry: Country? = nil
    @Published var flagURL: URL? // Die URL der aktuellen Flagge wird hier gespeichert
    @Published var randomCountries: [String] = [] // Die zufälligen Ländernamen für die Buttons, werden hier gespeichert
    @Published var randomCities: [String] = [] // Die zufälligen Länderstädte für die Buttons, werden hier gespeichert
    @Published var randomCurrencies: [String] = [] // Die zufälligen Währungen für die Buttons, werden hier gespeichert
    @Published var categoryName = ""
    @Published var continentName = ""
    @Published var score: Int = 0
    @Published var totalScore = 0
    @Published var isQuizFinished = false
    @Published var continent: ContinentOption?
    @Published var category: GameOption?
    
    var game: Game?
    
    private let repository = CountriesRepository()
    
    // MARK: - Functions
    
    // Funktion zum Speichern des Quiz-Fortschritts (CoreData)
    func saveQuizProgress() {
        let persistentStore = PersistentStore.shared
        let newGame = game ?? Game(context: persistentStore.context)
        newGame.id = UUID().uuidString
        newGame.continent = continent?.id
        newGame.category = category?.id
        newGame.score = Int16(score)
        newGame.answercount = Int16(index)
        newGame.countries = Int16(countries.count)
        newGame.date = Date()
        
        persistentStore.save() // Speichert die Änderungen im Persistent Store
    }
    
    // Funktion zum Abrufen aller Länder aus allen Kontinenten
    func fetchAllCountries() {
        repository.fetchAllCountries { [weak self] countries in
            DispatchQueue.main.async {
                self?.countries = countries
            }
        }
    }
    
    // Funktion zum Abrufen von Ländern für einen bestimmten Kontinent
    func fetchCountries(for continent: String) {
        repository.fetchCountries(for: continent) { [weak self] countries in
            guard let self else { return }
            
            DispatchQueue.main.async {
                self.countries = countries
                self.currentCountry = countries[(self.index) - 1]
                self.updateFlagURL()
                self.createAnswers()
            }
        }
    }
    
    // Diese Funktion erstellt die URL für die aktuelle Flagge
    private func updateFlagURL() {
        if let country = currentCountry {
            flagURL = URL(string: "https://public.syntax-institut.de/apps/batch6/SedatDuentas/images/" + country.flag)
        } else {
            flagURL = nil
        }
    }
    
    // Funktion für zufällige Antwortmöglichkeiten
    private func createAnswers() {
        var buttonNames: [String] = []

        if category == .flags {
            // Für das Flaggen-Quiz
            buttonNames.append(currentCountry?.country ?? "Fehler")
            var count = 0

            while count < 3 {
                let randomCountry = countries.randomElement()?.country ?? "Fehler"

                if !(buttonNames.contains(randomCountry)) {
                    buttonNames.append(randomCountry)
                    count += 1
                }
            }
            randomCountries = buttonNames.shuffled()
        } else if category == .cities {
            // Für das Städte-Quiz
            buttonNames.append(currentCountry?.capital ?? "Fehler")
            var count = 0

            while count < 3 {
                let randomCity = countries.randomElement()?.capital ?? "Fehler"

                if !(buttonNames.contains(randomCity)) {
                    buttonNames.append(randomCity)
                    count += 1
                }
            }
            randomCities = buttonNames.shuffled()
        } else if category == .currency {
            // Für das Währungs-Quiz
            buttonNames.append(currentCountry?.currency ?? "Fehler")
            var count = 0

            while count < 3 {
                let randomCurrency = countries.randomElement()?.currency ?? "Fehler"

                if !(buttonNames.contains(randomCurrency)) {
                    buttonNames.append(randomCurrency)
                    count += 1
                }
            }
            randomCurrencies = buttonNames.shuffled()
        }
    }
    
    // Funktion zum Abrufen der Antwortmöglichkeiten
    func getAnswerList() -> [String] {
        switch category {
        case .flags:
            return randomCountries
        case .cities:
            return randomCities
        case .currency:
            return randomCurrencies
        case .none:
            return []
        }
    }
    
    // Funktion zum Verarbeiten der gegebenen Antwort
    func handleAnswer(answer: String) {
        if let currentCountry {
            var isCorrect = false
            
            switch category {
            case .flags:
                isCorrect = answer == currentCountry.country
            case .cities:
                isCorrect = answer == currentCountry.capital
            case .currency:
                isCorrect = answer == currentCountry.currency
            case .none:
                break
            }
            
            if isCorrect {
                score += 1
            }
            nextCountry()
        }
    }
    
    // Funktion zum Wechseln zum nächsten Land
    func nextCountry() {
        if index < countries.count {
            index += 1
            currentCountry = countries[index - 1]
            updateFlagURL()
            createAnswers()
        } else {
            isQuizFinished = true
        }
    }
    
    // Funktion zur Ermittlung der Ergebnisansicht basierend auf dem Punktestand
    func getResultType() -> ResultType {
        if score == countries.count {
            return ResultType.three
        } else if score > countries.count / 2 {
            return ResultType.two
        } else {
            return ResultType.one
        }
    }
    
    // Funktion zum Aktualisieren der Ergebnisinformationen
    func updateResultInfo() {
        categoryName = category?.title ?? ""
        continentName = continent?.title ?? ""
        totalScore = countries.count // Gesamtpunktzahl ist die Anzahl der Fragen
    }
}
