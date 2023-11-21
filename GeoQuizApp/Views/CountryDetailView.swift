//
//  CountryDetailView.swift
//  GeoQuizApp
//
//  Created by Sedat Düntas on 25.09.23.
//

import SwiftUI

struct CountryDetailView: View {
    
    // MARK: - Variables
    let country: Country
    
    var body: some View {
        VStack {
            if let flagURL = URL(string: "https://public.syntax-institut.de/apps/batch6/SedatDuentas/images/" + country.flag) {
                AsyncImage(url: flagURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 400)
                        .padding(50)
                } placeholder: {
                    ProgressView() // Anzeige während des Laden des Bildes
                }
            } else {
                ProgressView() // Anzeige, falls die Bild-URL nicht verfügbar ist
            }
            Form {
                Section(header: Text(Strings.information)) {
                    Text("\(Strings.name) \(country.country)")
                    Text("\(Strings.capital) \(country.capital)")
                    Text("\(Strings.currency) \(country.currency)")
                    Text("\(Strings.language) \(country.language)")
                }
                .listRowBackground(Color.clear) // Transparente Zeilenhintergrundfarbe
                .font(.title2)
            }
            .scrollContentBackground(.hidden) // Transparente Scrollview-Hintergrundfarbe
            .navigationBarTitle(country.country)
        }
        .background(Color.pastelblue.opacity(0.6)).ignoresSafeArea()
    }
}

#Preview {
    let sampleCountry = Country(country: "Deutschland", capital: "Berlin", language: "Deutsch", flag: "deutschland.png", currency: "Euro")
    return CountryDetailView(country: sampleCountry)
}

