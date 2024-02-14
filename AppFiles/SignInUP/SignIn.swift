//
//  SignIn.swift
//  Looper
//
//  Created by Samuel Ridet on 8/19/22.
//

import SwiftUI
import GoogleSignIn
import CryptoKit
import AuthenticationServices
import FirebaseAuth

struct SignIn: View {
    @State var email = ""
    @State var password = ""
    @EnvironmentObject private var authModel: AuthViewModel
    @State var currentNonce:String?

    var body: some View {
        
        GeometryReader {geometry in

            ScrollView (showsIndicators: false) {
                VStack {
                    VStack(spacing: 5){
                        HStack{
                            VStack(alignment: .leading){
                                Text("Welcome Back, \nSign in to Forum")
                                    .foregroundColor(.white)
                                    .font(.custom("Montserrat-Bold", size: 20))

                            }
                            Spacer()
                            
                            Image("logo1black")
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width * 0.15)
                        }.onTapGesture {
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }.padding(.bottom, 10)
              
                        VStack (spacing: 0){
                            FloatingTextField(placeHolder: "Email", text: $email, Iconimage: "envelope", charLimit: 40)
                                .frame(width: geometry.size.width/1.1)
                                .padding(5)
                                .textContentType(.username)
                            Text(authModel.accountIssueSignIn ? "Invalid Email" : " ")
                                .foregroundColor(Color.red)
                                .font(.custom("Montserrat-SemiBold", size: 13))
                                //.offset(y: 40)
                                
                        }

                       
                        VStack (spacing: 0){
                            SecureFloatingTextField(placeHolder: "Password", text: $password, Iconimage: "eye.slash.fill", charLimit: 25)
                                .frame(width: geometry.size.width/1.1)
                                .padding(5)
                                .textContentType(.password)
                            Text(authModel.wrongPassword ? "Wrong Password" : " ")
                                .foregroundColor(Color.red)
                                .font(.custom("Montserrat-SemiBold", size: 13))
                                
                        }
                            
                            
                   
                        Button(action: {
                            authModel.wrongPassword = false
                            authModel.accountIssueSignIn = false
                            
                            authModel.signIn(emailAddress: email, password: password)
                            guard !email.isEmpty, !password.isEmpty else{
                                return
                            }
                            password = ""
                            
                        }, label: {
                            Text("Sign In")
                                .foregroundColor(.black)
                                .font(.custom("Montserrat-SemiBold", size: 15))
                                .padding([.leading, .trailing], 35)
                                .padding([.bottom,.top])
                                .background(password.isEmpty || email.isEmpty ? .gray : Color.white)
                                .cornerRadius(10)
                        })
                        .disabled(password.isEmpty || email.isEmpty)
                        .padding(5)
                        
                        
                        NavigationLink(destination: SignUp()){
                            Text("Or create account")
                                .foregroundColor(.white)
                                .font(.custom("Montserrat-SemiBold", size: 13))
                        }
                        
                        Spacer(minLength: geometry.size.width * 0.75)
                        
                      
                        SignInWithAppleButton(
                            onRequest: { request in
                                let nonce = authModel.randomNonceString()
                                currentNonce = nonce
                                request.requestedScopes = [.email]
                                request.nonce = authModel.sha256(nonce)
                            },
                            onCompletion: { result in
                                switch result {
                                case .success(let authResults):
                                    switch authResults.credential {
                                    case let appleIDCredential as ASAuthorizationAppleIDCredential:
                                        
                                        guard let nonce = currentNonce else {
                                            fatalError("Invalid state: A login callback was received, but no login request was sent.")
                                        }
                                        guard let appleIDToken = appleIDCredential.identityToken else {
                                            fatalError("Invalid state: A login callback was received, but no login request was sent.")
                                        }
                                        guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                                            print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                                            return
                                        }
                                        
                                        let credential = OAuthProvider.credential(withProviderID: "apple.com",idToken: idTokenString,rawNonce: nonce)
                                        Auth.auth().signIn(with: credential) { (authResult, error) in
                                            if let authData = authResult, authData.additionalUserInfo?.isNewUser == true {
                                                authModel.isNewAppleUser = true
                                            } else {
                                                print("signed in")
                                                    // Add other operations needed after signing in
                                            }
                                            print("signed in")
                                        }
                                        
                                        print("\(String(describing: Auth.auth().currentUser?.uid))")
                                    default:
                                        break
                                        
                                    }
                                default:
                                    break
                                }
                            }
                        ).signInWithAppleButtonStyle(.whiteOutline)
                            .frame(width: geometry.size.width * 0.75, height: 50)
                            .cornerRadius(15)
                      
                           
                        Spacer(minLength: geometry.size.width * 0.05)
                        
                        NavigationLink(destination: forgotPassword()){
                            Text("Forgot password?")
                                .foregroundColor(.white)
                                .font(.custom("Montserrat-SemiBold", size: 13))
                                .underline()
                        }
                        
             
                       
              
                        Spacer()
                    
                    }
                    .padding()
                }

                .background(.black)

            .navigationBarHidden(true)
        .navigationBarTitle("")
            }.onAppear{
                authModel.emailVerified = false
                authModel.wrongPassword = false
                authModel.accountIssueSignIn = false
            }

        }
     
        
    } 
    
    
}
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}
 
struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SignIn()
                .environmentObject(AuthViewModel())
        }
    }
}
