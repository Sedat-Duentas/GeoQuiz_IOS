//
//  InfoSheetHeaderModifier.swift
//  GeoQuizApp
//
//  Created by Sedat Düntas on 08.10.23.
//

import SwiftUI

struct InfoSheetHeaderModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .bold()
            .foregroundStyle(.black)
    }
}

extension View {
    func infoSheetHeaderModifier() -> some View {
        modifier(InfoSheetHeaderModifier())
    }
}
