//
//  thirdPartyUsername.swift
//  Looper
//
//  Created by Samuel Ridet on 5/22/23.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth


struct thirdPartyUsername: View {
    var apple : Bool
    @State var username = ""
    @State var usernameNotAvailable = false
    @EnvironmentObject private var authModel: AuthViewModel
    var body: some View {
        GeometryReader{geometry in
            VStack{
                HStack{
                    VStack(alignment: .leading){
                        Text("Finish Signing Up, \nEnter Your Username")
                            .foregroundColor(.white)
                            .font(.custom("Montserrat-Bold", size: 20))
                        
                    }
                    Spacer()
                    Image("logo1black")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.15)
                }
                FloatingTextField(placeHolder: "Username", text: $username, Iconimage: "person", charLimit: 20)
                    .frame(width: geometry.size.width/1.1)
                
            
                    Text(!usernameNotAvailable ? " " : "Username already taken" )
                        .foregroundColor(Color.red)
                        .font(.custom("Montserrat-SemiBold", size: 13))
            
                   
                Spacer()
           
                Button {
                    self.usernameNotAvailable = false
                    let db = Firestore.firestore()
                    db.collection("usernames").whereField("username", isEqualTo: username).getDocuments { (querySnapshot, error) in
                        if let error = error {
                                // An error occurred while querying the database.
                            print(error.localizedDescription)
                            
                        } else if querySnapshot?.documents.count ?? 0 > 0 {
                                // The username is already in use.
                            print("The chosen username is already in use. Please choose a different username.")
                            self.usernameNotAvailable = true
                        }else{
                            if let currentUser = Auth.auth().currentUser {
                                let email = currentUser.email ?? " "
                                authModel.storeuserInfo(email: email, username: username)
                                withAnimation {
                                    authModel.isNewAppleUser = false
                                    authModel.userAppleUsername = false
                                    authModel.justsignedUp = true
                                }
                              
                            }

                        }
                    }
                } label: {
                    VStack {
                        Text("Sign Up")
                            .foregroundColor(.black)
                            .bold()
                            .font(.headline)
                            .padding([.leading, .trailing], 35)
                            .padding([.bottom,.top])
                            .font(.custom("Montserrat-SemiBold", size: 15))
                            .background(username.isEmpty ? .gray : Color.white)
                            .cornerRadius(10)
                     
                    }
                }.disabled(username.isEmpty)
                    .padding(.vertical, 15)


            }.padding(10)
        }
     
    }
}

struct thirdPartyUsername_Previews: PreviewProvider {
    static var previews: some View {
        thirdPartyUsername(apple: true)
    }
}
