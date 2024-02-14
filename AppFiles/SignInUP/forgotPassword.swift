//
//  forgotPassword.swift
//  Looper
//
//  Created by Samuel Ridet on 5/9/23.
//

import SwiftUI

struct forgotPassword: View {
    @EnvironmentObject private var authModel: AuthViewModel
    @State private var lastEmailSent: Date? = nil
    @State private var remainingTime: Int = 0
    @State private var resendDisabled = false
    
    let resendInterval: TimeInterval = 60
    @State var sent = false
    
    @State var email = ""
    var body: some View {
        GeometryReader { geometry in
            ScrollView (showsIndicators: false){
                VStack{
                    
                    HStack {
                        VStack (alignment: .leading, spacing: 10){
                            Text("Reset your password")
                                .foregroundColor(.white)
                                .font(.custom("Montserrat-Bold", size: 20))
                        }
                        Spacer()
                        Image("logo1black")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width * 0.1)
                    }
                    
         
                    
                    if sent{
                        Text("Reset link sent!\nCheck your inbox for next steps.")
                            .font(.custom("Montserrat-SemiBold", size: 15))
                            .foregroundColor(.white)
                        
                            .multilineTextAlignment(.center)
                        
                    }else{
                        HStack {
                            Spacer()
                            VStack{
                                FloatingTextField(placeHolder: "Enter Email", text: $email, Iconimage: "envelope", charLimit: 31)
                                    .padding(.horizontal, 10)
                                
                                
                                Button {
                                    self.sent = true
                                    authModel.sendPasswordResetEmail(email: email) { err in
                                        
                                    }
                                } label: {
                                    Text("Send Password Reset Link")
                                        .font(.custom("Montserrat-SemiBold", size: 13))
                                        .foregroundColor(.black)
                                        .padding(.horizontal, 45)
                                        .padding(.vertical, 15)
                                        .background(RoundedRectangle(cornerRadius: 15).foregroundColor(email.isEmpty ? .gray : .white))
                                }.disabled(email.isEmpty)
                            }
                            Spacer()
                        }
                    }
                    
                    
                    Spacer()
                    
                }.padding(.horizontal, 15)
            }
                  
                
            }
        }
    

}

struct forgotPassword_Previews: PreviewProvider {
    static var previews: some View {
        forgotPassword()
            .environmentObject(AuthViewModel())
    }
}
