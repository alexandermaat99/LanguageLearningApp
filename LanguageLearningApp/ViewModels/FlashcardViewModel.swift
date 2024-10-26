//
//  FlashcardViewModel.swift
//  LanguageLearningApp
//
//  Created by Alexander Maat on 10/22/24.
//

import SwiftUI

class FlashcardViewModel: ObservableObject {
    //declares values, flashcards is an array of Flashcard objects which are 2 strings
    @Published var flashcards: [Flashcard]
    //declearing and init a property current index, which is an integer, that starts at 0
    @Published var currentIndex: Int = 0
    //declearing and init a property showTranslation state, which is a bool, to false meaning the Spanish will show first
    @Published var showTranslation: Bool = false
    
    
    //init the flashcards array by creating the array of Flashcard objects
    init(flashcards: [Flashcard]) {
        self.flashcards = flashcards.shuffled() // Shuffle flashcards that are recieved
    }
    
    //defining the nextFlashcard function what determines if the current index is at the end or not, resets the card to spanish side by assigning showTranslation to false
    
    func nextFlashcard() {
        currentIndex = (currentIndex + 1) % flashcards.count
        showTranslation = false // Reset to show word side first
    }
    
    //does the same for previous flashcard
    func previousFlashcard() {
        currentIndex = (currentIndex - 1 + flashcards.count) % flashcards.count
        showTranslation = false
    }
    
    //toggle flashcard flips the card .toggle() function just switched boolean value to opposite, which is sick
    func toggleFlashcard() {
        showTranslation.toggle()
    }
}
