//
//  VocabularyView.swift
//  LanguageLearningApp
//
//  Created by Alexander Maat on 10/22/24.
//

import SwiftUI

//pulls in data from wherever, in this case it will be used with TopicViewModel and structures is into a list + stles it

// VocabularyView is a SwiftUI view that displays a list of vocabulary words and their translations.
struct VocabularyView: View {
    // This property holds the list of vocabulary words and their translations.
    // It's expected to be provided by the parent view when VocabularyView is initialized.
    var vocabList: [(word: String, translation: String)]
    
    var body: some View {
        VStack(alignment: .leading) {
            // This text serves as a header for the vocabulary list.
            Text("Vocabulary List")
                .font(.headline)
                .padding(.bottom, 5)
            
            // ForEach is used to iterate over each item in vocabList.
            // Each item is a tuple containing a word and its translation.
            ForEach(vocabList, id: \.word) { vocab in
                HStack {
                    // Display the word from the tuple.
                    Text(vocab.word)
                        .font(.body)
                    Spacer()
                    // Display the translation from the tuple, styled in gray.
                    Text(vocab.translation)
                        .font(.body)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 2) // Add vertical padding between items.
            }
        }
        .padding() // Add padding around the entire VStack.
    }
}
