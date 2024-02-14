//
//  emailConfirmation.swift
//  Looper
//
//  Created by Samuel Ridet on 4/26/23.
//

import SwiftUI

struct emailConfirmation: View {
    @EnvironmentObject private var authModel: AuthViewModel
    @State private var lastEmailSent: Date? = nil
    @State private var remainingTime: Int = 0
    @State private var resendDisabled = false
    @Environment(\.scenePhase) private var scenePhase
    
    let resendInterval: TimeInterval = 60
    @State var clickedOnce = false
    
    
    var body: some View {
        GeometryReader { geometry in
        ZStack (alignment: .leading){
            Circle()
                .fill(CustomColor.mainBlue)
                .frame(width: geometry.size.width * 1.8, height: geometry.size.width * 1.8)
                .offset(x: geometry.size.width * -0.8, y: geometry.size.height * 0.6)
            Circle()
                .fill(CustomColor.mainThird)
                .frame(width: geometry.size.width * 1.5, height: geometry.size.width * 1.5)
                .offset(x: geometry.size.width * 0.5, y: geometry.size.height * 0.6)
            Circle()
                .fill(CustomColor.mainPurple)
                .frame(width: geometry.size.width * 2, height: geometry.size.width * 1.5)
                .offset(x: -geometry.size.width * 1, y: -geometry.size.height * 0.7)
            
    

                HStack {
                    Spacer()
                    VStack{
                        HStack {
                            
                            Spacer()
                            Image("logo1black")
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width * 0.15)
                        }
                       Spacer()
                       
                        VStack{
                            Text("Yay! Confirm Your ")
                                .font(.custom("Montserrat-Bold", size: 20))
                                .foregroundColor(.white)
                            Text("Email 🎉")
                                .font(.custom("Montserrat-Bold", size: 20))
                                .foregroundColor(.white)
                                .padding(.bottom, 5)
                            Text("Please check your email for")
                                .font(.custom("Montserrat-SemiBold", size: 15))
                                .foregroundColor(.white)
                            Text("confirmation mail. Click link in email")
                                .font(.custom("Montserrat-SemiBold", size: 15))
                                .foregroundColor(.white)
                            Text("to verify your account")
                                .font(.custom("Montserrat-SemiBold", size: 15))
                                .foregroundColor(.white)
                      
                        }
                     
                        HStack {
                            Spacer()
                            VStack {
  
                                Button {
    
                                    authModel.checkEmailVerification { res in
                                        withAnimation {
                                            authModel.emailVerified = res
                                      
                                            clickedOnce = true
                                        }
                                    }
                                } label: {
                                    Text("Verify")
                                        .font(.custom("Montserrat-SemiBold", size: 15))
                                        .foregroundColor(.black)
                                        .padding(.horizontal, 45)
                                        .padding(.vertical, 15)
                                        .background(RoundedRectangle(cornerRadius: 15).foregroundColor(.white))
                                }
    
                            }
                            Spacer()
                     
                        }.padding(.vertical, 5)
                        Spacer()
                      
                
                        Button {
                            authModel.signOut()
                        } label: {
                            HStack{
                                Image(systemName: "person.fill.xmark")
                                    .font(.body)
                       
                                    .foregroundColor(.white)
                                Text("Sign Out")
                                    .font(.custom("Montserrat-Bold", size: 15))
                                    .foregroundColor(.white)
                                    .padding([.leading],5)
                                Spacer()
                            }
                        }.padding([.bottom],5)
                        
                    }
                    Spacer()
                }.onAppear{
                    authModel.sendEmailVerification()
                    lastEmailSent = Date()
           
                }.frame(width: geometry.size.width, height: geometry.size.height).padding(10)
                 
        }  .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                    // App became active again, check email verification status
                authModel.checkEmailVerification { res in
                    withAnimation {
                        authModel.emailVerified = res
                        clickedOnce = true
                    }
                }
            }
        }.onAppear{
            authModel.checkEmailVerification { res in
                withAnimation {
                    authModel.emailVerified = res
                    clickedOnce = true
                }
            }
        }
        }
    }
}

struct emailConfirmation_Previews: PreviewProvider {
    static var previews: some View {
        emailConfirmation()
            .environmentObject(AuthViewModel())
    }
}
