//
//  FlashcardView.swift
//  LanguageLearningApp
//
//  Created by Alexander Maat on 10/25/24.
//

import SwiftUI

struct LessonView: View {
    @EnvironmentObject var topicViewModel: TopicViewModel
    let topicID: UUID
    
    var body: some View {
        if let topic = topicViewModel.topics.first(where: { $0.id == topicID }) {
            ScrollView {
                VStack(spacing: 20) {
                    // Lesson Text
                    VStack(alignment: .leading, spacing: 8) {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Lesson")
                                .font(.headline)
                                .foregroundColor(.secondary)
                            
                            Text(topic.lesson)
                                .font(.body)
                                .foregroundColor(.primary)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(.systemBackground))
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                    }
                    
                    // Progress Section
                    VStack(alignment: .leading, spacing: 8) {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Learn")
                                .font(.headline)
                                .foregroundColor(.secondary)
                            ProgressRow(label: "Flashcards", isCompleted: topic.isFlashcardsCompleted)
                            ProgressRow(label: "Quiz", isCompleted: topic.isQuizCompleted)
                            Text("Your High Score: \(topic.highScore)")
                                .font(.headline)
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                        
                    }

                    
                    // Study Buttons
                    VStack(spacing: 15) {
                        NavigationLink(destination: FlashcardView(
                            viewModel: FlashcardViewModel(flashcards: topic.flashcards),
                            topicID: topic.id
                        )) {
                            StudyButton(title: "Study Flashcards", color: .blue)
                        }
                        
                        NavigationLink(destination: QuizView(
                            viewModel: QuizViewModel(
                                quiz: topic.quiz,
                                updateHighScore: { newHighScore in
                                    topicViewModel.updateHighScore(for: topicID, newScore: newHighScore)
                                }
                            ),
                            topicID: topic.id,
                            topicName: topic.name // Add this argument
                        )) {
                            StudyButton(title: "Quiz Yourself", color: .green)
                        }

                        
                        if topic.isQuizCompleted {
                            Button(action: {
                                topicViewModel.unmarkQuizComplete(for: topicID)
                            }) {
                                StudyButton(title: "Mark Quiz as Incomplete", color: .red)
                            }
                        }
                    }
                    
                    // Vocabulary List
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Vocabulary")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        VocabularyView(vocabList: topic.flashcards.map { ($0.word, $0.translation) })
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                }
                .padding()
                .navigationTitle(topic.name)
            }
            .background(Color(.systemGroupedBackground))
        } else {
            Text("Topic not found")
                .foregroundColor(.red)
        }
    }
}

struct ProgressRow: View {
    let label: String
    let isCompleted: Bool
    
    var body: some View {
        HStack {
            Text(label)
            Spacer()
            Text(isCompleted ? "Complete" : "Incomplete")
                .foregroundColor(isCompleted ? .green : .primary)
        }
        .font(.headline)
    }
}

struct StudyButton: View {
    let title: String
    let color: Color
    
    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(color)
            .cornerRadius(10)
    }
}

struct LessonView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleTopic = Topic(
            name: "Sample",
            lesson: """
                In this lesson, you will learn basic greetings and salutations in Spanish. Greetings are an essential part of any language as they help you make a good first impression. You will learn how to say 'Hello', 'Goodbye', and other common phrases used in everyday interactions. Mastering these basics will help you start conversations and connect with Spanish speakers.
                """,
            flashcards: [
                Flashcard(word: "Hello", translation: "Hola"),
                Flashcard(word: "Goodbye", translation: "Adiós")
            ],
            quiz: Quiz(questions: [
                QuizQuestion(question: "What is the capital of Spain?", correctAnswer: "Madrid", options: ["Madrid", "Barcelona", "Seville"]),
                QuizQuestion(question: "How do you say 'apple' in Spanish?", correctAnswer: "manzana", options: ["manzana", "pera", "naranja"])
            ])
        )
        
        let topicViewModel = TopicViewModel()
        topicViewModel.topics = [sampleTopic]
        
        return NavigationView {
            LessonView(topicID: sampleTopic.id)
                .environmentObject(topicViewModel)
        }
    }
}
