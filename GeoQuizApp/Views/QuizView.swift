//
//  QuizView.swift
//  GeoQuizApp
//
//  Created by Sedat Düntas on 04.10.23.
//

import SwiftUI

struct QuizView: View {
    
    // Das ViewModel zur Steuerung des Quiz
    @StateObject var viewModel = QuizViewModel()
    
    // Binding zur Navigation
    @Binding var path: NavigationPath
    
    // Die ausgewählte Spielkategorie, Kontinent, Spielstand, score und das Spiel
    let category: GameOption
    let continent: ContinentOption
    let progress: Int
    let score: Int
    let game: Game?
    
    // Initialisieren der View
    init(category: GameOption, continent: ContinentOption, progress: Int = 1, score: Int = 0, game: Game? = nil, path: Binding<NavigationPath>) {
        self.category = category
        self.continent = continent
        self.progress = progress
        self.score = score
        self.game = game
        _path = path
    }
    
    var body: some View {
        ZStack {
            // Hintergrund basierend auf der ausgewählten Kategorie
            category.background
            VStack {
                Spacer()
                
                HStack {
                    // Anzeige der Überschrift der Kategorie
                    Text(category.headline)
                        .quizHeaderModifier(with: .title)
                        .padding(.leading, 5)
                    
                    // Anzeige des aktuellen Fortschritts im Quiz
                    Text("\(viewModel.index)/\(viewModel.countries.count)")
                        .quizHeaderModifier(with: .title2)
                        .padding(.leading)
                }
                Spacer()
                
                // Anzeige der Flagge oder des Ländernamens basierend auf der Kategorie
                if category.shouldDisplayFlag, let flagURL = viewModel.flagURL {
                    AsyncImage(url: flagURL) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(20)
                    } placeholder: {
                        ProgressView()
                    }
                } else {
                    if let countryName = viewModel.currentCountry?.country {
                        Text(countryName)
                            .font(.largeTitle)
                            .bold()
                            .padding(.top, 80)
                    } else {
                        ProgressView()
                    }
                }
                Spacer()
                
                // Grid mit den Antwortmöglichkeiten
                LazyVGrid(columns: [.init(.flexible()), .init(.flexible())], spacing: 20) {
                    ForEach(viewModel.getAnswerList(), id: \.self) { answer in
                        Button(action: {
                            viewModel.handleAnswer(answer: answer)
                        }) {
                            Text(answer)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                        }
                        .frame(height: 70)
                        .background(Color.black)
                        .cornerRadius(10)
                        .padding(5)
                    }
                }
                
                Spacer()
            }
        }
        .onAppear {
            // Initialisieren des ViewModels mit den ausgewählten Optionen
            viewModel.continent = continent
            viewModel.category = category
            viewModel.fetchCountries(for: continent.id)
            viewModel.index = progress
            viewModel.score = score
            viewModel.game = game
        }
        // Navigationsziel zur Ergebnisansicht, wenn das Quiz beendet ist
        .navigationDestination(isPresented: $viewModel.isQuizFinished) {
            
            ResultView(viewModel: viewModel, path: $path, resultType: viewModel.getResultType())
        }
        // Dieser Code wird ausgeführt, wenn die Ansicht verschwindet
        .onDisappear {
            viewModel.saveQuizProgress()
        }
    }
}

#Preview {
    QuizView(category: .cities, continent: .asia, path: .constant(NavigationPath()))
}
