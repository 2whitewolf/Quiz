// ViewModel for Test
class TestViewModel: ObservableObject {
    @Published var questions: [Question] = []
    @Published var selectedAnswers: [[Int]] = []
    private let db = Firestore.firestore()
    
    func fetchQuestions() {
        db.collection("questions").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching questions: \(error)")
                return
            }
            
            self.questions = snapshot?.documents.compactMap { doc in
                let data = doc.data()
                return Question(
                    id: doc.documentID,
                    text: data["text"] as? String ?? "",
                    options: data["options"] as? [String] ?? [],
                    correctAnswers: data["correctAnswers"] as? [Int] ?? [],
                    isMultipleChoice: data["isMultipleChoice"] as? Bool ?? false
                )
            } ?? []
            
            self.selectedAnswers = Array(repeating: [], count: self.questions.count)
        }
    }
    
    func calculateScore() -> Int {
        var score = 0
        for i in 0..<questions.count {
            let correct = questions[i].correctAnswers.sorted()
            let selected = selectedAnswers[i].sorted()
            if correct == selected {
                score += 1
            }
        }
        return score
    }
    
    func calculatePercentage() -> Double {
        guard !questions.isEmpty else { return 0.0 }
        return (Double(calculateScore()) / Double(questions.count)) * 100
    }
    
    func submitResults(userName: String) {
        let result = TestResult(
            id: UUID().uuidString,
            userName: userName,
            score: calculateScore(),
            timestamp: Date()
        )
        
        do {
            try db.collection("results").document(result.id).setData(from: result)
        } catch {
            print("Error saving result: \(error)")
        }
    }
}
