import SwiftUI
import FirebaseFirestore
import FirebaseAuth

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