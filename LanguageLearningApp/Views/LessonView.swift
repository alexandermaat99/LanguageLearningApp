//
//  LessonView.swift
//  LanguageLearningApp
//
//  Created by Alexander Maat on 10/22/24.
//


import SwiftUI

struct LessonView: View {
    @EnvironmentObject var topicViewModel: TopicViewModel
    var topic: Topic
    

    var body: some View {
        ScrollView {
            VStack {
                //title at the top
                Text(topic.lesson)
               
                    .padding()
                
                //this pulls in vocab list, feeds it topic.flashcards.map and defines that its starting in the top position
                //.map transforms arrayu of Flashcard objets into an array of tuples of word and translation properites
                VocabularyView(vocabList: topic.flashcards.map { ($0.word, $0.translation)})
                
                    .padding()
                
                Text(topic.isFlashcardsCompleted ? "Flashcards: Complete" : "Flashcards: Incomplete")
                    .font(.headline)
                    .padding(.top, 10)
                
                Text(topic.isQuizCompleted ? "Quiz: Complete" : "Quiz: Incomplete")
                    .font(.headline)
                    .padding(.top, 5)
                
                NavigationLink(destination: FlashcardView(viewModel: FlashcardViewModel(flashcards: topic.flashcards), topic: topic)) {
                    Text("Study Flashcards")
                        .font(.title2)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }

                Spacer()
                
                NavigationLink(destination: QuizView(viewModel: QuizViewModel(quiz: topic.quiz), topic: topic)) {
                    Text("Quiz Yourself")
                        .font(.title2)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }


                Spacer()

                
            }
        }
        .navigationTitle(topic.name)
    }
}


struct LessonView_Previews: PreviewProvider {
    static var previews: some View {
        LessonView(topic: Topic(
            name: "Sample",
            lesson: "Sample Lesson",
            flashcards: [
                Flashcard(word: "Hello", translation: "Hola"),
                Flashcard(word: "Goodbye", translation: "Adiós"),
                Flashcard(word: "Goodbye", translation: "Adiós"),
                Flashcard(word: "Goodbye", translation: "Adiós"),
                Flashcard(word: "Goodbye", translation: "Adiós"),
                Flashcard(word: "Goodbye", translation: "Adiós"),
                Flashcard(word: "Goodbye", translation: "Adiós")

            ],
            quiz: Quiz(questions: [])
        ))
    }
}
