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
    var topicName: String

    @State private var bonusPointsScale: CGFloat = 1.0
    @State private var highScoreUpdated = false

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                if viewModel.quizCompleted {
                    quizCompletedView
                } else {
                    quizInProgressView
                }
            }
            .padding()
        }
        .navigationTitle("\(topicName) Quiz")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var quizCompletedView: some View {
        VStack(spacing: 30) {
            Text("Quiz Completed!")
                .font(.system(size: 36, weight: .bold, design: .rounded))
                .foregroundColor(.primary)
            
            VStack(spacing: 10) {
                Text("\(viewModel.correctCounter) of \(viewModel.quiz.questions.count) questions correct")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                Text("Final Score: \(viewModel.currentScore)")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(.primary)
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(15)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
            
            Button(action: {
                viewModel.resetQuiz()
                topicViewModel.unmarkQuizComplete(for: topicID)
                highScoreUpdated = false
            }) {
                Text("Take Quiz Again")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            if viewModel.correctCounter == viewModel.quiz.questions.count {
                Button(action: {
                    topicViewModel.markQuizComplete(for: topicID)
                    dismiss()
                }) {
                    Text("Mark Quiz as Complete")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(10)
                }
            }
        }
        .task {
            if !highScoreUpdated, viewModel.currentScore > topicViewModel.fetchTopic(by: topicID)?.highScore ?? 0 {
                topicViewModel.updateHighScore(for: topicID, newScore: viewModel.currentScore)
                highScoreUpdated = true
            }
        }
    }
    
    private var quizInProgressView: some View {
        VStack(spacing: 20) {
            Text(viewModel.quiz.questions[viewModel.currentIndex].question)
                .font(.system(size: 24, weight: .semibold, design: .rounded))
                .multilineTextAlignment(.center)
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
            
            if viewModel.showAnswerFeedback {
                Text(viewModel.isCorrect ? "Correct! + \(viewModel.addedScore)" : "Incorrect")
                    .font(.headline)
                    .foregroundColor(viewModel.isCorrect ? .green : .red)
                    .scaleEffect(bonusPointsScale)
                    .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.5), value: bonusPointsScale)
                    .onAppear { bonusPointsScale = 1.5 }
                    .onDisappear { bonusPointsScale = 1.0 }
            } else {
                Color.clear.frame(height: 20)
            }
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                ForEach(viewModel.quiz.questions[viewModel.currentIndex].options, id: \.self) { option in
                    Button(action: {
                        viewModel.submitAnswer(option)
                    }) {
                        Text(option)
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity, minHeight: 44)
                            .background(
                                viewModel.selectedAnswer == option
                                ? (viewModel.isCorrect ? Color.green : Color.red)
                                : Color.blue
                            )
                            .cornerRadius(10)
                            .overlay(
                                viewModel.selectedAnswer != nil &&
                                viewModel.selectedAnswer != viewModel.quiz.questions[viewModel.currentIndex].correctAnswer &&
                                option == viewModel.quiz.questions[viewModel.currentIndex].correctAnswer
                                ? RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.green, lineWidth: 8)
                                : nil
                            )
                    }
                    .disabled(viewModel.selectedAnswer != nil)
                    .animation(.easeInOut(duration: 0.3), value: viewModel.selectedAnswer)
                }
            }
            
            VStack(spacing: 5) {
                ProgressView("Time Bonus", value: min(viewModel.elapsedTime, 20.0), total: 20.0)
                    .progressViewStyle(LinearProgressViewStyle(tint: Color.blue))
                
                Text("Current Score: \(viewModel.currentScore)")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                Text("Question \(viewModel.currentIndex + 1) of \(viewModel.quiz.questions.count)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(15)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        }
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleQuiz = Quiz(questions: [
            QuizQuestion(question: "What is the capital of France?", correctAnswer: "Paris", options: ["London", "Berlin", "Paris", "Madrid"]),
            QuizQuestion(question: "Which planet is known as the Red Planet?", correctAnswer: "Mars", options: ["Venus", "Mars", "Jupiter", "Saturn"])
        ])
        
        let viewModel = QuizViewModel(quiz: sampleQuiz) { _ in }
        let topicViewModel = TopicViewModel()
        
        NavigationView {
            QuizView(viewModel: viewModel, topicID: UUID(), topicName: "Sample Topic")
                .environmentObject(topicViewModel)
        }
    }
}
