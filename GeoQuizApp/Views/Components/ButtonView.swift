//
//  ButtonBlueView.swift
//  GeoQuizApp
//
//  Created by Sedat Düntas on 06.09.23.
//

import SwiftUI

// Eine benutzerdefinierte SwiftUI-Ansicht namens 'ButtonView'
struct ButtonView: View {
    let text: String // Der Text, der auf dem Button angezeigt wird
    let value: String // Ein Wert, der mit der Navigation verknüpft ist
    
    var body: some View {
        NavigationLink(value: value) { // Ein Navigationslink, der zu einem Ziel führt, wenn der Button gedrückt wird
            Text(text) // Der Text, der auf dem Button angezeigt wird
                .foregroundColor(.white) // Die Textfarbe des Buttons
                .padding() // Ein Innenabstand um den Text
                .frame(width: 200) // Die Breite des Buttons
                .background(Color.black) // Die Hintergrundfarbe des Buttons
                .cornerRadius(10) // Die abgerundeten Ecken des Buttons
        }
    }
}

#Preview  {
    ButtonView(text: "Beispieltext", value: "") // Eine Vorschau für die 'ButtonView'-Ansicht
}
