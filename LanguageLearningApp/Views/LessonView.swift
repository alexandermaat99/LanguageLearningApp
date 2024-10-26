import SwiftUI

struct LessonView: View {
    @EnvironmentObject var topicViewModel: TopicViewModel
    let topicID: UUID  // Pass topic ID instead of the entire Topic

    var body: some View {
        // Retrieve the topic directly from the ViewModel using topicID
        if let topic = topicViewModel.topics.first(where: { $0.id == topicID }) {
            ScrollView {
                VStack {
                    Text(topic.lesson)
                        .padding()

                    VocabularyView(vocabList: topic.flashcards.map { ($0.word, $0.translation) })
                        .padding()

                    Text(topic.isFlashcardsCompleted ? "Flashcards: Complete" : "Flashcards: Incomplete")
                        .font(.headline)
                        .padding(.top, 10)

                    Text(topic.isQuizCompleted ? "Quiz: Complete" : "Quiz: Incomplete")
                        .font(.headline)
                        .padding(.top, 5)

                    Text("High Score: \(topic.highScore)") // Display high score
                        .font(.headline)
                        .padding(.top, 10)

                    NavigationLink(destination: FlashcardView(
                        viewModel: FlashcardViewModel(flashcards: topic.flashcards),
                        topicID: topic.id  // Pass only the topic ID to FlashcardView
                    )) {
                        Text("Study Flashcards")
                            .font(.title2)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }

                    Spacer()

                    NavigationLink(destination: QuizView(
                        viewModel: QuizViewModel(
                            quiz: topic.quiz,
                            updateHighScore: { newHighScore in
                                topicViewModel.updateHighScore(for: topicID, newScore: newHighScore)
                            }
                        ),
                        topicID: topic.id  // Pass only the topic ID to QuizView
                    )) {
                        Text("Quiz Yourself")
                            .font(.title2)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }

                    if topic.isQuizCompleted {
                        Button(action: {
                            topicViewModel.unmarkQuizComplete(for: topicID)
                        }) {
                            Text("Mark Quiz as Incomplete")
                                .font(.title2)
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                }
                .navigationTitle(topic.name)
            }
        } else {
            Text("Topic not found")
                .foregroundColor(.red)
        }
    }
}

struct LessonView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleTopic = Topic(
            name: "Sample",
            lesson: "Sample Lesson",
            flashcards: [
                Flashcard(word: "Hello", translation: "Hola"),
                Flashcard(word: "Goodbye", translation: "Adiós")
            ],
            quiz: Quiz(questions: [
                QuizQuestion(question: "What is the capital of Spain?", correctAnswer: "Madrid", options: ["Madrid", "Barcelona", "Seville"]),
                QuizQuestion(question: "How do you say 'apple' in Spanish?", correctAnswer: "manzana", options: ["manzana", "pera", "naranja"])
            ])
        )

        let topicViewModel = TopicViewModel()
        topicViewModel.topics = [sampleTopic]

        return LessonView(topicID: sampleTopic.id)
            .environmentObject(topicViewModel)
    }
}
