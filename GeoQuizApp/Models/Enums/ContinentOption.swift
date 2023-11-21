//
//  ContinentOption.swift
//  GeoQuizApp
//
//  Created by Sedat Düntas on 19.09.23.
//

import Foundation

// Enumeration 'ContinentOption' zur Darstellung der Kontinente
enum ContinentOption: String, Identifiable, CaseIterable {
    
    // Enumeration-Fälle für verschiedene Kontinente
    case europe, asia, africa, northAmerica, southAmerica, oceania
    
    // Die 'id'-Eigenschaft ist für das Identifiable-Protokoll erforderlich
    var id: String { rawValue }
    
    // Die 'title'-Eigenschaft gibt den lesbaren Namen des Kontinents zurück
    var title: String {
        // Ein Switch-Statement, um den Namen basierend auf dem Fall auszuwählen
        switch self {
        case .europe: return "Europa"
        case .asia: return "Asien"
        case .africa: return "Afrika"
        case .northAmerica: return "Nordamerika"
        case .southAmerica: return "Südamerika"
        case .oceania: return "Ozeanien"
        }
    }
}
