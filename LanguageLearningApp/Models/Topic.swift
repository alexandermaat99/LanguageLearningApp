import Foundation

struct Topic: Identifiable {
    var id = UUID()
    var name: String
    var lesson: String
    var flashcards: [Flashcard]
    var quiz: Quiz
    var isLessonRead: Bool = false
    var isFlashcardsCompleted: Bool = false
    var isQuizCompleted: Bool = false
}
