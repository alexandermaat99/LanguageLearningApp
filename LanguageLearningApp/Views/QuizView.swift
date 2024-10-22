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
                Text("Final Score: \(viewModel.currentScore)")
                    .font(.title)
                Button(action: {
                    viewModel.resetQuiz()
                }) {
                    Text("Retry Quiz")
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

                // Options as buttons
                ForEach(viewModel.quiz.questions[viewModel.currentIndex].options, id: \.self) { option in
                    Button(action: {
                        viewModel.submitAnswer(option)
                    }) {
                        Text(option)
                            .font(.title2)
                            .padding()
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.bottom, 5)
                    }
                }

                if viewModel.showAnswerFeedback {
                    if viewModel.isCorrect {
                        Text("Correct!")
                            .font(.title)
                            .foregroundColor(.green)
                            .transition(.scale)
                    } else {
                        Text("Incorrect!")
                            .font(.title)
                            .foregroundColor(.red)
                            .transition(.scale)
                        Text("Correct answer: \(viewModel.quiz.questions[viewModel.currentIndex].correctAnswer)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    // Next Question Button
                    Button(action: {
                        viewModel.nextQuestion()
                    }) {
                        Text("Next Question")
                            .font(.title2)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.top)
                }

                // Timer animation showing remaining bonus time
                ProgressView("Time Bonus", value: min(viewModel.elapsedTime, 20), total: 20)
                    .progressViewStyle(LinearProgressViewStyle(tint: Color.blue))
                    .padding()
                
                Text("Current Score: \(viewModel.currentScore)")
                    .font(.title2)
                    .padding(.top, 20)
            }
        }
        .padding()
        .navigationTitle("Quiz")
        .animation(.easeInOut, value: viewModel.showAnswerFeedback)  // Animate feedback transition
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleQuiz = Quiz(questions: [
            QuizQuestion(question: "What is the capital of Spain?", correctAnswer: "Madrid", options: ["Madrid", "Barcelona", "Seville"]),
            QuizQuestion(question: "How do you say 'apple' in Spanish?", correctAnswer: "manzana", options: ["manzana", "pera", "naranja"])
        ])
        QuizView(viewModel: QuizViewModel(quiz: sampleQuiz))
    }
}



