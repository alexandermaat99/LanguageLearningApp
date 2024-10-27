//
//  FlashcardView.swift
//  LanguageLearningApp
//
//  Created by Alexander Maat on 10/25/24.
//
import SwiftUI

struct FlashcardView: View {
    @ObservedObject var viewModel: FlashcardViewModel
    @EnvironmentObject var topicViewModel: TopicViewModel
    var topicID: UUID
    
    @State private var degrees: Double = 0
    @State private var offset: CGFloat = 0
    @State private var opacity: Double = 1
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                // Flashcard flip animation
                ZStack {
                    CardFace(content: viewModel.flashcards[viewModel.currentIndex].word, color: .blue)
                        .opacity(viewModel.showTranslation ? 0 : 1)
                        .rotation3DEffect(.degrees(degrees), axis: (x: 0, y: 1, z: 0))
                    
                    CardFace(content: viewModel.flashcards[viewModel.currentIndex].translation, color: .green)
                        .opacity(viewModel.showTranslation ? 1 : 0)
                        .rotation3DEffect(.degrees(degrees - 180), axis: (x: 0, y: 1, z: 0))
                }
                .frame(height: 300)
                .offset(x: offset)
                .opacity(opacity)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        degrees += 180
                        viewModel.toggleFlashcard()
                    }
                }
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                
                // Card counter
                Text("\(viewModel.currentIndex + 1) / \(viewModel.flashcards.count)")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                // Navigation Buttons for flashcards
                HStack(spacing: 20) {
                    NavigationButton(title: "Previous", color: .gray) {
                        animateCardTransition(direction: .backward)
                    }
                    
                    NavigationButton(title: "Next", color: .blue) {
                        animateCardTransition(direction: .forward)
                    }
                }
                
                // Completion Toggle Button
                CompletionToggleButton(topicViewModel: topicViewModel, topicID: topicID) {
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .padding()
        }
        .navigationTitle("\(topicViewModel.topics.first(where: { $0.id == topicID })?.name ?? "Topic") Flashcards")
        .navigationBarTitleDisplayMode(.inline)
    }

    
    private func resetCard() {
        degrees = 0
        viewModel.showTranslation = false
    }
    
    private func animateCardTransition(direction: CardTransitionDirection) {
        let screenWidth = UIScreen.main.bounds.width
        
        withAnimation(.easeInOut(duration: 0.3)) {
            offset = direction == .forward ? -screenWidth : screenWidth
            opacity = 0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            if direction == .forward {
                viewModel.nextFlashcard()
            } else {
                viewModel.previousFlashcard()
            }
            resetCard()
            offset = direction == .forward ? screenWidth : -screenWidth
            
            withAnimation(.easeInOut(duration: 0.3)) {
                offset = 0
                opacity = 1
            }
        }
    }
}

struct CardFace: View {
    let content: String
    let color: Color
    
    var body: some View {
        Text(content)
            .font(.system(size: 36, weight: .bold, design: .rounded))
            .padding()
            .frame(width: 300, height: 200)
            .background(color.opacity(0.8))
            .cornerRadius(20)
            .foregroundColor(.white)
    }
}

struct NavigationButton: View {
    let title: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(color)
                .cornerRadius(10)
        }
    }
}

struct CompletionToggleButton: View {
    @ObservedObject var topicViewModel: TopicViewModel
    let topicID: UUID
    let onComplete: () -> Void
    
    var body: some View {
        Button(action: {
            if let topic = topicViewModel.topics.first(where: { $0.id == topicID }) {
                if topic.isFlashcardsCompleted {
                    topicViewModel.unmarkFlashcardsComplete(for: topicID)
                } else {
                    topicViewModel.markFlashcardsComplete(for: topicID)
                    onComplete()
                }
            }
        }) {
            Text(topicViewModel.topics.first(where: { $0.id == topicID })?.isFlashcardsCompleted == true ? "Unmark as Complete" : "Mark as Complete")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.purple)
                .cornerRadius(10)
        }
    }
}

enum CardTransitionDirection {
    case forward
    case backward
}

struct FlashcardView_Previews: PreviewProvider {
    static var previews: some View {
        let topic = Topic(
            name: "Sample Topic",
            lesson: "Sample Lesson",
            flashcards: [
                Flashcard(word: "Hello", translation: "Hola"),
                Flashcard(word: "Goodbye", translation: "Adiós")
            ],
            quiz: Quiz(questions: [])
        )
        
        NavigationView {
            FlashcardView(
                viewModel: FlashcardViewModel(flashcards: topic.flashcards),
                topicID: topic.id
            )
            .environmentObject(TopicViewModel())
        }
    }
}
