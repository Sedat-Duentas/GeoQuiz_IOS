//
//  BackgroundFlagsView.swift
//  GeoQuizApp
//
//  Created by Sedat Düntas on 04.10.23.
//

import SwiftUI

struct BackgroundBlueView: View {
    var body: some View {
        ZStack {
            // Hintergrundfarbe mit reduzierter Deckkraft
            Color.pastelblue.ignoresSafeArea().opacity(0.6)
        }
    }
}

#Preview {
    BackgroundBlueView()
}
