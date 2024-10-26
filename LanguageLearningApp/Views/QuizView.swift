//
//  QuizView.swift
//  LanguageLearningApp
//
//  Created by Alexander Maat on 10/25/24.
//

import SwiftUI

struct QuizView: View {
    @ObservedObject var viewModel: QuizViewModel
    @EnvironmentObject var topicViewModel: TopicViewModel
    @Environment(\.dismiss) var dismiss
    var topicID: UUID

    var body: some View {
        VStack {
            if viewModel.quizCompleted {
                Text("Quiz Completed!")
                    .font(.largeTitle)
                    .padding()
                
                Text("\(viewModel.correctCounter) of \(viewModel.quiz.questions.count) questions correct.")
                    .padding()
                    .font(.headline)
                
                Text("Final Score: \(viewModel.currentScore)")
                    .font(.title)
                
                // Button to retake the quiz
                Button(action: {
                    viewModel.resetQuiz()
                    topicViewModel.unmarkQuizComplete(for: topicID) // Unmark quiz complete if retaking
                }) {
                    Text("Take Quiz Again")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                // Conditionally show "Mark Quiz as Complete" if all answers are correct
                if viewModel.correctCounter == viewModel.quiz.questions.count {
                    Button(action: {
                        topicViewModel.markQuizComplete(for: topicID)
                        dismiss() // Dismiss the QuizView to go back to LessonView
                    }) {
                        Text("Mark Quiz as Complete")
                            .font(.title2)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.top, 10)
                }
            } else {
                Text(viewModel.quiz.questions[viewModel.currentIndex].question)
                    .font(.title)
                    .padding()
                
                if viewModel.showAnswerFeedback {
                    Text(viewModel.isCorrect ? "Correct! + \(viewModel.addedScore)" : "Incorrect")
                        .font(.headline)
                        .foregroundColor(viewModel.isCorrect ? .green : .red)
                        .transition(.opacity)
                        .padding()
                } else {
                    Text(" ")
                        .font(.headline)
                        .padding()
                        .opacity(0) // Invisible placeholder
                }
                
                // Display answer options
                ForEach(viewModel.quiz.questions[viewModel.currentIndex].options, id: \.self) { option in
                    Button(action: {
                        viewModel.submitAnswer(option)
                    }) {
                        Text(option)
                            .font(.title2)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                viewModel.selectedAnswer == option
                                    ? (viewModel.isCorrect ? Color.green : Color.red)
                                    : Color.gray
                            )
                            .foregroundColor(.white)
                            .overlay(
                                viewModel.selectedAnswer != nil &&
                                viewModel.selectedAnswer != viewModel.quiz.questions[viewModel.currentIndex].correctAnswer &&
                                option == viewModel.quiz.questions[viewModel.currentIndex].correctAnswer
                                    ? RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.green, lineWidth: 10)
                                    : nil
                            )
                            .cornerRadius(10)
                    }
                    .padding(.bottom, 5)
                    .animation(.easeInOut(duration: 0.5), value: viewModel.selectedAnswer)
                }
                
                ProgressView("Time Bonus", value: min(viewModel.elapsedTime, 20.0), total: 20.0)
                    .progressViewStyle(LinearProgressViewStyle(tint: Color.blue))
                    .padding()
                
                Text("Current Score: \(viewModel.currentScore)")
                    .font(.title2)
                    .padding(.top, 20)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Quiz")
    }
}


struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleQuiz = Quiz(questions: [
            QuizQuestion(question: "What is the capital of Spain?", correctAnswer: "Madrid", options: ["Madrid", "Barcelona", "Seville"]),
            QuizQuestion(question: "How do you say 'apple' in Spanish?", correctAnswer: "manzana", options: ["manzana", "pera", "naranja"]),
            QuizQuestion(question: "How do you say 'car' in Spanish?", correctAnswer: "coche", options: ["coche", "bici", "barco"]),
            QuizQuestion(question: "What is the color of the sky?", correctAnswer: "blue", options: ["red", "blue", "green"])
        ])
        
        let sampleTopic = Topic(
            name: "Sample Topic",
            lesson: "This is a sample lesson for Spanish basics.",
            flashcards: [
                Flashcard(word: "Hello", translation: "Hola"),
                Flashcard(word: "Goodbye", translation: "Adiós")
            ],
            quiz: sampleQuiz
        )
        
        return QuizView(viewModel: QuizViewModel(quiz: sampleQuiz), topicID: sampleTopic.id)
            .environmentObject(TopicViewModel())
    }
}
