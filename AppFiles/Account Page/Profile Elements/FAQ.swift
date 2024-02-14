//
//  FAQ.swift
//  Looper
//
//  Created by Samuel Ridet on 5/25/23.
//

import SwiftUI

struct FAQ: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        GeometryReader{geometry in
            ScrollView(showsIndicators: false){
                VStack( alignment: .leading, spacing: 15){
                    
                    HStack {
                     
                        VStack(alignment: .leading) {
                            Text("FAQ")
                                .font(.custom("Montserrat-Bold", size: 20))
                                .foregroundColor(.white)
                            Text("Answers to Your Questions")
                                .font(.custom("Montserrat-SemiBold", size: 15))
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    }
                    
                    
                    
                    VStack(alignment: .leading){
                        
                       
                        HStack {
                            Image(systemName: "questionmark.circle.fill")
                                .font(.body)
                                .foregroundColor(.white)
                            Text("About us")
                                .font(.custom("Montserrat-Bold", size: 17))
                            .foregroundColor(.white)
                           
                        }
                        Text("Forum aims to provide a community space optimized for transacting, networking, and growing within the sneaker industry.")
                            .font(.custom("Montserrat-SemiBold", size: 15))
                            .foregroundColor(.white)
                            .padding(.leading, 10)
                           
                    }
                    
                    VStack(alignment: .leading){
                        HStack {
                            Image(systemName: "dollarsign.circle.fill")
                                .font(.body)
                                .foregroundColor(.white)
                            Text("Conducting business")
                                .font(.custom("Montserrat-Bold", size: 17))
                            .foregroundColor(.white)
                        }
                        Text("Forum authorizes all users to participate in relevant and permitted transactions. For clarification, please refer to the rules.\n\nUsers may create listings or posts to promote products in their possession, send offers to engage with other parties, and complete transactions if all parties agree to the terms.\n\nCurrently, Forum does not oversee or participate in the transaction process between users, and cannot be held accountable for associated liability. Therefore, all users are encouraged to complete personal due diligence to verify the legitimacy of buyers, sellers, and products. This may be completed through external sources (i.e. social media references and authentication platforms). If the users are not familiar with this procedure, Forum recommends conducting in-person meetups only.\n\nUsers may leave reviews upon completing the transaction and refer to Logger feature.")
                            .font(.custom("Montserrat-SemiBold", size: 15))
                            .foregroundColor(.white)
                            .padding(.leading, 10)
                        
                    }

                    VStack(alignment: .leading, spacing: 5){
                        HStack {
                            Image(systemName: "wrench.and.screwdriver.fill")
                                .font(.body)
                                .foregroundColor(.white)
                            Text("Utility and features")
                                .font(.custom("Montserrat-Bold", size: 17))
                            .foregroundColor(.white)
                        }
                        Text("Currently, Forum supports the following features:")
                            .font(.custom("Montserrat-SemiBold", size: 15))
                            .foregroundColor(.white)
                            .padding(.leading, 10)
                        Text("- General Timeline (Feed), located on the Home page, shows listings and posts created by the users.")
                            .font(.custom("Montserrat-SemiBold", size: 15))
                            .foregroundColor(.white)
                            .padding(.leading, 10)
                        
                        Text("- Search Engine, accessible at the top of the Home page, allows users to search for available products.")
                            .font(.custom("Montserrat-SemiBold", size: 15))
                            .foregroundColor(.white)
                            .padding(.leading, 10)
                        
                        Text("- Streamlined Messaging, accessible at the top right corner of the Home page, serves as a communication line between the users.")
                            .font(.custom("Montserrat-SemiBold", size: 15))
                            .foregroundColor(.white)
                            .padding(.leading, 10)
                           
                        Text("- Creating sale listings and posts, located on the Sell page, enables users to share their content and upload products for sale.")
                            .font(.custom("Montserrat-SemiBold", size: 15))
                            .foregroundColor(.white)
                            .padding(.leading, 10)
                        
                        Text("- Logger, located at the top of the chat or within the Dash page Sales/Purchases tabs, records all sales and purchases.")
                            .font(.custom("Montserrat-SemiBold", size: 15))
                            .foregroundColor(.white)
                            .padding(.leading, 10)
                        
                        Text("- Inventory Management, located on the Profile page, allows users to efficiently manage their listings.")
                            .font(.custom("Montserrat-SemiBold", size: 15))
                            .foregroundColor(.white)
                            .padding(.leading, 10)

                        Text("- Dashboard, located on the Dash page, provides insight into the relevant metrics for logged sales and purchases.")
                            .font(.custom("Montserrat-SemiBold", size: 15))
                            .foregroundColor(.white)
                            .padding(.leading, 10)
                        
                        Text("- Profile, located on the Profile page, boosts user brand identity and connects to external media sources.")
                            .font(.custom("Montserrat-SemiBold", size: 15))
                            .foregroundColor(.white)
                            .padding(.leading, 10)

                    }
          
                    VStack(alignment: .leading){
                        HStack {
                            Image(systemName: "envelope.fill")
                                .font(.body)
                                .foregroundColor(.white)
                            Text("Help")
                                .font(.custom("Montserrat-Bold", size: 17))
                            .foregroundColor(.white)
                        }
                        Text("To contact us, please reach out via Discord, Instagram, or Twitter. The relevant links are located at the bottom of the previous page (Account Settings). Our email is customerhelp.forumapp@gmail.com.\nWe are happy to assist you!")
                            .font(.custom("Montserrat-SemiBold", size: 15))
                            .foregroundColor(.white)
                            .padding(.leading, 10)
                        
                    }
                    
              
                    
                    
                }
            }     .navigationBarTitle("", displayMode: .inline)
        
                .padding(10)
                .onAppear {
                        // Disable back swipe gesture
                    UINavigationController().interactivePopGestureRecognizer?.isEnabled = false
                }
            
        }
    }
}

struct FAQ_Previews: PreviewProvider {
    static var previews: some View {
        FAQ()
    }
}
