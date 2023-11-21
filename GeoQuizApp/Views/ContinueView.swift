//
//  ContinueView.swift
//  GeoQuizApp
//
//  Created by Sedat Düntas on 07.09.23.
//

import SwiftUI

struct ContinueView: View {
    
    // MARK: - Variables
    
    // Ein Binding für die Navigationspfad-Variable
    @Binding var path: NavigationPath
    
    // Ein StateObject für das 'ContinueViewModel'
    @StateObject var viewModel = ContinueViewModel()
    
    var body: some View {
        ZStack {
            BackgroundBlueView() // Hintergrundansicht in Blau
            VStack {
                Text(Strings.recentGames)
                List {
                    // Schleife durch Spiele im ViewModel
                    ForEach(viewModel.games) { game in
                        // Wenn Informationen über den Kontinent, die Option und die Kategorie verfügbar ist, wird ein Navigationslink zu einer Quizansicht mit den entsprechenden Parametern erstellt
                        if let continent = game.continent, 
                            let option = ContinentOption(rawValue: continent),
                            let category = GameOption(rawValue: game.category ?? ""){
                            NavigationLink(destination: QuizView(category: category, continent: option, progress: Int(game.answercount),score: Int(game.score), game: game, path: $path)) {
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text(Strings.category)
                                        Text(category.title)
                                    }
                                    .continueModifier()
                                    
                                    HStack {
                                        Text(Strings.continent)
                                        Text(option.title)
                                    }
                                    .continueModifier()
                                    
                                    HStack {
                                        Text(Strings.progress)
                                        Text("\(game.answercount)/\(game.countries) \(Strings.countries)")
                                    }
                                    .continueModifier()
                                    
                                    HStack {
                                        Text(Strings.score)
                                        Text("\(game.score)")
                                    }
                                    .continueModifier()
                                }
                            }
                            .listRowBackground(Color.clear)
                            .padding(.vertical, 8)
                            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                Button {
                                    viewModel.deleteGame(game: game)
                                    
                                } label: {
                                    Label(Strings.delete, systemImage: "trash")
                                }
                                .tint(.red)
                            }
                        }
                    }
                }
                .scrollContentBackground(.hidden)
            }
            .padding(.top)
        }
    }
}

#Preview {
    ContinueView(path: .constant(NavigationPath()))
}
