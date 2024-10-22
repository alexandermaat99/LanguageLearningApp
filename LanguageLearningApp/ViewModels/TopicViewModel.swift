//
//  TopicViewModel.swift
//  LanguageLearningApp
//
//  Created by Alexander Maat on 10/22/24.
//

import SwiftUI

class TopicViewModel: ObservableObject {
    @Published var topics: [Topic] = []

    init() {
        loadTopics()  // Load topics when the ViewModel is initialized
    }

    func loadTopics() {
        let sampleTopics = [
            Topic(name: "Greetings", lesson: "Basic greetings and salutations.", flashcards: [
                Flashcard(word: "Hello", translation: "Hola"),
                Flashcard(word: "Goodbye", translation: "Adiós")
            ], quiz: Quiz(questions: [
                QuizQuestion(question: "How do you say 'Hello' in Spanish?", correctAnswer: "Hola", options: ["Hola", "Adiós", "Gracias"])
            ])),

            Topic(name: "Numbers", lesson: "Learn numbers from 1 to 10 in Spanish.", flashcards: [
                Flashcard(word: "One", translation: "Uno"),
                Flashcard(word: "Two", translation: "Dos"),
                Flashcard(word: "Three", translation: "Tres"),
                Flashcard(word:"Four", translation: "Quatro")
            ], quiz: Quiz(questions: [
                QuizQuestion(question: "How do you say 'Two' in Spanish?", correctAnswer: "Dos", options: ["Uno", "Dos", "Tres"]),
                QuizQuestion(question: "How do you say 'Three' in Spanish?", correctAnswer: "Tres", options: ["Uno", "Dos", "Tres"])
            ])),

            Topic(name: "Colors", lesson: "Learn the colors in Spanish.", flashcards: [
                Flashcard(word: "Red", translation: "Rojo"),
                Flashcard(word: "Blue", translation: "Azul"),
                Flashcard(word: "Green", translation: "Verde")
            ], quiz: Quiz(questions: [
                QuizQuestion(question: "How do you say 'Blue' in Spanish?", correctAnswer: "Azul", options: ["Rojo", "Azul", "Verde"])
            ]))
        ]

        topics = sampleTopics
    }

}
