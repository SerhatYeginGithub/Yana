import SwiftUI
struct SplashScreen: View {
    @ObservedObject var appViewModel: AppViewModel
    @State private var isAnimating = false
    @State private var isRegistered = false
    
    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let screenHeight = geometry.size.width
            ZStack {
                Color(red: 234/255, green: 222/255, blue: 210/255).opacity(0.25)
                    .ignoresSafeArea()
                VStack(spacing: 100) {
                    Image("splash")
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(isAnimating ? 0.5 : 0.1)
                        .animation(.spring())
                    
                    Text("YOU ARE NOT ALONE")
                        .font(.custom("Irish Grover", size: screenWidth/18))
                }
                .onAppear {
                    print(UserDefaultsManager.shared.email)
                    print(UserDefaultsManager.shared.password)
                    print(UserDefaultsManager.shared.userName)
                    if UserDefaultsManager.shared.email != nil && UserDefaultsManager.shared.password != nil {
                        isRegistered = true
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation {
                            isAnimating = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            if appViewModel.isInternetAvailable {
                                if isRegistered {
                                    appViewModel.currentScreen = .loading
                                } else {
                                    appViewModel.currentScreen = .register
                                }
                            } else {
                                appViewModel.currentScreen = .networkPage
                            }
                        }
                    }
                    
                    appViewModel.startMonitoringInternetConnection()
                }
            }
        }
    }
}
