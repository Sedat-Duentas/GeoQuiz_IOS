//
//  ResultView.swift
//  GeoQuizApp
//
//  Created by Sedat Düntas on 02.10.23.
//

import SwiftUI

struct ResultView: View {
    
    // Das ViewModel zur Steuerung des Quiz
    @StateObject var viewModel: QuizViewModel
    // Binding zur Navigation
    @Binding var path: NavigationPath
    // Der Ergebnistyp des Quiz
    let resultType: ResultType
    
    // Zustandsvariablen für Kategorie, Kontinent, Punktzahl und Gesamtpunktzahl
    @State private var categoryName = "Flaggen"
    @State private var continentName = "Europa"
    @State private var score = 0
    @State private var totalScore = 0
    
    var body: some View {
        NavigationView {
            ZStack {
                // Hintergrundansicht
                BackgroundBlueView()
                VStack {
                    Spacer()
                    
                    // Anzeige des Ergebnisbilds basierend auf dem Ergebnistyp
                    resultType.resultImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                        .padding(.horizontal)
                    
                    Form {
                        Section(header: Text(Strings.resultTitle)) {
                            // Anzeige von Kategorie, Kontinent, Punktzahl und Gesamtpunktzahl
                            Text("\(Strings.category) \(viewModel.categoryName)")
                            Text("\(Strings.continent) \(viewModel.continentName)")
                            Text("\(Strings.score) \(viewModel.score) \(Strings.outOf) \(viewModel.totalScore) \(Strings.questions)")
                        }
                        .listRowBackground(Color.clear)
                    }
                    .font(.title2)
                    .scrollContentBackground(.hidden)
                    
                    // Zurück zum Startbildschirm-Button
                    // Zugriff auf das path-Binding und Entfernen des letzten Elements aus dem Array.
                    // .wrappedValue wird verwendet, um auf den Wert des Bindings zuzugreifen.
                    // removeLast entfernt das letzte Element, und count bestimmt die Anzahl der zu entfernenden Elemente.
                    Button(action: {
                        $path.wrappedValue.removeLast($path.wrappedValue.count)
                        viewModel.saveQuizProgress()
                    }) {
                        Text(Strings.home)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 200)
                            .background(Color.black)
                            .cornerRadius(10)
                    }
                    Spacer()
                }
                .navigationBarTitle(Strings.gameResult)
            }
        }
        .onAppear {
            // Aktualisieren der Ergebnisinformationen beim Erscheinen der Ansicht
            viewModel.updateResultInfo()
        }
    }
}

#Preview {
    // Beispiel-Preview der ResultView mit Dummy-Daten
    ResultView(viewModel: QuizViewModel(), path: .constant(NavigationPath()), resultType: .three)
}
