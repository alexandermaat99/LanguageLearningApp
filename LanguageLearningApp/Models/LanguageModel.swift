//
//  LanguageModel.swift
//  LanguageLearningApp
//
//  Created by Alexander Maat on 10/25/24.
//

import Foundation

struct Flashcard {
    var word: String
    var translation: String
}

struct Topic: Identifiable {
    var id = UUID()
    var name: String
    var lesson: String
    var flashcards: [Flashcard]
    var quiz: Quiz
    var isLessonRead: Bool = false
    var isFlashcardsCompleted: Bool = false
    var isQuizCompleted: Bool = false
}


struct Quiz {
    var questions: [QuizQuestion]
}

struct QuizQuestion {
    var question: String
    var correctAnswer: String
    var options: [String]
}

