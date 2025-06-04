//
//  AdminViewModel.swift
//  Quiz
//
//  Created by Bogdan on 05.06.2025.
//


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