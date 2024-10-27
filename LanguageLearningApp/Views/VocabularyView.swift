//
//  VocabularyView.swift
//  LanguageLearningApp
//
//  Created by Alexander Maat on 10/22/24.
//

import SwiftUI

struct VocabularyView: View {
    var vocabList: [(word: String, translation: String)]
    
    var body: some View {
        VStack(alignment: .leading) {

            HStack {
                Text("English")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Spacer()
                
                Text("Spanish")
                    .font(.headline)
                    .foregroundColor(.primary)
            }
            .padding(.bottom, 5)
            
            ForEach(vocabList, id: \.word) { vocab in
                HStack {
                    Text(vocab.word)
                        .font(.body)
                    
                    Spacer()
                    
                    Text(vocab.translation)
                        .font(.body)
                        .foregroundColor(.green)
                }
                .padding(.vertical, 2)
            }
        }
        .padding()
    }
}

struct VocabularyView_Previews: PreviewProvider {
    static var previews: some View {
        VocabularyView(vocabList: [
            (word: "One", translation: "Uno"),
            (word: "Two", translation: "Dos"),
            (word: "Three", translation: "Tres"),
            (word: "Four", translation: "Cuatro"),
            (word: "Five", translation: "Cinco"),
            (word: "Six", translation: "Seis"),
            (word: "Seven", translation: "Siete"),
            (word: "Eight", translation: "Ocho"),
            (word: "Nine", translation: "Nueve"),
            (word: "Ten", translation: "Diez")
        ])
    }
}
