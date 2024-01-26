//
//  ContentView.swift
//  SentimentAnalysis
//
//  Created by Timote POLICET on 1/26/24.
//

import SwiftUI

enum Sentiment: String {
    case positive = "POSITIVE"
    case negative = "NEGATIVE"
    case mixed = "MIXED"
    case neutral = "NEUTRAL"
    
    func color() -> Color {
        switch self{
        case .positive :
            Color.green
        case .negative :
            Color.red
        case .neutral :
            Color.gray
        case .mixed :
            Color.purple
        }
    }
    
    func smiley() -> String {
        switch self{
        case .positive :
            "😃"
        case .negative :
            "🙁"
        case .neutral :
            "😐"
        case .mixed :
            "🤔"
        }
    }
}

struct ContentView: View {
    @State private var selectedName:String = ""
    @State private var modelOutput: Sentiment?
    
    
    func classify() {
        do {
            // MyModel est une classe générée automatiquement par Xcode
            let model = try MyTextClassifier(configuration: .init())
            let prediction = try model.prediction(text: selectedName)
            modelOutput = Sentiment(rawValue:prediction.label)
            // A vous de travailler la suite
        } catch {
            modelOutput = Sentiment(rawValue:"Something went wrong")
        }
    }

    var body: some View {
        NavigationStack(){
            VStack{
                Text("Entrez une phrase, l'IA va deviner votre sentiment")
                    .padding(.top, 12)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                TextField("", text: $selectedName)
                    .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                    .background(.white)
                    .fontWeight(.bold)
                    .cornerRadius(18)
                    
                    .padding(.all, 12)
                    
                
                Button(action: classify, label: {
                    Text("Deviner le sentiment")
                        .padding(.all, 20)
                        .foregroundColor(.white)
                        .background(.blue)
                        .cornerRadius(12)
                })
                .padding(.bottom, 12)
                    
                
            }.background(.purple)

            
            .cornerRadius(18)
            
            if let modelOutput{
                VStack{
                    Text(modelOutput.smiley())
                    Text(modelOutput.rawValue)
                        .fontWeight(.bold)
                        
                }
                .frame(width: 200, height: 100)
                .background(modelOutput.color())
                .cornerRadius(18)
                .padding(.all, 12)
                
                    
                
                
            }
            
            
            
            
            
            Spacer()
            .navigationBarTitle("🧠 IA du futur")
        }
        .padding(.all,10)
        
    }
}

#Preview {
    ContentView()
}
