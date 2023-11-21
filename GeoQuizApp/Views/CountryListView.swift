//
//  CountryListView.swift
//  GeoQuizApp
//
//  Created by Sedat Düntas on 25.09.23.
//

import SwiftUI

struct CountryListView: View {
    
    // MARK: - Variables
    @ObservedObject var viewModel: QuizViewModel
    
    init(viewModel: QuizViewModel) {
        self.viewModel = viewModel
        // Die Funktion wird hier aufgerufen, um Länderdaten zu laden
        viewModel.fetchAllCountries()
    }
    
    var body: some View {
        NavigationView {
            List(viewModel.countries) { country in
                NavigationLink(destination: CountryDetailView(country: country)) {
                    Text(country.country)
                }
                .listRowBackground(Color.clear) // Transparente Zeilenhintergrundfarbe
            }
            .scrollContentBackground(.hidden) // Transparente Scrollview-Hintergrundfarbe
            .background {
                BackgroundBlueView()
            }
            .navigationBarTitle(Strings.countryList)
        }
    }
}

#Preview {
    let viewModel = QuizViewModel()
    return CountryListView(viewModel: viewModel)
}
