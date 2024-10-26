//
//  FlashcardView.swift
//  LanguageLearningApp
//
//  Created by Alexander Maat on 10/22/24.
//

import SwiftUI

//creates a struct
struct FlashcardView: View {
    //brings in the FlashcardViewModel as viewModel, this has the function to mess with cards as well as the flashcards array
    @ObservedObject var viewModel: FlashcardViewModel
    @EnvironmentObject var topicViewModel: TopicViewModel
    var topic: Topic

    var body: some View {
        VStack {
            Spacer()
            
            // Flashcard flip animation
            ZStack {
                
                if viewModel.showTranslation {
                    // If 'showTranslation' is true, we display the translation side of the flashcard.
                    Text(viewModel.flashcards[viewModel.currentIndex].translation)
                        .font(.largeTitle)
                        .padding()
                        .frame(width: 300, height: 200)  // Size of the card
                        .background(Color.blue)  // Background color for the translation side
                        .cornerRadius(10)  // Rounded corners for the card
                        .foregroundColor(.white)  // Text color
                        // The rotation effect creates the flip animation. Since we're showing the translation,
                        // the card is rotated 180 degrees on the y-axis.
                        .rotation3DEffect(.degrees(viewModel.showTranslation ? 180 : 0), axis: (x: 0, y: 0, z: 0))
                        // Tapping the card will call 'toggleFlashcard()', flipping it back to the word side.
                        .onTapGesture {
                            viewModel.toggleFlashcard()
                        }
                } else {
                    // If 'showTranslation' is false, we display the word side of the flashcard.
                    Text(viewModel.flashcards[viewModel.currentIndex].word)
                        .font(.largeTitle)
                        .padding()
                        .frame(width: 300, height: 200)  // Size of the card
                        .background(Color.orange)  // Background color for the word side
                        .cornerRadius(10)  // Rounded corners for the card
                        .foregroundColor(.white)  // Text color
                        // The rotation effect creates the flip animation. Since we're showing the word,
                        // the card is not rotated (0 degrees) on the y-axis.
                        .rotation3DEffect(.degrees(viewModel.showTranslation ? 0 : 180), axis: (x: 0, y: 0, z: 0))
                        // Tapping the card will call 'toggleFlashcard()', flipping it to the translation side.
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
            Button(action: {
                if topic.isFlashcardsCompleted {
                    topicViewModel.unmarkFlashcardsComplete(for: topic)
                } else {
                    topicViewModel.markFlashcardsComplete(for: topic)
                }
            }) {
                Text(topic.isFlashcardsCompleted ? "Unmark Flashcards as Complete" : "Mark Flashcards as Complete")
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
            topic: topic
        )
        .environmentObject(TopicViewModel()) // Provide TopicViewModel for EnvironmentObject
    }
}

