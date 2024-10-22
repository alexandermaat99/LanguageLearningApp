//
//  QuizViewModel.swift
//  LanguageLearningApp
//
//  Created by Alexander Maat on 10/22/24.
//

import SwiftUI

class QuizViewModel: ObservableObject {
    @Published var quiz: Quiz
    @Published var currentIndex: Int = 0
    @Published var currentScore: Int = 0
    @Published var showAnswerFeedback: Bool = false
    @Published var isCorrect: Bool = false
    @Published var elapsedTime: Double = 0.0
    @Published var quizCompleted: Bool = false
    
    var timer: Timer?

    init(quiz: Quiz) {
        self.quiz = quiz
        startTimer()  // Start timer when quiz begins
    }

    func startTimer() {
        elapsedTime = 0.0
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.elapsedTime += 1.0
        }
    }

    func stopTimer() {
        timer?.invalidate()
    }

    func submitAnswer(_ answer: String) {
        stopTimer()

        if quiz.questions[currentIndex].correctAnswer == answer {
            isCorrect = true
            currentScore += 10  // Base points
            let bonus = max(0, Int((20 - elapsedTime) / 2))  // Time-based bonus
            currentScore += bonus
        } else {
            isCorrect = false
        }

        showAnswerFeedback = true
    }

    func nextQuestion() {
        showAnswerFeedback = false
        if currentIndex + 1 < quiz.questions.count {
            currentIndex += 1
            startTimer()  // Reset timer for the next question
        } else {
            quizCompleted = true  // Quiz is finished
        }
    }

    func resetQuiz() {
        currentIndex = 0
        currentScore = 0
        quizCompleted = false
        startTimer()
    }
}
