//
//  QuizView.swift
//  LanguageLearningApp
//
//  Created by Alexander Maat on 10/22/24.
//
import SwiftUI

struct QuizView: View {
    @ObservedObject var viewModel: QuizViewModel
    
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
                Button(action: {
                    viewModel.resetQuiz()
                }) {
                    Text("Quiz Again")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
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
                    // Placeholder with the same height as the feedback text
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
                                // Check if option is selected and correct/incorrect
                                viewModel.selectedAnswer == option
                                    ? (viewModel.isCorrect ? Color.green : Color.red)
                                    : Color.gray
                            )
                            .foregroundColor(.white)
                            .overlay(
                                // Outline correct answer in green if answer is incorrect
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
            QuizQuestion(question: "How do you say 'apple' in Spanish?", correctAnswer: "manzana", options: ["manzana", "pera", "naranja"]),
            QuizQuestion(question: "How do you say 'apple' in Spanish?", correctAnswer: "manzana", options: ["manzana", "pera", "naranja"])
        ])
        QuizView(viewModel: QuizViewModel(quiz: sampleQuiz))
    }
}



