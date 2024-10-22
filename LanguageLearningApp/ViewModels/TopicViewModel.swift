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
                    Flashcard(word: "Good night", translation: "Buenas noches")
                ],
                quiz: Quiz(questions: [
                    QuizQuestion(question: "How do you say 'Hello' in Spanish?", correctAnswer: "Hola", options: ["Hola", "Adiós", "Gracias"]),
                    QuizQuestion(question: "How do you say 'Goodbye' in Spanish?", correctAnswer: "Adiós", options: ["Hola", "Adiós", "Gracias"])
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
                    QuizQuestion(question: "How do you say 'Two' in Spanish?", correctAnswer: "Dos", options: ["Uno", "Dos", "Tres"]),
                    QuizQuestion(question: "How do you say 'Three' in Spanish?", correctAnswer: "Tres", options: ["Uno", "Dos", "Tres"])
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
                    Flashcard(word:"Yellow", translation:"Amarillo"),
                    Flashcard(word:"Black", translation:"Negro")
                ],
                quiz: Quiz(questions:[
                    QuizQuestion(question:"How do you say 'Blue' in Spanish?", correctAnswer:"Azul", options:["Rojo","Azul","Verde"]),
                    QuizQuestion(question:"How do you say 'Red' in Spanish?", correctAnswer:"Rojo", options:["Rojo","Azul","Verde"])
                ])
            ),
            Topic(
                name:"Family Members",
                lesson:
                  """
                  This lesson introduces vocabulary related to family members. Understanding these terms is crucial for discussing personal life and relationships. You'll learn how to refer to immediate family members like parents, siblings, and extended family such as grandparents and cousins. This knowledge will enable you to talk about your family and inquire about others'.
                  """,
                flashcards:[
                    Flashcard(word:"Father",translation:"Padre"),
                    Flashcard(word:"Mother",translation:"Madre"),
                    Flashcard(word:"Brother",translation:"Hermano"),
                    Flashcard(word:"Sister",translation:"Hermana")
                ],
                quiz:
                    Quiz(questions:[
                        QuizQuestion(question:"How do you say 'Father' in Spanish?",correctAnswer:"Padre", options:["Padre","Madre","Hermano"]),
                        QuizQuestion(question:"How do you say 'Sister' in Spanish?",correctAnswer:"Hermana", options:["Hermano","Hermana","Abuelo"])
                    ])
            ),
            Topic(
                name:"Days of the Week",
                lesson:
                  """
                  In this lesson, you'll learn the days of the week in Spanish. Knowing these is essential for scheduling activities, making plans, and understanding time-related conversations. By mastering this vocabulary, you'll be able to discuss events happening on specific days and comprehend calendar-related topics.
                  """,
                flashcards:[
                    Flashcard(word:"Monday", translation:"Lunes"),
                    Flashcard(word:"Tuesday", translation:"Martes"),
                    Flashcard(word:"Wednesday", translation:"Miércoles"),
                    Flashcard(word:"Thursday", translation:"Jueves"),
                    Flashcard(word:"Friday", translation:"Viernes")
                ],
                quiz:
                    Quiz(questions:[
                        QuizQuestion(question:"How do you say 'Wednesday' in Spanish?", correctAnswer:"Miércoles", options:["Martes","Miércoles","Jueves"])
                    ])
            )
        ]
        
        topics = sampleTopics
    }
}
