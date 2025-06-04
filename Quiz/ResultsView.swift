import SwiftUI
import FirebaseFirestore
import FirebaseAuth

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
