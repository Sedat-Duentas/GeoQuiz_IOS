//
//  ResultType.swift
//  GeoQuizApp
//
//  Created by Sedat Düntas on 02.10.23.
//

import Foundation
import SwiftUI

// Enumeration 'ResultType' zur Darstellung verschiedener Ergebnistypen
enum ResultType {
    // Enumeration-Fälle für verschiedene Ergebnistypen
    case one, two, three
    
    // Die 'resultImage'-Eigenschaft gibt das Image-Objekt für jeden Ergebnistyp zurück
    var resultImage: Image {
        // Ein Switch-Statement, um das Image-Objekt basierend auf dem Fall auszuwählen
        switch self {
        case .one: return Image("one-beginner")
        case .two: return Image("two-advanced")
        case .three: return Image("three-expert")
        }
    }
}
