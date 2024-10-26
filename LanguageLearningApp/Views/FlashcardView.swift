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
    var topicID: UUID  // Use topicID instead of the entire Topic object

    var body: some View {
        VStack {
            Spacer()
            
            // Flashcard flip animation
            ZStack {
                if viewModel.showTranslation {
                    Text(viewModel.flashcards[viewModel.currentIndex].translation)
                        .font(.largeTitle)
                        .padding()
                        .frame(width: 300, height: 200)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .rotation3DEffect(.degrees(viewModel.showTranslation ? 180 : 0), axis: (x: 0, y: 0, z: 0))
                        .onTapGesture {
                            viewModel.toggleFlashcard()
                        }
                } else {
                    Text(viewModel.flashcards[viewModel.currentIndex].word)
                        .font(.largeTitle)
                        .padding()
                        .frame(width: 300, height: 200)
                        .background(Color.orange)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .rotation3DEffect(.degrees(viewModel.showTranslation ? 0 : 180), axis: (x: 0, y: 0, z: 0))
                        .onTapGesture {
                            viewModel.toggleFlashcard()
                        }
                }
            }
            .animation(.easeInOut, value: viewModel.showTranslation)

            Spacer()

            // Navigation Buttons for flashcards
            HStack {
                Button(action: {
                    viewModel.previousFlashcard()
                }) {
                    Text("Previous")
                        .font(.title)
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }

                Spacer()

                Button(action: {
                    viewModel.nextFlashcard()
                }) {
                    Text("Next")
                        .font(.title)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()

            // Completion Toggle Button
            Button(action: {
                if let topic = topicViewModel.topics.first(where: { $0.id == topicID }) {
                    if topic.isFlashcardsCompleted {
                        topicViewModel.unmarkFlashcardsComplete(for: topicID)
                    } else {
                        topicViewModel.markFlashcardsComplete(for: topicID)
                    }
                }
            }) {
                Text(topicViewModel.topics.first(where: { $0.id == topicID })?.isFlashcardsCompleted == true ? "Unmark Flashcards as Complete" : "Mark Flashcards as Complete")
                    .font(.title2)
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            
        }
        .padding()
        .navigationTitle("Flashcards")
    }
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
        
        FlashcardView(
            viewModel: FlashcardViewModel(flashcards: topic.flashcards),
            topicID: topic.id
        )
        .environmentObject(TopicViewModel())
    }
}
