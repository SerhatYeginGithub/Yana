import SwiftUI

struct TabBarScreen: View {
    @ObservedObject var appViewModel: AppViewModel
    @State private var selectedSection = 0
    @ObservedObject var userViewModel: UsersViewModel
    
    var body: some View {
        GeometryReader { geometry in
            let screenHeight = geometry.size.height
            let screenWidth = geometry.size.width
            ZStack {
                Color(UIColor.systemGray).opacity(0.2)
                    .edgesIgnoringSafeArea(.all)
                Group {
                    if appViewModel.isInternetAvailable {
                        VStack {
                            if appViewModel.tabbarItems == .house {
                                HomeScreen(userViewModel: userViewModel)
                            } else if appViewModel.tabbarItems == .chat {
                                ChatScreen(appViewModel: appViewModel)
                            } else if appViewModel.tabbarItems == .crisis {
                                CrisisScreen()
                            } else if appViewModel.tabbarItems == .call {
//                                CallKitPage()
                                CallRoomScreen(appViewModel: appViewModel)
//                                    .transition(.move(edge: .trailing))
//                                    .animation(.bouncy)
                            } else if appViewModel.tabbarItems == .settings {
                                SettingsScreen(appViewModel: appViewModel, userViewModel: userViewModel)
                            } else {
                                Text("Bir Sorunla Karşılaşıldı.")
                            }
                            
                            if appViewModel.tabbarVisibility == .no {
                                Spacer()
                                VStack {
                                    HStack {
                                        Spacer()
                                        Image(systemName: "house.fill")
                                            .foregroundColor(appViewModel.tabbarItems == .house ? Color.blue : .black)
                                            .onTapGesture {
                                                appViewModel.tabbarItems = .house
                                            }
                                            .frame(width: screenWidth / 10, height: screenHeight / 15)
                                        Spacer()
                                        Image(systemName: "message.fill")
                                            .foregroundColor(appViewModel.tabbarItems == .chat ? Color.blue : .black)
                                            .onTapGesture {
                                                appViewModel.tabbarItems = .chat
                                            }
                                            .frame(width: screenWidth / 10, height: screenHeight / 15)
                                        Spacer()
                                        Image(systemName: "cross.case.fill")
                                            .foregroundColor(appViewModel.tabbarItems == .crisis ? Color.blue : .black)
                                            .onTapGesture {
                                                appViewModel.tabbarItems = .crisis
                                            }
                                            .frame(width: screenWidth / 10, height: screenHeight / 15)
                                        Spacer()
                                        Image(systemName: "phone.fill")
                                            .foregroundColor(appViewModel.tabbarItems == .call ? Color.blue : .black)
                                            .onTapGesture {
                                                appViewModel.tabbarItems = .call
                                            }
                                            .frame(width: screenWidth / 10, height: screenHeight / 15)
                                        Spacer()
                                        Image(systemName: "gear")
                                            .foregroundColor(appViewModel.tabbarItems == .settings ? Color.blue : .black)
                                            .onTapGesture {
                                                appViewModel.tabbarItems = .settings
                                            }
                                            .frame(width: screenWidth / 10, height: screenHeight / 15)
                                        Spacer()
                                    }
                                    .font(.title)
                                    .multilineTextAlignment(.center)
                                }
                                .frame(width: screenWidth, height: screenHeight / 15)
                                .scaledToFit()
                                Spacer()
                            }
                        }
                    } else {
                        networkErrorScreen()
                    }
                }
            }
            .onAppear {
                appViewModel.startMonitoringInternetConnection()
            }
        }
    }
}
