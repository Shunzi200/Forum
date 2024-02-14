//
//  SignUp.swift
//  Looper
//
//  Created by Samuel Ridet on 8/19/22.
//

import SwiftUI
import FirebaseAuth

struct SignUp: View {
    @State var email = ""
    @State var password = ""
    @State var confirmPassword = ""
    @State var username = ""
    @State var image : UIImage?
    @EnvironmentObject private var authModel: AuthViewModel
    @State var passwordMatch = true
    
   @State var usernameAv = false

    
    var body: some View {
        
        GeometryReader { geometry in
            ScrollView(showsIndicators: false) {
                VStack {
                    VStack (spacing: 0){
                        HStack{
                            VStack(alignment: .leading){
                                Text("Welcome to Forum, \nCreate an Account")
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
                        
                        
                        VStack(spacing: 0) {
                            
                            FloatingTextField(placeHolder: "Email", text: $email, Iconimage: "envelope", charLimit: 40)
                                .frame(width: geometry.size.width/1.1)
                                .textContentType(.username)
                                //.//padding(5)
                            
                            Text(authModel.invalidEmail ?  "Invalid Email" : " ")
                                .foregroundColor(Color.red)
                                .font(.custom("Montserrat-SemiBold", size: 13))
    
                        }
                      
                        
                        VStack(spacing: 0) {
                            FloatingTextField(placeHolder: "Username", text: $username, Iconimage: "person", charLimit: 20)
                                .frame(width: geometry.size.width/1.1)
                            
                            //.padding(5)
                            Text(!authModel.usernameNotAvailable ? " " : "Username already taken" )
                                .foregroundColor(Color.red)
                                .font(.custom("Montserrat-SemiBold", size: 13))
                                
                            
                        }
                        VStack(spacing: 0) {
                            SecureFloatingTextField(placeHolder: "Password", text: $password, Iconimage: "eye.slash.fill", charLimit: 32)
                                .frame(width: geometry.size.width/1.1)
                               // .textContentType(.password)
                                //.padding(5)
                            Text(passwordMatch ? " " : "Passwords do not match")
                                .foregroundColor(Color.black)
                                .font(.custom("Montserrat-SemiBold", size: 13))
                            
                        }
                        
                        VStack(spacing: 0) {
                            SecureFloatingTextField(placeHolder: "Confirm Password", text: $confirmPassword, Iconimage: "eye.slash.fill", charLimit: 32)
                                .frame(width: geometry.size.width/1.1)
                            //.padding(5)
                            
                            Text(passwordMatch ? " " : "Passwords do not match")
                                .foregroundColor(Color.red)
                                .font(.custom("Montserrat-SemiBold", size: 13))
                                
                        }
                        
                        HStack {
                            Spacer()
                            Button(action: {
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                authModel.exists = false
                                authModel.invalidEmail = false
                                self.usernameAv = false
                
                                print("creating")
                                if password == confirmPassword{
                                    self.passwordMatch = true
                                    authModel.signUp(emailAddress: email, password: password, userName: username.trimmingCharacters(in: .whitespaces)){error in
                                        
                                        if error != nil {
                                                // Handle the error here
                                        } else {
                                                // Success! Do something here
                                   
                                        if let userID = Auth.auth().currentUser?.uid {
                                            let pushManager = PushNotificationManager(userID: userID)
                                            let center = UNUserNotificationCenter.current()
                                            center.getNotificationSettings { settings in
                                                if settings.authorizationStatus == .authorized {
                                                    pushManager.registerForPushNotifications()
                                                }
                                            }
                                            pushManager.updateFirestorePushTokenIfNeeded()
                                        }
                                        }
                                        guard !email.isEmpty, !password.isEmpty else{
                                            return
                                        }
                                        password = ""
                                        confirmPassword = ""
                                    }
                                    
                                  
                                }else{
                                    self.passwordMatch = false
                                    password = ""
                                    confirmPassword = ""
                                }
                                
                            }, label: {
                                VStack {
                                    Text("Sign Up")
                                        .foregroundColor(.black)
                                        .bold()
                                        .font(.headline)
                                        .padding([.leading, .trailing], 35)
                                        .padding([.bottom,.top])
                                        .font(.custom("Montserrat-SemiBold", size: 15))
                                        .background(password.isEmpty || confirmPassword.isEmpty || email.isEmpty || username.isEmpty ? .gray : Color.white)
                                    .cornerRadius(10)
                                    
                                    
                                    Text(authModel.exists ? "Account already exists" : " ")
                                        .foregroundColor(Color.red)
                                        .font(.body)
                                }
                            })
                            .disabled(password.isEmpty || confirmPassword.isEmpty || email.isEmpty || username.isEmpty )
                            .padding(10)
                            Spacer()
                        }
                        
                 
                        
          
                        
                        
                        Spacer()
                        
                    }
                    .padding(.horizontal)
                    
                }
                .background(.black)
            .navigationBarTitle("", displayMode: .inline)
            }.onAppear{
                authModel.exists = false
                authModel.emailVerified = false
                authModel.invalidEmail = false
                self.usernameAv = false
                self.passwordMatch = true
            }
   
        }
       
        
        
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
            .environmentObject(AuthViewModel())
    }
}
