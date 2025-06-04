import SwiftUI
import FirebaseFirestore
import FirebaseAuth

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