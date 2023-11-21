//
//  BackgroundCitiesView.swift
//  GeoQuizApp
//
//  Created by Sedat Düntas on 04.10.23.
//

import SwiftUI

struct BackgroundCitiesView: View {
    var body: some View {
        ZStack(alignment: .top) { // Ein ZStack, der verschiedene Ansichten übereinander stapelt
            Color.pastelblue.ignoresSafeArea().opacity(0.6) // Hintergrundfarbe mit reduzierter Deckkraft
            VStack { // Ein vertikaler Stapel von Ansichten
                Image("citiesicon") // Ein Bild mit dem Namen "citiesicon"
                    .resizable() // Das Bild kann in der Größe angepasst werden
                    .scaledToFit() // Das Bild passt sich proportional an die Größe an
                    .frame(width: 350, height: 350) // Die Größe des Bildes
                    .offset(x: 0, y: 40) // Die Position des Bildes (horizontal und vertikal verschoben)
                    .opacity(0.4) // Die Deckkraft des Bildes
            }
        }
    }
}

#Preview {
    BackgroundCitiesView()
}
