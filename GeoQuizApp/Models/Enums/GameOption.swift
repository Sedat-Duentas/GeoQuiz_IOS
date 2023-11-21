//
//  GameOption.swift
//  GeoQuizApp
//
//  Created by Sedat Düntas on 20.09.23.
//

import Foundation
import SwiftUI

// Enumeration 'GameOption' zur Darstellung verschiedener Spieloptionen
enum GameOption: String, Identifiable, CaseIterable {
    
    // Enumeration-Fälle für verschiedene Spieloptionen
    case flags, cities, currency
    
    // Die 'id'-Eigenschaft ist für das Identifiable-Protokoll erforderlich
    var id: String { rawValue }
    
    // Die 'title'-Eigenschaft gibt den lesbaren Namen der Spieloption zurück
    var title: String {
        // Ein Switch-Statement, um den Namen basierend auf dem Fall auszuwählen
        switch self {
        case .flags: return "Flaggen"
        case .cities: return "Städte"
        case .currency: return "Währungen"
        }
    }
    
    // Die 'background'-Eigenschaft gibt die Hintergrundansicht für jede Spieloption zurück
    var background: some View {
        // Ein Switch-Statement, um die Hintergrundansicht basierend auf dem Fall auszuwählen
        switch self {
        case .flags: return AnyView(BackgroundBlueView())
        case .cities: return AnyView(BackgroundCitiesView())
        case .currency: return AnyView(BackgroundCurrenciesView())
        }
    }
    
    // Die 'headline'-Eigenschaft gibt die Überschrift für jede Spieloption zurück
    var headline: String {
        // Ein Switch-Statement, um die Überschrift basierend auf dem Fall auszuwählen
        switch self {
        case .flags: return "Errate die Flagge"
        case .cities: return "Errate die Hauptstadt"
        case .currency: return "Errate die Währung"
        }
    }
    
    // Die 'shouldDisplayFlag'-Eigenschaft gibt an, ob die Flagge in dieser Spieloption angezeigt werden soll
    var shouldDisplayFlag: Bool {
        return self == .flags
    }
}
