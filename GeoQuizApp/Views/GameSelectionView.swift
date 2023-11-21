//
//  Test3View.swift
//  GeoQuizApp
//
//  Created by Sedat Düntas on 27.09.23.
//

import SwiftUI

struct GameSelectionView: View {
    
    // MARK: - Variables
    
    // Das ViewModel zur Steuerung der Auswahl im Spiel
    @StateObject private var gameSelectionViewModel = GameSelectionViewModel()
    // Binding zur Navigation
    @Binding var path: NavigationPath
    @State private var isHighscoreSheetPresented = false
    
    var body: some View {
        ZStack {
            BackgroundBlueView()
            VStack {
                
//                HStack {
//                    // Ein Info-Button in Form eines Fragezeichens.
//                    Image(systemName: "list.bullet")
//                        .resizable()
//                        .frame(width: 30, height: 30)
//                        .offset(x: 144, y: -10.0)
//                        .onTapGesture {
//                            isHighscoreSheetPresented.toggle()
//                        }
//                        .sheet(isPresented: $isHighscoreSheetPresented) {
//                            HighscoreView(path: .constant(NavigationPath()))
//                        }
//                }
                
                // Das GeoQuiz-Logo
                Image("worldlogo")
                    .resizable()
                    .frame(width: 200, height: 200)
                
                Text(Strings.categorySelectionTitle)
                    .font(.title)
                    .padding(.bottom)
                
                // Ein Picker für die Auswahl der Spielkategorie
                Picker(Strings.category, selection: $gameSelectionViewModel.category) {
                    ForEach(GameOption.allCases) { category in
                        Text(category.title)
                            .tag(category)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.bottom)
                
                Spacer()
                
                Text(Strings.continentSelectionTitle)
                    .font(.title)
                    .padding(.top)
                
                // Eine Liste von Buttons für die Auswahl des Kontinents
                List(ContinentOption.allCases) { continent in
                    Button {
                        gameSelectionViewModel.continent = continent
                    } label: {
                        HStack {
                            Image(continent.id)
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding(.trailing)
                            Text(continent.title)
                            
                            Spacer()
                            
                            // Ein Häkchen, um den ausgewählten Kontinenten anzuzeigen
                            if gameSelectionViewModel.continent == continent {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                    .listRowBackground(Color.clear)
                }
                .padding(.top, -30)
                .foregroundColor(.black)
                .padding()
                .padding(.bottom)
                
                Spacer()
                
                // Ein Button zur Navigation zur Quiz-Ansicht
                NavigationLink(value: gameSelectionViewModel.category) {
                    Text(Strings.continueTitle)
                    
                }
                .padding()
                .frame(width: 200)
                .background(gameSelectionViewModel.gameSelected ? .black : .gray) // Aktivierung des Buttons basierend auf dem Status
                .foregroundColor(.white)
                .cornerRadius(10)
                .disabled(!gameSelectionViewModel.gameSelected)
                
                Spacer()
            }
            .padding()
        }
        .navigationDestination(for: GameOption.self, destination: { category in
            // Navigationsziel für die ausgewählte Spielkategorie
            QuizView(category: category, continent: gameSelectionViewModel.continent ?? .europe, path: $path)
        })
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    GameSelectionView(path: .constant( NavigationPath()))
}
