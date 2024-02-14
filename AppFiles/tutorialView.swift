//
//  tutorialView.swift
//  Looper
//
//  Created by Samuel Ridet on 5/16/23.
//

import SwiftUI

struct tutorialView: View {
    @EnvironmentObject private var authModel: AuthViewModel
    @State private var selectedTab = 0
    var body: some View {
        GeometryReader{geometry in
            VStack {
                HStack {
                    VStack (alignment: .leading){
                        Text("Welcome to Forum!")
                            .font(.custom("Montserrat-Bold", size: 20))
                        .foregroundColor(.white)
                        Text("Markets-Simplified")
                            .font(.custom("Montserrat-SemiBold", size: 15))
                            .foregroundColor(.gray)
                    }

                    Spacer()
                }
                
                TabView(selection: $selectedTab) {
                    
              
                    
                 
                    
                    VStack {
                        Image("iphone10")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Text("Customize your page")
                            .font(.custom("Montserrat-Bold", size: 17))
                            .foregroundColor(.white)
                        Text("Add a profile picture")
                            .font(.custom("Montserrat-SemiBold", size: 15))
                            .foregroundColor(.white)
                    }
                    .tabItem {
                        EmptyView() // Empty view, as we want to use a custom tab item view
                    }
                    .tag(0)
                    
                    VStack {
                        Image("iphone13")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Text("Improve your brand image")
                            .font(.custom("Montserrat-Bold", size: 17))
                            .foregroundColor(.white)
                        Text("Upload posts to stand out ")
                            .font(.custom("Montserrat-SemiBold", size: 15))
                            .foregroundColor(.white)
                    }
                    .tabItem {
                        EmptyView() // Empty view, as we want to use a custom tab item view
                    }
                    .tag(1)
                    
                    VStack {
                        Image("socialmedia")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Text("Complete your profile")
                            .font(.custom("Montserrat-Bold", size: 17))
                            .foregroundColor(.white)
                        Text("Connect your social media")
                            .font(.custom("Montserrat-SemiBold", size: 15))
                            .foregroundColor(.white)
                    }
                    .tabItem {
                        EmptyView() // Empty view, as we want to use a custom tab item view
                    }
                    .tag(2)
                    
                    VStack {
                        Image("sellUI")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Text("Submit your first listing")
                            .font(.custom("Montserrat-Bold", size: 17))
                            .foregroundColor(.white)
                        Text("Sell your items quickly with no fees")
                            .font(.custom("Montserrat-SemiBold", size: 15))
                            .foregroundColor(.white)
                    }
                    .tabItem {
                        EmptyView() // Empty view, as we want to use a custom tab item view
                    }
                    .tag(3)
                    
                    VStack {
                        Image("iphone11")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Text("Fill in details")
                            .font(.custom("Montserrat-Bold", size: 17))
                            .foregroundColor(.white)
                        Text("List items individually or in bulk")
                            .font(.custom("Montserrat-SemiBold", size: 15))
                            .foregroundColor(.white)
                    }
                    .tabItem {
                        EmptyView() // Empty view, as we want to use a custom tab item view
                    }
                    .tag(4)
                    
                    VStack {
                        Image("iphone15")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Text("Find the perfect item")
                            .font(.custom("Montserrat-Bold", size: 17))
                            .foregroundColor(.white)
                        Text("Send your first offer")
                            .font(.custom("Montserrat-SemiBold", size: 15))
                            .foregroundColor(.white)
                    }
                    .tabItem {
                        EmptyView() // Empty view, as we want to use a custom tab item view
                    }
                    .tag(5)
                    
                    
                    VStack {
                        Image("onboardRule")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Text("Learn about the rules")
                            .font(.custom("Montserrat-Bold", size: 17))
                            .foregroundColor(.white)
                        Text("Read our guidelines in settings")
                            .font(.custom("Montserrat-SemiBold", size: 15))
                            .foregroundColor(.white)
                    }
                    .tabItem {
                        EmptyView() // Empty view, as we want to use a custom tab item view
                    }
                    .tag(6)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // Hide default tab index
                .padding(.vertical, 10)
                
                    // Custom index view
                HStack(spacing: 4) {
                    ForEach(0..<7) { index in
                        Circle()
                            .foregroundColor(index == selectedTab ? .white : .gray)
                            .frame(width: 8, height: 8)
                    }
                }
                Spacer()
                Button {
           
                        authModel.justsignedUp = false
           
                } label: {
                    Text("Get Started")
                        .font(.custom("Montserrat-Bold", size: 15))
                        .foregroundColor(.white)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 15)
                        .background(RoundedRectangle(cornerRadius: 15).foregroundColor(CustomColor.mainPurple))
                }

              
            }.padding(.horizontal, 10)
                .padding(.vertical, 20)
        }
    }
}


struct tutorialView_Previews: PreviewProvider {
    static var previews: some View {
        tutorialView()
            .environmentObject(AuthViewModel())
    }
}

