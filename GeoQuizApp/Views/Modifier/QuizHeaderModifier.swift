//
//  QuizHeaderModifier.swift
//  GeoQuizApp
//
//  Created by Sedat Düntas on 08.10.23.
//

import Foundation
import SwiftUI

struct QuizHeaderModifier: ViewModifier {
    let font: Font
    
    func body(content: Content) -> some View {
        content
            .font(font)
            .bold()
            .foregroundColor(.black)
            .padding(.bottom, 80)
    }
}

extension View {
    func quizHeaderModifier(with font: Font = .title) -> some View {
        modifier(QuizHeaderModifier(font: font))
    }
}
