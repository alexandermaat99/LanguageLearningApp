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
            Topic(
                name: "Greetings",
                lesson: """
                    In this lesson, you will learn basic greetings and salutations in Spanish. Greetings are an essential part of any language as they help you make a good first impression. You will learn how to say 'Hello', 'Goodbye', and other common phrases used in everyday interactions. Mastering these basics will help you start conversations and connect with Spanish speakers.
                    """,
                flashcards: [
                    Flashcard(word: "Hello", translation: "Hola"),
                    Flashcard(word: "Goodbye", translation: "Adiós"),
                    Flashcard(word: "Good morning", translation: "Buenos días"),
                    Flashcard(word: "Good night", translation: "Buenas noches"),
                    Flashcard(word: "Thank you", translation: "Gracias"),
                    Flashcard(word: "Excuse me", translation: "Siento molestar")
                ],
                quiz: Quiz(questions: [
                    QuizQuestion(question: "How do you say 'Hello' in Spanish?", correctAnswer: "Hola", options: ["Hola", "Adiós", "Gracias", "Buenos días"]),
                    QuizQuestion(question: "How do you say 'Goodbye' in Spanish?", correctAnswer: "Adiós", options: ["Adiós", "Hola", "Buenas noches", "Gracias"]),
                    QuizQuestion(question: "How do you say 'Good morning' in Spanish?", correctAnswer: "Buenos días", options: ["Buenos días", "Buenas noches", "Adiós", "Hola"]),
                    QuizQuestion(question: "How do you say 'Good night' in Spanish?", correctAnswer: "Buenas noches", options: ["Buenas noches", "Gracias", "Buenos días", "Siento molestar"]),
                    QuizQuestion(question: "How do you say 'Thank you' in Spanish?", correctAnswer: "Gracias", options: ["Gracias", "Hola", "Adiós", "Siento molestar"]),
                    QuizQuestion(question: "How do you say 'Excuse me' in Spanish?", correctAnswer: "Siento molestar", options: ["Siento molestar", "Gracias", "Buenos días", "Buenas noches"]),
                    QuizQuestion(question: "How do you say 'Please' in Spanish?", correctAnswer: "Por favor", options: ["Por favor", "Gracias", "Adiós", "Hola"])
                ])
            ),
            Topic(
                name: "Numbers",
                lesson: """
                    This lesson focuses on learning numbers from 1 to 10 in Spanish. Numbers are fundamental in daily communication, whether you're shopping, telling time, or simply counting objects. By the end of this lesson, you'll be able to count to ten and use these numbers in simple sentences, enhancing your ability to communicate basic numerical information.
                    """,
                flashcards: [
                    Flashcard(word: "One", translation: "Uno"),
                    Flashcard(word: "Two", translation: "Dos"),
                    Flashcard(word: "Three", translation: "Tres"),
                    Flashcard(word: "Four", translation: "Cuatro"),
                    Flashcard(word: "Five", translation: "Cinco"),
                    Flashcard(word: "Six", translation: "Seis"),
                    Flashcard(word: "Seven", translation: "Siete"),
                    Flashcard(word: "Eight", translation: "Ocho"),
                    Flashcard(word: "Nine", translation: "Nueve"),
                    Flashcard(word: "Ten", translation: "Diez")
                ],
                quiz: Quiz(questions: [
                    QuizQuestion(question: "How do you say 'Two' in Spanish?", correctAnswer: "Dos", options: ["Dos", "Uno", "Tres", "Cuatro"]),
                    QuizQuestion(question: "How do you say 'Three' in Spanish?", correctAnswer: "Tres", options: ["Tres", "Cuatro", "Dos", "Cinco"]),
                    QuizQuestion(question: "How do you say 'Four' in Spanish?", correctAnswer: "Cuatro", options: ["Cuatro", "Tres", "Cinco", "Seis"]),
                    QuizQuestion(question: "How do you say 'Five' in Spanish?", correctAnswer: "Cinco", options: ["Cinco", "Cuatro", "Seis", "Siete"]),
                    QuizQuestion(question: "How do you say 'Six' in Spanish?", correctAnswer: "Seis", options: ["Seis", "Cinco", "Siete", "Ocho"]),
                    QuizQuestion(question: "How do you say 'Seven' in Spanish?", correctAnswer: "Siete", options: ["Siete", "Ocho", "Seis", "Nueve"]),
                    QuizQuestion(question: "How do you say 'Ten' in Spanish?", correctAnswer: "Diez", options: ["Diez", "Nueve", "Ocho", "Siete"])
                ])
            ),
            Topic(
                name: "Colors",
                lesson: """
                    In this lesson, you will learn the names of common colors in Spanish. Colors are used frequently in descriptions and can help you add detail to your conversations. You'll learn how to describe objects by their color and understand color-related vocabulary, which is useful in various situations like shopping for clothes or describing your surroundings.
                    """,
                flashcards: [
                    Flashcard(word: "Red", translation: "Rojo"),
                    Flashcard(word: "Blue", translation: "Azul"),
                    Flashcard(word: "Green", translation: "Verde"),
                    Flashcard(word: "Yellow", translation: "Amarillo"),
                    Flashcard(word: "Black", translation: "Negro")
                ],
                quiz: Quiz(questions: [
                    QuizQuestion(question: "How do you say 'Blue' in Spanish?", correctAnswer: "Azul", options: ["Azul", "Rojo", "Verde", "Amarillo"]),
                    QuizQuestion(question: "How do you say 'Red' in Spanish?", correctAnswer: "Rojo", options: ["Rojo", "Azul", "Negro", "Amarillo"]),
                    QuizQuestion(question: "How do you say 'Green' in Spanish?", correctAnswer: "Verde", options: ["Verde", "Azul", "Rojo", "Amarillo"]),
                    QuizQuestion(question: "How do you say 'Yellow' in Spanish?", correctAnswer: "Amarillo", options: ["Amarillo", "Verde", "Azul", "Rojo"]),
                    QuizQuestion(question: "How do you say 'Black' in Spanish?", correctAnswer: "Negro", options: ["Negro", "Azul", "Rojo", "Verde"]),
                    QuizQuestion(question: "How do you say 'White' in Spanish?", correctAnswer: "Blanco", options: ["Blanco", "Negro", "Azul", "Rojo"]),
                    QuizQuestion(question: "How do you say 'Purple' in Spanish?", correctAnswer: "Morado", options: ["Morado", "Azul", "Amarillo", "Rojo"])
                ])
            ),
            Topic(
                name: "Family Members",
                lesson: """
                    This lesson introduces vocabulary related to family members. Understanding these terms is crucial for discussing personal life and relationships. You'll learn how to refer to immediate family members like parents, siblings, and extended family such as grandparents and cousins. This knowledge will enable you to talk about your family and inquire about others'.
                    """,
                flashcards: [
                    Flashcard(word: "Father", translation: "Padre"),
                    Flashcard(word: "Mother", translation: "Madre"),
                    Flashcard(word: "Brother", translation: "Hermano"),
                    Flashcard(word: "Sister", translation: "Hermana")
                ],
                quiz: Quiz(questions: [
                    QuizQuestion(question: "How do you say 'Father' in Spanish?", correctAnswer: "Padre", options: ["Padre", "Madre", "Hermano", "Hermana"]),
                    QuizQuestion(question: "How do you say 'Mother' in Spanish?", correctAnswer: "Madre", options: ["Madre", "Padre", "Hermano", "Hermana"]),
                    QuizQuestion(question: "How do you say 'Brother' in Spanish?", correctAnswer: "Hermano", options: ["Hermano", "Padre", "Madre", "Hermana"]),
                    QuizQuestion(question: "How do you say 'Sister' in Spanish?", correctAnswer: "Hermana", options: ["Hermana", "Padre", "Madre", "Hermano"]),
                    QuizQuestion(question: "How do you say 'Grandfather' in Spanish?", correctAnswer: "Abuelo", options: ["Abuelo", "Hermana", "Padre", "Madre"]),
                    QuizQuestion(question: "How do you say 'Grandmother' in Spanish?", correctAnswer: "Abuela", options: ["Abuela", "Padre", "Madre", "Hermano"]),
                    QuizQuestion(question: "How do you say 'Uncle' in Spanish?", correctAnswer: "Tío", options: ["Tío", "Hermana", "Madre", "Padre"])
                ])
            ),
            Topic(
                name: "Days of the Week",
                lesson: """
                    In this lesson, you'll learn the days of the week in Spanish. Knowing these is essential for scheduling activities, making plans, and understanding time-related conversations. By mastering this vocabulary, you'll be able to discuss events happening on specific days and comprehend calendar-related topics.
                    """,
                flashcards: [
                    Flashcard(word: "Monday", translation: "Lunes"),
                    Flashcard(word: "Tuesday", translation: "Martes"),
                    Flashcard(word: "Wednesday", translation: "Miércoles"),
                    Flashcard(word: "Thursday", translation: "Jueves"),
                    Flashcard(word: "Friday", translation: "Viernes")
                ],
                quiz: Quiz(questions: [
                    QuizQuestion(question: "How do you say 'Monday' in Spanish?", correctAnswer: "Lunes", options: ["Lunes", "Martes", "Miércoles", "Viernes"]),
                    QuizQuestion(question: "How do you say 'Tuesday' in Spanish?", correctAnswer: "Martes", options: ["Martes", "Lunes", "Miércoles", "Viernes"]),
//                    QuizQuestion(question: "How do you say 'Wednesday' in Spanish?", correctAnswer: "Miércoles", options: ["Miércoles", "Martes", "Jueves", "Viernes"]),
//                    QuizQuestion(question: "How do you say 'Thursday' in Spanish?", correctAnswer: "Jueves", options: ["Jueves", "Lunes", "Martes", "Viernes"]),
//                    QuizQuestion(question: "How do you say 'Friday' in Spanish?", correctAnswer: "Viernes", options: ["Viernes", "Lunes", "Martes", "Jueves"]),
//                    QuizQuestion(question: "How do you say 'Saturday' in Spanish?", correctAnswer: "Sábado", options: ["Sábado", "Domingo", "Lunes", "Viernes"]),
//                    QuizQuestion(question: "How do you say 'Sunday' in Spanish?", correctAnswer: "Domingo", options: ["Domingo", "Lunes", "Sábado", "Viernes"])
                ])
            )
        ]

        
        topics = sampleTopics
    }
    // Fetch a topic by ID - helps avoid direct binding manipulation
    func fetchTopic(by id: UUID) -> Topic? {
        return topics.first(where: { $0.id == id })
    }
    
    // Update methods with topicID instead of direct topic binding
    func markFlashcardsComplete(for topicID: UUID) {
        if let index = topics.firstIndex(where: { $0.id == topicID }) {
            topics[index].markFlashcardsComplete()
        }
    }
    
    func unmarkFlashcardsComplete(for topicID: UUID) {
        if let index = topics.firstIndex(where: { $0.id == topicID }) {
            topics[index].unmarkFlashcardsComplete()
        }
    }
    
    func markQuizComplete(for topicID: UUID) {
        if let index = topics.firstIndex(where: { $0.id == topicID }) {
            topics[index].markQuizComplete()
        }
    }
    
    func unmarkQuizComplete(for topicID: UUID) {
        if let index = topics.firstIndex(where: { $0.id == topicID }) {
            topics[index].isQuizCompleted = false
        }
    }
    
    func updateHighScore(for topicID: UUID, newScore: Int) {
        if let index = topics.firstIndex(where: { $0.id == topicID }) {
            topics[index].highScore = max(topics[index].highScore, newScore)
        }
    }
}
