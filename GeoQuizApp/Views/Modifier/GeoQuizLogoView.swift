//
//  GeoQuizLogoView.swift
//  GeoQuizApp
//
//  Created by Sedat Düntas on 05.10.23.
//

import SwiftUI

struct GeoQuizLogoView: View {
    var body: some View {
        Image("geoquizlogo")
            .resizable() // Das Bild kann in der Größe angepasst werden
            .scaledToFit() // Das Bild passt sich proportional an die Größe an
            .frame(width: 300, height: 300) // Die Größe des Bildes (Breite und Höhe)
    }
}

#Preview {
    GeoQuizLogoView()
}
