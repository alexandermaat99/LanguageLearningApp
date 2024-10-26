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
    
    var timer: Timer?  // Timer for tracking elapsed time
    
    private var soundPlayer = SoundPlayer()
    
    init(quiz: Quiz) {
        // Initialize the view model with a quiz
        self.quiz = quiz
        startTimer()  // Start timer when quiz begins
    }

// MARK: Timer Functionality
    
    func startTimer() {
        // Start the timer when the quiz begins
        elapsedTime = 0.0
        timer?.invalidate()  // Ensure any existing timer is stopped

        // Create a new timer that increments the elapsed time every second
        //withTimeInterval is the time interval between each fire of the timer
        //repeats is a Boolean value that determines whether the timer should repeatedly reschedule itself
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.elapsedTime += 1.0
        }
    }
    
    //timer? is an optional value, so we need to unwrap it before calling invalidate()
    //invalidate() stops the timer from firing
    func stopTimer() {
        timer?.invalidate()
    }
    
// MARK: Answering Functionality
    
    func submitAnswer(_ answer: String) {
        //answer is pulled from the view and passed to the view model
        selectedAnswer = answer
        stopTimer()  // Stop the timer when an answer is submitted

        // Check if the submitted answer is correct
        if quiz.questions[currentIndex].correctAnswer == answer {
            isCorrect = true
            correctCounter += 1
            addedScore = 10
            currentScore += addedScore  // Base points for a correct answer
            //max is a function that returns the greater of two values
            // 20 - elapsedTime is the time remaining divided by 2
            let bonus = max(0, Int((20 - elapsedTime) / 2))  // Time-based bonus points
            addedScore += bonus
            currentScore += bonus  // Add bonus points to score
            // task is a function that creates a new asynchronous task
            Task {
                
                //await is a keyword that suspends the current task until the asynchronous operation completes
                //soundPlayer is an instance of SoundPlayer, which is a class that plays sounds
                await soundPlayer.playSound(named: "Click.m4a")
            }
        } else {
            // does't assign incorrect but instead assigns opposite of correct
            isCorrect = false
            incorrectCounter += 1
            Task {
                await soundPlayer.playSound(named: "Click2.m4a")
            }
        }

        // Show the answer feedback for a brief moment before moving to the next question
        //showAnswerFeedback is a Boolean value that determines whether the answer feedback is displayed
        withAnimation {
            showAnswerFeedback = true
        }

        // Move to the next question after a brief delay
        //DispatchQueue is a class that manages the execution of work items
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.nextQuestion()
            self.addedScore = 0
        }
    }
    
//MARK: Question Advance Functionality

    func nextQuestion() {
        // Move to the next question in the quiz
        //showAnswerFeedback is set to false to hide the answer feedback
        showAnswerFeedback = false
        //selected answer is set to nil to clear the selected answer
        selectedAnswer = nil
        //isCorrect is set to false to reset the correct answer status
        isCorrect = false

        // Check if there are more questions in the quiz
        if currentIndex + 1 < quiz.questions.count {
            currentIndex += 1
            startTimer()  // Reset timer for the next question
        } else {
            quizCompleted = true
            stopTimer()  // Stop the timer when the quiz is completed
        }
    }
    
//MARK: Reset Quiz Functionality

    //quiz is reset to the first question, the score is reset to 0, and the quizCompleted flag is set to false
    func resetQuiz() {
        currentIndex = 0
        currentScore = 0
        quizCompleted = false
        selectedAnswer = nil
        startTimer()
    }
}
