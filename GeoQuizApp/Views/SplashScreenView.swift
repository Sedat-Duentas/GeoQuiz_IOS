//
//  SplashScreenView.swift
//  GeoQuizApp
//
//  Created by Sedat Düntas on 01.09.23.
//

import SwiftUI

struct SplashScreenView: View {
    // Ein Zustand, um den Übergang zur Hauptansicht zu steuern.
    @State var isActive: Bool = false
    
    // Zustände für die Animation von Größe und Deckkraft des Logos.
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive {
            // Wenn isActive true ist, wechsle zur Hauptansicht (HomeView).
            HomeView()
        } else {
            // Wenn isActive false ist, zeige den Splash Screen an.
            ZStack {
                // Hellblaue Hintergrundansicht (hier als BackgroundFlagsView bezeichnet).
                BackgroundBlueView()
                
                VStack {
                    // Ein benutzerdefiniertes Logo für die App.
                    GeoQuizLogoView()
                        .scaleEffect(size) // Skaliere das Logo.
                        .opacity(opacity)  // Setze die Deckkraft des Logos.
                        .onAppear {
                            // Animation beim Erscheinen des Logos.
                            withAnimation(.easeInOut(duration: 1.2)) {
                                self.size = 0.9    // Ändere die Größe des Logos.
                                self.opacity = 1.0 // Ändere die Deckkraft des Logos.
                            }
                        }
                }
                .onAppear {
                    // Hier wird ein Timer erstellt, um isActive nach 2 Sekunden auf true zu setzen.
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        withAnimation {
                            self.isActive = true // Aktiviere die Hauptansicht.
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
