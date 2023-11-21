//
//  ContinueModifier.swift
//  GeoQuizApp
//
//  Created by Sedat Düntas on 08.10.23.
//

import Foundation
import SwiftUI

struct ContinueModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .padding(5)
    }
}

extension View {
    func continueModifier() -> some View {
        modifier(ContinueModifier())
    }
}

