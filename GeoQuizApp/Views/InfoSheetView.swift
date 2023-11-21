//
//  InfoSheetView.swift
//  GeoQuizApp
//
//  Created by Sedat Düntas on 26.09.23.
//

import SwiftUI

struct InfoSheetView: View {
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundBlueView()
                List {
                    Text(Strings.welcomeMessage)
                        .font(.title3)
                        .padding(.bottom, 20)
                        .listRowBackground(Color.clear)
                    
                    Section(header: Text(Strings.gameplay)
                        .infoSheetHeaderModifier()) {
                            Text(Strings.categorySelection)
                            Text(Strings.continentSelection)
                            Text(Strings.quizInfo)
                                .padding(.bottom, 20)
                        }
                        .listRowBackground(Color.clear)
                    
                    Section(header: Text(Strings.yourGoal)
                        .infoSheetHeaderModifier()) {
                            Text(Strings.yourGoalDescription)
                        
                            Text(Strings.haveFun)
                            .italic()
                    }
                    .listRowBackground(Color.clear)
                    .padding(.bottom, 10)
                    
                }
                .scrollContentBackground(.hidden)
            }
        }
    }
}

#Preview {
    InfoSheetView()
}
