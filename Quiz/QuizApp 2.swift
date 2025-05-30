import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

// Main App
@main
struct QuizApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

// Main Content View
struct ContentView: View {
    @StateObject private var authViewModel = AuthViewModel()
    
    var body: some View {
        if authViewModel.isAuthenticated {
            AdminPanelView()
                .environmentObject(authViewModel)
        } else {
            NavigationView {
                WelcomeView()
                    .environmentObject(authViewModel)
            }
        }
    }
}

// Welcome View (Main Page)
struct WelcomeView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var showTest = false
    @State private var showLogin = false
    
    var body: some View {
        VStack {
            Text("General Knowledge Quiz")
                .font(.largeTitle)
                .padding()
            
            Button(action: { showTest = true }) {
                Text("Take the Test")
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            
            Button(action: { showLogin = true }) {
                Text("Admin Login")
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding()
        .navigationTitle("Quiz App")
        .sheet(isPresented: $showTest) {
            TestView()
        }
        .sheet(isPresented: $showLogin) {
            LoginView()
                .environmentObject(authViewModel)
        }
    }
}

// Test View
struct TestView: View {
    @StateObject private var viewModel = TestViewModel()
    @State private var userName = ""
    @State private var showResults = false
    
    var body: some View {
        VStack {
            if viewModel.questions.isEmpty {
                ProgressView("Loading questions...")
            } else if showResults {
                ResultsView(score: viewModel.calculateScore(), percentage: viewModel.calculatePercentage())
            } else {
                List {
                    Section(header: Text("Your Name")) {
                        TextField("Enter your name", text: $userName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    ForEach(viewModel.questions.indices, id: \.self) { index in
                        QuestionView(
                            question: viewModel.questions[index],
                            selectedAnswers: $viewModel.selectedAnswers[index]
                        )
                    }
                }
                
                Button(action: {
                    if !userName.isEmpty {
                        viewModel.submitResults(userName: userName)
                        showResults = true
                    }
                }) {
                    Text("Submit Test")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(userName.isEmpty ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .disabled(userName.isEmpty)
                }
                .padding()
            }
        }
        .navigationTitle("Take Quiz")
        .onAppear {
            viewModel.fetchQuestions()
        }
    }
}

// Question View
struct QuestionView: View {
    let question: Question
    @Binding var selectedAnswers: [Int]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(question.text)
                .font(.headline)
                .padding(.bottom, 5)
            
            ForEach(question.options.indices, id: \.self) { index in
                if question.isMultipleChoice {
                    CheckboxView(
                        text: question.options[index],
                        isChecked: selectedAnswers.contains(index),
                        onToggle: {
                            if selectedAnswers.contains(index) {
                                selectedAnswers.removeAll { $0 == index }
                            } else {
                                selectedAnswers.append(index)
                            }
                        }
                    )
                } else {
                    RadioButtonView(
                        text: question.options[index],
                        isSelected: selectedAnswers.contains(index),
                        onSelect: { selectedAnswers = [index] }
                    )
                }
            }
        }
        .padding(.vertical, 5)
    }
}

// Checkbox View
struct CheckboxView: View {
    let text: String
    let isChecked: Bool
    let onToggle: () -> Void
    
    var body: some View {
        Button(action: onToggle) {
            HStack {
                Image(systemName: isChecked ? "checkmark.square" : "square")
                Text(text)
            }
        }
        .foregroundColor(.primary)
    }
}

// Radio Button View
struct RadioButtonView: View {
    let text: String
    let isSelected: Bool
    let onSelect: () -> Void
    
    var body: some View {
        Button(action: onSelect) {
            HStack {
                Image(systemName: isSelected ? "circle.fill" : "circle")
                Text(text)
            }
        }
        .foregroundColor(.primary)
    }
}

// Results View
struct ResultsView: View {
    let score: Int
    let percentage: Double
    
    var body: some View {
        VStack {
            Text("Test Results")
                .font(.largeTitle)
                .padding()
            
            Text("Score: \(score) correct answers")
                .font(.title2)
                .padding()
            
            Text("Percentage: \(String(format: "%.1f", percentage))%")
                .font(.title2)
                .padding()
            
            Button(action: { /* Dismiss or restart */ }) {
                Text("Back to Home")
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
    }
}

// Login View
struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    
    var body: some View {
        VStack {
            Text("Admin Login")
                .font(.largeTitle)
                .padding()
            
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
            
            Button(action: {
                authViewModel.login(email: email, password: password) { error in
                    if let error = error {
                        errorMessage = error.localizedDescription
                    }
                }
            }) {
                Text("Login")
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding()
    }
}

// Admin Panel View
struct AdminPanelView: View {
    @StateObject private var viewModel = AdminViewModel()
    
    var body: some View {
        VStack {
            Text("Admin Panel")
                .font(.largeTitle)
                .padding()
            
            List(viewModel.results) { result in
                VStack(alignment: .leading) {
                    Text("User: \(result.userName)")
                        .font(.headline)
                    Text("Score: \(result.score)")
                    Text("Time: \(result.timestamp, style: .date) \(result.timestamp, style: .time)")
                }
            }
            .onAppear {
                viewModel.fetchResults()
            }
            
            Button(action: {
                // Logout functionality
            }) {
                Text("Logout")
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
    }
}

// Data Models
struct Question: Identifiable {
    let id: String
    let text: String
    let options: [String]
    let correctAnswers: [Int]
    let isMultipleChoice: Bool
}

struct TestResult: Identifiable {
    let id: String
    let userName: String
    let score: Int
    let timestamp: Date
}

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

// ViewModel for Admin
class AdminViewModel: ObservableObject {
    @Published var results: [TestResult] = []
    private let db = Firestore.firestore()
    
    func fetchResults() {
        db.collection("results").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching results: \(error)")
                return
            }
            
            self.results = snapshot?.documents.compactMap { doc in
                try? doc.data(as: TestResult.self)
            } ?? []
        }
    }
}

// Authentication ViewModel
class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    
    func login(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result