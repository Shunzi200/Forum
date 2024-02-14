//
//  holder.swift
//  Looper
//
//  Created by Samuel Ridet on 5/25/23.
//

import SwiftUI

struct holder: View {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @EnvironmentObject private var authModel: AuthViewModel
    @EnvironmentObject var firestoreConnector: FirebaseConnector
    @EnvironmentObject var appState : AppState
    @State var functionComplete = false
    var body: some View {
       
        ZStack {
            if !functionComplete {
                Launch()
                    .onAppear {
                        authModel.listenToAuthState {resA in
                            
                            if resA{
                                print("auth state listened")
                                if authModel.user != nil {
                                    authModel.checkUsernameAdded {
                                        authModel.checkEmailVerification { res in
                                            authModel.emailVerified = res
                                            firestoreConnector.feedPull {
                                                print("Launch feed pull")
                                                withAnimation {
                                                    functionComplete = true
                                                }
                                            }
                                        }
                                    }
                                    ReviewHandler.requestReview()
                                }else{
                                    
                                }
                            } else {
                                
                            }
                        }
                    }
                
            }else  {
                ContentView()
                    .transition(.opacity)
                    .environmentObject(authModel)
                    .environmentObject(firestoreConnector)
                    .environmentObject(appState)
            }
        }

        
    }
    
}

struct holder_Previews: PreviewProvider {
    static var previews: some View {
        holder()
    }
}
