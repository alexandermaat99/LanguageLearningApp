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
    @Published var quizCompleted: Bool = false
    @Published var selectedAnswer: String?  // Track selected answer
    @Published var elapsedTime: Double = 0.0
    @Published var addedScore: Int = 0
    @Published var correctCounter: Int = 0
    @Published var incorrectCounter: Int = 0
    
    private var timer: Timer?  // Timer for tracking elapsed time
    private var updateHighScore: ((Int) -> Void)?  // Callback to update high score
    private var soundPlayer = SoundPlayer()
    
    init(quiz: Quiz, updateHighScore: ((Int) -> Void)? = nil) {
        self.quiz = quiz
        self.updateHighScore = updateHighScore
        startTimer()
    }
    
    // MARK: Timer Functionality
    
    func startTimer() {
        elapsedTime = 0.0
        timer?.invalidate()  // Ensure any existing timer is stopped
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.elapsedTime += 1.0
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
    }
    
    // MARK: Answering Functionality
    
    func submitAnswer(_ answer: String) {
        guard !quizCompleted else { return }
        
        selectedAnswer = answer
        stopTimer()
        
        if quiz.questions[currentIndex].correctAnswer == answer {
            isCorrect = true
            correctCounter += 1
            addedScore = 10
            currentScore += addedScore
            let bonus = max(0, Int((20 - elapsedTime) / 2))
            addedScore += bonus
            currentScore += bonus
            Task { await soundPlayer.playSound(named: "right.m4a") }
        } else {
            isCorrect = false
            incorrectCounter += 1
            Task { await soundPlayer.playSound(named: "wrong.m4a") }
        }
        
        withAnimation { showAnswerFeedback = true }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.showAnswerFeedback = false
            self.selectedAnswer = nil
            self.isCorrect = false
            self.addedScore = 0
            
            // Check if this was the last question
            if self.currentIndex == self.quiz.questions.count - 1 {
                self.quizCompleted = true
                //                if let updateHighScore = self.updateHighScore, self.currentScore > 0 {
                //                    updateHighScore(self.currentScore)
                //                }
            } else {
                self.currentIndex += 1
                self.startTimer()
            }
        }
    }
    
    
    // MARK: Question Advance Functionality
    
    func nextQuestion() {
        showAnswerFeedback = false
        selectedAnswer = nil
        isCorrect = false
        
        currentIndex += 1
        startTimer()
    }
    
    
    
    
    // MARK: Reset Quiz Functionality
    
    func resetQuiz() {
        guard quizCompleted else { return }  // Prevent resetting if not completed
        currentIndex = 0
        currentScore = 0
        quizCompleted = false
        selectedAnswer = nil
        correctCounter = 0
        incorrectCounter = 0
        elapsedTime = 0.0
        startTimer()
    }
}

