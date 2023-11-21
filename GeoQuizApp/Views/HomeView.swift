//
//  HomeView.swift
//  GeoQuizApp
//
//  Created by Sedat Düntas on 29.08.23.
//

import SwiftUI

struct HomeView: View {
    
    // MARK: - Variables
    
    // Diese Variable ist für das Anzeigen eines Sheets verantwortlich.
    @State private var isShowingSheet = false
    
    // Dieser 'path' beinhaltet alle Views, zu denen wir navigieren.
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack() {
                
                // Hintergrundbild der Weltkarte mit geringer Deckkraft.
                Image("world")
                    .resizable()
                    .scaledToFill()
                    .opacity(0.1)
                
                VStack {
                    
                    Spacer()
                    
                    HStack {
                        // Ein Info-Button in Form eines Fragezeichens.
                        Image(systemName: "questionmark.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .offset(x: 144, y: -60.0)
                            .onTapGesture {
                                isShowingSheet.toggle()
                            }
                            .sheet(isPresented: $isShowingSheet) {
                                InfoSheetView()
                            }
                    }
                    
                    // Das GeoQuiz-Logo.
                    GeoQuizLogoView()
                    
                    Spacer()
                    
                    // Buttons für verschiedene Aktionen.
                    ButtonView(text: Strings.newGame, value: "new")
                        .padding(.bottom)
                    
                    ButtonView(text: Strings.continuePlaying, value: "continue")
                        .padding(.bottom)
                    
                    ButtonView(text: Strings.countryList, value: "countrylist")
                    
                    Spacer()
                }
            }
            .navigationDestination(for: String.self) { value in
                switch value {
                case "continue":
                    // Navigiere zur Ansicht "ContinueView" und übergib Gameplay-Daten.
                    ContinueView(path: $path)
                case "countrylist":
                    // Navigiere zur Ansicht "CountryListView" und initialisiere ein QuizViewModel.
                    CountryListView(viewModel: QuizViewModel())
                default:
                    // Navigiere zur Ansicht "GameSelectionView".
                    GameSelectionView(path: $path)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
